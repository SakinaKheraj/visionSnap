import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/upload.dart';

abstract class ImageRepository {
  Future<Either<Failure, Upload>> uploadImage({
    required File imageFile,
    required String userId,
    required String source,
  });

  Future<Either<Failure, List<Upload>>> getUserUploads(String userId);

  Future<Either<Failure, Upload>> getUploadById(String uploadId);

  Future<Either<Failure, void>> deleteUpload(String uploadId);
}