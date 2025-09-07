abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  LoginSuccess(this.message);
}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}

class LoginAuthenticated extends LoginState {
  final String token;
  LoginAuthenticated(this.token);
}

class LoginUnauthenticated extends LoginState {}
