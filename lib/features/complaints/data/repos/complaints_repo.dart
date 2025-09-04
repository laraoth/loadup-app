import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/complaints/data/datasources/complaints_remote_data_source.dart';
import 'package:loadup/features/complaints/data/models/complaints_model.dart';

class ComplaintsRepo {
  final ComplaintsRemoteDataSource complaintsRemoteDataSource;
  final NetworkInfo networkInfo;

  ComplaintsRepo({
    required this.complaintsRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, ComplaintsModel>> getcomplaints() async {
    if (await networkInfo.isConnected) {
      try {
        final getComplaintsResponse =
            await complaintsRemoteDataSource.getcomplaints();

        return Right(getComplaintsResponse);
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
