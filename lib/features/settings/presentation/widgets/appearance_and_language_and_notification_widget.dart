import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/localization/app_localizations.dart';
import 'package:loadup/core/localization/localization_cubit.dart';

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
        'title': AppLocalizations.of(context).translate("appearance"),
        'trailing': const Icon(Icons.dark_mode, color: Colors.black),
        'onTap': () {},
      },
      {
        'title': AppLocalizations.of(context).translate("language"),
        'trailing': const Icon(Icons.language, color: Colors.black),
        'onTap': () {
          _showLanguageDialog(context);
        },
      },
      {
        'title': AppLocalizations.of(context).translate("notification"),
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
                trailing: action['title'] ==
                        AppLocalizations.of(context).translate("notification")
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

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context).translate("language")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("English"),
              onTap: () {
                context.read<LocalizationCubit>().changeLanguage("en");
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: const Text("العربية"),
              onTap: () {
                context.read<LocalizationCubit>().changeLanguage("ar");
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }
}
