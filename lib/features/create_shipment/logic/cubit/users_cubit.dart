import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:loadup/features/create_shipment/data/models/users_model.dart';
import 'package:loadup/features/create_shipment/data/repos/users_repo.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepo _usersRepo;
  UsersCubit(this._usersRepo) : super(UsersInitial());

  final TextEditingController recieverController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  int? selectedReciverId;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _perPage = 5;
  String? _search;
  String? _role = "customer";
  String? _sortBy = "created_at";
  String? _sortOrder = "desc";

  Future<void> getUsers({
    int page = 1,
    int? perPage,
    String? search,
    String? role,
    String? sortBy,
    String? sortOrder,
  }) async {
    emit(UsersLoading());

    final response = await _usersRepo.getusers(
      page: page,
      perPage: perPage ?? _perPage,
      search: search ?? _search,
      role: role ?? _role,
      sortBy: sortBy ?? _sortBy,
      sortOrder: sortOrder ?? _sortOrder,
    );

    response.fold(
      (fail) {
        if (!isClosed) emit(UsersError(fail.toString()));
      },
      (usersResponse) {
        if (!isClosed) {
          _currentPage = page;
          _perPage = perPage ?? _perPage;
          _search = search ?? _search;
          _role = role ?? _role;
          _sortBy = sortBy ?? _sortBy;
          _sortOrder = sortOrder ?? _sortOrder;

          emit(UsersSuccess(usersResponse.message ?? '', usersResponse));
        }
      },
    );
  }

  void searchUsers(String search) {
    _search = search.isNotEmpty ? search : null;
    getUsers(page: 1, search: _search);
  }

  void nextPage() => getUsers(page: _currentPage + 1);

  void previousPage() {
    if (_currentPage > 1) getUsers(page: _currentPage - 1);
  }

  void setselectedReciver(UserDatum user) {
    selectedReciverId = user.id;
    recieverController.text = user.name ?? '';
    emit(UsersSelectionUpdated());
  }
}
