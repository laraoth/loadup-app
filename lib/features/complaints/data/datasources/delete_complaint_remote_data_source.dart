import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/main.dart';

abstract class DeleteComplaintRemoteDataSource {
  Future<String> deleteComplaint(int id);
}

class DeleteComplaintRemoteDataSourceImp
    implements DeleteComplaintRemoteDataSource {
  final CrudDio dio;

  DeleteComplaintRemoteDataSourceImp({required this.dio});

  @override
  Future<String> deleteComplaint(int id) async {
    final result = await dio.dioDeleteMethod(
      endPoint: AppLinkUrl.deleteComplaint(id),
      token: storage.getString('token'),
      data: {},
      queryParameters: {},
    );

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (deleteResponse) => deleteResponse["message"] ?? "Deleted successfully",
    );
  }
}
