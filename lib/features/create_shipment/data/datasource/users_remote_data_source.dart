import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/create_shipment/data/models/users_model.dart';
import 'package:loadup/main.dart';

abstract class UsersRemoteDataSource {
  Future<UsersModel> getusers({int page = 1});
}

class UsersRemoteDataSourceImp implements UsersRemoteDataSource {
  final CrudDio dio;

  UsersRemoteDataSourceImp({required this.dio});

  @override
  @override
  Future<UsersModel> getusers({int page = 1}) async {
    final result = await dio.dioGetMethod(
      endPoint: AppLinkUrl.getusers,
      token: storage.getString('token'),
      queryParameters: {
        "page": page,
        "per_page": 5,
        "search": "",
        "role": "customer",
        "sort_by": "created_at",
        "sort_order": "desc",
      },
    );

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (usersResponse) => UsersModel.fromJson(usersResponse),
    );
  }
}
