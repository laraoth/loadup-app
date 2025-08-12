import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/reset_password/data/datasources/reset_password_remote_data_source.dart';
import 'package:loadup/features/reset_password/data/models/reset_password_request.dart';
import 'package:loadup/features/reset_password/data/models/reset_password_response.dart';

class ResetPasswordRepo {
  final ResetPasswordRemoteDataSource resetPasswordRemoteDataSource;
  final NetworkInfo networkInfo;

  ResetPasswordRepo({
    required this.resetPasswordRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, ResetPasswordResponse>> reset(
      ResetPasswordRequest reset) async {
    final resetModel = ResetPasswordRequest(
      email: reset.email,
      newpassword: reset.newpassword,
    );

    if (await networkInfo.isConnected) {
      try {
        final resetResponse =
            await resetPasswordRemoteDataSource.reset(resetModel);

        return Right(resetResponse);
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
