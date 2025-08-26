// lib/config/l10n/l10n.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class L10n {
  static final List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('fa', 'IR'), // For Persian
    // Add more locales
  ];

  static final List<LocalizationsDelegate> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  // Note: Actual localization files would be generated with intl
  // This is a placeholder for app_localizations.dart
  static String get appTitle => Intl.message('CV Builder', name: 'appTitle');
  // Add more strings
}