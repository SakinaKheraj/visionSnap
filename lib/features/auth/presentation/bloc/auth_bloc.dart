import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionsnap/core/util/error_mapper.dart';
import 'package:visionsnap/features/auth/domain/usecases/reset_password.dart';
import 'package:visionsnap/features/auth/domain/usecases/update_password.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/get_current_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;
  final Logout logout;
  final GetCurrentUser getCurrentUser;
  final ResetPassword resetPassword;
  final UpdatePassword updatePassword;

  AuthBloc({
    required this.login,
    required this.register,
    required this.logout,
    required this.getCurrentUser,
    required this.resetPassword,
    required this.updatePassword,
  }) : super(AuthInitial()) {
    // Register event handlers
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
    on<UpdatePasswordRequested>(_onUpdatePasswordRequested);
  }

  /// Handle login event
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await login(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthError(ErrorMapper.map(failure.msg))),
      (user) => emit(Authenticated(user)),
    );
  }

  /// Handle register event
  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await register(
      RegisterParams(
        email: event.email,
        password: event.password,
        username: event.username,
        fullname: event.fullname,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(ErrorMapper.map(failure.msg))),
      (user) => emit(Authenticated(user)),
    );
  }

  /// Handle logout event
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await logout(const NoParams());

    result.fold(
      (failure) => emit(AuthError(ErrorMapper.map(failure.msg))),
      (_) => emit(Unauthenticated()),
    );
  }

  /// Check if user is already logged in (on app start)
  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await getCurrentUser(const NoParams());

    result.fold((failure) => emit(Unauthenticated()), (user) {
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  /// Handle password reset
  Future<void> _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await resetPassword(
      ResetPasswordParams(
        email: event.email,
        redirectTo: 'io.supabase.flutter://reset-callback/',
      ),
    );

    result.fold(
      (failure) => emit(AuthError(ErrorMapper.map(failure.msg))),
      (_) => emit(
        PasswordResetEmailSent('Password reset link sent to ${event.email}'),
      ),
    );
  }

  /// Handle password update
  Future<void> _onUpdatePasswordRequested(
    UpdatePasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await updatePassword(
      UpdatePasswordParams(newPassword: event.newPassword),
    );

    result.fold(
      (failure) => emit(AuthError(ErrorMapper.map(failure.msg))),
      (_) => emit(const PasswordUpdated('Password updated successfully!')),
    );
  }
}
