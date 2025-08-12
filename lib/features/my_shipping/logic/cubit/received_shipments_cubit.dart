import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';
import 'package:loadup/features/my_shipping/data/repo/received_shipments_repo.dart';

part 'received_shipments_state.dart';

class ReceivedShipmentsCubit extends Cubit<ReceivedShipmentsState> {
  final ReceivedShipmentsRepo _receivedShipmentsRepo;
  ReceivedShipmentsCubit(this._receivedShipmentsRepo)
      : super(ReceivedShipmentsInitial());

  void getreceivedshipments() async {
    emit(ReceivedShipmentsLoading());
    final response = await _receivedShipmentsRepo.getreceivedshipments();

    response.fold(
      (fail) {
        if (!isClosed) emit(ReceivedShipmentsError(fail.toString()));
      },
      (getReceivedshipmentsResponse) {
        if (!isClosed) {
          emit(ReceivedShipmentsSuccess(getReceivedshipmentsResponse.message,
              getReceivedshipmentsResponse));
        }
      },
    );
  }
}
