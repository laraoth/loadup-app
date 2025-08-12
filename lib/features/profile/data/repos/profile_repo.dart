import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/my_shipping/data/datasource/sent_shipments_remote_data_source.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';
import 'package:loadup/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:loadup/features/profile/data/models/profile_model.dart';

class ProfileRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepo({
    required this.profileRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, ProfileModel>> getprofile() async {
    if (await networkInfo.isConnected) {
      try {
        final getprofileResponse = await profileRemoteDataSource.getprofile();

        return Right(getprofileResponse);
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
