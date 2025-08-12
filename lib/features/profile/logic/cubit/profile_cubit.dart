import 'package:bloc/bloc.dart';
import 'package:loadup/features/profile/data/models/profile_model.dart';
import 'package:loadup/features/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;
  ProfileCubit(this._profileRepo) : super(ProfileInitial());

  void getprofile() async {
    emit(ProfileLoading());
    final response = await _profileRepo.getprofile();

    response.fold(
      (fail) {
        if (!isClosed) emit(ProfileError(fail.toString()));
      },
      (getprofileResponse) {
        if (!isClosed) {
          emit(ProfileSuccess(getprofileResponse.message, getprofileResponse));
        }
      },
    );
  }
}
