import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/features/my_shipping/logic/cubit/sent_shipments_cubit.dart';

class DetailItemWidget extends StatelessWidget {
  final String title;
  final String value;

  const DetailItemWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Center(
        child: Column(
          children: [
            Text(title, style: AppTextStyles.font16Bold(context)),
            SizedBox(height: 4.h),
            Text(value, style: AppTextStyles.font14Regular(context)),
            Divider(
              color: AppColors.grey,
            )
          ],
        ),
      ),
    );
  }
}
