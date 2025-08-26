// lib/app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/themes/app_themes.dart';
import 'config/l10n/l10n.dart';
import 'config/routes/app_router.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/locale_provider.dart';

class CVApp extends StatelessWidget {
  const CVApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'CV Builder',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.themeMode,
      locale: localeProvider.locale,
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: L10n.localizationsDelegates,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.builder,
    );
  }
}