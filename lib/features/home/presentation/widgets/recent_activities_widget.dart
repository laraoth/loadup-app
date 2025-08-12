import 'package:flutter/material.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'activity_item_widget.dart';

class ActivityItemData {
  final String code;
  final String status;
  final Color statusColor;
  final Color textColor;

  const ActivityItemData({
    required this.code,
    required this.status,
    required this.statusColor,
    required this.textColor,
  });
}

class RecentActivitiesListWidget extends StatelessWidget {
  final List<ActivityItemData> activities;

  const RecentActivitiesListWidget({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activities', style: AppTextStyles.font18BlackBold),
            const Text('See All', style: TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 10),
        ...activities.map(
          (activity) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ActivityItemWidget(
              code: activity.code,
              status: activity.status,
              statusColor: activity.statusColor,
              textColor: activity.textColor,
            ),
          ),
        ),
      ],
    );
  }
}
