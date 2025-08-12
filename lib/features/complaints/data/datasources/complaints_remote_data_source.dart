import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/complaints/data/models/complaints_model.dart';
import 'package:loadup/main.dart';

abstract class ComplaintsRemoteDataSource {
  Future<ComplaintsModel> getcomplaints({int page = 1});
}

class ComplaintsRemoteDataSourceImp implements ComplaintsRemoteDataSource {
  final CrudDio dio;

  ComplaintsRemoteDataSourceImp({required this.dio});

  @override
  Future<ComplaintsModel> getcomplaints({int page = 1}) async {
    final result = await dio.dioGetMethod(
        endPoint: AppLinkUrl.getcomplaints,
        token: storage.getString('token'),
        queryParameters: {
          "page": 1,
          "per_page": 10,
          "search": "",
          "shipment_id": "",
          "customer_id": "",
          "sort_by": "created_at",
          "sort_order": "desc"
        });

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (getComplaintsResponse) =>
          ComplaintsModel.fromJson(getComplaintsResponse),
    );
  }
}
