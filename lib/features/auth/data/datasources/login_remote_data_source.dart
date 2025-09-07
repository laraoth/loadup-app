import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/auth/data/models/login_request_body.dart';
import 'package:loadup/features/auth/data/models/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(LoginRequestBody login);
}

class LoginRemoteDataSourceImp implements LoginRemoteDataSource {
  final CrudDio dio;

  LoginRemoteDataSourceImp({required this.dio});

  @override
  Future<LoginResponse> login(LoginRequestBody login) async {
    final result = await dio.dioPostMethod(
      endPoint: AppLinkUrl.login,
      data: {
        'email': login.email,
        'password': login.password,
      },
      token: '',
      queryParameters: {},
    );

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (loginResponse) => LoginResponse.fromJson(loginResponse),
    );
  }
}
