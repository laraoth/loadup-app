import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/complaints/data/datasources/update_complaint_remote_data_source.dart';
import 'package:loadup/features/complaints/data/models/update_complaint_request_model.dart';
import 'package:loadup/features/complaints/data/models/update_complaint_response_model.dart';

class UpdateComplaintsRepo {
  final UpdateComplaintsRemoteDataSource updateComplaintsRemoteDataSource;
  final NetworkInfo networkInfo;

  UpdateComplaintsRepo({
    required this.updateComplaintsRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, UpdateComplaintsResponseModel>> updatecomplaints(
      UpdateComplaintsRequestModel updatecomplaints) async {
    final updatecopmlaintsModel = UpdateComplaintsRequestModel(
        complaintId: updatecomplaints.complaintId,
        description: updatecomplaints.description);
    if (await networkInfo.isConnected) {
      try {
        final updateComplaintsResponse = await updateComplaintsRemoteDataSource
            .updatecomplaints(updatecopmlaintsModel);

        return Right(updateComplaintsResponse);
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
