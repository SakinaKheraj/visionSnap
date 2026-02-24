import '../../domain/entities/detected_item.dart';

class DetectedItemModel extends DetectedItem {
  DetectedItemModel({
    required super.id,
    required super.uploadId,
    required super.label,
    required super.confidence,
    super.attributes,
    super.boundingBox,
    required super.createdAt,
  });

  factory DetectedItemModel.fromJson(Map<String, dynamic> json) {
    return DetectedItemModel(
      id: json['id'],
      uploadId: json['upload_id'],
      label: json['label'],
      confidence: (json['confidence'] as num).toDouble(),
      boundingBox: json['bounding_box'],
      attributes: json['attributes'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'upload_id': uploadId,
      'label': label,
      'confidence': confidence,
      'bounding_box': boundingBox,
      'attributes': attributes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class DetectionResultModel extends DetectionResult {
  DetectionResultModel({
    required super.uploadId,
    required super.items,
    required super.status,
  });

  factory DetectionResultModel.fromItems(
    String uploadId,
    List<DetectedItemModel> items,
  ) {
    return DetectionResultModel(
      uploadId: uploadId,
      items: items,
      status: items.isNotEmpty ? 'completed' : 'failed',
    );
  }
}
