import 'package:cairn/core/config/api_config.dart';
import 'package:cairn/core/network.dart/dio_client.dart';
import 'package:cairn/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:cairn/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:cairn/features/authentication/domain/repositories/auth_repository.dart';
import 'package:cairn/features/authentication/domain/usecase/sign_up_owner.dart';
import 'package:cairn/features/authentication/presentation/desktop/bloc/owner_signup_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void configureDependencies() {
  // ---------- Core ----------
  sl.registerLazySingleton<Dio>(
    () => DioClient.create(baseUrl: ApiConfig.baseUrl),
  );

  // ---------- Authentication ----------
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => ApiAuthRemoteDataSource(sl<Dio>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );
  sl.registerLazySingleton<SignUpOwner>(
    () => SignUpOwner(sl<AuthRepository>()),
  );

  // Blocs are factories: a new instance per page.
  sl.registerFactory<OwnerSignupBloc>(
    () => OwnerSignupBloc(signUpOwner: sl<SignUpOwner>()),
  );
}