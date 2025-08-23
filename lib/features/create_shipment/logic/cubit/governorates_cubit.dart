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
  final TextEditingController searchController = TextEditingController();

  int? selectedOriginGovernorateId;
  int? selectedDestinationGovernorateId;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _perPage = 10;
  String? _search;
  String? _sortBy = "name";
  String? _sortOrder = "asc";

  void getgovernorates({
    int page = 1,
    int? perPage,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    emit(GovernoratesLoading());

    final response = await _governoratesRepo.getgovernorates(
      page: page,
      perPage: perPage ?? _perPage,
      search: search ?? _search,
      sortBy: sortBy ?? _sortBy,
      sortOrder: sortOrder ?? _sortOrder,
    );

    response.fold(
      (fail) {
        if (!isClosed) emit(GovernoratesError(fail.toString()));
      },
      (res) {
        if (!isClosed) {
          _currentPage = page;
          _perPage = perPage ?? _perPage;
          _search = search ?? _search;
          _sortBy = sortBy ?? _sortBy;
          _sortOrder = sortOrder ?? _sortOrder;
          emit(GovernoratesSuccess(res.message, res));
        }
      },
    );
  }

  void searchGovernorates(String search) {
    _search = search;
    getgovernorates(page: 1, search: search);
  }

  void nextPage() => getgovernorates(page: _currentPage + 1);
  void previousPage() {
    if (_currentPage > 1) getgovernorates(page: _currentPage - 1);
  }

  void setSelectedOriginGovernorate(GovernorateDatum g) {
    selectedOriginGovernorateId = g.id;
    originGovernorateController.text = g.name;
    emit(GovernoratesSelectionUpdated());
  }

  void setSelectedDestinationGovernorate(GovernorateDatum g) {
    selectedDestinationGovernorateId = g.id;
    destinationGovernorateController.text = g.name;
    emit(GovernoratesSelectionUpdated());
  }
}
