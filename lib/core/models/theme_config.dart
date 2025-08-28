// lib/core/models/theme_config.dart
import 'package:flutter/material.dart';

class ThemeConfig {
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Brightness brightness;

  const ThemeConfig({
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.brightness,
  });

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: surfaceColor,
        background: backgroundColor,
        onPrimary: Colors.white,
        onSecondary: brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        onSurface: textPrimaryColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: const Color(0xFF1E1E1E),
        background: const Color(0xFF121212),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1F1F1F),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // Predefined theme presets
  static const List<ThemeConfig> presets = [
    // Modern Blue
    ThemeConfig(
      primaryColor: Color(0xFF2196F3),
      secondaryColor: Color(0xFF03DAC6),
      accentColor: Color(0xFFFF9800),
      backgroundColor: Color(0xFFF5F5F5),
      surfaceColor: Colors.white,
      textPrimaryColor: Color(0xFF212121),
      textSecondaryColor: Color(0xFF757575),
      brightness: Brightness.light,
    ),
    // Dark Purple
    ThemeConfig(
      primaryColor: Color(0xFF673AB7),
      secondaryColor: Color(0xFF9C27B0),
      accentColor: Color(0xFFE91E63),
      backgroundColor: Color(0xFF121212),
      surfaceColor: Color(0xFF1E1E1E),
      textPrimaryColor: Colors.white,
      textSecondaryColor: Color(0xFFB0B0B0),
      brightness: Brightness.dark,
    ),
    // Green Nature
    ThemeConfig(
      primaryColor: Color(0xFF4CAF50),
      secondaryColor: Color(0xFF8BC34A),
      accentColor: Color(0xFFFFEB3B),
      backgroundColor: Color(0xFFF1F8E9),
      surfaceColor: Colors.white,
      textPrimaryColor: Color(0xFF1B5E20),
      textSecondaryColor: Color(0xFF4E7C59),
      brightness: Brightness.light,
    ),
    // Orange Sunset
    ThemeConfig(
      primaryColor: Color(0xFFFF5722),
      secondaryColor: Color(0xFFFF9800),
      accentColor: Color(0xFFFFC107),
      backgroundColor: Color(0xFFFFF3E0),
      surfaceColor: Colors.white,
      textPrimaryColor: Color(0xFFBF360C),
      textSecondaryColor: Color(0xFF795548),
      brightness: Brightness.light,
    ),
  ];

  ThemeData toThemeData() {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: surfaceColor,
        background: backgroundColor,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'System',
          color: textPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'System',
          color: textPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(fontFamily: 'System', color: textPrimaryColor),
        bodyMedium: TextStyle(fontFamily: 'System', color: textSecondaryColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
    );
  }
}
