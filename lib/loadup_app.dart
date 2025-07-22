import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/routing/app_router.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/profile/presentation/screens/profile_screen.dart';
import 'package:loadup/features/wallet/presentation/screens/wallet_screen.dart';

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
          initialRoute: Routes.profileScreen,
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
