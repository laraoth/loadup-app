import 'package:flutter/widgets.dart';
import 'package:loadup/core/localization/app_localizations.dart';

extension TranslateX on BuildContext {
  String tr(String key) {
    return AppLocalizations.of(this).translate(key);
  }
}
