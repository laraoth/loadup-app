import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/wallet/data/datasources/payment_remote_data_source.dart';
import 'package:loadup/features/wallet/data/models/payment_model.dart';

class PaymentsRepo {
  final PaymentsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PaymentsRepo({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, PaymentsModel>> getPayments({int page = 1}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getPayments(page: page);
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
