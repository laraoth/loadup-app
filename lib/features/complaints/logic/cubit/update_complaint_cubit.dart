import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/features/complaints/data/models/update_complaint_request_model.dart';
import 'package:loadup/features/complaints/data/models/update_complaint_response_model.dart';
import 'package:loadup/features/complaints/data/repos/update_complaint_repo.dart';
import 'package:loadup/features/complaints/logic/cubit/complaints_cubit.dart';

part 'update_complaint_state.dart';

class UpdateComplaintsCubit extends Cubit<UpdateComplaintsState> {
  final UpdateComplaintsRepo _updateComplaintsRepo;
  UpdateComplaintsCubit(this._updateComplaintsRepo)
      : super(UpdateComplaintsInitial());

  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<bool> updatecomplaints(int complaintId) async {
    print('updatecomplaints called with id: $complaintId');

    if (!formKey.currentState!.validate()) {
      print('Form validation failed');
      return false;
    }

    final response = await _updateComplaintsRepo.updatecomplaints(
      UpdateComplaintsRequestModel(
        complaintId: complaintId,
        description: descriptionController.text.trim(),
      ),
    );

    print('Response received from repo');

    return response.fold(
      (fail) {
        print('Update failed with error: $fail');
        return false;
      },
      (updateComplaintsResponse) {
        print('Update success: ${updateComplaintsResponse.message}');
        return true;
      },
    );
  }

  @override
  Future<void> close() {
    descriptionController.dispose();
    return super.close();
  }
}
