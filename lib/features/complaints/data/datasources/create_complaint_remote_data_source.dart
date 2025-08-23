import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/complaints/data/models/create_complains_request_model.dart';
import 'package:loadup/features/complaints/data/models/create_complains_response_model.dart';
import 'package:loadup/main.dart';

abstract class CreateComplaintsRemoteDataSource {
  Future<CreateComplaintsResponseModel> createcomplaints(
      CreateComplaintsRequestModel createcomplaints);
}

class CreateComplaintsRemoteDataSourceImp
    implements CreateComplaintsRemoteDataSource {
  final CrudDio dio;

  CreateComplaintsRemoteDataSourceImp({required this.dio});

  @override
  Future<CreateComplaintsResponseModel> createcomplaints(
      CreateComplaintsRequestModel createcomplaints) async {
    final result = await dio.dioPostMethod(
        endPoint: AppLinkUrl.sendcomplaints,
        token: storage.getString('token'),
        data: createcomplaints.toJson(),
        queryParameters: {});

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (createComplaintsResponse) =>
          CreateComplaintsResponseModel.fromJson(createComplaintsResponse),
    );
  }
}
