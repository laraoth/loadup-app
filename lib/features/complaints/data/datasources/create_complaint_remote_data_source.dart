import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/complaints/data/models/create_complains_request_model.dart';
import 'package:loadup/features/complaints/data/models/create_complains_response_model.dart';

abstract class CreateComplaintsRemoteDataSource {
  Future<CreateComplaintsResponseModel> createcomplaints(
      CreateComplaintsRequestModel createcomplaints);
}

class SendComplaintsRemoteDataSourceImp
    implements CreateComplaintsRemoteDataSource {
  final CrudDio dio;

  SendComplaintsRemoteDataSourceImp({required this.dio});

  @override
  Future<CreateComplaintsResponseModel> createcomplaints(
      CreateComplaintsRequestModel createcomplaints) async {
    final result = await dio
        .dioPostMethod(endPoint: AppLinkUrl.sendcomplaints, token: '', data: {
      'shipment_id': createcomplaints.shipmentId,
      'customer_id': createcomplaints.customerId,
      'description': createcomplaints.description,
    }, queryParameters: {});

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (createComplaintsResponse) =>
          CreateComplaintsResponseModel.fromJson(createComplaintsResponse),
    );
  }
}
