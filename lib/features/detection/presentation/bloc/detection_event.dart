import 'package:equatable/equatable.dart';

/// Base class for all detection events
/// Events = things that happen (user actions, system events)
class DetectionEvent extends Equatable {
  const DetectionEvent();

  @override
  List<Object?> get props => [];
}

/// User wants to detect items in an uploaded image
/// Triggered after image upload completes
class DetectItemsEvent extends DetectionEvent {
  final String imageUrl;
  final String uploadId;

  const DetectItemsEvent({required this.imageUrl, required this.uploadId});

  @override
  List<Object?> get props => [imageUrl, uploadId];
}

// User wants to see previously detected items
/// Triggered when viewing upload history
class LoadDetectedItemsEvent extends DetectionEvent {
  final String uploadId;

  const LoadDetectedItemsEvent({
    required this.uploadId
    });

  @override
  List<Object?> get props => [uploadId];
}
