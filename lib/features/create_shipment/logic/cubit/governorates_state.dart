part of 'governorates_cubit.dart';

abstract class GovernoratesState {}

class GovernoratesInitial extends GovernoratesState {}

class GovernoratesLoading extends GovernoratesState {}

class GovernoratesSuccess extends GovernoratesState {
  final String message;
  final GovernoratesModel governoratesModel;
  GovernoratesSuccess(this.message, this.governoratesModel);
}

class GovernoratesError extends GovernoratesState {
  final String error;
  GovernoratesError(this.error);
}

class GovernoratesSelectionUpdated extends GovernoratesState {}
