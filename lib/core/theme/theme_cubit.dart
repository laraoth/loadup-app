import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/main.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(ThemeMode initialMode) : super(initialMode);

  static const _key = "app_theme";

  Future<void> changeTheme(ThemeMode mode) async {
    await storage.setString(_key, mode.name);
    emit(mode);
  }

  static ThemeMode getSavedTheme() {
    final themeName = storage.getString(_key) ?? ThemeMode.system.name;
    return ThemeMode.values.firstWhere((e) => e.name == themeName);
  }
}
