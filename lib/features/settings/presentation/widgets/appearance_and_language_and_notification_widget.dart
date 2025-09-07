import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/core/localization/localization_cubit.dart';
import 'package:loadup/core/theme/theme_cubit.dart';
import 'package:loadup/core/constant/colors.dart';

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
        'title': context.tr("appearance"),
        'trailing': Icon(Icons.dark_mode, color: AppColors.icon(context)),
        'onTap': () {
          _showThemeDialog(context);
        },
      },
      {
        'title': context.tr("language"),
        'trailing': Icon(Icons.language, color: AppColors.icon(context)),
        'onTap': () {
          _showLanguageDialog(context);
        },
      },
      // {
      //   'title': context.tr("notification"),
      //   'trailing': Switch(
      //     value: notificationsEnabled,
      //     onChanged: (value) {
      //       setState(() {
      //         notificationsEnabled = value;
      //       });
      //     },
      //   ),
      //   'onTap': () {},
      // },
    ];

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ...actions.map((action) {
          Widget trailingWidget;
          if (action['trailing'] is Icon) {
            trailingWidget = Icon(
              (action['trailing'] as Icon).icon,
              color: AppColors.icon(context),
            );
          } else {
            trailingWidget = action['trailing'] as Widget;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              elevation: 2,
              color: AppColors.cardBackground(context),
              child: ListTile(
                minVerticalPadding: 24.h,
                title: Text(
                  action['title'] as String,
                  style: TextStyle(
                    color: AppColors.text(context),
                    fontSize: 16.sp,
                  ),
                ),
                trailing: trailingWidget,
                onTap: action['onTap'] as void Function()?,
              ),
            ),
          );
        }).toList(),
        SizedBox(height: 16.h),
      ],
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.tr("appearance")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Light"),
              onTap: () {
                context.read<ThemeCubit>().changeTheme(ThemeMode.light);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: const Text("Dark"),
              onTap: () {
                context.read<ThemeCubit>().changeTheme(ThemeMode.dark);
                Navigator.pop(ctx);
              },
            ),
            // ListTile(
            //   title: const Text("System Default"),
            //   onTap: () {
            //     context.read<ThemeCubit>().changeTheme(ThemeMode.system);
            //     Navigator.pop(ctx);
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.tr("language")),
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
