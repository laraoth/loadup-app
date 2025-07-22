import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/auth/data/datasources/login_remote_data_source.dart';
import 'package:loadup/features/auth/data/datasources/sign_up_remote_data_source.dart';
import 'package:loadup/features/auth/data/models/login_request_body.dart';
import 'package:loadup/features/auth/data/models/login_response.dart';
import 'package:loadup/features/auth/data/models/sign_up_request_body.dart';
import 'package:loadup/features/auth/data/models/sign_up_response.dart';
import 'package:loadup/main.dart';

class SignUpRepo {
  final SignUpRemoteDataSource signupRemoteDataSource;
  final NetworkInfo networkInfo;
  SignUpRepo({
    required this.signupRemoteDataSource,
    required this.networkInfo,
  });
  Future<Either<Failure, SignUpResponse>> signup(
      SignUpRequestBody signup) async {
    final SignUpRequestBody signupModel = SignUpRequestBody(
      name: signup.name,
      email: signup.email,
      password: signup.password,
      phone: signup.phone,
      address: signup.address,
      age: signup.age,
      passwordConfirmation: signup.passwordConfirmation,
    );

    if (await networkInfo.isConnected) {
      try {
        final signUpResponse = await signupRemoteDataSource.signup(signupModel);
         final token = signUpResponse.data.token;
        if (token != null && token.isNotEmpty) {
          await storage.setString("token", token);
        }
        return Right(signUpResponse);
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
