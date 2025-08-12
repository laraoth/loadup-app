import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:loadup/features/create_shipment/data/models/shipment_request_model.dart';
import 'package:loadup/features/create_shipment/data/repos/shipment_request_repo.dart';

part 'shipment_request_state.dart';

class ShipmentRequestCubit extends Cubit<ShipmentRequestState> {
  final ShipmentRequestRepo _shipmentRequestRepo;
  ShipmentRequestCubit(this._shipmentRequestRepo)
      : super(ShipmentRequestInitial());

  final TextEditingController typeOfCargoController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController originAddressController = TextEditingController();
  final TextEditingController destinationAddressController =
      TextEditingController();
  final TextEditingController specialInstructionsController =
      TextEditingController();

  int? selectedReceiverId;
  int? selectedOriginGovernorateId;
  int? selectedDestinationGovernorateId;
  int? selectedOriginCenterId;
  int? selectedDestinationCenterId;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void shipmentrequest() async {
    if (!formKey.currentState!.validate()) return;

    emit(ShipmentRequestLoading());
    final response = await _shipmentRequestRepo.shipmentrequest(
      ShipmentRequestModel(
        weight: double.parse(weightController.text.trim()),
        typeOfCargo: typeOfCargoController.text.trim(),
        destinationAddress: destinationAddressController.text.trim(),
        originAddress: originAddressController.text.trim(),
        specialHandlingInstructions: specialInstructionsController.text.trim(),
        destinationCenterId: selectedDestinationCenterId!,
        destinationGovernorateId: selectedDestinationGovernorateId!,
        originCenterId: selectedOriginCenterId!,
        originGovernorateId: selectedOriginGovernorateId!,
        receiverId: selectedReceiverId!,
      ),
    );

    response.fold(
      (fail) {
        if (!isClosed) emit(ShipmentRequestError(fail.toString()));
      },
      (loginResponse) {
        if (!isClosed) {
          emit(ShipmentRequestSuccess(loginResponse.message ??
              'The shipment request has been sent successfully.'));
        }
      },
    );
  }

  @override
  Future<void> close() {
    weightController.dispose();
    typeOfCargoController.dispose();
    destinationAddressController.dispose();
    originAddressController.dispose();
    specialInstructionsController.dispose();
    return super.close();
  }
}
