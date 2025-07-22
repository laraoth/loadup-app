import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/di/dependency_injection.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/auth/logic/cubit/login_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/logout_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/signup_cubit.dart';
import 'package:loadup/features/profile/presentation/screens/profile_screen.dart';
import 'package:loadup/features/get_started/presentation/screens/get_started_screen.dart';
import 'package:loadup/features/home/presentation/screens/home_screen.dart';
import 'package:loadup/features/auth/presentation/screens/login_screen.dart';
import 'package:loadup/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:loadup/features/my_shipping/presentation/screens/my_shipping_screen.dart';
import 'package:loadup/features/reset_password/logic/cubit/reset_password_cubit.dart';
import 'package:loadup/features/reset_password/presentation/screens/reset_password_screen.dart';
import 'package:loadup/features/wallet/presentation/screens/wallet_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.getStartedScreen:
        return MaterialPageRoute(
          builder: (_) => GetStartedScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.myShipping:
        return MaterialPageRoute(
          builder: (_) => const MyShippingScreen(),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LogoutCubit>(),
            child: const ProfileScreen(),
          ),
        );
      case Routes.resetpasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ResetPasswordCubit>(),
            child: const ResetPasswordScreen(),
          ),
        );

      case Routes.walletScreen:
        return MaterialPageRoute(
          builder: (_) => WalletScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No Routes'),
            ),
          ),
        );
    }
  }
}
