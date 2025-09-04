import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';
import 'package:loadup/main.dart';

abstract class SentShipmentsRemoteDataSource {
  Future<ShipmentsModel> getsentshipments({String? status});
}

class SentShipmentsRemoteDataSourceImp
    implements SentShipmentsRemoteDataSource {
  final CrudDio dio;

  SentShipmentsRemoteDataSourceImp({required this.dio});

  @override
  Future<ShipmentsModel> getsentshipments({String? status}) async {
    final result = await dio.dioGetMethod(
      endPoint: AppLinkUrl.getsentshipments,
      token: storage.getString('token'),
      queryParameters: status != null ? {"filters[status]": status} : {},
    );

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (getSentshipmentsResponse) =>
          ShipmentsModel.fromJson(getSentshipmentsResponse),
    );
  }
}
