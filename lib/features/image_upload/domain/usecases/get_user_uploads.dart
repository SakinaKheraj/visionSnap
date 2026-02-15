import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/upload.dart';
import '../repositories/image_repository.dart';

class GetUserUploads implements UseCase<List<Upload>, GetUserUploadsParams> {
  final ImageRepository repository;

  GetUserUploads(this.repository);
  
  @override
  Future<Either<Failure, List<Upload>>> call(GetUserUploadsParams params) async {
    return await repository.getUserUploads(params.userId);
  }
}

class GetUserUploadsParams {
  final String userId;

  GetUserUploadsParams({required this.userId});
}