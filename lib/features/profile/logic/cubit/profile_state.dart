part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final String message;
  final ProfileModel profileModel;
  ProfileSuccess(this.message, this.profileModel);
}

class ProfileError extends ProfileState {
  final String error;
  ProfileError(this.error);
}
