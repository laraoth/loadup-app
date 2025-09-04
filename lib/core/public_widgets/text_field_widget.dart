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
  final bool readOnly;
  final void Function()? onTap;

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
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // الألوان حسب الثيم
    final bgColor = AppColors.cardBackground(context);
    final textColor = AppColors.text(context);
    final hintColor = AppColors.hintText(context);
    final iconCol = AppColors.icon(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        cursorColor: AppColors.primaryOrange,
        validator: (value) => value!.isEmpty ? 'Can\'t Be Empty' : null,
        controller: controller,
        obscureText: obscureText,
        style: AppTextStyles.font14Regular(context).copyWith(color: textColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: bgColor,
          hintText: hintText,
          hintStyle:
              AppTextStyles.font14Grey(context).copyWith(color: hintColor),
          labelText: labelText,
          labelStyle:
              AppTextStyles.font14Regular(context).copyWith(color: textColor),
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: prefixIcon != null
              ? (onPressedPrefixIcon != null
                  ? IconButton(
                      icon: Icon(prefixIcon, color: prefixIconColor ?? iconCol),
                      onPressed: onPressedPrefixIcon,
                    )
                  : Icon(prefixIcon, color: prefixIconColor ?? iconCol))
              : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon, color: suffixIconColor ?? iconCol),
                  onPressed: onPressedSuffixIcon,
                )
              : null,
        ),
      ),
    );
  }
}
