import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';
import 'package:loadup/main.dart';

abstract class PendingShipmentsRemoteDataSource {
  Future<ShipmentsModel> getPendingShipments();
}

class PendingShipmentsRemoteDataSourceImp
    implements PendingShipmentsRemoteDataSource {
  final CrudDio dio;

  PendingShipmentsRemoteDataSourceImp({required this.dio});

  @override
  Future<ShipmentsModel> getPendingShipments() async {
    final result = await dio.dioGetMethod(
        endPoint: AppLinkUrl.getpendingShipments,
        token: storage.getString('token'),
        queryParameters: {});

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (pendingShipmentsResponse) =>
          ShipmentsModel.fromJson(pendingShipmentsResponse),
    );
  }
}
