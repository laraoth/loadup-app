import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/routing/app_router.dart';
import 'package:loadup/core/routing/routes.dart';

class LoadUpApp extends StatelessWidget {
  final AppRouter appRouter;
  const LoadUpApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: Routes.getStartedScreen,
          theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: AppColors.primaryOrange,
            scaffoldBackgroundColor: AppColors.pureWhite,
          ),
          debugShowCheckedModeBanner: false,
          // home: const GetStartedScreen(),
        );
      },
    );
  }
}
