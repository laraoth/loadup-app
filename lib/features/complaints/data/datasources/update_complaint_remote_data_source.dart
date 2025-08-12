import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/complaints/data/models/update_complaint_request_model.dart';
import 'package:loadup/features/complaints/data/models/update_complaint_response_model.dart';
import 'package:loadup/main.dart';

abstract class UpdateComplaintsRemoteDataSource {
  Future<UpdateComplaintsResponseModel> updatecomplaints(
      UpdateComplaintsRequestModel updatecomplaints);
}

class UpdateComplaintsRemoteDataSourceImp
    implements UpdateComplaintsRemoteDataSource {
  final CrudDio dio;

  UpdateComplaintsRemoteDataSourceImp({required this.dio});

  @override
  Future<UpdateComplaintsResponseModel> updatecomplaints(
      UpdateComplaintsRequestModel updatecomplaints) async {
    final result = await dio.dioPutMethod(
        endPoint: AppLinkUrl.updateComplaint(updatecomplaints.complaintId!),
        data: {
          'description': updatecomplaints.description,
        },
        token: storage.getString('token'),
        queryParameters: {});

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (updateComplaintsResponse) =>
          UpdateComplaintsResponseModel.fromJson(updateComplaintsResponse),
    );
  }
}
