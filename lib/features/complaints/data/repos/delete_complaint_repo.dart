import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/complaints/data/datasources/delete_complaint_remote_data_source.dart';

class DeleteComplaintRepo {
  final DeleteComplaintRemoteDataSource deleteComplaintRemoteDataSource;
  final NetworkInfo networkInfo;

  DeleteComplaintRepo({
    required this.deleteComplaintRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, String>> deleteComplaint(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await deleteComplaintRemoteDataSource.deleteComplaint(id);
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
