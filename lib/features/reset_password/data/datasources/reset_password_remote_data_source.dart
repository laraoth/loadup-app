import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/auth/data/models/login_request_body.dart';
import 'package:loadup/features/auth/data/models/login_response.dart';
import 'package:loadup/features/reset_password/data/models/reset_password_request.dart';
import 'package:loadup/features/reset_password/data/models/reset_password_response.dart';

abstract class ResetPasswordRemoteDataSource {
  Future<ResetPasswordResponse> reset(ResetPasswordRequest reset);
}

class ResetPasswordRemoteDataSourceImp
    implements ResetPasswordRemoteDataSource {
  final CrudDio dio;

  ResetPasswordRemoteDataSourceImp({required this.dio});

  @override
  Future<ResetPasswordResponse> reset(ResetPasswordRequest reset) async {
    final result = await dio.dioPostMethod(
      endPoint: AppLinkUrl.reset,
      data: {
        'email': reset.email,
        'new_password': reset.newpassword,
      },
      token: '',
      queryParameters: {},
    );
    // return Future.value(unit);
    return result.fold(
      (fail) => throw ServerException(fail.message),
      (resetPasswordResponse) =>
          ResetPasswordResponse.fromJson(resetPasswordResponse),
    );
  }
}
