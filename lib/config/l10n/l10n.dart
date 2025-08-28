// lib/config/l10n/l10n.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';

class L10n {
  static final List<Locale> supportedLocales =
      AppLocalizations.supportedLocales;

  static final List<LocalizationsDelegate> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  // Helper method to get localized strings
  static AppLocalizations getStrings(BuildContext context) {
    return AppLocalizations.of(context);
  }
}
