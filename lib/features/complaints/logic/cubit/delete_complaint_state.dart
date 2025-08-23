part of 'delete_complaint_cubit.dart';

abstract class DeleteComplaintState {}

class DeleteComplaintInitial extends DeleteComplaintState {}

class DeleteComplaintLoading extends DeleteComplaintState {}

class DeleteComplaintSuccess extends DeleteComplaintState {
  final String message;
  DeleteComplaintSuccess(this.message);
}

class DeleteComplaintError extends DeleteComplaintState {
  final String error;
  DeleteComplaintError(this.error);
}
