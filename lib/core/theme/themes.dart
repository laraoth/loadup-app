import 'package:flutter/material.dart';
import '../constant/colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    primaryColor: AppColors.primaryOrange,
    scaffoldBackgroundColor: const Color(0xFFF6F6F6), // رمادي فاتح للخلفية
    cardColor: Colors.white, // الكروت أوضح من الخلفية
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF6F6F6),
      foregroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF1E1E1E)),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF1E1E1E)),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1E1E1E)), // نص أساسي
      bodyMedium: TextStyle(color: Colors.black54), // نص ثانوي
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryOrange,
      onPrimary: Colors.white,
      secondary: AppColors.deepBlue,
      onSecondary: Colors.white,
      background: Color(0xFFF6F6F6),
      onBackground: Color(0xFF1E1E1E),
      surface: Colors.white,
      onSurface: Color(0xFF1E1E1E),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    primaryColor: AppColors.primaryOrange,
    scaffoldBackgroundColor: const Color(0xFF121212), // أغمق لتمييز الخلفية
    cardColor: const Color(0xFF1E1E1E), // الكروت أفتح شوي من الخلفية
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // نص أساسي
      bodyMedium: TextStyle(color: Colors.white70), // نص ثانوي
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryOrange,
      onPrimary: Colors.black,
      secondary: AppColors.deepBlue,
      onSecondary: Colors.white,
      background: Color(0xFF121212),
      onBackground: Colors.white,
      surface: Color(0xFF1E1E1E), // أوضح من الخلفية
      onSurface: Colors.white,
    ),
  );
}
