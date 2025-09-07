import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/create_shipment/data/datasource/governorates_remote_data_source.dart';
import 'package:loadup/features/create_shipment/data/datasource/users_remote_data_source.dart';
import 'package:loadup/features/create_shipment/data/models/governorates_model.dart';
import 'package:loadup/features/create_shipment/data/models/users_model.dart';

class UsersRepo {
  final UsersRemoteDataSource usersRemoteDataSource;
  final NetworkInfo networkInfo;

  UsersRepo({
    required this.usersRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, UsersModel>> getusers({
    int page = 1,
    int perPage = 5,
    String? search,
    String? role,
    String? sortBy,
    String? sortOrder,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final usersresponse = await usersRemoteDataSource.getusers(
          page: page,
          perPage: perPage,
          search: search,
          role: role,
          sortBy: sortBy,
          sortOrder: sortOrder,
        );
        return Right(usersresponse);
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
