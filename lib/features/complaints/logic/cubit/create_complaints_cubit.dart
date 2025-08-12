// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:loadup/features/complaints/data/repos/create_complaint_repo.dart';

// part 'create_complaints_state.dart';

// class CreateComplaintsCubit extends Cubit<CreateComplaintsState> {
//   final CreateComplaintRepo _createComplaintRepo;
//   CreateComplaintsCubit(this._createComplaintRepo) : super(CreateComplaintsInitial());

//   final TextEditingController shipmentController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   void login() async {
//     if (!formKey.currentState!.validate()) return;

//     emit(LoginLoading());
//     final response = await _loginRepo.login(
//       LoginRequestBody(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       ),
//     );

//     response.fold(
//       (fail) {
//         if (!isClosed) emit(LoginError(fail.toString()));
//       },
//       (loginResponse) {
//         if (!isClosed) {
//           emit(
//               LoginSuccess(loginResponse.message ?? 'Logged in successfully.'));
//         }
//       },
//     );
//   }

//   @override
//   Future<void> close() {
//     emailController.dispose();
//     passwordController.dispose();
//     return super.close();
//   }
// }
