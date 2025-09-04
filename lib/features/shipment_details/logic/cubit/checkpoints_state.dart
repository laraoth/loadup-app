part of 'checkpoints_cubit.dart';

abstract class CheckpointsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckpointsInitial extends CheckpointsState {}

class CheckpointsLoading extends CheckpointsState {}

class CheckpointsSuccess extends CheckpointsState {
  final CheckpointsModel checkpoints;
  CheckpointsSuccess(this.checkpoints);
  @override
  List<Object?> get props => [checkpoints];
}

class CheckpointsError extends CheckpointsState {
  final String error;
  CheckpointsError(this.error);
  @override
  List<Object?> get props => [error];
}
