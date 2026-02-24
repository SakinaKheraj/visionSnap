import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/detected_item_model.dart';

abstract class DetectionRemoteDataSource {
  Future<List<DetectedItemModel>> detectItems({
    required String imageUrl,
    required String uploadId,
  });

  Future<List<DetectedItemModel>> getDetectedItems(String uploadId);
}

class DetectionRemoteDataSourceImpl implements DetectionRemoteDataSource {
  final Dio dio;
  final SupabaseClient supabaseClient;

  DetectionRemoteDataSourceImpl({
    required this.dio,
    required this.supabaseClient,
  });

  @override
  Future<List<DetectedItemModel>> detectItems({
    required String imageUrl,
    required String uploadId,
  }) async {
    try {
      // Call Google Cloud Vision API
      print('Calling Google Vision API with imageUrl: $imageUrl');

      final response = await dio.post(
        '${ApiConstants.visionApiUrl}?key=${ApiConstants.visionApiKey}',
        data: {
          'requests': [
            {
              'image': {
                'source': {'imageUri': imageUrl}
              },
              'features': [
                {'type': 'LABEL_DETECTION', 'maxResults': 10},
                {'type': 'OBJECT_LOCALIZATION', 'maxResults': 10},
              ],
            }
          ],
        },
      );

      // Check if API call was successful
      if(response.statusCode != 200) {
        throw ServerException('Vision API request failed');
      }

      print("Got response from Google Vision API");

      final data = response.data;
      final annotations = data['responses'][0];

      // Parse the results and save to Supabase
      final List<DetectedItemModel> detectedItems = [];

      // OBJECT_LOCALIZATION (gives us positions)
      if(annotations['localizedObjectAnnotations'] != null) {
        print("Found ${annotations['localizedObjectAnnotaions'].length} objects");

        for(var obj in annotations['localizedObjectAnnotations']) {
          // Create object to save to supabase
          final itemData = {
            'upload_id': uploadId,
            'label': obj['name'],
            'confiedence': obj['score'],
            'bounding_box': {
              'vertices': obj['boundingPoly']['normalizedVertices'],
            },
          };

          // Save to database
          final saved = await supabaseClient
                        .from('detected_items')
                        .insert(itemData)
                        .select()
                        .single();

          // Convert JSON to model
          detectedItems.add(DetectedItemModel.fromJson(saved));
        }
      }

    // If no objects found, use LABEL_DETECTION
    if(detectedItems.isEmpty && annotations['labelAnnotations']!=null) {
      print('Found ${annotations['labelAnnotations'].length} labels');

      // Take top 5 labels
      for(var label in annotations['labelAnnotations'].take(5)) {
        final itemData = {
          'upload_id': uploadId,
          'label': label['descrption'],
          'confidence': label['score'],
        };

        final saved = await supabaseClient
                      .from('detected_items')
                      .insert(itemData)
                      .select()
                      .single();

        detectedItems.add(DetectedItemModel.fromJson(saved));
      }
    }

    // Update upload status
    await supabaseClient
        .from('uploads')
        .update({'processing_status': 'completed'})
        .eq('id', uploadId);

      print('Saved ${detectedItems.length} items to database');
      return detectedItems;

    } catch(e) {
      await supabaseClient
          .from('uploads')
          .update({'processing_status': 'failed'})
          .eq('id', uploadId);

      throw ServerException("Detection Failed ${e.toString()}");
    }
  }

  @override
  Future<List<DetectedItemModel>> getDetectedItems(String uploadId) async {
    try {
      print('Loadind detected items for upload: $uploadId');

      final response = await supabaseClient
                        .from('detected_items')
                        .select()
                        .eq('upload_id', uploadId);

      final items = (response as List)
                .map((json) => DetectedItemModel.fromJson(json))
                .toList();

      print('Found ${items.length} items');
      return items;

    } catch(e) {
      throw ServerException("Failed to load detected items ${e.toString()}");
    }
  }
}
