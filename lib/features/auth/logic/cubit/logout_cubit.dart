import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/features/auth/data/repos/logout_repo.dart';
import 'package:loadup/features/auth/logic/cubit/logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutRepo logoutRepo;

  LogoutCubit(this.logoutRepo) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    final result = await logoutRepo.logout();

    result.fold(
      (failure) => emit(LogoutFailure(failure.message)),
      (logoutResponse) => emit(LogoutSuccess()),
    );
  }
}
