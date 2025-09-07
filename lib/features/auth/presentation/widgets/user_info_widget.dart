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
import 'package:loadup/core/helpers/translation_extension.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({super.key});

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

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
            hintText: context.tr("full_name"),
            labelText: context.tr("full_name"),
            obscureText: false,
            prefixIcon: Icons.person,
            prefixIconColor: AppColors.primaryOrange,
          ),
          verticalSpace(24),
          TextFieldWidget(
            controller: signupCubit.phoneController,
            hintText: context.tr("phone_number"),
            labelText: context.tr("phone_number"),
            obscureText: false,
          ),
          verticalSpace(24),
          TextFieldWidget(
            controller: signupCubit.addressController,
            hintText: context.tr("address"),
            labelText: context.tr("address"),
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
                    labelText: context.tr("birth_date"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: AppColors.primaryOrange,
                    ),
                  ),
                  child: Text(
                    selectedBirthDate == null
                        ? context.tr("select_birth_date")
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
            hintText: context.tr("email"),
            labelText: context.tr("email"),
            obscureText: false,
            prefixIcon: Icons.email,
            prefixIconColor: AppColors.primaryOrange,
          ),
          verticalSpace(24),

     
          TextFieldWidget(
            controller: signupCubit.passwordController,
            hintText: context.tr("password"),
            labelText: context.tr("password"),
            prefixIcon: Icons.lock,
            prefixIconColor: AppColors.primaryOrange,
            obscureText: !isPasswordVisible,
            suffixIcon: isPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            onPressedSuffixIcon: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            suffixIconColor: AppColors.primaryOrange,
          ),
          verticalSpace(24),

     
          TextFieldWidget(
            controller: signupCubit.passwordConfirmationController,
            hintText: context.tr("confirm_password"),
            labelText: context.tr("confirm_password"),
            prefixIcon: Icons.lock,
            prefixIconColor: AppColors.primaryOrange,
            obscureText: !isConfirmPasswordVisible,
            suffixIcon: isConfirmPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            onPressedSuffixIcon: () {
              setState(() {
                isConfirmPasswordVisible = !isConfirmPasswordVisible;
              });
            },
            suffixIconColor: AppColors.primaryOrange,
          ),

          verticalSpace(40),
          BlocConsumer<SignUpCubit, SignupState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.message)));
                context.pushNamed(Routes.customBottomNavigationBar);
              } else if (state is SignUpError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is SignUpLoading) {
                return const LoadingWidget();
              } else {
                return ButtonWidget(
                  title: context.tr("sign_up"),
                  onTap: () {
                    if (signupCubit.selectedBirthDate != null) {
                      signupCubit.signUp();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            context.tr("please_select_birth_date"),
                          ),
                        ),
                      );
                    }
                  },
                  textStyle: AppTextStyles.font24Bold(context),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
