part of 'create_complaints_cubit.dart';

abstract class CreateComplaintsState {}

class CreateComplaintsInitial extends CreateComplaintsState {}

class CreateComplaintsLoading extends CreateComplaintsState {}

class CreateComplaintsSuccess extends CreateComplaintsState {
  final String message;
  CreateComplaintsSuccess(this.message);
}

class CreateComplaintsError extends CreateComplaintsState {
  final String error;
  CreateComplaintsError(this.error);
}
