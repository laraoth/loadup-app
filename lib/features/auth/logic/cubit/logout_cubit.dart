import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/features/auth/data/datasources/logout_remote_data_source.dart';
import 'package:loadup/features/auth/logic/cubit/logout_state.dart';
import 'package:loadup/main.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutRemoteDataSource logoutDatasource;

  LogoutCubit(this.logoutDatasource) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      final token = await storage.getString('token');
      await logoutDatasource.logout(token!);
      await storage.remove('token');
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }
}
