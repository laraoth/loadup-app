import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/create_shipment/data/models/users_model.dart';
import 'package:loadup/main.dart';

abstract class UsersRemoteDataSource {
  Future<UsersModel> getusers({
    int page,
    int perPage,
    String? search,
    String? role,
    String? sortBy,
    String? sortOrder,
  });
}

class UsersRemoteDataSourceImp implements UsersRemoteDataSource {
  final CrudDio dio;

  UsersRemoteDataSourceImp({required this.dio});

  @override
  Future<UsersModel> getusers({
    int page = 1,
    int perPage = 5,
    String? search,
    String? role = "customer",
    String? sortBy = "created_at",
    String? sortOrder = "desc",
  }) async {
    final result = await dio.dioGetMethod(
      endPoint: AppLinkUrl.getusers,
      token: storage.getString('token'),
      queryParameters: {
        "page": page,
        "per_page": perPage,
        if (search != null && search.isNotEmpty) "search": search,
        if (role != null) "role": role,
        if (sortBy != null) "sort_by": sortBy,
        if (sortOrder != null) "sort_order": sortOrder,
      },
    );

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (usersResponse) => UsersModel.fromJson(usersResponse),
    );
  }
}
