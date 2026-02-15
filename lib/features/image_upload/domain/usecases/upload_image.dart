import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/upload.dart';
import '../repositories/image_repository.dart';

class UploadImage implements UseCase<Upload, UploadImageParams> {
  final ImageRepository repository;

  UploadImage(this.repository);
  
  @override
  Future<Either<Failure, Upload>> call(UploadImageParams params) async {
    return await repository.uploadImage(
      imageFile: params.imageFile,
      userId: params.userId,
      source: params.source,
    );
  }
}

class UploadImageParams {
  final File imageFile;
  final String userId;
  final String source;

  UploadImageParams({
    required this.imageFile,
    required this.userId,
    required this.source,
  });
}

