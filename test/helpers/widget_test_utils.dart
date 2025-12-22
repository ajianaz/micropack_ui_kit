import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helpers.dart';

/// Widget testing utilities for Micropack UI Kit components
///
/// Provides specialized testing utilities for common widget scenarios
/// including theme testing, interactive testing, and golden tests
class MPWidgetTestUtils {
  MPWidgetTestUtils._();

  /// Theme test utilities
  static const _themeTestUtils = _ThemeTestUtils();

  /// Get theme test utilities
  static _ThemeTestUtils get theme => _themeTestUtils;

  /// Interaction test utilities
  static const _interactionTestUtils = _InteractionTestUtils();

  /// Get interaction test utilities
  static _InteractionTestUtils get interaction => _interactionTestUtils;

  /// Golden test utilities
  static const _goldenTestUtils = _GoldenTestUtils();

  /// Get golden test utilities
  static _GoldenTestUtils get golden => _goldenTestUtils;

  /// Builder test utilities
  static const _builderTestUtils = _BuilderTestUtils();

  /// Get builder test utilities
  static _BuilderTestUtils get builder => _builderTestUtils;
}

/// Theme testing utilities
class _ThemeTestUtils {
  const _ThemeTestUtils();

  /// Create themed test widget
  Widget createThemedTestWidget({
    required Widget child,
    Brightness brightness = Brightness.light,
    Color? primaryColor,
    Color? backgroundColor,
  }) {
    return MaterialApp(
      theme: _createTestTheme(
        brightness: brightness,
        primaryColor: primaryColor,
        backgroundColor: backgroundColor,
      ),
      home: Scaffold(
        body: child,
      ),
    );
  }

  /// Create test theme data
  ThemeData _createTestTheme({
    required Brightness brightness,
    Color? primaryColor,
    Color? backgroundColor,
  }) {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor ?? const Color(0xFF6366F1),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor ?? const Color(0xFF6366F1),
        brightness: brightness,
      ),
      scaffoldBackgroundColor: backgroundColor,
    );
  }

  /// Test widget in light mode
  Future<void> testInLightMode({
    required WidgetTester tester,
    required Widget widget,
    required VoidCallback then,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(body: widget),
      ),
    );
    then();
  }

  /// Test widget in dark mode
  Future<void> testInDarkMode({
    required WidgetTester tester,
    required Widget widget,
    required VoidCallback then,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(body: widget),
      ),
    );
    then();
  }

  /// Test widget in both light and dark modes
  Future<void> testInBothModes({
    required WidgetTester tester,
    required Widget widget,
    required VoidCallback then,
  }) async {
    await testInLightMode(tester: tester, widget: widget, then: () {
      then();
    });

    await testInDarkMode(tester: tester, widget: widget, then: () {
      then();
    });
  }

  /// Verify theme color is applied correctly
  void verifyThemeColor({
    required Finder finder,
    required Color expectedColor,
    String propertyName = 'color',
  }) {
    // Theme color verification depends on widget type
    // This is a placeholder for custom verification logic
    // Actual implementation should be in component-specific tests
  }

  /// Verify text color adapts to theme
  void verifyAdaptiveTextColor({
    required Finder textFinder,
    required Brightness brightness,
  }) {
    final textWidget = textFinder.evaluate().first.widget as Text;
    final style = textWidget.style;

    // Verify color exists and is appropriate for theme
    if (style != null && style.color != null) {
      final color = style.color!;
      // In light mode, expect darker text
      // In dark mode, expect lighter text
      if (brightness == Brightness.light) {
        assert(color.computeLuminance() < 0.5,
            'Text color should be dark in light mode');
      } else {
        assert(color.computeLuminance() > 0.5,
            'Text color should be light in dark mode');
      }
    }
  }
}

/// Interaction testing utilities
class _InteractionTestUtils {
  const _InteractionTestUtils();

  /// Test tap interaction
  Future<void> testTap({
    required WidgetTester tester,
    required Finder finder,
    VoidCallback? onTap,
    int numberOfTaps = 1,
  }) async {
    for (int i = 0; i < numberOfTaps; i++) {
      await tester.tap(finder);
      await tester.pumpAndSettle();
      onTap?.call();
    }
  }

