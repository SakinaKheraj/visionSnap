import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/error/exceptions.dart';
import '../models/upload_model.dart';

abstract class ImageRemoteDatasource {
  Future<UploadModel> uploadImage({
    required File imageFile,
    required String userId,
    required String source,
  });

  Future<List<UploadModel>> getUserUploads(String userId);

  Future<UploadModel> getUploadById(String uploadId);

  Future<void> deleteUpload(String uploadId);
}

class ImageRemoteDatasourceImpl extends ImageRemoteDatasource {
  final SupabaseClient supabaseClient;

  ImageRemoteDatasourceImpl(this.supabaseClient);

  @override
  Future<void> deleteUpload(String uploadId) {
    // TODO: implement deleteUpload
    throw UnimplementedError();
  }

  @override
  Future<UploadModel> getUploadById(String uploadId) {
    // TODO: implement getUploadById
    throw UnimplementedError();
  }

  @override
  Future<List<UploadModel>> getUserUploads(String userId) {
    // TODO: implement getUserUploads
    throw UnimplementedError();
  }

  @override
  Future<UploadModel> uploadImage({
    required File imageFile,
    required String userId,
    required String source,
  }) async {
    try {
      // generate unique filename
      final uuid = const Uuid();
      final fileExtension = imageFile.path.split('.').last;
      final fileName = '${uuid.v4()}.$fileExtension';
      final filePath = '$userId/$fileName';

      // upload image to storage
      await supabaseClient.storage.from('uploads').upload(filePath, imageFile);

      // get public url
      final imageUrl = await supabaseClient.storage
          .from('uploads')
          .getPublicUrl(filePath);

      // create database record
      final uploadData = {
        'user_id': userId,
        'image_url': imageUrl,
        'upload_source': source,
        'processing_status': 'pending',
      };

      final response = await supabaseClient
                          .from('uploads')
                          .insert(uploadData)
                          .select()
                          .single();
                
      return UploadModel.fromJson(response);
    } catch (e) {
      throw ServerException('Uplaod Failed; ${e.toString()}');
    }
  }
}
