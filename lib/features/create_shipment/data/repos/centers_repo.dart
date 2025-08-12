import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/create_shipment/data/datasource/centers_remote_data_source.dart';
import 'package:loadup/features/create_shipment/data/datasource/governorates_remote_data_source.dart';
import 'package:loadup/features/create_shipment/data/models/centers_model.dart';
import 'package:loadup/features/create_shipment/data/models/governorates_model.dart';

class CentersRepo {
  final CentersRemoteDataSource centersRemoteDataSource;
  final NetworkInfo networkInfo;

  CentersRepo({
    required this.centersRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, CentersModel>> getcenters(
      {int page = 1}) async {
    if (await networkInfo.isConnected) {
      try {
        final centersResponse =
            await centersRemoteDataSource.getcenters(page: page);

        return Right(centersResponse);
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