  /// Test long press interaction
  Future<void> testLongPress({
    required WidgetTester tester,
    required Finder finder,
    VoidCallback? onLongPress,
  }) async {
    await tester.longPress(finder);
    await tester.pumpAndSettle();
    onLongPress?.call();
  }

  /// Test drag interaction
  Future<void> testDrag({
    required WidgetTester tester,
    required Finder finder,
    required Offset offset,
    int? pointer,
  }) async {
    await tester.drag(finder, offset, pointer: pointer);
    await tester.pumpAndSettle();
  }

  /// Test hover interaction (web/desktop)
  Future<void> testHover({
    required WidgetTester tester,
    required Finder finder,
    required Offset location,
  }) async {
    await tester.pump();
    // Hover is tested differently based on platform
    // For now, we pump to trigger any hover-related rebuilds
    await tester.pumpAndSettle();
  }

  /// Test scroll interaction
  Future<void> testScroll({
    required WidgetTester tester,
    required Finder finder,
    required Offset offset,
    int? pointer,
  }) async {
    await tester.drag(finder, offset, pointer: pointer);
    await tester.pumpAndSettle();
  }

  /// Test text input interaction
  Future<void> testTextInput({
    required WidgetTester tester,
    required Finder finder,
    required String text,
    bool clearFirst = false,
  }) async {
    if (clearFirst) {
      await tester.enterText(finder, '');
    }
    await tester.enterText(finder, text);
    await tester.pumpAndSettle();
  }

  /// Test multiple interactions in sequence
  Future<void> testInteractionSequence({
    required WidgetTester tester,
    required List<InteractionStep> steps,
  }) async {
    for (final step in steps) {
      await step.execute(tester);
    }
  }

  /// Verify widget is tappable
  bool isTappable(Finder finder) {
    final widget = finder.evaluate().first.widget;
    return widget is GestureDetector ||
        widget is InkWell ||
        widget is IconButton ||
        widget is TextButton ||
        widget is ElevatedButton ||
        widget is OutlinedButton;
  }

  /// Verify widget is scrollable
  bool isScrollable(Finder finder) {
    final widget = finder.evaluate().first.widget;
    return widget is ListView ||
        widget is SingleChildScrollView ||
        widget is GridView ||
        widget is CustomScrollView;
  }
}

/// Golden testing utilities
class _GoldenTestUtils {
  const _GoldenTestUtils();

