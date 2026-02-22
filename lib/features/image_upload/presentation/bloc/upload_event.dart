import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object?> get props => [];
}

class UploadImageEvent extends UploadEvent {
  final File imageFile;
  final String source;

  UploadImageEvent({required this.imageFile, required this.source});

  @override
  List<Object?> get props => [imageFile, source];
}

class LoadUserUploadEvent extends UploadEvent {
  const LoadUserUploadEvent();
}

class DeleteUserUploadEvent extends UploadEvent {
  final String uploadId;
  const DeleteUserUploadEvent(this.uploadId);

  @override
  List<Object?> get props => [uploadId];
}
