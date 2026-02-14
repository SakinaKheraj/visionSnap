import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String? username;
  final String? fullname;

  const RegisterRequested({
    required this.email,
    required this.password,
    this.username,
    this.fullname,
  });

  @override
  List<Object?> get props => [email, password, username, fullname];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

// App started - check if user is already logged in
class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

class ResetPasswordRequested extends AuthEvent {
  final String email;

  const ResetPasswordRequested(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdatePasswordRequested extends AuthEvent {
  final String newPassword;

  const UpdatePasswordRequested(this.newPassword);

  @override
  List<Object?> get props => [newPassword];
}
