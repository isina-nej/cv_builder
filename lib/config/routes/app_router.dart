// lib/config/routes/app_router.dart
import 'package:flutter/material.dart';
import '../../features/cv_builder/screens/builder_screen.dart';
import '../../features/cv_builder/screens/preview_screen.dart';
import '../../features/cv_builder/screens/edit_screen.dart';

class AppRouter {
  static const String builder = '/builder';
  static const String preview = '/preview';
  static const String edit = '/edit';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case builder:
        return MaterialPageRoute(builder: (_) => const BuilderScreen());
      case preview:
        return MaterialPageRoute(builder: (_) => const PreviewScreen());
      case edit:
        return MaterialPageRoute(builder: (_) => const EditScreen());
      default:
        return MaterialPageRoute(builder: (_) => const BuilderScreen());
    }
  }
}