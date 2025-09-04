import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loadup/core/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.getStartedScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          isDark ? "assets/images/SplashBlack.png" : "assets/images/Splash.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
