// lib/core/utils/constants.dart
class Constants {
  static const String appName = 'Professional CV Builder';
  static const String appVersion = '1.0.0';
  static const String supportEmail = 'support@cvbuilder.com';

  // App Settings
  static const int maxSkills = 20;
  static const int maxExperiences = 10;
  static const int maxEducations = 5;
  static const int maxSummaryLength = 500;
  static const int maxDescriptionLength = 1000;

  // Export Settings
  static const String defaultExportPath = '/Downloads';
  static const List<String> supportedExportFormats = ['PDF', 'DOCX', 'HTML'];

  // Template Settings
  static const int maxTemplatePreviewWidth = 400;
  static const int maxTemplatePreviewHeight = 600;

  // Validation
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^[\+]?[1-9][\d]{0,15}$';

  // API Keys (if needed)
  static const String? googleApiKey = null;
  static const String? linkedInApiKey = null;
}

class CVTemplates {
  static const String modern = 'modern_professional';
  static const String classic = 'classic_traditional';
  static const String creative = 'creative_colorful';
  static const String minimal = 'minimal_clean';
  static const String executive = 'professional_executive';
  static const String glassMorphism = 'modern_glass';
  static const String darkTheme = 'modern_dark';

  static const List<String> allTemplates = [
    modern,
    classic,
    creative,
    minimal,
    executive,
    glassMorphism,
    darkTheme,
  ];

  static const List<String> premiumTemplates = [
    glassMorphism,
    darkTheme,
    executive,
  ];

  static bool isPremiumTemplate(String templateId) {
    return premiumTemplates.contains(templateId);
  }
}

class AppRoutes {
  static const String welcome = '/';
  static const String builder = '/builder';
  static const String preview = '/preview';
  static const String edit = '/edit';
  static const String templates = '/templates';
  static const String export = '/export';
  static const String settings = '/settings';
  static const String about = '/about';
}

class StorageKeys {
  static const String cvData = 'cv_data';
  static const String theme = 'app_theme';
  static const String language = 'app_language';
  static const String lastUsedTemplate = 'last_template';
  static const String userPreferences = 'user_preferences';
  static const String exportHistory = 'export_history';
}

class AnimationDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration fadeIn = Duration(milliseconds: 500);
  static const Duration slideIn = Duration(milliseconds: 700);
}
