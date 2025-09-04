import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/images.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/core/public_widgets/button_widget.dart';
import 'package:loadup/core/routing/routes.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية (صورة الشاحنة)
          SizedBox.expand(
            child: Image.asset(
              AppImages.getstarted,
              fit: BoxFit.cover,
            ),
          ),

          // طبقة التمويه والزر
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
            ),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // النص في المنتصف تقريباً
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    context.tr("lets_get_your_shipment_moving"),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font32Bold(context),
                  ),
                ),

                const Spacer(flex: 1),

                // الزر بأسفل الشاشة مع مسافة
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.w),
                  child: ButtonWidget(
                    title: context.tr("get_started"),
                    onTap: () {
                      context.pushNamed(Routes.loginScreen);
                    },
                    // backgroundColor: AppColors.primaryOrange,
                    radius: 12.r,
                    textStyle: AppTextStyles.font24Bold(context),
                    width: double.infinity,
                    height: 50.h,
                  ),
                ),

                verticalSpace(80) // مسافة تحت الزر
              ],
            ),
          ),
        ],
      ),
    );
  }
}
