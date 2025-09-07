import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/colors.dart';

class AppTextStyles {
  static TextStyle font32Bold(BuildContext context) => TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.text(context),
      );

  static TextStyle font24Bold(BuildContext context) => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.text(context),
      );

  static TextStyle font18Bold(BuildContext context) => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.text(context),
      );

  static TextStyle font16Bold(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.text(context),
      );

  static TextStyle font16Regular(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.text(context),
      );

  static TextStyle font14Regular(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.text(context),
      );

  static TextStyle font11Regular(BuildContext context) => TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.text(context),
      );

  static TextStyle font14Grey(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.hintText(context),
      );
}
