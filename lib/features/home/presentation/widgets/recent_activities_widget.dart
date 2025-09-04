import 'package:flutter/material.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'activity_item_widget.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/core/routing/routes.dart';

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
            Text(
              context.tr("recent_activities"),
              style: AppTextStyles.font18Bold(context),
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(Routes.myShipping);
              },
              child: Text(
                context.tr("see_all"),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...activities.map(
          (activity) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ActivityItemWidget(
              code: "${context.tr("shipment_code")}: ${activity.code}",
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
