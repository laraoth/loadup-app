import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/create_shipment/data/datasource/governorates_remote_data_source.dart';
import 'package:loadup/features/create_shipment/data/models/governorates_model.dart';

class GovernoratesRepo {
  final GovernoratesRemoteDataSource governoratesRemoteDataSource;
  final NetworkInfo networkInfo;

  GovernoratesRepo({
    required this.governoratesRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, GovernoratesModel>> getgovernorates({
    int page = 1,
    int perPage = 10,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await governoratesRemoteDataSource.getgovernorates(
          page: page,
          perPage: perPage,
          search: search,
          sortBy: sortBy,
          sortOrder: sortOrder,
        );
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
