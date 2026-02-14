import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class UpdatePassword implements UseCase<void, UpdatePasswordParams> {
  final AuthRepository repository;

  UpdatePassword(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdatePasswordParams params) async {
    return await repository.updatePassword(newPassword: params.newPassword);
  }
}

class UpdatePasswordParams {
  final String newPassword;

  UpdatePasswordParams({required this.newPassword});
}
