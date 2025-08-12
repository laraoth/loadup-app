import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/features/reset_password/data/models/reset_password_request.dart';
import 'package:loadup/features/reset_password/data/repos/reset_password_repo.dart';
import 'package:loadup/features/reset_password/logic/cubit/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepo _resetRepo;
  ResetPasswordCubit(this._resetRepo) : super(ResetPasswordInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void reset() async {
    if (!formKey.currentState!.validate()) return;

    emit(ResetPasswordLoading());
    final response = await _resetRepo.reset(
      ResetPasswordRequest(
        email: emailController.text.trim(),
        newpassword: newpasswordController.text.trim(),
      ),
    );

    response.fold((fail) {
      if (!isClosed) emit(ResetPasswordError(fail.toString()));
    }, (resetResponse) {
      if (!isClosed) {
        emit(ResetPasswordSuccess('Your password changed successfully.'));
      }
    });

    @override
    Future<void> close() {
      emailController.dispose();
      newpasswordController.dispose();
      return super.close();
    }
  }
}
