// lib/core/utils/validators.dart
import 'constants.dart';

class Validators {
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter ${fieldName ?? 'this field'}';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < Constants.minNameLength) {
      return 'Name must be at least ${Constants.minNameLength} characters';
    }
    if (value.trim().length > Constants.maxNameLength) {
      return 'Name must not exceed ${Constants.maxNameLength} characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    if (!RegExp(Constants.emailPattern).hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(Constants.phonePattern).hasMatch(value.trim())) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? validateOptionalEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }
    if (!RegExp(Constants.emailPattern).hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validateUrl(String? value, {bool isOptional = true}) {
    if (value == null || value.trim().isEmpty) {
      return isOptional ? null : 'Please enter a URL';
    }

    final urlPattern = RegExp(
      r'^(https?|ftp)://[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
    );

    if (!urlPattern.hasMatch(value.trim())) {
      return 'Please enter a valid URL (include http:// or https://)';
    }
    return null;
  }

  static String? validateSummary(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a professional summary';
    }
    if (value.trim().length > Constants.maxSummaryLength) {
      return 'Summary must not exceed ${Constants.maxSummaryLength} characters';
    }
    return null;
  }

  static String? validateDescription(String? value, {bool isOptional = true}) {
    if (value == null || value.trim().isEmpty) {
      return isOptional ? null : 'Please enter a description';
    }
    if (value.trim().length > Constants.maxDescriptionLength) {
      return 'Description must not exceed ${Constants.maxDescriptionLength} characters';
    }
    return null;
  }

  static String? validateSkillLevel(int? value) {
    if (value == null || value < 1 || value > 5) {
      return 'Please select a skill level between 1 and 5';
    }
    return null;
  }

  static String? validateGPA(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }

    final gpaValue = double.tryParse(value.trim());
    if (gpaValue == null) {
      return 'Please enter a valid GPA';
    }

    if (gpaValue < 0 || gpaValue > 4.0) {
      return 'GPA must be between 0.0 and 4.0';
    }

    return null;
  }

  static String? validateYearsOfExperience(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }

    final years = int.tryParse(value.trim());
    if (years == null || years < 0 || years > 50) {
      return 'Please enter valid years of experience (0-50)';
    }

    return null;
  }

  static String? validateDate(String? value, {bool isOptional = false}) {
    if (value == null || value.trim().isEmpty) {
      return isOptional ? null : 'Please enter a date';
    }

    // Basic date format validation (MM/YYYY or MM/DD/YYYY)
    final datePattern = RegExp(
      r'^(0[1-9]|1[0-2])\/(\d{4})$|^(0[1-9]|1[0-2])\/([0-2][0-9]|3[0-1])\/(\d{4})$',
    );

    if (!datePattern.hasMatch(value.trim())) {
      return 'Please enter date in MM/YYYY format';
    }

    return null;
  }

  static String? validateLinkedInUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }

    final linkedInPattern = RegExp(
      r'^https?://(?:www\.)?linkedin\.com/in/[\w\-_]+/?$',
      caseSensitive: false,
    );

    if (!linkedInPattern.hasMatch(value.trim())) {
      return 'Please enter a valid LinkedIn profile URL';
    }

    return null;
  }

  static String? validateGitHubUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }

    final githubPattern = RegExp(
      r'^https?://(?:www\.)?github\.com/[\w\-_]+/?$',
      caseSensitive: false,
    );

    if (!githubPattern.hasMatch(value.trim())) {
      return 'Please enter a valid GitHub profile URL';
    }

    return null;
  }
}
