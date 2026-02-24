import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DetectedItem extends Equatable {
  final String id;
  final String uploadId;
  final String label;
  final double confidence;
  final Map<String, dynamic>? boundingBox;
  final Map<String, dynamic>? attributes;
  final DateTime createdAt;

  DetectedItem({
    required this.id,
    required this.uploadId,
    required this.label,
    required this.confidence,
    this.boundingBox,
    this.attributes,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    uploadId,
    label,
    confidence,
    boundingBox,
    attributes,
  ];
}

class DetectionResult extends Equatable {
  final String uploadId;
  final List<DetectedItem> items;
  final String status;

  DetectionResult({
    required this.uploadId,
    required this.items,
    required this.status,
  });
  
  @override
  List<Object?> get props => [
    uploadId,
    items,
    status,
  ];
}
