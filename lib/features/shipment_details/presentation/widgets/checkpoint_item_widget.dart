import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/features/shipment_details/data/models/checkpoints_model.dart';

class CheckpointItemWidget extends StatelessWidget {
  final Checkpoint checkpoint;

  const CheckpointItemWidget({super.key, required this.checkpoint});

  Color getStatusColor(bool isChecked) =>
      isChecked ? AppColors.green : AppColors.red;

  String getStatusText(bool isChecked) => isChecked ? "Checked" : "Pending";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundColor:
                getStatusColor(checkpoint.isChecked).withOpacity(0.2),
            child: Icon(
              checkpoint.isChecked ? Icons.check_circle : Icons.pending,
              color: getStatusColor(checkpoint.isChecked),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Checkpoint: ${checkpoint.checkpoint.name}",
                  style: AppTextStyles.font16Bold(context),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Order: ${checkpoint.order}",
                  style: AppTextStyles.font14Grey(context),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Status: ${getStatusText(checkpoint.isChecked)}",
                  style: AppTextStyles.font14Regular(context).copyWith(
                    color: getStatusColor(checkpoint.isChecked),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
