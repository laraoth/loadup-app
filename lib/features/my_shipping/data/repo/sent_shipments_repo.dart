import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/my_shipping/data/datasource/sent_shipments_remote_data_source.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';

class SentShipmentsRepo {
  final SentShipmentsRemoteDataSource sentshipmentsRemoteDataSource;
  final NetworkInfo networkInfo;

  SentShipmentsRepo({
    required this.sentshipmentsRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, ShipmentsModel>> getsentshipments() async {
    if (await networkInfo.isConnected) {
      try {
        final getsentshipmentsResponse =
            await sentshipmentsRemoteDataSource.getsentshipments();

        return Right(getsentshipmentsResponse);
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
