// lib/config/l10n/app_localizations.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  // Common strings
  String get appTitle => 'CV Builder';

  String get welcome => 'Welcome';
  String get getStarted => 'Get Started';
  String get next => 'Next';
  String get previous => 'Previous';
  String get save => 'Save';
  String get cancel => 'Cancel';
  String get edit => 'Edit';
  String get delete => 'Delete';
  String get add => 'Add';

  // Personal Information
  String get personalInfo => 'Personal Information';
  String get fullName => 'Full Name';
  String get email => 'Email';
  String get phone => 'Phone';
  String get address => 'Address';
  String get summary => 'Professional Summary';
  String get photo => 'Photo';

  // Experience
  String get experience => 'Work Experience';
  String get jobTitle => 'Job Title';
  String get company => 'Company';
  String get startDate => 'Start Date';
  String get endDate => 'End Date';
  String get currentJob => 'Current Job';
  String get description => 'Description';

  // Education
  String get education => 'Education';
  String get degree => 'Degree';
  String get institution => 'Institution';
  String get graduationDate => 'Graduation Date';

  // Skills
  String get skills => 'Skills';
  String get skillName => 'Skill Name';
  String get skillLevel => 'Skill Level';
  String get beginner => 'Beginner';
  String get intermediate => 'Intermediate';
  String get advanced => 'Advanced';
  String get expert => 'Expert';

  // Templates
  String get templates => 'Templates';
  String get preview => 'Preview';
  String get selectTemplate => 'Select Template';

  // Export
  String get export => 'Export';
  String get exportPDF => 'Export as PDF';
  String get exportDOCX => 'Export as DOCX';
  String get exportHTML => 'Export as HTML';

  // Settings
  String get settings => 'Settings';
  String get language => 'Language';
  String get theme => 'Theme';
  String get lightTheme => 'Light Theme';
  String get darkTheme => 'Dark Theme';
  String get systemTheme => 'System Theme';

  // Validation messages
  String get requiredField => 'This field is required';
  String get invalidEmail => 'Please enter a valid email';
  String get invalidPhone => 'Please enter a valid phone number';

  // Success messages
  String get savedSuccessfully => 'Saved successfully';
  String get exportedSuccessfully => 'Exported successfully';

  // Error messages
  String get errorOccurred => 'An error occurred';
  String get exportFailed => 'Export failed';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
