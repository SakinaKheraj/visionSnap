//  Domain Layer - Entity
import 'package:equatable/equatable.dart';

class Upload extends Equatable {
    final String id;
    final String userId;
    final String imageUrl;
    final String? thumbnailUrl;
    final String uploadSource; // 'camera' or 'gallery'
    final String processingStatus;  // 'pending', 'processing', 'completed', 'failed'
    final DateTime createdAt;

    const Upload({
        required this.id,
        required this.userId,
        required this.imageUrl,
        this.thumbnailUrl,
        required this.uploadSource,
        required this.processingStatus,
        required this.createdAt,
    });

    @override
    List<Object?> get props => [
        id,
        userId,
        imageUrl,
        thumbnailUrl,
        uploadSource,
        processingStatus,
        createdAt,
    ];
}