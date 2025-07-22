// signup_cubit.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/features/auth/data/models/sign_up_request_body.dart';
import 'package:loadup/features/auth/data/repos/sign_up_repo.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignupState> {
  final SignUpRepo _signupRepo;
  SignUpCubit(this._signupRepo) : super(SignUpInitial());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? selectedBirthDate;
  int? calculatedAge;

  void pickBirthDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedBirthDate = pickedDate;
      calculatedAge = calculateAge(pickedDate);
      emit(SignUpBirthDatePicked(pickedDate, calculatedAge!));
    }
  }

  int calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void signUp() async {
    if (!formKey.currentState!.validate()) return;

    if (calculatedAge == null) {
      emit(SignUpError("Please select your birth date."));
      return;
    }

    emit(SignUpLoading());

    final response = await _signupRepo.signup(
      SignUpRequestBody(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        age: calculatedAge!.toString(),
        passwordConfirmation: passwordConfirmationController.text.trim(),
      ),
    );

    response.fold(
      (fail) {
        if (!isClosed) emit(SignUpError(fail.toString()));
      },
      (signupResponse) {
        if (!isClosed) {
          emit(SignUpSuccess(
              signupResponse.message ?? 'Account created successfully!'));
        }
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    return super.close();
  }
}
