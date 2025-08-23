import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/auth/data/models/login_request_body.dart';
import 'package:loadup/features/auth/data/models/login_response.dart';
import 'package:loadup/features/create_shipment/data/models/governorates_model.dart';
import 'package:loadup/features/create_shipment/data/models/shipment_request_model.dart';
import 'package:loadup/features/create_shipment/data/models/shipment_response_model.dart';
import 'package:loadup/main.dart';

abstract class GovernoratesRemoteDataSource {
  Future<GovernoratesModel> getgovernorates({
    int page,
    int perPage,
    String? search,
    String? sortBy,
    String? sortOrder,
  });
}

class GovernoratesRemoteDataSourceImp implements GovernoratesRemoteDataSource {
  final CrudDio dio;

  GovernoratesRemoteDataSourceImp({required this.dio});

  @override
  Future<GovernoratesModel> getgovernorates({
    int page = 1,
    int perPage = 10,
    String? search,
    String? sortBy = "name",
    String? sortOrder = "asc",
  }) async {
    final result = await dio.dioGetMethod(
      endPoint: AppLinkUrl.getgovernorates,
      token: storage.getString('token'),
      queryParameters: {
        "page": page,
        "per_page": perPage,
        if (search != null && search.isNotEmpty) "search": search,
        if (sortBy != null) "sort_by": sortBy,
        if (sortOrder != null) "sort_order": sortOrder,
      },
    );

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (response) => GovernoratesModel.fromJson(response),
    );
  }
}
