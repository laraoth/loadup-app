import 'package:dartz/dartz.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/core/networking/error/failure.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/auth/data/datasources/logout_remote_data_source.dart';
import 'package:loadup/features/auth/data/models/LogoutResponse.dart';
import 'package:loadup/main.dart';

class LogoutRepo {
  final LogoutRemoteDataSource logoutRemoteDataSource;
  final NetworkInfo networkInfo;

  LogoutRepo({
    required this.logoutRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, LogoutResponse>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await storage.getString("token");
        if (token == null || token.isEmpty) {
          return Left(ServerFailure("Token not found"));
        }

        final logoutResponse = await logoutRemoteDataSource.logout(token!);

        if (logoutResponse.success) {
          await storage.remove("token");
        }

        return Right(logoutResponse);
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
