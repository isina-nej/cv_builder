// lib/core/utils/theme_utils.dart
import 'package:flutter/material.dart';

/// Utility class for theme-related operations
class ThemeUtils {
  /// Get appropriate text color based on background brightness
  static Color getTextColor(BuildContext context, {Color? backgroundColor}) {
    final brightness = Theme.of(context).brightness;
    final bgColor = backgroundColor ?? Theme.of(context).colorScheme.surface;

    // Calculate luminance to determine if background is light or dark
    final luminance = bgColor.computeLuminance();

    if (brightness == Brightness.dark) {
      return luminance > 0.5 ? Colors.black : Colors.white;
    } else {
      return luminance > 0.5 ? Colors.white : Colors.black;
    }
  }

  /// Get appropriate icon color for current theme
  static Color getIconColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  /// Get appropriate shadow color for current theme
  static Color getShadowColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Colors.black.withOpacity(0.3)
        : Colors.black.withOpacity(0.1);
  }

  /// Check if current theme is dark
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Get theme-aware surface color with elevation
  static Color getSurfaceColor(BuildContext context, {double elevation = 0}) {
    final colorScheme = Theme.of(context).colorScheme;
    if (elevation == 0) return colorScheme.surface;

    // Simulate elevation effect
    final baseColor = colorScheme.surface;
    final elevationOpacity = (elevation / 24).clamp(0.0, 1.0);

    return Color.alphaBlend(
      colorScheme.surfaceTint.withOpacity(elevationOpacity * 0.1),
      baseColor,
    );
  }

  /// Get appropriate border color for current theme
  static Color getBorderColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return colorScheme.outline.withOpacity(0.3);
  }

  /// Get theme-aware card color
  static Color getCardColor(BuildContext context) {
    return Theme.of(context).cardTheme.color ??
        Theme.of(context).colorScheme.surface;
  }
}

/// Extension methods for easier theme access
extension ThemeContextExtension on BuildContext {
  bool get isDarkMode => ThemeUtils.isDarkMode(this);
  Color getTextColor([Color? backgroundColor]) =>
      ThemeUtils.getTextColor(this, backgroundColor: backgroundColor);
  Color getIconColor() => ThemeUtils.getIconColor(this);
  Color getShadowColor() => ThemeUtils.getShadowColor(this);
  Color getSurfaceColor({double elevation = 0}) =>
      ThemeUtils.getSurfaceColor(this, elevation: elevation);
  Color getBorderColor() => ThemeUtils.getBorderColor(this);
  Color getCardColor() => ThemeUtils.getCardColor(this);
}
