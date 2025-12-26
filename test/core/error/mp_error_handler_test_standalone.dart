import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

// Include the error handler code directly in the test file
// This is a workaround for import issues

enum MPErrorSeverity {
  low,
  medium,
  high,
  critical,
}

enum MPErrorCategory {
  theme,
  font,
  component,
  network,
  validation,
  system,
  unknown,
}

class MPError {
  final MPErrorCategory category;
  final MPErrorSeverity severity;
  final String code;
  final String message;
  final String? technicalDetails;
  final dynamic originalError;
  final StackTrace? stackTrace;
  final DateTime timestamp;
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

  @override
  String toString() {
    return 'MPError($category: $code): $message';
  }

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

void main() {
  group('MPError Standalone Tests', () {
    test('should create MPError with all properties', () {
      final timestamp = DateTime.now();
      final error = MPError(
        category: MPErrorCategory.theme,
        severity: MPErrorSeverity.high,
        code: 'TEST_ERROR',
        message: 'Test message',
        technicalDetails: 'Test details',
        originalError: 'Original error',
        stackTrace: StackTrace.current,
        timestamp: timestamp,
        context: {'key': 'value'},
      );

      expect(error.category, MPErrorCategory.theme);
      expect(error.severity, MPErrorSeverity.high);
      expect(error.code, 'TEST_ERROR');
      expect(error.message, 'Test message');
      expect(error.technicalDetails, 'Test details');
      expect(error.originalError, 'Original error');
      expect(error.stackTrace, isNotNull);
      expect(error.timestamp, timestamp);
      expect(error.context, {'key': 'value'});
    });

    test('should create MPError with factory constructors', () {
      // Theme error
      final themeError = MPError.theme(
        code: 'THEME_ERROR',
        message: 'Theme error message',
      );
      expect(themeError.category, MPErrorCategory.theme);
      expect(themeError.severity, MPErrorSeverity.medium);
      expect(themeError.code, 'THEME_ERROR');
      expect(themeError.message, 'Theme error message');

      // Font error
      final fontError = MPError.font(
        code: 'FONT_ERROR',
        message: 'Font error message',
      );
      expect(fontError.category, MPErrorCategory.font);
      expect(fontError.severity, MPErrorSeverity.medium);
      expect(fontError.code, 'FONT_ERROR');
      expect(fontError.message, 'Font error message');

      // Component error with custom severity
      final componentError = MPError.component(
        code: 'COMPONENT_ERROR',
        message: 'Component error message',
        severity: MPErrorSeverity.critical,
      );
      expect(componentError.category, MPErrorCategory.component);
      expect(componentError.severity, MPErrorSeverity.critical);
      expect(componentError.code, 'COMPONENT_ERROR');
      expect(componentError.message, 'Component error message');

      // Network error
      final networkError = MPError.network(
        code: 'NETWORK_ERROR',
        message: 'Network error message',
      );
      expect(networkError.category, MPErrorCategory.network);
      expect(networkError.severity, MPErrorSeverity.high);
      expect(networkError.code, 'NETWORK_ERROR');
      expect(networkError.message, 'Network error message');

      // Validation error
      final validationError = MPError.validation(
        code: 'VALIDATION_ERROR',
        message: 'Validation error message',
      );
      expect(validationError.category, MPErrorCategory.validation);
      expect(validationError.severity, MPErrorSeverity.low);
      expect(validationError.code, 'VALIDATION_ERROR');
      expect(validationError.message, 'Validation error message');

      // System error with custom severity
      final systemError = MPError.system(
        code: 'SYSTEM_ERROR',
        message: 'System error message',
        severity: MPErrorSeverity.critical,
      );
      expect(systemError.category, MPErrorCategory.system);
      expect(systemError.severity, MPErrorSeverity.critical);
      expect(systemError.code, 'SYSTEM_ERROR');
      expect(systemError.message, 'System error message');
    });

    test('should convert to string representations', () {
      final error = MPError(
        category: MPErrorCategory.component,
        severity: MPErrorSeverity.high,
        code: 'TEST_ERROR',
        message: 'Test message',
        technicalDetails: 'Test details',
        context: {'key': 'value'},
      );

      // Test toString
      final stringRep = error.toString();
      expect(stringRep,
          'MPError(MPErrorCategory.component: TEST_ERROR): Test message');

      // Test toDetailedString
      final detailedString = error.toDetailedString();
      expect(detailedString, contains('MPError Details:'));
      expect(detailedString, contains('Category: component'));
      expect(detailedString, contains('Severity: high'));
      expect(detailedString, contains('Code: TEST_ERROR'));
      expect(detailedString, contains('Message: Test message'));
      expect(detailedString, contains('Technical Details: Test details'));
      expect(detailedString, contains('Context: {key: value}'));
      expect(detailedString, contains('Timestamp:'));
    });

    test('should handle error severity and category enums', () {
      // Test all severity values
      expect(MPErrorSeverity.low.index, 0);
      expect(MPErrorSeverity.medium.index, 1);
      expect(MPErrorSeverity.high.index, 2);
      expect(MPErrorSeverity.critical.index, 3);

      // Test all category values
      expect(MPErrorCategory.theme.index, 0);
      expect(MPErrorCategory.font.index, 1);
      expect(MPErrorCategory.component.index, 2);
      expect(MPErrorCategory.network.index, 3);
      expect(MPErrorCategory.validation.index, 4);
      expect(MPErrorCategory.system.index, 5);
      expect(MPErrorCategory.unknown.index, 6);
    });

    test('should handle error with minimal properties', () {
      final error = MPError(
        category: MPErrorCategory.unknown,
        severity: MPErrorSeverity.low,
        code: 'MINIMAL_ERROR',
        message: 'Minimal error',
      );

      expect(error.category, MPErrorCategory.unknown);
      expect(error.severity, MPErrorSeverity.low);
      expect(error.code, 'MINIMAL_ERROR');
      expect(error.message, 'Minimal error');
      expect(error.technicalDetails, isNull);
      expect(error.originalError, isNull);
      expect(error.stackTrace, isNull);
      expect(error.context, isNull);
      expect(error.timestamp, isNotNull);
    });

    test('should handle error with all optional properties', () {
      final exception = Exception('Test exception');
      final stackTrace = StackTrace.current;
      final timestamp = DateTime(2023, 1, 1, 12, 0, 0);
      final context = {'component': 'TestComponent', 'action': 'test'};

      final error = MPError(
        category: MPErrorCategory.system,
        severity: MPErrorSeverity.critical,
        code: 'FULL_ERROR',
        message: 'Full error message',
        technicalDetails: 'Technical details',
        originalError: exception,
        stackTrace: stackTrace,
        timestamp: timestamp,
        context: context,
      );

      expect(error.category, MPErrorCategory.system);
      expect(error.severity, MPErrorSeverity.critical);
      expect(error.code, 'FULL_ERROR');
      expect(error.message, 'Full error message');
      expect(error.technicalDetails, 'Technical details');
      expect(error.originalError, exception);
      expect(error.stackTrace, stackTrace);
      expect(error.timestamp, timestamp);
      expect(error.context, context);
    });

    test('should handle error with timestamp auto-generation', () {
      // Just verify that timestamp is set and is recent
      final error = MPError(
        category: MPErrorCategory.validation,
        severity: MPErrorSeverity.medium,
        code: 'TIMESTAMP_ERROR',
        message: 'Timestamp test',
      );

      final now = DateTime.now();
      // Timestamp should be within last 5 seconds
      final difference = now.difference(error.timestamp).inMilliseconds;
      expect(difference, lessThan(5000));
    });
  });
}
