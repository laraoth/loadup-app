import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/auth/data/models/LogoutResponse.dart';
import 'package:loadup/main.dart';

abstract class LogoutRemoteDataSource {
  Future<LogoutResponse> logout(String token);
}

class LogoutRemoteDatasourceImp implements LogoutRemoteDataSource {
  final CrudDio dio;

  LogoutRemoteDatasourceImp({required this.dio});

  @override
  Future<LogoutResponse> logout(String token) async {
    final token = await storage.getString('token');

    final result = await dio.dioPostMethod(
      endPoint: AppLinkUrl.logout,
      data: {},
      queryParameters: {},
      token: token,
    );
    return result.fold(
      (fail) => throw ServerException(fail.message),
      (logoutResponse) => LogoutResponse.fromJson(logoutResponse),
    );
  }
}
