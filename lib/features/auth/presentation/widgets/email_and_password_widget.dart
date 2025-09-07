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
import 'package:loadup/core/helpers/translation_extension.dart'; // مهم

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
            hintText: context.tr("email"),
            labelText: context.tr("email"),
            obscureText: false,
            prefixIcon: Icons.email,
            prefixIconColor: AppColors.primaryOrange,
          ),
          verticalSpace(24),
          TextFieldWidget(
            controller: loginCubit.passwordController,
            hintText: context.tr("password"),
            labelText: context.tr("password"),
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
              if (state is LoginAuthenticated) {
                // عرض رسالة النجاح
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text("Logged in successfully")),
                  );

                context.pushReplacementNamed(Routes.customBottomNavigationBar);
              } else if (state is LoginError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return const LoadingWidget();
              } else {
                return ButtonWidget(
                  title: context.tr("log_in"),
                  onTap: () {
                    if (loginCubit.formKey.currentState!.validate()) {
                      loginCubit.login();
                    }
                  },
                  textStyle: AppTextStyles.font24Bold(context),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
