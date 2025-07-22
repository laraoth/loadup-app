// signup_state.dart

abstract class SignupState {}

class SignUpInitial extends SignupState {}

class SignUpLoading extends SignupState {}

class SignUpSuccess extends SignupState {
  final String message;
  SignUpSuccess(this.message);
}

class SignUpError extends SignupState {
  final String message;
  SignUpError(this.message);
}

class SignUpBirthDatePicked extends SignupState {
  final DateTime birthDate;
  final int age;
  SignUpBirthDatePicked(this.birthDate, this.age);
}
