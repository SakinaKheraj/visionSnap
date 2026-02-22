import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/upload.dart';
import '../../domain/repositories/image_repository.dart';
import '../datasources/image_remote_datasource.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  ImageRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Upload>> uploadImage({
    required File imageFile,
    required String userId,
    required String source,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final upload = await remoteDatasource.uploadImage(
        imageFile: imageFile,
        userId: userId,
        source: source,
      );
      return Right(upload);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, List<Upload>>> getUserUploads(String userId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final uploads = await remoteDatasource.getUserUploads(userId);
      return Right(uploads);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, Upload>> getUploadById(String uploadId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final upload = await remoteDatasource.getUploadById(uploadId);
      return Right(upload);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUpload(String uploadId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      await remoteDatasource.deleteUpload(uploadId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }
}