import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/public_widgets/button_widget.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/core/public_widgets/text_field_widget.dart';
import 'package:loadup/features/reset_password/logic/cubit/reset_password_cubit.dart';
import 'package:loadup/features/reset_password/logic/cubit/reset_password_state.dart';

class EmailAndNewPasswordWidget extends StatefulWidget {
  const EmailAndNewPasswordWidget({super.key});

  @override
  State<EmailAndNewPasswordWidget> createState() =>
      _EmailAndNewPasswordWidgetState();
}

class _EmailAndNewPasswordWidgetState extends State<EmailAndNewPasswordWidget> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final resetPasswordCubit = context.read<ResetPasswordCubit>();
    return Form(
        key: resetPasswordCubit.formKey,
        child: Column(
          children: [
            TextFieldWidget(
              controller: resetPasswordCubit.emailController,
              hintText: 'Email',
              labelText: 'Email',
              obscureText: false,
              prefixIcon: Icons.email,
              prefixIconColor: AppColors.primaryOrange,
            ),
            verticalSpace(24),
            TextFieldWidget(
              controller: resetPasswordCubit.newpasswordController,
              hintText: 'New Password',
              labelText: 'New Password',
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
            verticalSpace(40),
            BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) {
                if (state is ResetPasswordSuccess) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.message)));
                  // context.pushNamed(Routes.);
                } else if (state is ResetPasswordError) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is ResetPasswordLoading) {
                  return LoadingWidget();
                } else {
                  return ButtonWidget(
                      title: "Done",
                      onTap: () {
                        if (context
                            .read<ResetPasswordCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          context.read<ResetPasswordCubit>().reset();
                        }
                      },
                      textStyle: AppTextStyles.font24WhiteBold);
                }
              },
            )
          ],
        ));
  }
}
