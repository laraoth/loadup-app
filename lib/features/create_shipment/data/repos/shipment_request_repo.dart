import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/auth/data/datasources/login_remote_data_source.dart';
import 'package:loadup/features/auth/data/models/login_request_body.dart';
import 'package:loadup/features/auth/data/models/login_response.dart';
import 'package:loadup/features/create_shipment/data/datasource/shipment_request_remote_data_source.dart';
import 'package:loadup/features/create_shipment/data/models/shipment_request_model.dart';
import 'package:loadup/features/create_shipment/data/models/shipment_response_model.dart';
import 'package:loadup/main.dart';

class ShipmentRequestRepo {
  final ShipmentRequestRemoteDataSource shipmentRequestRemoteDataSource;
  final NetworkInfo networkInfo;

  ShipmentRequestRepo({
    required this.shipmentRequestRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, ShipmentResponseModel>> shipmentrequest(
      ShipmentRequestModel shipmentrequest) async {
    final shipmentRequestModel = ShipmentRequestModel(
      receiverId: shipmentrequest.receiverId,
      destinationAddress: shipmentrequest.destinationAddress,
      destinationCenterId: shipmentrequest.destinationCenterId,
      destinationGovernorateId: shipmentrequest.destinationGovernorateId,
      originAddress: shipmentrequest.originAddress,
      originCenterId: shipmentrequest.originCenterId,
      originGovernorateId: shipmentrequest.originGovernorateId,
      specialHandlingInstructions: shipmentrequest.specialHandlingInstructions,
      typeOfCargo: shipmentrequest.typeOfCargo,
      weight: shipmentrequest.weight,
    );

    if (await networkInfo.isConnected) {
      try {
        final shipmentresponse = await shipmentRequestRemoteDataSource.shipmentrequest(shipmentRequestModel);


        return Right(shipmentresponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure("Unexpected error: $e"));
      }
    } else {
      return Left(OfflineFailure("No internet connection"));
    }
  }
}
