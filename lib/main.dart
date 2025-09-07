import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/notification/firebase_messaging_service.dart';
import 'package:loadup/core/notification/notification_service.dart';
import 'package:loadup/features/auth/logic/cubit/login_cubit.dart';
import 'package:loadup/features/my_shipping/logic/cubit/pending_shipments_cubit.dart';
import 'package:loadup/loadup_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:loadup/core/di/dependency_injection.dart';
import 'package:loadup/core/localization/localization_cubit.dart';
import 'package:loadup/core/routing/app_router.dart';
import 'package:loadup/core/theme/theme_cubit.dart';
import 'package:loadup/features/my_shipping/logic/cubit/sent_shipments_cubit.dart';
import 'package:loadup/features/payment/logic/cubit/payments_cubit.dart';
import 'package:loadup/features/profile/logic/cubit/profile_cubit.dart';

import 'firebase_options.dart';

late SharedPreferences storage;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase init
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  storage = await SharedPreferences.getInstance();
  await setupGetit();

  final notifs = NotificationService();
  await notifs.init();

  final fcmService = FirebaseMessagingService(notifs, CrudDio());
  await fcmService.init();

  final token = await fcmService.messaging.getToken();
  print("🔑 FCM Token: $token");

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
          create: (_) => getIt<SentShipmentsCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<ProfileCubit>()..getprofile(),
        ),
        BlocProvider(
          create: (_) => getIt<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<PaymentsCubit>()..fetchPayments(),
        ),
        BlocProvider(
          create: (_) => getIt<PendingShipmentsCubit>()..getPendingShipments(),
        ),
      ],
      child: LoadUpApp(appRouter: AppRouter()),
    ),
  );
}
