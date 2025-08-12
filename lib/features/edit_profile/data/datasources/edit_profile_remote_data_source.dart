import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/edit_profile/data/models/edit_profile_model.dart';
import 'package:loadup/features/profile/data/models/profile_model.dart';
import 'package:loadup/main.dart';

abstract class EditProfileRemoteDataSource {
  Future<ProfileModel> updateprofile(EditProfileModel editprofilemodel);
}

class EditProfileRemoteDataSourceImp implements EditProfileRemoteDataSource {
  final CrudDio dio;

  EditProfileRemoteDataSourceImp({required this.dio});

  @override
  Future<ProfileModel> updateprofile(EditProfileModel editprofilemodel) async {
    final result = await dio.dioPutMethod(
      data: {
        'name': editprofilemodel.name,
        'email': editprofilemodel.email,
        'phone': editprofilemodel.phone,
        'address': editprofilemodel.address,
        'age': editprofilemodel.age,
        'role': 'customer',
      },
      endPoint: AppLinkUrl.updateprofile,
      token: storage.getString('token'),
      queryParameters: {},
    );

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (updateprofileResponse) => ProfileModel.fromJson(updateprofileResponse),
    );
  }
}
