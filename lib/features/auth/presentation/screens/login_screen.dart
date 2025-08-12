import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/auth/presentation/widgets/linktext_widget.dart';
import 'package:loadup/features/auth/presentation/widgets/email_and_password_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 30.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(30),
                Text(
                  "Welcome Back",
                  style: AppTextStyles.font32BlackBold,
                ),
                verticalSpace(55),
                EmailAndPasswordWidget(),
                verticalSpace(55),
                LinkTextWidget(
                  normalText: "Don't have an account? ",
                  linkText: "Sign Up",
                  onTap: () {
                    context.pushNamed(Routes.signUpScreen);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
