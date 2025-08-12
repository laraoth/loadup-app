import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';
import 'package:loadup/main.dart';

abstract class ReceivedShipmentsRemoteDataSource {
  Future<ShipmentsModel> getreceivedshipments();
}

class ReceivedShipmentsRemoteDataSourceImp
    implements ReceivedShipmentsRemoteDataSource {
  final CrudDio dio;

  ReceivedShipmentsRemoteDataSourceImp({required this.dio});

  @override
  Future<ShipmentsModel> getreceivedshipments() async {
    final result = await dio.dioGetMethod(
      endPoint: AppLinkUrl.getreceivedshipments,
      token: storage.getString('token'),
      queryParameters: {},
    );

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (getReceivedshipmentsResponse) =>
          ShipmentsModel.fromJson(getReceivedshipmentsResponse),
    );
  }
}
