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
import 'package:loadup/features/auth/logic/cubit/login_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/login_state.dart';

class EmailAndPasswordWidget extends StatefulWidget {
  const EmailAndPasswordWidget({super.key});

  @override
  State<EmailAndPasswordWidget> createState() => _EmailAndPasswordWidgetState();
}

class _EmailAndPasswordWidgetState extends State<EmailAndPasswordWidget> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Form(
        key: loginCubit.formKey,
        child: Column(
          children: [
            TextFieldWidget(
              controller: loginCubit.emailController,
              hintText: 'Email',
              labelText: 'Email',
              obscureText: false,
              prefixIcon: Icons.email,
              prefixIconColor: AppColors.primaryOrange,
            ),
            verticalSpace(24),
            TextFieldWidget(
              controller: loginCubit.passwordController,
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
            verticalSpace(40),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.message)));
                  context
                      .pushReplacementNamed(Routes.customBottomNavigationBar);
                } else if (state is LoginError) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return LoadingWidget();
                } else {
                  return ButtonWidget(
                      title: "Log in",
                      onTap: () {
                        if (context
                            .read<LoginCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          context.read<LoginCubit>().login();
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
