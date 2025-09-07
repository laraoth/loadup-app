import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/features/auth/data/models/login_request_body.dart';
import 'package:loadup/features/auth/data/repos/login_repo.dart';
import 'package:loadup/features/auth/logic/cubit/login_state.dart';
import 'package:loadup/main.dart'; // للتخزين SharedPreferences

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(LoginInitial()) {
    _checkLoginStatus();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _checkLoginStatus() async {
    final token = await storage.getString("token");
    if (token != null && token.isNotEmpty) {
      if (!isClosed) emit(LoginAuthenticated(token));
    } else {
      if (!isClosed) emit(LoginUnauthenticated());
    }
  }

  void login() async {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());
    final response = await _loginRepo.login(
      LoginRequestBody(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );

    response.fold(
      (fail) {
        if (!isClosed) emit(LoginError(fail.toString()));
      },
      (loginResponse) async {
        final token = loginResponse.data.token;
        if (token != null && token.isNotEmpty) {
          await storage.setString("token", token);
          if (!isClosed) emit(LoginAuthenticated(token));
        } else {
          if (!isClosed) {
            emit(
              LoginSuccess(loginResponse.message ?? 'Logged in successfully.'),
            );
          }
        }
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
