// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/detected_item.dart';
import '../../domain/repositories/detection_repository.dart';
import '../datasources/detection_remote_data_source.dart';
import '../datasources/detection_mock_data_source.dart';
import '../models/detected_item_model.dart';

class DetectionRepositoryImpl implements DetectionRepository {
  final DetectionRemoteDataSource? remoteDataSource;
  final DetectionMockDataSource mockDataSource;
  final NetworkInfo networkInfo;
  final bool useMockData;

  DetectionRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    this.useMockData = false,
    required this.mockDataSource,
  });

  @override
  Future<Either<Failure, DetectionResult>> detectItems({
    required String imageUrl,
    required String uploadId,
  }) async {
    // Check internet connection
    print('Checking Internet Connection...');
    
    if (!await networkInfo.isConnected) {
      print('No Internet Connection');
      return const Left(NetworkFailure("No Internet Connection"));
    }
    print("Internet Connection OK");

    try {
      // call remote data source
      print('Starting detection upload for $uploadId');

      // Use mock or real data source based on flag
      final List<DetectedItemModel> items;
      if (useMockData) {
        print('Using MOCK data source');
        items = await mockDataSource.detectItems(
          imageUrl: imageUrl,
          uploadId: uploadId,
        );
      } else {
        print('Using REAL data source');
        items = await remoteDataSource!.detectItems(
          imageUrl: imageUrl,
          uploadId: uploadId,
        );
      }

      // create result from items
      final result = DetectionResultModel.fromItems(uploadId, items);

      print('Detection Completed: ${items.length} items found');
      return Right(result);
    } on ServerException catch (e) {
      print('Server Error ${e.msg}');
      return Left(ServerFailure(e.msg));
    } catch (e) {
      print('Unexpected Error $e');
      return Left(ServerFailure('Detection Failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<DetectedItem>>> getDetectedItems({
    required String uploadId,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No Internet Connection'));
    }

    try {
      // get items from database
      final items = await mockDataSource.getDetectedItems(uploadId);
      print('Loaded ${items.length} items from database');
      return Right(items);
    } on ServerException catch (e) {
      print('Error loading items: ${e.msg}');
      return Left(ServerFailure(e.msg));
    } catch (e) {
      print('Error loading items: ${e.toString()}');
      return Left(ServerFailure('Failed to load items: ${e.toString()}'));
    }
  }
}
