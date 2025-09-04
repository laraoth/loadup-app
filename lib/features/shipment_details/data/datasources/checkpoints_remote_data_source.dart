import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/shipment_details/data/models/checkpoints_model.dart';
import 'package:loadup/main.dart';

abstract class CheckpointsRemoteDataSource {
  Future<CheckpointsModel> getCheckpoints({int page, int perPage});
}

class CheckpointsRemoteDataSourceImp implements CheckpointsRemoteDataSource {
  final CrudDio dio;
  CheckpointsRemoteDataSourceImp({required this.dio});

  @override
  Future<CheckpointsModel> getCheckpoints(
      {int page = 1, int perPage = 10}) async {
    final result = await dio.dioGetMethod(
      endPoint: AppLinkUrl.getCheckpoints,
      token: storage.getString('token'),
      queryParameters: {
        "page": page,
        "per_page": perPage,
        "search": "",
        "governorate_id": "",
        "sort_by": "created_at",
        "sort_order": "desc",
      },
    );

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (response) => CheckpointsModel.fromJson(response),
    );
  }
}
