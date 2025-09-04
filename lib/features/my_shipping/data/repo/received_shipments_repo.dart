import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/my_shipping/data/datasource/received_shipments_remote_data_source.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';

class ReceivedShipmentsRepo {
  final ReceivedShipmentsRemoteDataSource receivedShipmentsRemoteDataSource;
  final NetworkInfo networkInfo;

  ReceivedShipmentsRepo({
    required this.receivedShipmentsRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, ShipmentsModel>> getreceivedshipments(
      {String? status}) async {
    if (await networkInfo.isConnected) {
      try {
        final getReceivedshipmentsResponse =
            await receivedShipmentsRemoteDataSource.getreceivedshipments(
                status: status);

        return Right(getReceivedshipmentsResponse);
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
