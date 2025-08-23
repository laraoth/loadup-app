import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/complaints/data/datasources/create_complaint_remote_data_source.dart';
import 'package:loadup/features/complaints/data/models/create_complains_request_model.dart';
import 'package:loadup/features/complaints/data/models/create_complains_response_model.dart';

class CreateComplaintRepo {
  final CreateComplaintsRemoteDataSource createComplaintsRemoteDataSource;
  final NetworkInfo networkInfo;

  CreateComplaintRepo({
    required this.createComplaintsRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, CreateComplaintsResponseModel>> createcomplaints(
      CreateComplaintsRequestModel createcomplaints) async {
    final createcopmlaintsModel = CreateComplaintsRequestModel(
        shipmentId: createcomplaints.shipmentId,
        description: createcomplaints.description);

    if (await networkInfo.isConnected) {
      try {
        final createComplaintsResponse = await createComplaintsRemoteDataSource
            .createcomplaints(createcopmlaintsModel);

        return Right(createComplaintsResponse);
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
