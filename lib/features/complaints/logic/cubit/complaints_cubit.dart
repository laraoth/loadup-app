import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:loadup/features/complaints/data/models/complaints_model.dart';
import 'package:loadup/features/complaints/data/repos/complaints_repo.dart';

part 'complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  final ComplaintsRepo _complaintsRepo;
  ComplaintsCubit(this._complaintsRepo) : super(ComplaintsInitial());

  void getcomplaints() async {
    emit(ComplaintsLoading());

    final response = await _complaintsRepo.getcomplaints();

    response.fold(
      (fail) {
        if (!isClosed) emit(ComplaintsError(fail.toString()));
      },
      (getComplaintsResponse) {
        if (!isClosed) {
          emit(ComplaintsSuccess(
            getComplaintsResponse.message,
            getComplaintsResponse,
          ));
        }
      },
    );
  }
}
