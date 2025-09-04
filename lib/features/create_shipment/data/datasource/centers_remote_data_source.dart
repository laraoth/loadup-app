import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/create_shipment/data/models/centers_model.dart';

import 'package:loadup/main.dart';

abstract class CentersRemoteDataSource {
  Future<CentersModel> getcenters();
}

class CentersRemoteDataSourceImp implements CentersRemoteDataSource {
  final CrudDio dio;

  CentersRemoteDataSourceImp({required this.dio});

  @override
  Future<CentersModel> getcenters() async {
    final result = await dio.dioGetMethod(
      endPoint: AppLinkUrl.getcenters,
      token: storage.getString('token'),
      queryParameters: {},
    );
    print("🔍 Response: $result");

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (centersResponse) => CentersModel.fromJson(centersResponse),
    );
  }
}
