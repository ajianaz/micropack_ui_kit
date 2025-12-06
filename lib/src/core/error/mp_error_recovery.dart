import 'dart:async';
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/src/core/error/mp_error_handler.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_manager.dart';
import 'package:micropack_ui_kit/src/core/fonts/mp_font_manager.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Error recovery strategies for different types of errors
enum MPErrorRecoveryStrategy {
  /// Retry the operation that failed
  retry,

  /// Use fallback value/mechanism
  fallback,

  /// Graceful degradation with reduced functionality
  degrade,

  /// Reset to default state
  reset,

  /// Skip the operation and continue
  skip,

  /// Ask user for intervention
  userIntervention,
}

/// Error recovery configuration
class MPErrorRecoveryConfig {
  /// Maximum number of retry attempts
  final int maxRetries;

  /// Delay between retry attempts
  final Duration retryDelay;

  /// Whether to use exponential backoff for retries
  final bool useExponentialBackoff;

  /// Maximum backoff delay
  final Duration maxBackoffDelay;

  /// Fallback values for different error types
  final Map<String, dynamic> fallbackValues;

  /// Recovery strategy for each error category
  final Map<MPErrorCategory, MPErrorRecoveryStrategy> strategies;

  const MPErrorRecoveryConfig({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.useExponentialBackoff = true,
    this.maxBackoffDelay = const Duration(seconds: 10),
    this.fallbackValues = const {},
    this.strategies = const {},
  });
}

/// Enhanced error recovery system
class MPErrorRecovery {
  static MPErrorRecoveryConfig _config = const MPErrorRecoveryConfig();
  static final Map<String, int> _retryCounters = {};

  /// Configure error recovery behavior
  static void configure(MPErrorRecoveryConfig config) {
    _config = config;
  }

  /// Attempt to recover from an error with automatic retry and fallback
  static Future<T?> recoverFromError<T>({
    required MPError error,
    required Future<T> Function() operation,
    String? operationKey,
    Map<String, dynamic>? context,
  }) async {
    final key = operationKey ?? error.code;
    final strategy =
        _config.strategies[error.category] ?? MPErrorRecoveryStrategy.fallback;

    switch (strategy) {
      case MPErrorRecoveryStrategy.retry:
        return await _retryWithBackoff<T>(
          operationKey: key,
          operation: operation,
          error: error,
          context: context,
        );

      case MPErrorRecoveryStrategy.fallback:
        return await _applyFallback<T>(error, context);

      case MPErrorRecoveryStrategy.degrade:
        return await _gracefulDegradation<T>(error, context);

      case MPErrorRecoveryStrategy.reset:
        return await _resetToDefaults<T>(error, context);

      case MPErrorRecoveryStrategy.skip:
        return null; // Skip operation

      case MPErrorRecoveryStrategy.userIntervention:
        await _requestUserIntervention(error, context);
        return null;
    }
  }

  /// Retry operation with exponential backoff
  static Future<T?> _retryWithBackoff<T>({
    required String operationKey,
    required Future<T> Function() operation,
    required MPError error,
    Map<String, dynamic>? context,
  }) async {
    final currentRetryCount = _retryCounters[operationKey] ?? 0;

    if (currentRetryCount >= _config.maxRetries) {
      debugPrint('Max retries exceeded for $operationKey, applying fallback');
      return await _applyFallback<T>(error, context);
    }

    _retryCounters[operationKey] = currentRetryCount + 1;

    try {
      debugPrint(
          'Retrying operation $operationKey (attempt ${currentRetryCount + 1})');
      return await operation();
    } catch (e) {
      debugPrint('Retry $currentRetryCount failed for $operationKey: $e');

      // Calculate delay for next retry
      Duration delay = _config.retryDelay;
      if (_config.useExponentialBackoff) {
        final backoffMultiplier = (1 << currentRetryCount).toDouble();
        delay = Duration(
          milliseconds: (_config.retryDelay.inMilliseconds * backoffMultiplier)
              .clamp(0.0, _config.maxBackoffDelay.inMilliseconds.toDouble())
              .toInt(),
        );
      }

      // Wait before retrying
      await Future.delayed(delay);

      // Recursive retry
      return await recoverFromError<T>(
        error: MPError(
          category: error.category,
          severity: error.severity,
          code: error.code,
          message: error.message,
          technicalDetails: error.technicalDetails,
          originalError: e,
          context: context,
        ),
        operation: operation,
        operationKey: operationKey,
        context: context,
      );
    }
  }

  /// Apply fallback value or mechanism
  static Future<T?> _applyFallback<T>(
      MPError error, Map<String, dynamic>? context) async {
    final fallbackValue = _config.fallbackValues[error.code];

    if (fallbackValue != null) {
      debugPrint('Applying fallback for ${error.code}: $fallbackValue');
      return fallbackValue as T?;
    }

    // Apply category-specific fallbacks
    switch (error.category) {
      case MPErrorCategory.theme:
        return await _applyThemeFallback<T>(error, context);

      case MPErrorCategory.font:
        return await _applyFontFallback<T>(error, context);

      case MPErrorCategory.component:
        return await _applyComponentFallback<T>(error, context);

      case MPErrorCategory.network:
        return await _applyNetworkFallback<T>(error, context);

      case MPErrorCategory.validation:
        return await _applyValidationFallback<T>(error, context);

      case MPErrorCategory.system:
        return await _applySystemFallback<T>(error, context);

      case MPErrorCategory.unknown:
        return await _applyUnknownFallback<T>(error, context);
    }
  }

