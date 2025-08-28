// lib/core/utils/optimization_utils.dart
import 'package:flutter/material.dart';

class OptimizationUtils {
  // کاهش کیفیت تصاویر در حالت کم‌مصرف
  static ImageProvider getOptimizedImage(
    String path, {
    bool lowQuality = false,
  }) {
    if (lowQuality) {
      return AssetImage(path);
    }
    return AssetImage(path);
  }

  // بهینه‌سازی انیمیشن‌ها برای دستگاه‌های ضعیف
  static Duration getOptimizedDuration(
    Duration original, {
    bool lowPerformance = false,
  }) {
    if (lowPerformance) {
      return original * 0.7; // 30% سریع‌تر
    }
    return original;
  }

  // کاهش تعداد آیتم‌های نمایش داده شده
  static int getOptimizedItemCount(int original, {bool lowMemory = false}) {
    if (lowMemory) {
      return (original * 0.8).toInt(); // 20% کمتر
    }
    return original;
  }

  // بهینه‌سازی shadow برای کاهش مصرف GPU
  static BoxShadow getOptimizedShadow({
    required Color color,
    double blurRadius = 8.0,
    Offset offset = const Offset(0, 2),
    bool lowPerformance = false,
  }) {
    if (lowPerformance) {
      return BoxShadow(
        color: color.withValues(alpha: 0.3),
        blurRadius: blurRadius * 0.7,
        offset: offset,
      );
    }
    return BoxShadow(color: color, blurRadius: blurRadius, offset: offset);
  }

  // تشخیص دستگاه‌های ضعیف
  static bool isLowPerformanceDevice(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // دستگاه‌های با RAM کمتر از 4GB یا صفحه نمایش کوچک
    return mediaQuery.size.width < 360 || mediaQuery.devicePixelRatio < 2.5;
  }
}
