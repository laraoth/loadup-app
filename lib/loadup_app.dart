import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loadup/core/localization/app_localizations.dart';
import 'package:loadup/core/localization/localization_cubit.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/routing/app_router.dart';
import 'package:loadup/core/routing/routes.dart';

class LoadUpApp extends StatelessWidget {
  final AppRouter appRouter;
  const LoadUpApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
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
              initialRoute: Routes.getStartedScreen,
              theme: ThemeData(
                brightness: Brightness.light,
                fontFamily: 'Poppins',
                primaryColor: AppColors.primaryOrange,
                scaffoldBackgroundColor: AppColors.pureWhite,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                fontFamily: 'Poppins',
                primaryColor: AppColors.primaryOrange,
                scaffoldBackgroundColor: Colors.black,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
              ),
              themeMode: ThemeMode.system,
            );
          },
        );
      },
    );
  }
}
