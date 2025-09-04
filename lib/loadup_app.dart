import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/localization/app_localizations.dart';
import 'package:loadup/core/localization/localization_cubit.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/core/theme/theme_cubit.dart';
import 'package:loadup/core/theme/themes.dart';
import 'core/routing/app_router.dart';

class LoadUpApp extends StatelessWidget {
  final AppRouter appRouter;
  const LoadUpApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return ScreenUtilInit(
              designSize: const Size(375, 667),
              minTextAdapt: true,
              builder: (context, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: locale,
                  supportedLocales: const [
                    Locale('en'),
                    Locale('ar'),
                  ],
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  onGenerateRoute: appRouter.generateRoute,
                  initialRoute: Routes.complaintsScreenSelector,
                  theme: AppThemes.lightTheme,
                  darkTheme: AppThemes.darkTheme,
                  themeMode: themeMode,
                );
              },
            );
          },
        );
      },
    );
  }
}
