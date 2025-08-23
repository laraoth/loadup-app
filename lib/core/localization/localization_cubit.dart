import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:loadup/main.dart'; // لاستعمال storage

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit(Locale initialLocale) : super(initialLocale);

  Future<void> changeLanguage(String langCode) async {
    await storage.setString("app_language", langCode);
    emit(Locale(langCode));
  }
}
