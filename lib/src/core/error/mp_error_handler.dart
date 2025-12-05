import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Error severity levels for categorizing errors
enum MPErrorSeverity {
  /// Low severity - minor issues that don't affect functionality
  low,

  /// Medium severity - issues that may affect some functionality but app continues
  medium,

  /// High severity - critical issues that significantly impact functionality
  high,

  /// Critical severity - errors that may cause app crashes or major failures
  critical,
}

/// Error categories for organizing different types of errors
enum MPErrorCategory {
  /// Theme-related errors (loading, switching, etc.)
  theme,

  /// Font loading and text rendering errors
  font,

  /// Component initialization and rendering errors
  component,

  /// Network and resource loading errors
  network,

  /// User input and validation errors
  validation,

  /// System and platform-specific errors
  system,

  /// Unknown or uncategorized errors
  unknown,
}

/// Custom error class for MicroPack UI Kit
class MPError {
  /// Error category
  final MPErrorCategory category;

  /// Error severity
  final MPErrorSeverity severity;

  /// Error code for identification
  final String code;

  /// User-friendly error message
  final String message;

  /// Technical error details
  final String? technicalDetails;

  /// Original error/exception if available
  final dynamic originalError;

  /// Stack trace if available
  final StackTrace? stackTrace;

  /// Timestamp when error occurred
  final DateTime timestamp;

  /// Additional context information
  final Map<String, dynamic>? context;

