// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'config/l10n/l10n.dart';
import 'config/routes/app_router.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/locale_provider.dart';
import 'core/providers/app_theme_provider.dart';
import 'core/widgets/error_boundary.dart';

class CVApp extends StatelessWidget {
  const CVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone 13 design size
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Consumer3<ThemeProvider, LocaleProvider, AppThemeProvider>(
            builder:
                (context, themeProvider, localeProvider, appThemeProvider, _) {
                  return MaterialApp(
                    title: 'Professional CV Builder',
                    debugShowCheckedModeBanner: false,
                    theme: appThemeProvider.currentTheme.lightTheme,
                    darkTheme: appThemeProvider.currentTheme.darkTheme,
                    themeMode: themeProvider.themeMode,
                    locale: localeProvider.locale,
                    supportedLocales: L10n.supportedLocales,
                    localizationsDelegates: L10n.localizationsDelegates,
                    onGenerateRoute: AppRouter.onGenerateRoute,
                    initialRoute: AppRouter.splash,
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(
                          context,
                        ).copyWith(textScaler: const TextScaler.linear(1.0)),
                        child: ErrorBoundary(
                          onError: (error, stackTrace) {
                            debugPrint('App Error: $error');
                            debugPrint('Stack Trace: $stackTrace');
                          },
                          child: child!,
                        ),
                      );
                    },
                  );
                },
          ),
        );
      },
    );
  }
}
