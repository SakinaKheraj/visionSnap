import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Register implements UseCase<User, RegisterParams> {
    final AuthRepository repository;

    Register(this.repository);

    @override
    Future<Either<Failure, User>> call(RegisterParams params) async{
        return await repository.register(
            email: params.email,
            password: params.password,
            username: params.username,
            fullname: params.fullname,
        );
    }
}

class RegisterParams {
    final String email;
    final String password;
    final String username;
    final String fullname;

  RegisterParams({
    required this.email,
    required this.password,
    required this.username,
    required this.fullname
    });

    
}