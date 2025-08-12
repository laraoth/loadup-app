part of 'edit_profile_cubit.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final String message;
  final ProfileModel profileModel;
  EditProfileSuccess(this.message, this.profileModel);
}

class EditProfileError extends EditProfileState {
  final String error;
  EditProfileError(this.error);
}

class EditProfileBirthDatePicked extends EditProfileState {
  final DateTime birthDate;
  final int age;
  EditProfileBirthDatePicked(this.birthDate, this.age);
}
