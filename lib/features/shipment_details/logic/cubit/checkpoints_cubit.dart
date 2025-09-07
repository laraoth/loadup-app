import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loadup/features/shipment_details/data/repos/checkpoints_repo.dart';
import 'package:loadup/features/shipment_details/logic/cubit/checkpoints_state.dart';

class CheckpointsCubit extends Cubit<CheckpointsState> {
  final CheckpointsRepo repo;
  CheckpointsCubit(this.repo) : super(CheckpointsInitial());

  void getCheckpoints({
    int page = 1,
    int perPage = 10,
    required int groupId,
  }) async {
    emit(CheckpointsLoading());
    final response = await repo.getCheckpoints(
      page: page,
      perPage: perPage,
      groupId: groupId,
    );

    response.fold(
      (fail) {
        if (!isClosed) emit(CheckpointsError(fail.toString()));
      },
      (model) {
        if (!isClosed) emit(CheckpointsSuccess(model));
      },
    );
  }
}
