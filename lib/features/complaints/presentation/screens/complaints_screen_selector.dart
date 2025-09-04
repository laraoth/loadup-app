import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/public_widgets/button_widget.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/core/helpers/translation_extension.dart';

class ComplaintsScreenSelector extends StatelessWidget {
  const ComplaintsScreenSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr("complaints"),
          style: AppTextStyles.font24Bold(context),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background(context),
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32.h),
            ButtonWidget(
              title: context.tr("my_complaints"),
              onTap: () {
                Navigator.pushNamed(context, Routes.complaintsViewScreen);
              },
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              backgroundColor: AppColors.deepBlue,
            ),
            SizedBox(height: 35.h),
            ButtonWidget(
              title: context.tr("submit_complaint"),
              onTap: () {
                Navigator.pushNamed(context, Routes.complaintsScreen);
              },
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              backgroundColor: AppColors.deepBlue,
            ),
          ],
        ),
      ),
    );
  }
}
