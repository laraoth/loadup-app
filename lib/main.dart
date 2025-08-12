import 'package:flutter/material.dart';
import 'package:loadup/core/di/dependency_injection.dart';
import 'package:loadup/core/routing/app_router.dart';
import 'package:loadup/loadup_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences storage;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  storage = await SharedPreferences.getInstance();

  await setupGetit();
  runApp(LoadUpApp(
    appRouter: AppRouter(),
  ));
}
