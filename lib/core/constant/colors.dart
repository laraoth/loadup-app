import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryOrange = Color(0xFFFF8C00);
  static const Color deepBlue = Color(0xFF022D71);
  static const Color red = Color.fromARGB(255, 198, 2, 2);
  static const Color green = Color.fromARGB(255, 18, 181, 83);
  static const Color grey = Color(0xFFC2C2C2);

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFFF6F6F6)
          : const Color(0xFF1E1E1E);

  static Color surface(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF2A2A2A);

  static Color text(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF1E1E1E)
          : const Color(0xFFF5F5F5);

  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color onPrimary(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;

  static Color secondary(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static Color onSecondary(BuildContext context) =>
      Theme.of(context).colorScheme.onSecondary;

  static Color onSurface(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color cardBackground(BuildContext context) => surface(context);

  static Color appBarBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFFF6F6F6)
          : const Color(0xFF2A2A2A);

  static Color divider(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade300
          : Colors.grey.shade700;

  static Color icon(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF1E1E1E)
          : const Color(0xFFF5F5F5);

  static Color hintText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade600
          : Colors.grey.shade400;
}
