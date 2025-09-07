import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/payment/data/datasources/payments_remote_data_source.dart';
import 'package:loadup/features/payment/data/models/payments_model.dart';

class PaymentsRepo {
  final PaymentsRemoteDataSource paymentsremoteDataSource;
  final NetworkInfo networkInfo;

  PaymentsRepo(
      {required this.paymentsremoteDataSource, required this.networkInfo});

  Future<Either<Failure, PaymentsModel>> getPayments() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await paymentsremoteDataSource.getPayments();

        print("[PaymentsRepo] Raw Payments Response: $response");

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
