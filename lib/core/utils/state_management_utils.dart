// lib/core/utils/state_management_utils.dart
import 'dart:async';
import 'package:flutter/material.dart';

/// Utility class for managing app state and preventing common issues
class StateManagementUtils {
  /// Safely dispose of resources
  static void safeDispose(Object? object) {
    if (object is ChangeNotifier) {
      object.dispose();
    }
  }

  /// Check if widget is still mounted before updating state
  static bool isMounted(State state) {
    try {
      return state.mounted;
    } catch (e) {
      return false;
    }
  }

  /// Safe state update that checks if widget is mounted
  static void safeSetState(State state, VoidCallback callback) {
    if (isMounted(state)) {
      // Direct callback execution since we can't access setState
      callback();
    }
  }

  /// Debounce function calls
  static Timer debounce(
    VoidCallback callback, {
    Duration delay = const Duration(milliseconds: 300),
  }) {
    final timer = Timer(delay, callback);
    return timer;
  }
}

/// Extension for safer state management
extension SafeStateExtension on State {
  bool get isSafe => StateManagementUtils.isMounted(this);

  void safeSetState(VoidCallback callback) {
    StateManagementUtils.safeSetState(this, callback);
  }
}
