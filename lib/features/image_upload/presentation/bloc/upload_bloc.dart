import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/usecases/upload_image.dart';
import '../../domain/usecases/get_user_uploads.dart';
import 'upload_event.dart';
import 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UploadImage uploadImage;
  final GetUserUploads getUserUploads;
  final String currentUserId;

  UploadBloc({
    required this.uploadImage,
    required this.getUserUploads,
    required this.currentUserId,
  }) : super(UploadInitial()) {
    on<UploadImageEvent>(_onUploadImage);
    on<LoadUserUploadEvent>(_onLoadUserUploads);
  }

  Future<void> _onUploadImage(
    UploadImageEvent event,
    Emitter<UploadState> emit,
  ) async {
    emit(UploadLoading());

    final userId =
        Supabase.instance.client.auth.currentUser?.id ?? currentUserId;

    if (userId.isEmpty) {
      emit(const UploadError('Please login to upload images'));
      return;
    }

    final result = await uploadImage(
      UploadImageParams(
        imageFile: event.imageFile,
        userId: userId,
        source: event.source,
      ),
    );

    result.fold(
      (failure) => emit(UploadError(failure.msg)),
      (upload) => emit(UploadSuccess(upload)),
    );
  }

  Future<void> _onLoadUserUploads(
    LoadUserUploadEvent event,
    Emitter<UploadState> emit,
  ) async {
    emit(UploadLoading());

    final userId =
        Supabase.instance.client.auth.currentUser?.id ?? currentUserId;

    if (userId.isEmpty) {
      emit(const UploadError('Please login to view uploads'));
      return;
    }

    final result = await getUserUploads(GetUserUploadsParams(userId: userId));

    result.fold(
      (failure) => emit(UploadError(failure.msg)),
      (uploads) => emit(UploadsLoaded(uploads)),
    );
  }
}
