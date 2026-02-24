import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/detected_item.dart';
import '../repositories/detection_repository.dart';

class DetectItems implements UseCase<DetectionResult, DetectItemsParams> {
  final DetectionRepository repository;

  DetectItems({required this.repository});

  @override
  Future<Either<Failure, DetectionResult>> call(
    DetectItemsParams params,
  ) async {
    return await repository.detectItems(
      imageUrl: params.imageUrl,
      uploadId: params.uploadId,
    );
  }
}

class DetectItemsParams {
  final String imageUrl;
  final String uploadId;
  
  DetectItemsParams({
    required this.imageUrl,
    required this.uploadId,
  });
}