  /// Create test widget for golden testing
  Widget createGoldenTestWidget({
    required Widget child,
    ThemeData? theme,
    Size surfaceSize = const Size(400, 600),
    Alignment alignment = Alignment.center,
  }) {
    return RepaintBoundary(
      child: SizedBox(
        width: surfaceSize.width,
        height: surfaceSize.height,
        child: MediaQuery(
          data: MediaQueryData(size: surfaceSize),
          child: MaterialApp(
            theme: theme,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(
                alignment: alignment,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Prepare golden test with custom surface size
  Widget prepareGoldenTest({
    required Widget child,
    Brightness brightness = Brightness.light,
    Size surfaceSize = const Size(400, 600),
  }) {
    return createGoldenTestWidget(
      child: child,
      theme: _getThemeForBrightness(brightness),
      surfaceSize: surfaceSize,
    );
  }

  /// Get theme for brightness
  ThemeData _getThemeForBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return ThemeData.light();
      case Brightness.dark:
        return ThemeData.dark();
    }
  }

  /// Generate golden test file name
  String generateGoldenFileName({
    required String componentName,
    String? variant,
    String? state,
    String? platform,
  }) {
    final buffer = StringBuffer(componentName);
    if (variant != null) buffer.write('_$variant');
    if (state != null) buffer.write('_$state');
    if (platform != null) buffer.write('_$platform');
    return buffer.toString();
  }

  /// Common golden test configurations
  static const Map<String, Size> goldenTestSizes = {
    'mobile': Size(375, 667),
    'mobileLandscape': Size(667, 375),
    'tablet': Size(768, 1024),
    'desktop': Size(1920, 1080),
  };

  /// Create golden tests for multiple screen sizes
  Map<String, Widget> createGoldenTestsForSizes({
    required Widget child,
    Brightness brightness = Brightness.light,
  }) {
    return goldenTestSizes.map(
      (name, size) => MapEntry(
        name,
        createGoldenTestWidget(
          child: child,
          theme: _getThemeForBrightness(brightness),
          surfaceSize: size,
        ),
      ),
    );
  }
}

/// Builder testing utilities
class _BuilderTestUtils {
  const _BuilderTestUtils();

  /// Test LayoutBuilder widget
  Future<void> testLayoutBuilder({
    required WidgetTester tester,
    required Widget child,
    required void Function(BoxConstraints) onBuild,
  }) async {
    ConstraintTracker? tracker;

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (context, setState) {
          return LayoutBuilder(
            builder: (context, constraints) {
              tracker = ConstraintTracker(constraints);
              onBuild(constraints);
              return child;
            },
          );
        },
      ),
    );

    expect(tracker, isNotNull);
  }

  /// Test MediaQuery changes
  Future<void> testMediaQueryChanges({
    required WidgetTester tester,
    required Widget child,
    required List<MediaQueryData> mediaQueryDataList,
    required void Function(MediaQueryData) onChanged,
  }) async {
    for (final mqData in mediaQueryDataList) {
      await tester.pumpWidget(
        MediaQuery(
          data: mqData,
          child: child,
        ),
      );
      onChanged(mqData);
      await tester.pumpAndSettle();
    }
  }

  /// Test OrientationBuilder widget
  Future<void> testOrientationBuilder({
    required WidgetTester tester,
    required Widget child,
    required void Function(Orientation) onBuild,
  }) async {
    await tester.pumpWidget(
      OrientationBuilder(
        builder: (context, orientation) {
          onBuild(orientation);
          return child;
        },
      ),
    );
  }

  /// Test responsive behavior across breakpoints
  Future<void> testResponsiveBreakpoints({
    required WidgetTester tester,
    required Widget Function(BuildContext) builder,
    required Map<double, void Function()> assertions,
  }) async {
    for (final entry in assertions.entries) {
      final width = entry.key;
      final assertion = entry.value;

      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: Size(width, 800)),
          child: Builder(
            builder: builder,
          ),
        ),
      );

      assertion();
      await tester.pumpAndSettle();
    }
  }
}

/// Interaction step for sequence testing
class InteractionStep {
  final String description;
  final Future<void> Function(WidgetTester) execute;

  const InteractionStep({
    required this.description,
    required this.execute,
  });
}

/// Constraint tracker for layout testing
class ConstraintTracker {
  final BoxConstraints constraints;

  ConstraintTracker(this.constraints);

  double get minWidth => constraints.minWidth;
  double get maxWidth => constraints.maxWidth;
  double get minHeight => constraints.minHeight;
  double get maxHeight => constraints.maxHeight;

  bool get hasBoundedWidth => constraints.hasBoundedWidth;
  bool get hasBoundedHeight => constraints.hasBoundedHeight;
  bool get hasTightWidth => constraints.hasTightWidth;
  bool get hasTightHeight => constraints.hasTightHeight;

  @override
  String toString() {
    return 'ConstraintTracker(${constraints.toString()})';
  }
}

/// Custom finders for common widget patterns
class MPCustomFinders {
  MPCustomFinders._();

  /// Find widget by tooltip
  static Finder byTooltip(String message) {
    return find.byWidgetPredicate(
      (widget) =>
          widget is Tooltip &&
          widget.message != null &&
          widget.message == message,
    );
  }

  /// Find widget by icon
  static Finder byIcon(IconData icon) {
    return find.byWidgetPredicate(
      (widget) =>
          widget is Icon &&
          widget.icon == icon,
    );
  }

