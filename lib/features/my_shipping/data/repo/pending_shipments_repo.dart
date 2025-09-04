import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/my_shipping/data/datasource/pending_shipments_remote_data_source.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';

class PendingShipmentsRepo {
  final PendingShipmentsRemoteDataSource pendingShipmentsRemoteDataSource;
  final NetworkInfo networkInfo;

  PendingShipmentsRepo({
    required this.pendingShipmentsRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, ShipmentsModel>> getPendingShipments() async {
    if (await networkInfo.isConnected) {
      try {
        final pendingShipmentsResponse =
            await pendingShipmentsRemoteDataSource.getPendingShipments();
        return Right(pendingShipmentsResponse);
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
