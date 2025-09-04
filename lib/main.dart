import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/di/dependency_injection.dart';
import 'package:loadup/core/localization/localization_cubit.dart';
import 'package:loadup/core/routing/app_router.dart';
import 'package:loadup/features/my_shipping/logic/cubit/sent_shipments_cubit.dart';
import 'package:loadup/features/profile/logic/cubit/profile_cubit.dart';
import 'package:loadup/loadup_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import الكيوبت تبعك
import 'package:loadup/features/wallet/logic/cubit/payment_cubit.dart';
// import الثيم
import 'package:loadup/core/theme/theme_cubit.dart';

late SharedPreferences storage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  storage = await SharedPreferences.getInstance();
  await setupGetit();

  final savedLangCode = storage.getString("app_language") ?? "en";
  final savedTheme = ThemeCubit.getSavedTheme();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LocalizationCubit(Locale(savedLangCode)),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(savedTheme),
        ),
        BlocProvider(
          create: (_) => getIt<PaymentsCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<SentShipmentsCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<ProfileCubit>()..getprofile(),
        ),
      ],
      child: LoadUpApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}
