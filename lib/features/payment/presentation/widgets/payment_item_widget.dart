import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/features/payment/data/models/payments_model.dart';

class PaymentItemWidget extends StatelessWidget {
  final Datum payment;

  const PaymentItemWidget({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final double amountValue = payment.amount ?? 0.0;
    final String formattedAmount =
        NumberFormat("#,##0.00", "en_US").format(amountValue);

    final String formattedDate = payment.createdAt != null
        ? DateFormat("yyyy-MM-dd").format(payment.createdAt!)
        : "-";

    print("===== Payment Debug =====");
    print("Payment ID: ${payment.id}");
    print("Amount: $amountValue");
    print("Shipment ID: ${payment.shipmentId}");
    print("=========================");

    final String shipmentInfo = payment.shipmentId != null
        ? "Shipment: ${payment.shipmentId}"
        : "No shipment";

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // shipment id
          Text(
            shipmentInfo,
            style: AppTextStyles.font16Bold(context),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),

          // amount
          Text(
            "Amount: \$ $formattedAmount",
            style: AppTextStyles.font16Regular(context).copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.green,
            ),
          ),
          SizedBox(height: 4.h),

          // date
          Text(
            "Paid at: $formattedDate",
            style: AppTextStyles.font14Grey(context),
          ),
        ],
      ),
    );
  }
}
