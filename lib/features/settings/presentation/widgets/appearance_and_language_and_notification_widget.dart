import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppearanceAndLanguageAndNotificationWidget extends StatefulWidget {
  const AppearanceAndLanguageAndNotificationWidget({super.key});

  @override
  State<AppearanceAndLanguageAndNotificationWidget> createState() =>
      _AppearanceAndLanguageAndNotificationWidgetState();
}

class _AppearanceAndLanguageAndNotificationWidgetState
    extends State<AppearanceAndLanguageAndNotificationWidget> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'title': 'appearance',
        'trailing': const Icon(Icons.dark_mode, color: Colors.black),
        'onTap': () {},
      },
      {
        'title': 'language',
        'trailing': const Icon(Icons.language, color: Colors.black),
        'onTap': () {},
      },
      {
        'title': 'notification',
        'trailing': Switch(
          value: notificationsEnabled,
          onChanged: (value) {
            setState(() {
              notificationsEnabled = value;
            });
          },
        ),
        'onTap': () {},
      },
    ];

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ...actions.map((action) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              elevation: 2,
              color: Colors.white,
              child: ListTile(
                minVerticalPadding: 24.h,
                title: Text(
                  action['title'] as String,
                  style: TextStyle(fontSize: 16.sp),
                ),
                trailing: action['title'] == 'notification'
                    ? Switch(
                        value: notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            notificationsEnabled = value;
                          });
                        },
                      )
                    : action['trailing'] as Widget,
                onTap: action['onTap'] as void Function()?,
              ),
            ),
          );
        }).toList(),
        SizedBox(height: 16.h),
      ],
    );
  }
}
