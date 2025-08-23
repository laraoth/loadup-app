import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final IconData? suffixIcon;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function()? onPressedSuffixIcon;
  final void Function()? onPressedPrefixIcon;
  final bool readOnly; // جديد
  final void Function()? onTap; // جديد

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    this.suffixIcon,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    this.keyboardType,
    this.onPressedSuffixIcon,
    this.onPressedPrefixIcon,
    this.readOnly = false, // افتراضي false
    this.onTap, // افتراضي null
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white, // خلفية بيضاء
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: TextFormField(
        readOnly: readOnly, // مضاف
        onTap: onTap, // مضاف
        keyboardType: keyboardType,
        cursorColor: AppColors.primaryOrange,
        validator: (value) => value!.isEmpty ? 'Can\'t Be Empty' : null,
        controller: controller,
        obscureText: obscureText,
        style: AppTextStyles.font14BlackRegular,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: AppTextStyles.font14GreyRegular,
          labelText: labelText,
          labelStyle: AppTextStyles.font14BlackRegular,
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),

          // بدون إطار نهائياً
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          prefixIcon: prefixIcon != null
              ? (onPressedPrefixIcon != null
                  ? IconButton(
                      icon: Icon(prefixIcon, color: prefixIconColor),
                      onPressed: onPressedPrefixIcon,
                    )
                  : Icon(prefixIcon, color: prefixIconColor))
              : null,

          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon, color: suffixIconColor),
                  onPressed: onPressedSuffixIcon,
                )
              : null,
        ),
      ),
    );
  }
}
