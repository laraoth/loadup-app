import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/edit_profile/data/datasources/edit_profile_remote_data_source.dart';
import 'package:loadup/features/edit_profile/data/models/edit_profile_model.dart';

import 'package:loadup/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:loadup/features/profile/data/models/profile_model.dart';

class EditProfileRepo {
  final EditProfileRemoteDataSource editprofileRemoteDataSource;
  final NetworkInfo networkInfo;

  EditProfileRepo({
    required this.editprofileRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, ProfileModel>> updateprofile(
      EditProfileModel editprofilemodel) async {
    final eprofilemdel = EditProfileModel(
      name: editprofilemodel.name,
      email: editprofilemodel.email,
      address: editprofilemodel.address,
      phone: editprofilemodel.phone,
      age: editprofilemodel.age,
    );
    if (await networkInfo.isConnected) {
      try {
        final updateprofileResponse =
            await editprofileRemoteDataSource.updateprofile(eprofilemdel);

        return Right(updateprofileResponse);
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
