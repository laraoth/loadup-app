import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:loadup/features/complaints/data/models/create_complains_request_model.dart';
import 'package:loadup/features/complaints/data/repos/create_complaint_repo.dart';

part 'create_complaints_state.dart';

class CreateComplaintsCubit extends Cubit<CreateComplaintsState> {
  final CreateComplaintRepo _createComplaintRepo;
  CreateComplaintsCubit(this._createComplaintRepo)
      : super(CreateComplaintsInitial());

  final TextEditingController shipmentidController = TextEditingController();
  final TextEditingController shipmentdescriptionController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int? selectedShipmentId;

  void selectShipmentId(int id) {
    selectedShipmentId = id;
    shipmentidController.text = id.toString();
    emit(CreateComplaintsInitial());
  }

  void createcomplaint() async {
    if (!formKey.currentState!.validate() || selectedShipmentId == null) return;

    emit(CreateComplaintsLoading());
    final response = await _createComplaintRepo.createcomplaints(
      CreateComplaintsRequestModel(
        shipmentId: selectedShipmentId!,
        description: shipmentdescriptionController.text.trim(),
      ),
    );

    response.fold(
      (fail) {
        if (!isClosed) emit(CreateComplaintsError(fail.toString()));
      },
      (createComplaintsResponse) {
        if (!isClosed) {
          emit(CreateComplaintsSuccess(createComplaintsResponse.message ??
              'The complaint has been successfully submitted.'));
        }
      },
    );
  }

  @override
  Future<void> close() {
    shipmentidController.dispose();
    shipmentdescriptionController.dispose();
    return super.close();
  }
}
