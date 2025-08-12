import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:loadup/features/create_shipment/data/models/governorates_model.dart';
import 'package:loadup/features/create_shipment/data/repos/governorates_repo.dart';

part 'governorates_state.dart';

class GovernoratesCubit extends Cubit<GovernoratesState> {
  final GovernoratesRepo _governoratesRepo;
  GovernoratesCubit(this._governoratesRepo) : super(GovernoratesInitial());

  final TextEditingController originGovernorateController =
      TextEditingController();
  final TextEditingController destinationGovernorateController =
      TextEditingController();

  int? selectedOriginGovernorateId;
  int? selectedDestinationGovernorateId;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  void getgovernorates({int page = 1}) async {
    emit(GovernoratesLoading());

    final response = await _governoratesRepo.getgovernorates(page: page);

    response.fold(
      (fail) {
        if (!isClosed) emit(GovernoratesError(fail.toString()));
      },
      (governoratesResponse) {
        if (!isClosed) {
          _currentPage = page;
          emit(GovernoratesSuccess(
            governoratesResponse.message,
            governoratesResponse,
          ));
        }
      },
    );
  }

  void nextPage() {
    getgovernorates(page: _currentPage + 1);
  }

  void previousPage() {
    if (_currentPage > 1) {
      getgovernorates(page: _currentPage - 1);
    }
  }

  void setSelectedOriginGovernorate(GovernorateDatum governorate) {
    selectedOriginGovernorateId = governorate.id;
    originGovernorateController.text = governorate.name;
    emit(GovernoratesSelectionUpdated());
  }

  void setSelectedDestinationGovernorate(GovernorateDatum governorate) {
    selectedDestinationGovernorateId = governorate.id;
    destinationGovernorateController.text = governorate.name;
    emit(GovernoratesSelectionUpdated());
  }
}