  MPError({
    required this.category,
    required this.severity,
    required this.code,
    required this.message,
    this.technicalDetails,
    this.originalError,
    this.stackTrace,
    DateTime? timestamp,
    this.context,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Creates a theme error
  factory MPError.theme({
    required String code,
    required String message,
    String? technicalDetails,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return MPError(
      category: MPErrorCategory.theme,
      severity: MPErrorSeverity.medium,
      code: code,
      message: message,
      technicalDetails: technicalDetails,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Creates a font error
  factory MPError.font({
    required String code,
    required String message,
    String? technicalDetails,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return MPError(
      category: MPErrorCategory.font,
      severity: MPErrorSeverity.medium,
      code: code,
      message: message,
      technicalDetails: technicalDetails,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Creates a component error
  factory MPError.component({
    required String code,
    required String message,
    MPErrorSeverity severity = MPErrorSeverity.medium,
    String? technicalDetails,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return MPError(
      category: MPErrorCategory.component,
      severity: severity,
      code: code,
      message: message,
      technicalDetails: technicalDetails,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Creates a network error
  factory MPError.network({
    required String code,
    required String message,
    String? technicalDetails,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return MPError(
      category: MPErrorCategory.network,
      severity: MPErrorSeverity.high,
      code: code,
      message: message,
      technicalDetails: technicalDetails,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Creates a validation error
  factory MPError.validation({
    required String code,
    required String message,
    String? technicalDetails,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return MPError(
      category: MPErrorCategory.validation,
      severity: MPErrorSeverity.low,
      code: code,
      message: message,
      technicalDetails: technicalDetails,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Creates a system error
  factory MPError.system({
    required String code,
    required String message,
    MPErrorSeverity severity = MPErrorSeverity.high,
    String? technicalDetails,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return MPError(
      category: MPErrorCategory.system,
      severity: severity,
      code: code,
      message: message,
      technicalDetails: technicalDetails,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Converts error to a user-friendly string representation
  @override
  String toString() {
    return 'MPError($category: $code): $message';
  }

  /// Converts error to a detailed string for debugging
  String toDetailedString() {
    final buffer = StringBuffer();
    buffer.writeln('MPError Details:');
    buffer.writeln('  Category: ${category.name}');
    buffer.writeln('  Severity: ${severity.name}');
    buffer.writeln('  Code: $code');
    buffer.writeln('  Message: $message');

    if (technicalDetails != null) {
      buffer.writeln('  Technical Details: $technicalDetails');
    }

    if (context != null && context!.isNotEmpty) {
      buffer.writeln('  Context: $context');
    }

    if (originalError != null) {
      buffer.writeln('  Original Error: $originalError');
    }

    if (stackTrace != null) {
      buffer.writeln('  Stack Trace: $stackTrace');
    }

    buffer.writeln('  Timestamp: $timestamp');

    return buffer.toString();
  }
}

/// Error handler callback function type
typedef MPErrorHandlerCallback = void Function(MPError error);

/// Centralized error handler for MicroPack UI Kit
class MPErrorHandler {
  // Singleton pattern
  static MPErrorHandler? _instance;
  static final _lock = _Mutex();

  MPErrorHandler._();

  /// Get singleton instance
  static MPErrorHandler get instance {
    if (_instance == null) {
      throw StateError(
        'MPErrorHandler must be initialized first. Call initialize() before accessing instance.',
      );
    }
    return _instance!;
  }

  /// Initialize error handler
  static Future<MPErrorHandler> initialize({
    bool enableLogging = true,
    bool enableCrashReporting = kDebugMode ? false : true,
    List<MPErrorHandlerCallback>? customHandlers,
  }) async {
    if (_instance == null) {
      await _lock.acquire();
      try {
        if (_instance == null) {
          _instance = MPErrorHandler._();
          await _instance!._initialize(
            enableLogging: enableLogging,
            enableCrashReporting: enableCrashReporting,
            customHandlers: customHandlers,
          );
        }
      } finally {
        _lock.release();
      }
    }
    return _instance!;
  }

  // Configuration
  bool _enableLogging = true;
  bool _enableCrashReporting = true;
  final List<MPErrorHandlerCallback> _customHandlers = [];

  // Error tracking
  final List<MPError> _errorHistory = [];
  final int _maxHistorySize = 100;

  // State
  bool _isInitialized = false;

  /// Initialize error handler with configuration
  Future<void> _initialize({
    required bool enableLogging,
    required bool enableCrashReporting,
    List<MPErrorHandlerCallback>? customHandlers,
  }) async {
    _enableLogging = enableLogging;
    _enableCrashReporting = enableCrashReporting;

    if (customHandlers != null) {
      _customHandlers.addAll(customHandlers);
    }

    // Set up global error handlers
    _setupGlobalErrorHandlers();

    _isInitialized = true;

    if (_enableLogging) {
      developer.log('MPErrorHandler initialized');
    }
  }

  /// Handle an error
  void handleError(MPError error) {
    if (!_isInitialized) {
      developer.log(
          'MPErrorHandler not initialized, logging error directly: ${error.toString()}');
      return;
    }

    // Add to history
    _addToHistory(error);

    // Log error
    if (_enableLogging) {
      _logError(error);
    }

    // Report crash if critical
    if (_enableCrashReporting && error.severity == MPErrorSeverity.critical) {
      _reportCrash(error);
    }

    // Notify custom handlers
    for (final handler in _customHandlers) {
      try {
        handler(error);
      } catch (e) {
        developer.log('Error in custom error handler: $e');
      }
    }
  }

  /// Handle an exception with optional context
  void handleException({
    required dynamic exception,
    StackTrace? stackTrace,
    MPErrorCategory category = MPErrorCategory.unknown,
    MPErrorSeverity severity = MPErrorSeverity.medium,
    String? code,
    String? message,
    Map<String, dynamic>? context,
  }) {
    final error = MPError(
      category: category,
      severity: severity,
      code: code ?? 'EXCEPTION_${exception.runtimeType}',
      message:
          message ?? 'An unexpected error occurred: ${exception.toString()}',
      technicalDetails: exception.toString(),
      originalError: exception,
      stackTrace: stackTrace,
      context: context,
    );

    handleError(error);
  }

  /// Handle a theme-related error
  void handleThemeError({
    required String code,
    required String message,
    String? technicalDetails,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    final error = MPError.theme(
      code: code,
      message: message,
      technicalDetails: technicalDetails,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );

    handleError(error);
  }

  /// Handle a font-related error
  void handleFontError({
    required String code,
    required String message,
    String? technicalDetails,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    final error = MPError.font(
      code: code,
      message: message,
      technicalDetails: technicalDetails,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );

    handleError(error);
  }

  /// Handle a component-related error
  void handleComponentError({
    required String code,
    required String message,
    MPErrorSeverity severity = MPErrorSeverity.medium,
    String? technicalDetails,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    final error = MPError.component(
      code: code,
      message: message,
      severity: severity,
      technicalDetails: technicalDetails,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );

    handleError(error);
  }

  /// Execute a function with error handling
  T? executeWithErrorHandling<T>(
    T Function() function, {
    MPErrorCategory category = MPErrorCategory.unknown,
    MPErrorSeverity severity = MPErrorSeverity.medium,
    String? code,
    String? message,
    Map<String, dynamic>? context,
  }) {
    try {
      return function();
    } catch (e, stackTrace) {
      handleException(
        exception: e,
        stackTrace: stackTrace,
        category: category,
        severity: severity,
        code: code,
        message: message,
        context: context,
      );
      return null;
    }
  }

  /// Execute an async function with error handling
  Future<T?> executeWithErrorHandlingAsync<T>(
    Future<T> Function() function, {
    MPErrorCategory category = MPErrorCategory.unknown,
    MPErrorSeverity severity = MPErrorSeverity.medium,
    String? code,
    String? message,
    Map<String, dynamic>? context,
  }) async {
    try {
      return await function();
    } catch (e, stackTrace) {
      handleException(
        exception: e,
        stackTrace: stackTrace,
        category: category,
        severity: severity,
        code: code,
        message: message,
        context: context,
      );
      return null;
    }
  }

  /// Get user-friendly message for common error codes
  String getUserFriendlyMessage(String errorCode) {
    switch (errorCode) {
      // Theme errors
      case 'THEME_LOAD_FAILED':
        return 'Unable to load theme. Using default theme instead.';
      case 'THEME_SWITCH_FAILED':
        return 'Unable to switch theme. Please try again.';
      case 'THEME_SAVE_FAILED':
        return 'Unable to save theme preference.';

      // Font errors
      case 'FONT_LOAD_FAILED':
        return 'Unable to load custom font. Using default font instead.';
      case 'FONT_NOT_FOUND':
        return 'Font not found. Using system font instead.';
      case 'FONT_RENDER_ERROR':
        return 'Text rendering issue. Using fallback font.';

      // Component errors
      case 'COMPONENT_INIT_FAILED':
        return 'Component failed to initialize. Please refresh the page.';
      case 'COMPONENT_RENDER_ERROR':
        return 'Display issue detected. Component may not appear correctly.';
      case 'COMPONENT_STATE_ERROR':
        return 'Component state error. Please try again.';

      // Network errors
      case 'NETWORK_TIMEOUT':
        return 'Connection timed out. Please check your internet connection.';
      case 'NETWORK_UNAVAILABLE':
        return 'No internet connection. Please check your network settings.';
      case 'RESOURCE_LOAD_FAILED':
        return 'Unable to load resource. Please try again later.';

      // Validation errors
      case 'INVALID_INPUT':
        return 'Invalid input provided. Please check and try again.';
      case 'REQUIRED_FIELD_MISSING':
        return 'Required information is missing.';

      // System errors
      case 'PERMISSION_DENIED':
        return 'Permission denied. Please check your app settings.';
      case 'STORAGE_ERROR':
        return 'Storage access error. Please check your device settings.';
      case 'MEMORY_ERROR':
        return 'Low memory detected. Some features may be limited.';

      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Get error history
  List<MPError> getErrorHistory(
      {MPErrorCategory? category, MPErrorSeverity? severity}) {
    var filteredErrors = _errorHistory;

    if (category != null) {
      filteredErrors =
          filteredErrors.where((e) => e.category == category).toList();
    }

    if (severity != null) {
      filteredErrors =
          filteredErrors.where((e) => e.severity == severity).toList();
    }

    return List.unmodifiable(filteredErrors);
  }

  /// Clear error history
  void clearErrorHistory() {
    _errorHistory.clear();
  }

  /// Add error to history
  void _addToHistory(MPError error) {
    _errorHistory.add(error);

    // Maintain history size limit
    if (_errorHistory.length > _maxHistorySize) {
      _errorHistory.removeAt(0);
    }
  }

  /// Log error to console
  void _logError(MPError error) {
    if (_enableLogging) {
      developer.log(
        error.toDetailedString(),
        name: 'MPErrorHandler',
        error: error.originalError,
        stackTrace: error.stackTrace,
      );
    }
  }

  /// Report crash (in a real implementation, this would send to crash reporting service)
  void _reportCrash(MPError error) {
    if (_enableCrashReporting) {
      // In a real implementation, this would send to a crash reporting service
      // For now, we'll just log it with higher severity
      developer.log(
        'CRASH REPORT: ${error.toDetailedString()}',
        name: 'MPErrorHandler',
        level: 1000, // High priority
      );
    }
  }

  /// Set up global error handlers
  void _setupGlobalErrorHandlers() {
    // Handle uncaught Flutter errors
    FlutterError.onError = (FlutterErrorDetails details) {
      handleException(
        exception: details.exception,
        stackTrace: details.stack,
        category: MPErrorCategory.system,
        severity: MPErrorSeverity.critical,
        code: 'FLUTTER_ERROR',
        message: details.exceptionAsString(),
        context: {
          'library': details.library,
          'context': details.context?.toString(),
          'silent': details.silent,
        },
      );
    };

    // Handle uncaught platform errors (only works in release mode)
    PlatformDispatcher.instance.onError = (error, stack) {
      handleException(
        exception: error,
        stackTrace: stack,
        category: MPErrorCategory.system,
        severity: MPErrorSeverity.critical,
        code: 'PLATFORM_ERROR',
        message: error.toString(),
      );
      return true; // Prevent default error handling
    };
  }

  /// Dispose of error handler
  void dispose() {
    _customHandlers.clear();
    _errorHistory.clear();
    _isInitialized = false;
  }
}

/// Error boundary widget for catching errors in widget trees
class MPErrorBoundary extends StatefulWidget {
  /// Child widget to wrap
  final Widget child;

  /// Error builder function
  final Widget Function(BuildContext context, MPError error)? errorBuilder;

  /// Fallback widget to show on error
  final Widget? fallbackWidget;

  /// Callback when an error occurs
  final void Function(MPError error)? onError;

  /// Custom error category for errors caught by this boundary
  final MPErrorCategory errorCategory;

  /// Custom error severity for errors caught by this boundary
  final MPErrorSeverity errorSeverity;

  const MPErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
    this.fallbackWidget,
    this.onError,
    this.errorCategory = MPErrorCategory.component,
    this.errorSeverity = MPErrorSeverity.medium,
  });

  @override
  State<MPErrorBoundary> createState() => _MPErrorBoundaryState();
}

class _MPErrorBoundaryState extends State<MPErrorBoundary> {
  MPError? _error;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      // Use custom error builder if provided
      if (widget.errorBuilder != null) {
        return widget.errorBuilder!(context, _error!);
      }

      // Use fallback widget if provided
      if (widget.fallbackWidget != null) {
        return widget.fallbackWidget!;
      }

      // Default error UI
      return _buildDefaultErrorUI(context);
    }

    return widget.child;
  }

  Widget _buildDefaultErrorUI(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.error),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.error,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Something went wrong',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            MPErrorHandler.instance.getUserFriendlyMessage(_error!.code),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
          if (kDebugMode) ...[
            const SizedBox(height: 8),
            Text(
              'Error details: ${_error!.technicalDetails ?? 'No details available'}',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Catch errors in the widget tree
  void _catchError(FlutterErrorDetails errorDetails) {
    final mpError = MPError(
      category: widget.errorCategory,
      severity: widget.errorSeverity,
      code: 'WIDGET_ERROR',
      message: 'Widget rendering error: ${errorDetails.exceptionAsString()}',
      technicalDetails: errorDetails.toString(),
      originalError: errorDetails.exception,
      stackTrace: errorDetails.stack,
      context: {
        'widget': widget.runtimeType.toString(),
        'library': errorDetails.library,
        'file': errorDetails.library,
      },
    );

    setState(() {
      _error = mpError;
    });

    // Handle error through centralized error handler
    MPErrorHandler.instance.handleError(mpError);

    // Call custom error callback
    widget.onError?.call(mpError);
  }
}

/// Simple mutex implementation for thread safety
class _Mutex {
  Completer<void>? _completer;

  Future<void> acquire() async {
    while (_completer != null) {
      await _completer!.future;
    }
    _completer = Completer<void>();
  }

  void release() {
    final completer = _completer;
    _completer = null;
    completer?.complete();
  }
}
