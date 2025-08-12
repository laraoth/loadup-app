part of 'centers_cubit.dart';

abstract class CentersState {}

class CentersInitial extends CentersState {}

class CentersLoading extends CentersState {}

class CentersSuccess extends CentersState {
  final String message;
  final CentersModel centersModel;
  CentersSuccess(this.message, this.centersModel);
}

class CentersError extends CentersState {
  final String error;
  CentersError(this.error);
}

class CentersSelectionUpdated extends CentersState {}
