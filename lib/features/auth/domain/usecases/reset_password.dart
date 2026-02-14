import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class ResetPassword implements UseCase<void, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPassword(this.repository);

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(
      email: params.email,
      redirectTo: params.redirectTo,
    );
  }
}

class ResetPasswordParams {
  final String email;
  final String? redirectTo;

  ResetPasswordParams({required this.email, this.redirectTo});
}
