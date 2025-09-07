import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/features/payment/data/models/payments_model.dart';
import 'package:loadup/features/payment/data/repos/payments_repo.dart';
import 'payments_state.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  final PaymentsRepo _repo;

  PaymentsCubit(this._repo) : super(PaymentsInitial());

  Future<void> fetchPayments() async {
    emit(PaymentsLoading());
    print("📡 [PaymentsCubit] Fetching payments...");

    final response = await _repo.getPayments();

    response.fold(
      (fail) {
        print(" [PaymentsCubit] Failed to fetch payments: $fail");
        if (!isClosed) emit(PaymentsError(fail.toString()));
      },
      (paymentsResponse) {
        print(" [PaymentsCubit] Payments fetched successfully!");
        print(" Total payments: ${paymentsResponse.data?.length ?? 0}");

        if (paymentsResponse.data != null &&
            paymentsResponse.data!.isNotEmpty) {
          for (final p in paymentsResponse.data!) {
            print(" Payment id=${p.id}, amount=${p.amount}, "
                "cargo=${p.shipment?.typeOfCargo}, code=${p.shipment?.code}");
          }
        }

        if (!isClosed) {
          emit(PaymentsSuccess(paymentsResponse));
        }
      },
    );
  }
}
