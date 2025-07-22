import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Color? backgroundColor;
  final double? radius;
  final TextStyle textStyle;
  final double? width;
  final double? height;
  const ButtonWidget(
      {super.key,
      required this.title,
      required this.onTap,
      this.backgroundColor,
      this.radius,
      required this.textStyle,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 327.w,
      height: height ?? 52.h,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 16.r)),
        color: backgroundColor ?? AppColors.primaryOrange,
        child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 16.r),
          ),
          onTap: onTap,
          child: Center(
            child: Text(
              title,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
