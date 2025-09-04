import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/wallet/data/models/payment_model.dart';
import 'package:loadup/main.dart';

abstract class PaymentsRemoteDataSource {
  Future<PaymentsModel> getPayments({int page, int perPage});
}

class PaymentsRemoteDataSourceImp implements PaymentsRemoteDataSource {
  final CrudDio dio;
  PaymentsRemoteDataSourceImp({required this.dio});

  @override
  Future<PaymentsModel> getPayments({int page = 1, int perPage = 10}) async {
    final result = await dio.dioGetMethod(
      endPoint: AppLinkUrl.getPayments,
      token: storage.getString('token'),
      queryParameters: {
        "page": page,
        "per_page": perPage,
        "sort_by": "created_at",
        "sort_order": "desc",
      },
    );

    return result.fold(
      (fail) => throw ServerException(fail.message),
      (response) => PaymentsModel.fromJson(response),
    );
  }
}
