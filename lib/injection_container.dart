import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'core/network/network_info.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_current_user.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/logout.dart';
import 'features/auth/domain/usecases/register.dart';
import 'features/auth/domain/usecases/reset_password.dart';
import 'features/auth/domain/usecases/update_password.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

// Image Upload
import 'features/image_upload/data/datasources/image_remote_datasource.dart';
import 'features/image_upload/data/repositories/image_repository_impl.dart';
import 'features/image_upload/domain/repositories/image_repository.dart';
import 'features/image_upload/domain/usecases/upload_image.dart';
import 'features/image_upload/domain/usecases/get_user_uploads.dart';
import 'features/image_upload/presentation/bloc/upload_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      login: sl(),
      register: sl(),
      logout: sl(),
      getCurrentUser: sl(),
      resetPassword: sl(),
      updatePassword: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));
  sl.registerLazySingleton(() => UpdatePassword(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  // Supabase initialization (assuming it will be initialized in main before calling init)
  sl.registerLazySingleton(() => Supabase.instance.client);
  sl.registerLazySingleton(() => Connectivity());

  //! Features - Image Upload
  // Bloc
  sl.registerFactory(
    () => UploadBloc(
      uploadImage: sl(),
      getUserUploads: sl(),
      currentUserId: sl<SupabaseClient>().auth.currentUser?.id ?? "",
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => UploadImage(sl()));
  sl.registerLazySingleton(() => GetUserUploads(sl()));

  // Repository
  sl.registerLazySingleton<ImageRepository>(
    () => ImageRepositoryImpl(remoteDatasource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ImageRemoteDatasource>(
    () => ImageRemoteDatasourceImpl(sl()),
  );
}
