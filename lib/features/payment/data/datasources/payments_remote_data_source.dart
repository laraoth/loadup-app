import 'dart:convert';
import 'package:loadup/core/networking/app_link_url.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/error/exceptions.dart';
import 'package:loadup/features/payment/data/models/payments_model.dart';
import 'package:loadup/main.dart';

abstract class PaymentsRemoteDataSource {
  Future<PaymentsModel> getPayments();
}

class PaymentsRemoteDataSourceImp implements PaymentsRemoteDataSource {
  final CrudDio dio;

  PaymentsRemoteDataSourceImp({required this.dio});

  @override
  Future<PaymentsModel> getPayments() async {
    print(" [PaymentsRemoteDataSource] Fetching payments...");

    final token = storage.getString('token');
    print(" Token: $token");
    print(" Endpoint: ${AppLinkUrl.getPayments}");

    final result = await dio.dioGetMethod(
      endPoint: AppLinkUrl.getPayments,
      token: token,
      queryParameters: {},
    );

    return result.fold(
      (fail) {
        print(" [PaymentsRemoteDataSource] Error: ${fail.message}");
        throw ServerException(fail.message);
      },
      (response) {
        print("  [PaymentsRemoteDataSource] Raw Response: $response");

        try {
          final paymentsModel = PaymentsModel.fromJson(response);
          print(" [PaymentsRemoteDataSource] Parsed PaymentsModel:");
          print("   success: ${paymentsModel.success}");
          print("   message: ${paymentsModel.message}");
          print("   total payments: ${paymentsModel.data?.length ?? 0}");

          if (paymentsModel.data != null) {
            for (var payment in paymentsModel.data!) {
              print(" Payment id=${payment.id}, amount=${payment.amount}, "
                  "cargo=${payment.shipment?.typeOfCargo}, code=${payment.shipment?.code}");
            }
          }

          return paymentsModel;
        } catch (e) {
          print(" [PaymentsRemoteDataSource] Parsing Error: $e");
          throw ServerException("Failed to parse payments response");
        }
      },
    );
  }
}
