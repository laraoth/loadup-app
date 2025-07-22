import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/auth/data/datasources/login_remote_data_source.dart';
import 'package:loadup/features/auth/data/datasources/logout_remote_data_source.dart';
import 'package:loadup/features/auth/data/datasources/sign_up_remote_data_source.dart';
import 'package:loadup/features/auth/data/repos/login_repo.dart';
import 'package:loadup/features/auth/data/repos/logout_repo.dart';
import 'package:loadup/features/auth/data/repos/sign_up_repo.dart';
import 'package:loadup/features/auth/logic/cubit/login_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/logout_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/signup_cubit.dart';
import 'package:loadup/features/reset_password/data/datasources/reset_password_remote_data_source.dart';
import 'package:loadup/features/reset_password/data/repos/reset_password_repo.dart';
import 'package:loadup/features/reset_password/logic/cubit/reset_password_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupGetit() async {
  //! feature - login

  // cubit
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt()),
  );
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));

  //repo
  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepo(networkInfo: getIt(), loginRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<SignUpRepo>(
    () => SignUpRepo(networkInfo: getIt(), signupRemoteDataSource: getIt()),
  );
  //data source
  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<SignUpRemoteDataSource>(
    () => SignUpRemoteDataSourceImp(dio: getIt()),
  );
  //! Core

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(internetConnectionChecker: getIt()),
  );

  getIt.registerLazySingleton(() => CrudDio());

  //! External

  final sharedPreference = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreference);
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  getIt.registerFactory<LogoutCubit>(
    () => LogoutCubit(getIt()),
  );

  getIt.registerLazySingleton<LogoutRepo>(
    () => LogoutRepo(networkInfo: getIt(), logoutRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<LogoutRemoteDataSource>(
    () => LogoutRemoteDatasourceImp(dio: getIt()),
  );

  getIt.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(getIt()),
  );
  getIt.registerLazySingleton<ResetPasswordRemoteDataSource>(
    () => ResetPasswordRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<ResetPasswordRepo>(
    () => ResetPasswordRepo(
        networkInfo: getIt(), resetPasswordRemoteDataSource: getIt()),
  );
}
