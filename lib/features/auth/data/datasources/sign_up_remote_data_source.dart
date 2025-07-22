import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/auth/data/models/login_request_body.dart';
import 'package:loadup/features/auth/data/models/login_response.dart';
import 'package:loadup/features/auth/data/models/sign_up_request_body.dart';
import 'package:loadup/features/auth/data/models/sign_up_response.dart';

abstract class SignUpRemoteDataSource {
  Future<SignUpResponse> signup(SignUpRequestBody signup);
}

class SignUpRemoteDataSourceImp implements SignUpRemoteDataSource {
  final CrudDio dio;

  SignUpRemoteDataSourceImp({required this.dio});

  @override
  Future<SignUpResponse> signup(SignUpRequestBody signup) async {
    final result = await dio.dioPostMethod(
      endPoint: AppLinkUrl.signup,
      data: {
        'name': signup.name,
        'email': signup.email,
        'password': signup.password,
        'phone': signup.phone,
        'address': signup.address,
        'age': signup.age,
        'role': signup.role,
        'password_confirmation': signup.passwordConfirmation,
      },
      token: '',
      queryParameters: {},
    );
    return result.fold(
      (fail) => throw ServerException(fail.message),
      (signupResponse) => SignUpResponse.fromJson(signupResponse),
    );
  }
}
