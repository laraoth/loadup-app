import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/complaints/data/models/complaints_model.dart';
import 'package:loadup/main.dart';

abstract class ComplaintsRemoteDataSource {
  Future<ComplaintsModel> getcomplaints();
}

class ComplaintsRemoteDataSourceImp implements ComplaintsRemoteDataSource {
  final CrudDio dio;

  ComplaintsRemoteDataSourceImp({required this.dio});

  @override
  Future<ComplaintsModel> getcomplaints() async {
    final result = await dio.dioGetMethod(
      endPoint: AppLinkUrl.getcomplaints,
      token: storage.getString('token'),
      queryParameters: {},
    );
    return result.fold(
      (fail) => throw ServerException(fail.message),
      (jsonResponse) {
        try {
          return ComplaintsModel.fromJson(jsonResponse);
        } catch (e, s) {
          print("❌ Parsing error: $e");
          print("Stack trace: $s");
          throw ServerException("Parsing error: $e");
        }
      },
    );
  }
}
