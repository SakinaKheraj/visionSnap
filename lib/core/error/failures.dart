import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String msg;

  const Failure(this.msg);
  @override
  List<Object> get props => [msg];
}

class ServerFailure extends Failure {
  const ServerFailure(super.msg);
}

class CacheFailure extends Failure {
  const CacheFailure(super.msg);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.msg);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.msg);
}