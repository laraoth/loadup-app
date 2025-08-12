import 'package:bloc/bloc.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';
import 'package:loadup/features/my_shipping/data/repo/sent_shipments_repo.dart';

part 'sent_shipments_state.dart';

class SentShipmentsCubit extends Cubit<SentShipmentsState> {
  final SentShipmentsRepo _sentshipmentsRepo;
  SentShipmentsCubit(this._sentshipmentsRepo) : super(SentShipmentsInitial());

  void getshipments() async {
    emit(SentShipmentsLoading());
    final response = await _sentshipmentsRepo.getsentshipments();

    response.fold(
      (fail) {
        if (!isClosed) emit(SentShipmentsError(fail.toString()));
      },
      (getsentshipmentsResponse) {
        if (!isClosed) {
          emit(SentShipmentsSuccess(
              getsentshipmentsResponse.message, getsentshipmentsResponse));
        }
      },
    );
  }
}
