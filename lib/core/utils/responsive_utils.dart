// lib/core/utils/responsive_utils.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static double getResponsiveFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isDesktop(context)) {
      return (desktop ?? tablet ?? mobile).sp;
    } else if (isTablet(context)) {
      return (tablet ?? mobile).sp;
    } else {
      return mobile.sp;
    }
  }

  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    if (isDesktop(context)) {
      final padding = desktop ?? tablet ?? mobile;
      return EdgeInsets.fromLTRB(
        padding.left.w,
        padding.top.h,
        padding.right.w,
        padding.bottom.h,
      );
    } else if (isTablet(context)) {
      final padding = tablet ?? mobile;
      return EdgeInsets.fromLTRB(
        padding.left.w,
        padding.top.h,
        padding.right.w,
        padding.bottom.h,
      );
    } else {
      return EdgeInsets.fromLTRB(
        mobile.left.w,
        mobile.top.h,
        mobile.right.w,
        mobile.bottom.h,
      );
    }
  }

  static int getResponsiveCrossAxisCount(
    BuildContext context, {
    required int mobile,
    int? tablet,
    int? desktop,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  static double getMaxWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (isDesktop(context)) {
      return screenWidth * 0.8; // 80% of screen width on desktop
    } else if (isTablet(context)) {
      return screenWidth * 0.9; // 90% of screen width on tablet
    } else {
      return screenWidth; // Full width on mobile
    }
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  )
  builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return builder(context, isMobile, isTablet, isDesktop);
  }
}
