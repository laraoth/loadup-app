import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/auth/presentation/widgets/linktext_widget.dart';
import 'package:loadup/features/auth/presentation/widgets/email_and_password_widget.dart';
import 'package:loadup/core/helpers/translation_extension.dart';

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
                  context.tr("welcome_back"),
                  style: AppTextStyles.font32Bold(context),
                ),
                verticalSpace(55),
                EmailAndPasswordWidget(),
                verticalSpace(55),
                LinkTextWidget(
                  normalText: context.tr("dont_have_account"),
                  linkText: context.tr("sign_up"),
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
