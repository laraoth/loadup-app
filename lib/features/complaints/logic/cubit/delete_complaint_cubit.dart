import 'package:bloc/bloc.dart';
import 'package:loadup/features/complaints/data/repos/delete_complaint_repo.dart';

part 'delete_complaint_state.dart';

class DeleteComplaintCubit extends Cubit<DeleteComplaintState> {
  final DeleteComplaintRepo _deleteComplaintRepo;

  DeleteComplaintCubit(this._deleteComplaintRepo)
      : super(DeleteComplaintInitial());

  Future<bool> deleteComplaint(int id) async {
    emit(DeleteComplaintLoading());
    final response = await _deleteComplaintRepo.deleteComplaint(id);

    return response.fold(
      (fail) {
        if (!isClosed) emit(DeleteComplaintError(fail.toString()));
        return false;
      },
      (message) {
        if (!isClosed) emit(DeleteComplaintSuccess(message));
        return true;
      },
    );
  }
}
