import 'package:equatable/equatable.dart';
import '../../domain/entities/upload.dart';

abstract class UploadState extends Equatable {
  const UploadState();

  @override
  List<Object?> get props => [];
}

class UploadInitial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadSuccess extends UploadState {
  final Upload upload;

  const UploadSuccess(this.upload);

  @override
  List<Object?> get props => [upload];
}

class UploadsLoaded extends UploadState {
  final List<Upload> uploads;

  const UploadsLoaded(this.uploads);

  @override
  List<Object?> get props => [uploads];
}

class UploadError extends UploadState {
  final String message;

  const UploadError(this.message);

  @override
  List<Object?> get props => [message];
}

class UploadDeleted extends UploadState {
  const UploadDeleted();
}