import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';
import 'package:loadup/features/profile/data/models/profile_model.dart';
import 'package:loadup/features/profile/presentation/screens/profile_screen.dart';
import 'package:loadup/main.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getprofile();
}

class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  final CrudDio dio;

  ProfileRemoteDataSourceImp({required this.dio});

  @override
  Future<ProfileModel> getprofile() async {
    final result = await dio.dioGetMethod(
      endPoint: AppLinkUrl.getprofile,
      token: storage.getString('token'),
      queryParameters: {},
    );

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (getprofileResponse) => ProfileModel.fromJson(getprofileResponse),
    );
  }
}