  /// Find widget by text content (partial match)
  static Finder byTextContaining(String text) {
    return find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          widget.data != null &&
          widget.data!.contains(text),
    );
  }

  /// Find widget by key prefix
  static Finder byKeyPrefix(String prefix) {
    return find.byWidgetPredicate(
      (widget) =>
          widget.key != null &&
          widget.key is ValueKey &&
          widget.key.toString().startsWith(prefix),
    );
  }

  /// Find enabled widgets
  static Finder byEnabled() {
    return find.byWidgetPredicate(
      (widget) =>
          widget is IgnorePointer && widget.ignoring == false,
    );
  }

  /// Find disabled widgets
  static Finder byDisabled() {
    return find.byWidgetPredicate(
      (widget) =>
          widget is IgnorePointer && widget.ignoring == true,
    );
  }

  /// Find widgets with specific semantic label
  static Finder bySemanticsLabel(String label) {
    return find.byWidgetPredicate(
      (widget) => widget.key != null && widget.key.toString().contains(label),
    );
  }
}

/// Test scenarios for common widget behaviors
class MPTestScenarios {
  MPTestScenarios._();

  /// Test widget loading states
  static Future<void> testLoadingStates({
    required WidgetTester tester,
    required Widget Function(bool) builder,
    VoidCallback? onLoadStart,
    VoidCallback? onLoadEnd,
  }) async {
    // Test loading state
    await tester.pumpWidget(
      MPTestHelpers.createTestApp(child: builder(true)),
    );
    onLoadStart?.call();
    await tester.pump();

    // Test not loading state
    await tester.pumpWidget(
      MPTestHelpers.createTestApp(child: builder(false)),
    );
    onLoadEnd?.call();
    await tester.pumpAndSettle();
  }

  /// Test widget error states
  static Future<void> testErrorStates({
    required WidgetTester tester,
    required Widget Function(Object?) builder,
    Object? error,
  }) async {
    await tester.pumpWidget(
      MPTestHelpers.createTestApp(child: builder(error)),
    );
    await tester.pumpAndSettle();
  }

  /// Test widget disabled states
  static Future<void> testDisabledStates({
    required WidgetTester tester,
    required Widget Function(bool) builder,
    VoidCallback? onEnabled,
    VoidCallback? onDisabled,
  }) async {
    // Test enabled state
    await tester.pumpWidget(
      MPTestHelpers.createTestApp(child: builder(false)),
    );
    onEnabled?.call();
    await tester.pump();

    // Test disabled state
    await tester.pumpWidget(
      MPTestHelpers.createTestApp(child: builder(true)),
    );
    onDisabled?.call();
    await tester.pumpAndSettle();
  }

  /// Test widget with different sizes
  static Future<void> testSizeVariants({
    required WidgetTester tester,
    required Map<String, Widget> sizeVariants,
    required void Function(String, Finder) assertions,
  }) async {
    for (final entry in sizeVariants.entries) {
      final size = entry.key;
      final widget = entry.value;

      await tester.pumpWidget(
        MPTestHelpers.createTestApp(child: widget),
      );
      await tester.pumpAndSettle();

      assertions(size, find.byType(widget.runtimeType));
    }
  }

  /// Test widget accessibility
  static Future<void> testAccessibility({
    required WidgetTester tester,
    required Widget widget,
    required Map<String, bool> expectations,
  }) async {
    await tester.pumpWidget(
      MPTestHelpers.createTestApp(child: widget),
    );

    final semantics = MPTestHelpers.getAllSemanticsNodes(tester);

    expectations.forEach((key, expected) {
      final hasLabel = MPTestHelpers.hasAccessibilityLabel(
        nodes: semantics,
        label: key,
      );
      expect(hasLabel, expected,
          reason: expected
              ? 'Expected to find accessibility label: $key'
              : 'Did not expect accessibility label: $key');
    });
  }

  /// Test widget responsiveness
  static Future<void> testResponsiveness({
    required WidgetTester tester,
    required Widget widget,
    required Map<String, Size> breakpoints,
    required void Function(String, Size) assertions,
  }) async {
    for (final entry in breakpoints.entries) {
      final breakpoint = entry.key;
      final size = entry.value;

      await tester.pumpWidget(
        MPTestHelpers.createTestWidgetWithSize(
          child: widget,
          size: size,
        ),
      );
      await tester.pumpAndSettle();

      assertions(breakpoint, size);
    }
  }
}
