import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loadup/features/shipment_details/data/models/checkpoints_model.dart';
import 'package:loadup/features/shipment_details/data/repos/checkpoints_repo.dart';

part 'checkpoints_state.dart';

class CheckpointsCubit extends Cubit<CheckpointsState> {
  final CheckpointsRepo repo;
  CheckpointsCubit(this.repo) : super(CheckpointsInitial());

  void fetchCheckpoints() async {
    emit(CheckpointsLoading());
    final result = await repo.getCheckpoints();

    result.fold(
      (fail) => emit(CheckpointsError(fail.toString())),
      (data) => emit(CheckpointsSuccess(data)),
    );
  }
}
