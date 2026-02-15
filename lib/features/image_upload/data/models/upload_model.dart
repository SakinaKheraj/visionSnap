import '../../domain/entities/upload.dart';

class UploadModel extends Upload {
  const UploadModel({
    required super.id,
    required super.userId,
    required super.imageUrl,
    super.thumbnailUrl,
    required super.uploadSource,
    required super.processingStatus,
    required super.createdAt,
  });

  factory UploadModel.fromJson(Map<String, dynamic> json) {
    return UploadModel(
      id: json['id'],
      userId: json['user_id'],
      imageUrl: json['image_url'],
      thumbnailUrl: json['thumbnail_url'],
      uploadSource: json['upload_source'],
      processingStatus: json['processing_status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'image_url': imageUrl,
      'thumbnail_url': thumbnailUrl,
      'upload_source': uploadSource,
      'processing_status': processingStatus,
      'created_at': createdAt.toIso8601String(),
    };
  }
}