import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:loadup/features/create_shipment/data/models/users_model.dart';
import 'package:loadup/features/create_shipment/data/repos/users_repo.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepo _usersRepo;
  UsersCubit(this._usersRepo) : super(UsersInitial());

  final TextEditingController recieverController = TextEditingController();
  int? selectedReciverId;

  int _currentPage = 1;

  int get currentPage => _currentPage;

  void getUsers({int page = 1}) async {
    emit(UsersLoading());
    final response = await _usersRepo.getusers(page: page);

    response.fold(
      (fail) {
        if (!isClosed) emit(UsersError(fail.toString()));
      },
      (usersResponse) {
        if (!isClosed) {
          _currentPage = page;
          emit(UsersSuccess(usersResponse.message, usersResponse));
        }
      },
    );
  }

  void nextPage() {
    getUsers(page: _currentPage + 1);
  }

  void previousPage() {
    if (_currentPage > 1) {
      getUsers(page: _currentPage - 1);
    }
  }

  void setselectedReciver(UserDatum user) {
    selectedReciverId = user.id;
    recieverController.text = user.name;
    emit(UsersSelectionUpdated());
  }
}
