import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/features/settings/presentation/widgets/appearance_and_language_and_notification_widget.dart';
import 'package:loadup/core/helpers/translation_extension.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: AppColors.background(context),
        title: Text(
          context.tr("settings"),
          style: AppTextStyles.font24Bold(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 30.w,
          ),
          child: Column(
            children: [
              verticalSpace(24),
              const AppearanceAndLanguageAndNotificationWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
