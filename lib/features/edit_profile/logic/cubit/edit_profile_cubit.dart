import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:loadup/features/edit_profile/data/models/edit_profile_model.dart';
import 'package:loadup/features/edit_profile/data/repos/edit_profile_repo.dart';
import 'package:loadup/features/profile/data/models/profile_model.dart';
import 'package:loadup/features/profile/logic/cubit/profile_cubit.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileRepo _editprofileRepo;
  EditProfileCubit(this._editprofileRepo) : super(EditProfileInitial());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

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
      emit(EditProfileBirthDatePicked(pickedDate, calculatedAge!));
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

  void updateprofile() async {
    if (!formKey.currentState!.validate()) return;

    if (calculatedAge == null) {
      emit(EditProfileError("Please select your birth date."));
      return;
    }
    emit(EditProfileLoading());
    final response = await _editprofileRepo.updateprofile(EditProfileModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        age: calculatedAge!));

    response.fold(
      (fail) {
        if (!isClosed) emit(EditProfileError(fail.toString()));
      },
      (updateprofileResponse) {
        if (!isClosed) {
          emit(EditProfileSuccess(
              updateprofileResponse.message, updateprofileResponse));
        }
      },
    );
  }
}
