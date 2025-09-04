import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/features/wallet/data/repos/payment_repo.dart';
import 'package:loadup/features/wallet/logic/cubit/payment_state.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  final PaymentsRepo repo;
  int currentPage = 1;
  int lastPage = 1;

  PaymentsCubit(this.repo) : super(PaymentsInitial());
  fetchPayments({int page = 1}) async {
    final res = await repo.getPayments(page: page);
    res.fold((f) => emit(PaymentsError(f.toString())), (data) async {
      lastPage = data.meta.pagination.lastPage;

      final lastRes = await repo.getPayments(page: lastPage);
      lastRes.fold(
        (f) => emit(PaymentsError(f.toString())),
        (lastData) {
          lastData.data.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          emit(PaymentsSuccess(lastData));
        },
      );
    });
  }

  void nextPage() {
    if (currentPage < lastPage) {
      fetchPayments(page: currentPage + 1);
    }
  }

  void prevPage() {
    if (currentPage > 1) {
      fetchPayments(page: currentPage - 1);
    }
  }
}
