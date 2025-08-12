part of 'complaints_cubit.dart';

abstract class ComplaintsState {}

class ComplaintsInitial extends ComplaintsState {}

class ComplaintsLoading extends ComplaintsState {}

class ComplaintsSuccess extends ComplaintsState {
  final String message;
  final ComplaintsModel complaintsModel;
  ComplaintsSuccess(this.message, this.complaintsModel);
}

class ComplaintsError extends ComplaintsState {
  final String error;
  ComplaintsError(this.error);
}
