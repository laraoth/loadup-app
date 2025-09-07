import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/shipment_details/data/datasources/checkpoints_remote_data_source.dart';
import 'package:loadup/features/shipment_details/data/models/checkpoints_model.dart';

class CheckpointsRepo {
  final CheckpointsRemoteDataSource checkpointsRemoteDataSource;
  final NetworkInfo networkInfo;

  CheckpointsRepo({
    required this.checkpointsRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, CheckpointsModel>> getCheckpoints({
    int page = 1,
    int perPage = 10,
    required int groupId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await checkpointsRemoteDataSource.getCheckpoints(
          page: page,
          perPage: perPage,
          groupId: groupId,
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
