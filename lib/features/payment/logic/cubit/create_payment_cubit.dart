import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loadup/features/payment/data/repos/create_payment_repo.dart';
import 'package:loadup/features/payment/logic/cubit/create_payment_state.dart';

class ApprovePriceCubit extends Cubit<ApprovePriceState> {
  final ApprovePriceRepo repo;
  ApprovePriceCubit(this.repo) : super(ApprovePriceInitial());

  void approvePrice(int shipmentId) async {
    emit(ApprovePriceLoading());
    final response = await repo.approvePrice(shipmentId);

    response.fold(
      (fail) => emit(ApprovePriceError(fail.toString())),
      (data) => emit(ApprovePriceSuccess(data)),
    );
  }
}
