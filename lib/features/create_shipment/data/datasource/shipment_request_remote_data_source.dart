import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/auth/data/models/login_request_body.dart';
import 'package:loadup/features/auth/data/models/login_response.dart';
import 'package:loadup/features/create_shipment/data/models/shipment_request_model.dart';
import 'package:loadup/features/create_shipment/data/models/shipment_response_model.dart';
import 'package:loadup/main.dart';

abstract class ShipmentRequestRemoteDataSource {
  Future<ShipmentResponseModel> shipmentrequest(ShipmentRequestModel shipmentrequest);
}

class ShipmentRequestRemoteDataSourceImp implements ShipmentRequestRemoteDataSource {
  final CrudDio dio;

  ShipmentRequestRemoteDataSourceImp({required this.dio});

  @override
  Future<ShipmentResponseModel> shipmentrequest(ShipmentRequestModel shipmentrequest) async {
    final result = await dio.dioPostMethod(
      endPoint: AppLinkUrl.shipmentrequest,
      data: shipmentrequest.toJson(),
      token:storage.getString('token'),
      queryParameters: {},
    );
   
    return result.fold(
      (fail) => throw ServerException(fail.message),
      (shipmentResponse) => ShipmentResponseModel.fromJson(shipmentResponse),
    );
  }
}
