import 'package:flutter/material.dart';
import 'package:loadup/core/constant/colors.dart';

class ActivityItemWidget extends StatelessWidget {
  final String code;
  final String status;
  final Color statusColor;
  final Color textColor;

  const ActivityItemWidget({
    super.key,
    required this.code,
    required this.status,
    required this.statusColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.local_shipping, color: AppColors.icon(context)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              code,
              style: TextStyle(color: AppColors.text(context), fontSize: 12),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(color: textColor, fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
