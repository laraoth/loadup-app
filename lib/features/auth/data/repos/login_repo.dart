import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/auth/data/datasources/login_remote_data_source.dart';
import 'package:loadup/features/auth/data/models/login_request_body.dart';
import 'package:loadup/features/auth/data/models/login_response.dart';
import 'package:loadup/main.dart'; 

class LoginRepo {
  final LoginRemoteDataSource loginRemoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepo({
    required this.loginRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, LoginResponse>> login(LoginRequestBody login) async {
    final loginModel = LoginRequestBody(
      email: login.email,
      password: login.password,
    );

    if (await networkInfo.isConnected) {
      try {
        final loginResponse = await loginRemoteDataSource.login(loginModel);

   
        final token = loginResponse.data.token;
        if (token != null && token.isNotEmpty) {
          await storage.setString("token", token);
        }

        return Right(loginResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure("Unexpected error: $e"));
      }
    } else {
      return Left(OfflineFailure("No internet connection"));
    }
  }
}
