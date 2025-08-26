// lib/config/themes/colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Modern Blue Gradient
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);

  // Secondary Colors - Emerald Green
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryLight = Color(0xFF34D399);
  static const Color secondaryDark = Color(0xFF059669);

  // Accent Colors - Orange/Amber
  static const Color accent = Color(0xFFF59E0B);
  static const Color accentLight = Color(0xFFFBBF24);
  static const Color accentDark = Color(0xFFD97706);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Status Light Colors
  static const Color successLight = Color(0xFFECFDF5);
  static const Color warningLight = Color(0xFFFFFBEB);
  static const Color errorLight = Color(0xFFFEF2F2);
  static const Color infoLight = Color(0xFFEFF6FF);

  // Status Dark Colors
  static const Color successDark = Color(0xFF064E3B);
  static const Color warningDark = Color(0xFF78350F);
  static const Color errorDark = Color(0xFF7F1D1D);
  static const Color infoDark = Color(0xFF1E3A8A);

  // Neutral Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);

  // Grey Scale
  static const Color grey = Color(0xFF6B7280);
  static const Color greyLight = Color(0xFF9CA3AF);
  static const Color greyExtraLight = Color(0xFFE5E7EB);
  static const Color greyDark = Color(0xFF4B5563);
  static const Color greyExtraDark = Color(0xFF374151);

  // Background Colors
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color surfaceDark = Color(0xFF1E293B);

  // Card and Surface Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1F2937);

  // Border Colors
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF374151);

  // Shadow and Overlay
  static const Color shadow = Color(0x1A000000);
  static const Color overlay = Color(0x80000000);

  // Shimmer Colors
  static const Color shimmerBaseLight = Color(0xFFE5E7EB);
  static const Color shimmerHighlightLight = Color(0xFFF3F4F6);
  static const Color shimmerBaseDark = Color(0xFF374151);
  static const Color shimmerHighlightDark = Color(0xFF4B5563);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primary, primaryDark],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryLight, secondary, secondaryDark],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentLight, accent, accentDark],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFAFAFA), Color(0xFFF8FAFC)],
  );

  static const LinearGradient darkSurfaceGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
  );

  // CV Template Colors
  static const Color templateModern = Color(0xFF6366F1);
  static const Color templateClassic = Color(0xFF374151);
  static const Color templateCreative = Color(0xFFEC4899);
  static const Color templateMinimal = Color(0xFF6B7280);
  static const Color templateProfessional = Color(0xFF1F2937);
  static const Color templateColorful = Color(0xFFF59E0B);

  // Skill Level Colors
  static const Color skillBeginner = Color(0xFFEF4444);
  static const Color skillIntermediate = Color(0xFFF59E0B);
  static const Color skillAdvanced = Color(0xFF10B981);
  static const Color skillExpert = Color(0xFF6366F1);

  // Priority Colors
  static const Color priorityHigh = Color(0xFFEF4444);
  static const Color priorityMedium = Color(0xFFF59E0B);
  static const Color priorityLow = Color(0xFF10B981);

  // Social Media Colors
  static const Color linkedin = Color(0xFF0A66C2);
  static const Color github = Color(0xFF181717);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color instagram = Color(0xFFE4405F);
  static const Color facebook = Color(0xFF1877F2);
  static const Color youtube = Color(0xFFFF0000);
  static const Color website = Color(0xFF6366F1);

  // Industry Colors
  static const Color techIndustry = Color(0xFF6366F1);
  static const Color healthcareIndustry = Color(0xFF10B981);
  static const Color financeIndustry = Color(0xFF059669);
  static const Color educationIndustry = Color(0xFF3B82F6);
  static const Color creativesIndustry = Color(0xFFEC4899);
  static const Color manufacturingIndustry = Color(0xFF6B7280);
}
