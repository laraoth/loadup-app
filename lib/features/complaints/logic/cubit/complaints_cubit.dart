import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:loadup/features/complaints/data/models/complaints_model.dart';
import 'package:loadup/features/complaints/data/repos/complaints_repo.dart';

part 'complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  final ComplaintsRepo _complaintsRepo;
  ComplaintsCubit(this._complaintsRepo) : super(ComplaintsInitial());

  int _currentPage = 1;
  int get currentPage => _currentPage;

  void getcomplaints({int page = 1}) async {
    emit(ComplaintsLoading());

    final response = await _complaintsRepo.getcomplaints(page: page);

    response.fold(
      (fail) {
        if (!isClosed) emit(ComplaintsError(fail.toString()));
      },
      (getComplaintsResponse) {
        if (!isClosed) {
          _currentPage = page;
          emit(ComplaintsSuccess(
            getComplaintsResponse.message,
            getComplaintsResponse,
          ));
        }
      },
    );
  }

  void nextPage() {
    getcomplaints(page: _currentPage + 1);
  }

  void previousPage() {
    if (_currentPage > 1) {
      getcomplaints(page: _currentPage - 1);
    }
  }
}
