import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/helpers/translation_extension.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = AppColors.cardBackground(context);
    final shadowColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black12
        : Colors.black54;
    final iconColor = AppColors.icon(context);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: TextFormField(
        cursorColor: AppColors.primary(context),
        decoration: InputDecoration(
          hintText: context.tr('search'),
          prefixIcon: Icon(Icons.search, color: iconColor),
          fillColor: bgColor,
          filled: true,
          contentPadding:
              EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide:
                BorderSide(color: AppColors.primary(context), width: 1.5),
          ),
        ),
      ),
    );
  }
}
