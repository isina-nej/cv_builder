// lib/core/providers/app_theme_provider.dart
import 'package:flutter/material.dart';
import '../models/theme_config.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeConfig _currentTheme = ThemeConfig.presets[0];
  int _currentThemeIndex = 0;
  bool _isLoading = false;

  ThemeConfig get currentTheme => _currentTheme;
  int get currentThemeIndex => _currentThemeIndex;
  bool get isLoading => _isLoading;

  ThemeData get themeData => _currentTheme.toThemeData();

  void setTheme(int themeIndex) {
    if (themeIndex >= 0 && themeIndex < ThemeConfig.presets.length) {
      _currentThemeIndex = themeIndex;
      _currentTheme = ThemeConfig.presets[themeIndex];
      notifyListeners();
    }
  }

  void setCustomTheme(ThemeConfig themeConfig) {
    _currentTheme = themeConfig;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> applyThemeWithAnimation() async {
    setLoading(true);
    await Future.delayed(const Duration(milliseconds: 300));
    setLoading(false);
  }
}
