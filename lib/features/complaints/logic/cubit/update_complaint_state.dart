part of 'update_complaint_cubit.dart';

abstract class UpdateComplaintsState {}

class UpdateComplaintsInitial extends UpdateComplaintsState {}

class UpdateComplaintsLoading extends UpdateComplaintsState {}

class UpdateComplaintsSuccess extends UpdateComplaintsState {
  final String message;
  final UpdateComplaintsResponseModel complaintsModel;
  UpdateComplaintsSuccess(this.message, this.complaintsModel);
}

class UpdateComplaintsError extends UpdateComplaintsState {
  final String error;
  UpdateComplaintsError(this.error);
}
