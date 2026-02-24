import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/detected_item.dart';

abstract class DetectionRepository {
  Future<Either<Failure, DetectionResult>> detectItems({
    required String imageUrl,
    required String uploadId,
  });

  Future<Either<Failure, List<DetectedItem>>> getDetectedItems({
    required String uploadId,
  });
}