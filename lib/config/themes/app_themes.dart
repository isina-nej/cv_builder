// lib/config/themes/app_themes.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'text_styles.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      surface: AppColors.backgroundLight,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    textTheme: TextTheme(
      displayLarge: TextStyles.displayLarge.copyWith(
        color: AppColors.textLight,
      ),
      // Add other styles
    ),
    useMaterial3: true,
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      surface: AppColors.backgroundDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: TextTheme(
      displayLarge: TextStyles.displayLarge.copyWith(color: AppColors.textDark),
      // Add other styles
    ),
    useMaterial3: true,
  );
}
