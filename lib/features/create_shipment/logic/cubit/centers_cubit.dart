import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:loadup/features/create_shipment/data/models/centers_model.dart';
import 'package:loadup/features/create_shipment/data/repos/centers_repo.dart';

part 'centers_state.dart';

class CentersCubit extends Cubit<CentersState> {
  final CentersRepo _centersRepo;
  CentersCubit(this._centersRepo) : super(CentersInitial());

  final TextEditingController destinationCenterController =
      TextEditingController();
  final TextEditingController originCenterController = TextEditingController();

  int? selectedOriginCenterId;
  int? selectedDestinationCenterId;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  void getcenters({int page = 1}) async {
    emit(CentersLoading());

    final response = await _centersRepo.getcenters(page: page);

    response.fold(
      (fail) {
        if (!isClosed) emit(CentersError(fail.toString()));
      },
      (centersResponse) {
        if (!isClosed) {
          _currentPage = page;
          emit(CentersSuccess(
            centersResponse.message,
            centersResponse,
          ));
        }
      },
    );
  }

  void nextPage() {
    getcenters(page: _currentPage + 1);
  }

  void previousPage() {
    if (_currentPage > 1) {
      getcenters(page: _currentPage - 1);
    }
  }

  void setSelectedOriginCenter(CenterDatum center) {
    selectedOriginCenterId = center.id;
    originCenterController.text = center.name;
    emit(CentersSelectionUpdated());
  }

  void setSelectedDestinationCenter(CenterDatum center) {
    selectedDestinationCenterId = center.id;
    destinationCenterController.text = center.name;
    emit(CentersSelectionUpdated());
  }
}
