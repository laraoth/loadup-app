part of 'users_cubit.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersSuccess extends UsersState {
  final String message;
  final UsersModel usersModel;
  UsersSuccess(this.message, this.usersModel);
}

class UsersError extends UsersState {
  final String error;
  UsersError(this.error);
}

class UsersSelectionUpdated extends UsersState {}