  /// Apply theme-specific fallback
  static Future<T?> _applyThemeFallback<T>(
      MPError error, Map<String, dynamic>? context) async {
    try {
      debugPrint('Applying theme fallback for ${error.code}');

      switch (error.code) {
        case 'THEME_INIT_FAILED':
        case 'THEME_SWITCH_FAILED':
          // Reset to system theme
          if (MPThemeManager.instance.isInitialized) {
            await MPThemeManager.instance.setSystemTheme();
          }
          break;

        case 'THEME_LOAD_FAILED':
          // Clear theme cache and reload
          if (MPThemeManager.instance.isInitialized) {
            MPThemeManager.instance.clearCaches();
          }
          break;
      }

      return null as T?;
    } catch (e) {
      debugPrint('Theme fallback failed: $e');
      return null;
    }
  }

  /// Apply font-specific fallback
  static Future<T?> _applyFontFallback<T>(
      MPError error, Map<String, dynamic>? context) async {
    try {
      debugPrint('Applying font fallback for ${error.code}');

      switch (error.code) {
        case 'FONT_LOAD_FAILED':
          // Clear font cache and retry with system font
          MPFontManager().clearCache();
          break;

        case 'FONT_NOT_FOUND':
          // Force system font usage
          MpUiKit.fontName = 'system';
          break;
      }

      return null as T?;
    } catch (e) {
      debugPrint('Font fallback failed: $e');
      return null;
    }
  }

  /// Apply component-specific fallback
  static Future<T?> _applyComponentFallback<T>(
      MPError error, Map<String, dynamic>? context) async {
    debugPrint('Applying component fallback for ${error.code}');

    // Component fallbacks are typically handled at the widget level
    // This method can be expanded for specific component recovery
    return null as T?;
  }

  /// Apply network-specific fallback
  static Future<T?> _applyNetworkFallback<T>(
      MPError error, Map<String, dynamic>? context) async {
    debugPrint('Applying network fallback for ${error.code}');

    switch (error.code) {
      case 'NETWORK_TIMEOUT':
      case 'NETWORK_UNAVAILABLE':
        // Implement offline mode or cached data
        break;

      case 'RESOURCE_LOAD_FAILED':
        // Use cached or local resources
        break;
    }

    return null as T?;
  }

  /// Apply validation-specific fallback
  static Future<T?> _applyValidationFallback<T>(
      MPError error, Map<String, dynamic>? context) async {
    debugPrint('Applying validation fallback for ${error.code}');

    // Validation fallbacks typically involve clearing invalid input
    // or showing validation messages
    return null as T?;
  }

  /// Apply system-specific fallback
  static Future<T?> _applySystemFallback<T>(
      MPError error, Map<String, dynamic>? context) async {
    debugPrint('Applying system fallback for ${error.code}');

    // System fallbacks might involve restarting services
    // or clearing caches
    return null as T?;
  }

  /// Apply unknown error fallback
  static Future<T?> _applyUnknownFallback<T>(
      MPError error, Map<String, dynamic>? context) async {
    debugPrint('Applying unknown fallback for ${error.code}');

    // For unknown errors, we typically log and continue
    // with minimal functionality
    return null as T?;
  }

  /// Graceful degradation with reduced functionality
  static Future<T?> _gracefulDegradation<T>(
      MPError error, Map<String, dynamic>? context) async {
    debugPrint('Applying graceful degradation for ${error.code}');

    switch (error.category) {
      case MPErrorCategory.theme:
        // Disable theme animations and transitions
        break;

      case MPErrorCategory.font:
        // Use basic system fonts
        MpUiKit.fontName = 'system';
        break;

      case MPErrorCategory.component:
        // Disable advanced features
        break;

      case MPErrorCategory.network:
        // Enable offline mode
        break;

      case MPErrorCategory.validation:
      case MPErrorCategory.system:
      case MPErrorCategory.unknown:
      default:
        // Log and continue
        break;
    }

    return null as T?;
  }

  /// Reset to default state
  static Future<T?> _resetToDefaults<T>(
      MPError error, Map<String, dynamic>? context) async {
    debugPrint('Resetting to defaults due to ${error.code}');

    try {
      switch (error.category) {
        case MPErrorCategory.theme:
          if (MPThemeManager.instance.isInitialized) {
            await MPThemeManager.instance.resetToDefaults();
          }
          break;

        case MPErrorCategory.font:
          MPFontManager().clearCache();
          MpUiKit.fontName = 'Poppins';
          break;

        case MPErrorCategory.component:
          // Reset component states
          break;

        case MPErrorCategory.network:
          // Reset network connections
          break;

        case MPErrorCategory.validation:
          // Clear validation states
          break;

        case MPErrorCategory.system:
          // Reset system configurations
          break;

        case MPErrorCategory.unknown:
          // Reset unknown configurations
          break;
      }
    } catch (e) {
      debugPrint('Reset to defaults failed: $e');
    }

    return null as T?;
  }

  /// Request user intervention for critical errors
  static Future<void> _requestUserIntervention(
      MPError error, Map<String, dynamic>? context) async {
    debugPrint('Requesting user intervention for ${error.code}');

    // This could show a dialog or notification
    // Implementation depends on the app context
    // For now, just log the need for intervention
  }

  /// Clear retry counters (useful for testing or reset)
  static void clearRetryCounters() {
    _retryCounters.clear();
  }

  /// Get retry statistics
  static Map<String, dynamic> getRetryStats() {
    return {
      'retryCounters': Map.from(_retryCounters),
      'config': {
        'maxRetries': _config.maxRetries,
        'retryDelay': _config.retryDelay.inMilliseconds,
        'useExponentialBackoff': _config.useExponentialBackoff,
        'maxBackoffDelay': _config.maxBackoffDelay.inMilliseconds,
      },
    };
  }
}
