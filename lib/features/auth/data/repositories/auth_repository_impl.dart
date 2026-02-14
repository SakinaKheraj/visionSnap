import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    // check internet first
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No Internet Connection'));
    }

    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    String? username,
    String? fullname,
  }) async {
    // check internet first
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No Internet Connection'));
    }

    try {
      final user = await remoteDataSource.register(
        email: email,
        password: password,
        username: username,
        fullname: fullname,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    String? redirectTo,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      await remoteDataSource.resetPassword(
        email: email,
        redirectTo: redirectTo,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, void>> updatePassword({
    required String newPassword,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      await remoteDataSource.updatePassword(newPassword: newPassword);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }
}
