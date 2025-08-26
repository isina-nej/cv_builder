// lib/core/providers/locale_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  final SharedPreferences prefs;

  LocaleProvider(this.prefs) {
    _loadLocale();
  }

  void _loadLocale() {
    final String? lang = prefs.getString('language');
    _locale = Locale(lang ?? 'en');
    notifyListeners();
  }

  void changeLocale(Locale newLocale) {
    if (L10n.supportedLocales.contains(newLocale)) {
      _locale = newLocale;
      prefs.setString('language', newLocale.languageCode);
      notifyListeners();
    }
  }
}