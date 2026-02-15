import 'package:equatable/equatable.dart';

class Upload extends Equatable {
  final String id;
  final String userId;
  final String imageUrl;
  final String? thumbnailUrl;
  final String uploadSource;
  final DateTime createdAt;
  final String processingStatus;

  const Upload({
    required this.id,
    required this.userId,
    required this.imageUrl,
    this.thumbnailUrl,
    required this.uploadSource,
    required this.createdAt,
    required this.processingStatus,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    imageUrl,
    thumbnailUrl,
    uploadSource,
    createdAt,
    processingStatus,
  ];
}
