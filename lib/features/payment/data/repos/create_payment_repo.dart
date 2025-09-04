import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/payment/data/datasources/create_payment_remote_data_source.dart';
import 'package:loadup/features/payment/data/models/create_payment_response_model.dart';

class ApprovePriceRepo {
  final ApprovePriceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ApprovePriceRepo({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, ApprovePriceModel>> approvePrice(
      int shipmentId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.approvePrice(shipmentId);
        return Right(response);
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
