import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String amount;
  final bool isPositive;
  final String currencySymbol;

  final String positivePrefix = '+ ';
  final String negativePrefix = '- ';

  const TransactionItem({
    super.key,
    required this.title,
    required this.amount,
    required this.isPositive,
    this.currencySymbol = '\$',
  });

  @override
  Widget build(BuildContext context) {
    // تحويل النص إلى رقم وتنسيقه
    final double parsedAmount = double.tryParse(amount) ?? 0.0;
    final String formattedAmount =
        NumberFormat("#,##0.00", "en_US").format(parsedAmount);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.font16Regular(context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text(
            '${isPositive ? positivePrefix : negativePrefix}$currencySymbol$formattedAmount',
            style: AppTextStyles.font16Regular(context).copyWith(
              color: isPositive ? AppColors.green : AppColors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
