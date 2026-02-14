import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

// Contract for remote data source
abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String email,
    required String password,
    String? username,
    String? fullname,
  });
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<void> resetPassword({required String email, String? redirectTo});
  Future<void> updatePassword({required String newPassword});
}

// Implementation using Supabase
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = await supabaseClient.auth.currentUser;

      if (user == null) return null;

      return UserModel(
        id: user.id,
        email: user.email!,
        username: user.userMetadata?['username'],
        fullname: user.userMetadata?['fullname'],
        avatarUrl: user.userMetadata?['avatar_url'],
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException('Login Failed');
      }

      return UserModel(
        id: response.user!.id,
        email: response.user!.email!,
        username: response.user!.userMetadata?['username'],
        fullname: response.user!.userMetadata?['fullname'],
        avatarUrl: response.user!.userMetadata?['avatar_url'],
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      return await supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    String? username,
    String? fullname,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'username': username, 'fullname': fullname},
      );

      if (response.user == null) {
        throw ServerException('Registration Failed');
      }

      return UserModel(
        id: response.user!.id,
        email: response.user!.email!,
        username: username,
        fullname: fullname,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
    String? redirectTo,
  }) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(
        email,
        redirectTo: redirectTo,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updatePassword({required String newPassword}) async {
    try {
      await supabaseClient.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
