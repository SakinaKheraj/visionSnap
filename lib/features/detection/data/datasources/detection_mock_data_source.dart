import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/detected_item_model.dart';

class DetectionMockDataSource {
  final SupabaseClient supabaseClient;

  DetectionMockDataSource({required this.supabaseClient});

  Future<List<DetectedItemModel>> detectItems({
    required String imageUrl,
    required String uploadId,
  }) async {
    try {
      print('Mock Data: Simulating detection...');

      await Future.delayed(const Duration(seconds: 2));

      final labelPool = [
        // Fashion Items
        ['Dress', 'Clothing', 'Fashion', 'Textile'],
        ['Shoes', 'Footwear', 'Sneaker', 'Fashion'],
        ['Handbag', 'Bag', 'Accessory', 'Fashion'],
        ['Sunglasses', 'Eyewear', 'Accessory'],
        ['Watch', 'Timepiece', 'Accessory', 'Jewelry'],

        // Furniture
        ['Chair', 'Furniture', 'Seat'],
        ['Table', 'Furniture', 'Wood'],
        ['Sofa', 'Couch', 'Furniture', 'Seating'],
        ['Lamp', 'Light', 'Lighting', 'Home decor'],

        // Electronics
        ['Phone', 'Smartphone', 'Mobile device', 'Electronics'],
        ['Laptop', 'Computer', 'Electronics', 'Technology'],
        ['Headphones', 'Audio', 'Electronics'],

        // Home items
        ['Plant', 'Houseplant', 'Indoor plant', 'Green'],
        ['Vase', 'Decoration', 'Home decor'],
        ['Pillow', 'Cushion', 'Home decor', 'Textile'],
      ];

      final random = Random();
      final selectedLabels = labelPool[random.nextInt(labelPool.length)];

      final List<DetectedItemModel> mockItems = [];

      for (int i = 0; i < selectedLabels.length; i++) {
        final baseConfidence = 0.95 - (i * 0.08);
        final randomVariation = (random.nextDouble() * 0.05) - 0.025;
        final confidence = (baseConfidence + randomVariation).clamp(0.6, 0.99);

        final boundingBox = i == 0
            ? {
                'vertices': [
                  {'x': 0.1, 'y': 0.15},
                  {'x': 0.9, 'y': 0.15},
                  {'x': 0.9, 'y': 0.85},
                  {'x': 0.1, 'y': 0.85},
                ],
              }
            : null;

        final itemData = {
          'upload_id': uploadId,
          'label': selectedLabels[i],
          'confidence': confidence,
          'bounding_box': boundingBox,
          'attributes': {
            'mock': true, // Flag to know this is mock data
            'category': _getCategoryForLabel(selectedLabels[i]),
          },
        };

        final saved = await supabaseClient
            .from('detected_items')
            .insert(itemData)
            .select()
            .single();

        mockItems.add(DetectedItemModel.fromJson(saved));
      }
      await supabaseClient
          .from('uploads')
          .update({'processing_status': 'completed'})
          .eq('id', uploadId);

      print('✅ MOCK: Generated ${mockItems.length} items');
      print('🏷️  Labels: ${mockItems.map((e) => e.label).join(", ")}');

      return mockItems;
    } catch (e) {
      await supabaseClient
          .from('uploads')
          .update({'processing_status': 'failed'})
          .eq('id', uploadId);

      print('Mock Detection Failed: ${e.toString()}');
      throw ServerException("Mock Detection Failed: ${e.toString()}");
    }
  }

  /// Get items from database (same as real implementation)
  Future<List<DetectedItemModel>> getDetectedItems(String uploadId) async {
    try {
      final response = await supabaseClient
          .from('detected_items')
          .select()
          .eq('upload_id', uploadId);

      return (response as List)
          .map((json) => DetectedItemModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException('Failed to load items: ${e.toString()}');
    }
  }

  /// Helper to categorize labels
  String _getCategoryForLabel(String label) {
    final fashionKeywords = [
      'dress',
      'clothing',
      'shoes',
      'bag',
      'watch',
      'sunglasses',
    ];
    final furnitureKeywords = ['chair', 'table', 'sofa', 'lamp', 'furniture'];
    final electronicsKeywords = [
      'phone',
      'laptop',
      'headphones',
      'electronics',
    ];

    final lowerLabel = label.toLowerCase();

    if (fashionKeywords.any((k) => lowerLabel.contains(k))) return 'fashion';
    if (furnitureKeywords.any((k) => lowerLabel.contains(k)))
      return 'furniture';
    if (electronicsKeywords.any((k) => lowerLabel.contains(k)))
      return 'electronics';

    return 'other';
  }
}
