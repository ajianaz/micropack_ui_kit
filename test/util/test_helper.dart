import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Test helper class that initializes all required components for testing
class MPTestHelper {
  /// Initialize all required components for testing
  static Future<void> initialize({Size? designSize}) async {
    // Initialize ScreenUtil first
    TestWidgetsFlutterBinding.ensureInitialized();

    // Initialize MPErrorHandler first before any components use it
    await MPErrorHandler.initialize(
      enableLogging: true,
      enableCrashReporting: false,
    );

    // Initialize MPThemeManager for theme-dependent components
    await MPThemeManager.initialize();
  }

  /// Creates a test widget with proper initialization
  static Widget createTestWidget({
    required Widget child,
    ThemeData? theme,
    ThemeData? darkTheme,
  }) {
    return MaterialApp(
      title: 'Micropack UI Kit Test',
      theme: theme ??
          MPTheme.main().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              MPColorTheme.light,
            ],
          ),
      darkTheme: darkTheme ??
          MPTheme.main().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              MPColorTheme.dark,
            ],
          ),
      home: Scaffold(
        body: child,
      ),
    );
  }

  /// Creates a test widget with MPComponentInit wrapper
  static Widget createTestWidgetWithInit({
    required Widget child,
    Size? designSize,
  }) {
    return MPComponentInit(
      designSize: designSize ?? const Size(375, 812), // Default iPhone X size
      builder: (_) => MaterialApp(
        title: 'Micropack UI Kit Test',
        theme: MPTheme.main().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            MPColorTheme.light,
          ],
        ),
        darkTheme: MPTheme.main().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            MPColorTheme.dark,
          ],
        ),
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  /// Wrapper for testWidgets that initializes components
  static Future<void> Function(WidgetTester) withInitialization({
    Size? designSize,
    required Future<void> Function(WidgetTester) callback,
  }) {
    return (WidgetTester tester) async {
      await initialize(designSize: designSize);
      await callback(tester);
    };
  }
}

/// Extension to make testWidgets with initialization easier
extension TestWidgetsExtension on WidgetTester {
  /// Pump widget with MPErrorHandler initialization
  Future<void> pumpWidgetWithInitialization(
    Widget widget, {
    Size? designSize,
    Duration? duration,
  }) async {
    await MPTestHelper.initialize(designSize: designSize);
    await pumpWidget(
      MPTestHelper.createTestWidget(child: widget),
      duration: duration,
    );
  }

  /// Pump widget with MPComponentInit wrapper
  Future<void> pumpWidgetWithMPInit(
    Widget widget, {
    Size? designSize,
    Duration? duration,
  }) async {
    await MPTestHelper.initialize(designSize: designSize);
    await pumpWidget(
      MPTestHelper.createTestWidgetWithInit(
        child: widget,
        designSize: designSize,
      ),
      duration: duration,
    );
  }
}
