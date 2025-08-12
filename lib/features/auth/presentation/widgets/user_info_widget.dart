import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/public_widgets/button_widget.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/core/public_widgets/text_field_widget.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/auth/logic/cubit/signup_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/signup_state.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  Future<void> _selectBirthDate(BuildContext context) async {
    context.read<SignUpCubit>().pickBirthDate(context);
  }

  @override
  Widget build(BuildContext context) {
    final signupCubit = context.read<SignUpCubit>();

    return Form(
      key: signupCubit.formKey,
      child: Column(
        children: [
          TextFieldWidget(
            controller: signupCubit.nameController,
            hintText: 'Full Name',
            labelText: 'Full Name',
            obscureText: false,
            prefixIcon: Icons.person,
            prefixIconColor: AppColors.primaryOrange,
          ),
          verticalSpace(24),
          TextFieldWidget(
            controller: signupCubit.phoneController,
            hintText: 'Phone Number',
            labelText: 'Phone Number',
            obscureText: false,
          ),
          verticalSpace(24),
          TextFieldWidget(
            controller: signupCubit.addressController,
            hintText: 'Address',
            labelText: 'Address',
            obscureText: false,
            prefixIcon: Icons.location_pin,
            prefixIconColor: AppColors.primaryOrange,
          ),
          verticalSpace(24),
          BlocBuilder<SignUpCubit, SignupState>(
            builder: (context, state) {
              final selectedBirthDate = signupCubit.selectedBirthDate;
              final calculatedAge = signupCubit.calculatedAge;
              return InkWell(
                onTap: () => _selectBirthDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Birth Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: Icon(Icons.calendar_today,
                        color: AppColors.primaryOrange),
                  ),
                  child: Text(
                    selectedBirthDate == null
                        ? 'Select your birth date'
                        : '${selectedBirthDate.toLocal()}'.split(' ')[0] +
                            ' - Age: ${calculatedAge ?? ''}',
                    style: TextStyle(
                      color: selectedBirthDate == null
                          ? Colors.grey
                          : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          ),
          verticalSpace(24),
          TextFieldWidget(
            controller: signupCubit.emailController,
            hintText: 'Email',
            labelText: 'Email',
            obscureText: false,
            prefixIcon: Icons.email,
            prefixIconColor: AppColors.primaryOrange,
          ),
          verticalSpace(24),
          StatefulBuilder(
            builder: (context, setState) {
              bool isVisible = false;
              return Column(
                children: [
                  TextFieldWidget(
                    controller: signupCubit.passwordController,
                    hintText: 'Password',
                    labelText: 'Password',
                    prefixIcon: Icons.lock,
                    prefixIconColor: AppColors.primaryOrange,
                    obscureText: !isVisible,
                    suffixIcon: isVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    onPressedSuffixIcon: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    suffixIconColor: AppColors.primaryOrange,
                  ),
                  verticalSpace(24),
                  TextFieldWidget(
                    controller: signupCubit.passwordConfirmationController,
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    prefixIcon: Icons.lock,
                    prefixIconColor: AppColors.primaryOrange,
                    obscureText: !isVisible,
                    suffixIcon: isVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    onPressedSuffixIcon: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    suffixIconColor: AppColors.primaryOrange,
                  ),
                ],
              );
            },
          ),
          verticalSpace(40),
          BlocConsumer<SignUpCubit, SignupState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.message)));
                context.pushNamed(Routes.homeScreen);
              } else if (state is SignUpError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is SignUpLoading) {
                return LoadingWidget();
              } else {
                return ButtonWidget(
                  title: "Sign up",
                  onTap: () {
                    if (signupCubit.selectedBirthDate != null) {
                      signupCubit.signUp();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please select your birth date")),
                      );
                    }
                  },
                  textStyle: AppTextStyles.font24WhiteBold,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
