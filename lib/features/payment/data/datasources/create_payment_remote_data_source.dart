import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/payment/data/models/create_payment_response_model.dart';
import 'package:loadup/main.dart';

abstract class ApprovePriceRemoteDataSource {
  Future<ApprovePriceModel> approvePrice(int shipmentId);
}

class ApprovePriceRemoteDataSourceImp implements ApprovePriceRemoteDataSource {
  final CrudDio dio;

  ApprovePriceRemoteDataSourceImp({required this.dio});

  @override
  Future<ApprovePriceModel> approvePrice(int shipmentId) async {
    final result = await dio.dioPostMethod(
      endPoint: AppLinkUrl.approvePrice,
      data: {
        "shipment_id": shipmentId,
      },
      token: storage.getString('token'),
      queryParameters: {},
    );

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (approveResponse) => ApprovePriceModel.fromJson(approveResponse),
    );
  }
}
