import 'package:loadup/features/shipment_details/data/models/checkpoints_model.dart';

abstract class CheckpointsState {}

class CheckpointsInitial extends CheckpointsState {}

class CheckpointsLoading extends CheckpointsState {}

class CheckpointsSuccess extends CheckpointsState {
  final CheckpointsModel checkpointsModel;
  CheckpointsSuccess(this.checkpointsModel);
}

class CheckpointsError extends CheckpointsState {
  final String error;
  CheckpointsError(this.error);
}
