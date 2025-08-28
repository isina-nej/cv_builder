// lib/core/utils/performance_monitor.dart
import 'package:flutter/foundation.dart';

class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  factory PerformanceMonitor() => _instance;
  PerformanceMonitor._internal();

  final Map<String, DateTime> _startTimes = {};

  void startTimer(String tag) {
    if (kDebugMode) {
      _startTimes[tag] = DateTime.now();
      debugPrint('⏱️ Started timer: $tag');
    }
  }

  void endTimer(String tag) {
    if (kDebugMode && _startTimes.containsKey(tag)) {
      final duration = DateTime.now().difference(_startTimes[tag]!);
      debugPrint('⏱️ Timer $tag completed in ${duration.inMilliseconds}ms');
      _startTimes.remove(tag);
    }
  }

  void logMemoryUsage(String context) {
    if (kDebugMode) {
      debugPrint('🧠 Memory check at $context');
    }
  }

  void logBuildTime(String widgetName, Duration buildTime) {
    if (kDebugMode && buildTime.inMilliseconds > 16) {
      // More than one frame
      debugPrint(
        '⚠️ Slow build detected: $widgetName took ${buildTime.inMilliseconds}ms',
      );
    }
  }
}
