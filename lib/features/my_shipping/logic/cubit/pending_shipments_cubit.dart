import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';
import 'package:loadup/features/my_shipping/data/repo/pending_shipments_repo.dart';

part 'pending_shipments_state.dart';

class PendingShipmentsCubit extends Cubit<PendingShipmentsState> {
  final PendingShipmentsRepo _pendingShipmentsRepo;
  PendingShipmentsCubit(this._pendingShipmentsRepo)
      : super(PendingShipmentsInitial());

  void getPendingShipments() async {
    emit(PendingShipmentsLoading());
    final response = await _pendingShipmentsRepo.getPendingShipments();

    response.fold(
      (fail) {
        if (!isClosed) emit(PendingShipmentsError(fail.toString()));
      },
      (pendingShipmentsResponse) {
        if (!isClosed) {
          emit(PendingShipmentsSuccess(
              pendingShipmentsResponse.message, pendingShipmentsResponse));
        }
      },
    );
  }
}
