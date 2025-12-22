import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Test helper utilities for Micropack UI Kit
///
/// Provides common test scenarios and utilities
/// for testing components with themes and responsive behavior
class MPTestHelpers {
  MPTestHelpers._();

  /// Create a test material app with theme setup
  static Widget createTestApp({
    required Widget child,
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode? themeMode,
  }) {
    return MaterialApp(
      title: 'Micropack UI Kit Test',
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode ?? ThemeMode.system,
      home: Scaffold(
        body: child,
      ),
    );
  }

  /// Create a test widget with specific screen size
  static Widget createTestWidgetWithSize({
    required Widget child,
    required Size size,
    ThemeData? theme,
  }) {
    return MediaQuery(
      data: MediaQueryData(size: size),
      child: MaterialApp(
        theme: theme,
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  /// Create a test widget with custom MediaQuery
  static Widget createTestWidgetWithMediaQuery({
    required Widget child,
    MediaQueryData? mediaQueryData,
    ThemeData? theme,
  }) {
    return MediaQuery(
      data: mediaQueryData ?? const MediaQueryData(),
      child: MaterialApp(
        theme: theme,
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  /// Pump a widget and wait for all animations to complete
  static Future<void> pumpAndSettle(
    WidgetTester tester, {
    required Widget widget,
    Duration duration = const Duration(milliseconds: 500),
  }) async {
    await tester.pumpWidget(widget);
    await tester.pump(duration);
  }

  /// Find a widget by its type and key
  static Finder findByTypeAndKey<T extends Widget>(Key key) {
    return find.byWidgetPredicate(
      (widget) => widget is T && widget.key == key,
    );
  }

  /// Find a widget by its text content
  static Finder findByText(String text) {
    return find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          widget.data != null &&
          widget.data!.contains(text),
    );
  }

  /// Get the render box of a widget
  static RenderBox getRenderBox(
    WidgetTester tester,
    Finder finder,
  ) {
    return tester.renderObject(finder) as RenderBox;
  }

  /// Get the size of a widget
  static Size getWidgetSize(
    WidgetTester tester,
    Finder finder,
  ) {
    return getRenderBox(tester, finder).size;
  }

  /// Get the position of a widget
  static Offset getWidgetPosition(
    WidgetTester tester,
    Finder finder,
  ) {
    return getRenderBox(tester, finder).localToGlobal(Offset.zero);
  }

  /// Tap a widget and wait for animations
  static Future<void> tapAndWait(
    WidgetTester tester,
    Finder finder, {
    Duration duration = const Duration(milliseconds: 300),
  }) async {
    await tester.tap(finder);
    await tester.pump(duration);
  }

  /// Long press a widget and wait for animations
  static Future<void> longPressAndWait(
    WidgetTester tester,
    Finder finder, {
    Duration duration = const Duration(milliseconds: 500),
  }) async {
    await tester.longPress(finder);
    await tester.pump(duration);
  }

  /// Drag a widget and wait for animations
  static Future<void> dragAndWait(
    WidgetTester tester,
    Finder finder, {
    required Offset offset,
    Duration duration = const Duration(milliseconds: 300),
  }) async {
    await tester.drag(finder, offset);
    await tester.pump(duration);
  }

  /// Enter text into a text field and wait
  static Future<void> enterTextAndWait(
    WidgetTester tester,
    Finder finder,
    String text, {
    Duration duration = const Duration(milliseconds: 100),
  }) async {
    await tester.enterText(finder, text);
    await tester.pump(duration);
  }

  /// Test if a widget is visible on screen
  static bool isWidgetVisible(WidgetTester tester, Finder finder) {
    try {
      final rect = tester.getRect(finder);
      return rect.width > 0 && rect.height > 0;
    } catch (e) {
      return false;
    }
  }

  /// Test if a widget is within bounds of another widget
  static bool isWithinBounds({
    required Rect inner,
    required Rect outer,
  }) {
    return outer.left <= inner.left &&
        outer.right >= inner.right &&
        outer.top <= inner.top &&
        outer.bottom >= inner.bottom;
  }

  /// Wait for a widget to appear
  static Future<void> waitFor(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 5),
    Duration pumpInterval = const Duration(milliseconds: 100),
  }) async {
    final startTime = DateTime.now();
    while (finder.evaluate().isEmpty) {
      final elapsed = DateTime.now().difference(startTime);
      if (elapsed > timeout) {
        throw Exception('Widget not found within $timeout');
      }
      await tester.pump(pumpInterval);
    }
  }

  /// Wait for a widget to disappear
  static Future<void> waitUntilAbsent(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 5),
    Duration pumpInterval = const Duration(milliseconds: 100),
  }) async {
    final startTime = DateTime.now();
    while (finder.evaluate().isNotEmpty) {
      final elapsed = DateTime.now().difference(startTime);
      if (elapsed > timeout) {
        throw Exception('Widget still present after $timeout');
      }
      await tester.pump(pumpInterval);
    }
  }

  /// Create a test widget with accessibility features
  static Widget createTestWidgetWithAccessibility({
    required Widget child,
    bool highContrast = false,
    bool disableAnimations = false,
    bool accessibleNavigation = false,
    double textScaleFactor = 1.0,
  }) {
    return MediaQuery(
      data: MediaQueryData(
        highContrast: highContrast,
        disableAnimations: disableAnimations,
        accessibleNavigation: accessibleNavigation,
        textScaleFactor: textScaleFactor.clamp(0.8, 3.0),
      ),
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  /// Get all semantics nodes for accessibility testing
  static List<SemanticsNode> getAllSemanticsNodes(
    WidgetTester tester, {
    bool ignoreContainers = true,
  }) {
    final semantics = SemanticsHandle(tester.ensureSemantics());
    try {
      return tester.pipelineOwner.semanticsOwner!
          .getSemanticsNodes()
          .where((node) => !ignoreContainers || !node.isTagged(SemanticsTags.container))
          .toList();
    } finally {
      semantics.dispose();
    }
  }

  /// Verify accessibility label exists
  static bool hasAccessibilityLabel({
    required List<SemanticsNode> nodes,
    required String label,
  }) {
    return nodes.any(
      (node) => node.label != null && node.label!.contains(label),
    );
  }

  /// Verify accessibility action exists
  static bool hasAccessibilityAction({
    required List<SemanticsNode> nodes,
    required SemanticsAction action,
  }) {
    return nodes.any(
      (node) => node.getActions().contains(action),
    );
  }

  /// Create a test widget builder for parameterized tests
  static Widget Function(Widget) createTestWrapper({
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode? themeMode,
  }) {
    return (child) => MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode ?? ThemeMode.system,
      home: Scaffold(
        body: child,
      ),
    );
  }

  /// Get test material app for golden tests
  static Widget createTestAppForGolden({
    required Widget child,
    ThemeData? theme,
    Size surfaceSize = const Size(400, 600),
  }) {
    return RepaintBoundary(
      child: MediaQuery(
        data: MediaQueryData(size: surfaceSize),
        child: MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Center(child: child),
          ),
        ),
      ),
    );
  }

  /// Common test scenarios for responsive testing
  static const Map<String, Size> responsiveTestSizes = {
    'smallMobile': Size(320, 568), // iPhone SE
    'mobile': Size(375, 667), // iPhone 8
    'largeMobile': Size(414, 896), // iPhone 11 Pro Max
    'tablet': Size(768, 1024), // iPad
    'desktop': Size(1920, 1080), // Full HD
  };

  /// Get test size for device type
  static Size getTestSize(String deviceType) {
    return responsiveTestSizes[deviceType] ?? responsiveTestSizes['mobile']!;
  }

  /// Create test widgets for all responsive breakpoints
  static Map<String, Widget> createResponsiveTestWidgets({
    required Widget Function(Size) builder,
  }) {
    return responsiveTestSizes.map(
      (deviceType, size) => MapEntry(
        deviceType,
        MediaQuery(
          data: MediaQueryData(size: size),
          child: SizedBox(width: size.width, height: size.height, child: builder(size)),
        ),
      ),
    );
  }
}

/// Custom matcher for widget property testing
class WidgetPropertyMatcher extends Matcher {
  final String propertyName;
  final dynamic expectedValue;
  final dynamic Function(Widget) getProperty;

  const WidgetPropertyMatcher({
    required this.propertyName,
    required this.expectedValue,
    required this.getProperty,
  });

  @override
  bool matches(covariant Widget widget, Map matchState) {
    final actualValue = getProperty(widget);
    matchState['actualValue'] = actualValue;
    return actualValue == expectedValue;
  }

  @override
  Description describe(Description description) {
    return description.add('has $propertyName = $expectedValue');
  }

  @override
  Description describeMismatch(
    covariant Widget widget,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    final actualValue = matchState['actualValue'];
    return mismatchDescription
        .add('has $propertyName = $actualValue');
  }
}

/// Common test data generators
class MPTestDataGenerators {
  MPTestDataGenerators._();

  /// Generate test strings
  static List<String> testStrings({
    int minLength = 1,
    int maxLength = 100,
  }) {
    return [
      'Short',
      'A bit longer text for testing',
      'This is a much longer text string that should test the component\'s ability to handle various text lengths and potentially wrap or truncate content accordingly',
      '', // Empty string
      ' ', // Single space
      '🎉✨🚀', // Emoji only
      'Test\nwith\nnewlines', // Multiline
    ];
  }

  /// Generate test colors
  static List<Color> testColors() {
    return [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.black,
      Colors.white,
      Colors.transparent,
      const Color(0xFF6366F1), // Primary color
      const Color(0xFFF3F4F6), // Neutral light
      const Color(0xFF111827), // Neutral dark
    ];
  }

  /// Generate test durations
  static List<Duration> testDurations() {
    return [
      Duration.zero,
      const Duration(milliseconds: 100),
      const Duration(milliseconds: 200),
      const Duration(milliseconds: 300),
      const Duration(seconds: 1),
    ];
  }

  /// Generate test sizes
  static List<double> testSizes() {
    return [
      0.0,
      8.0,
      16.0,
      24.0,
      32.0,
      48.0,
      64.0,
    ];
  }

  /// Generate test border radius values
  static List<double> testBorderRadius() {
    return [
      0.0,
      4.0,
      8.0,
      12.0,
      16.0,
      20.0,
      24.0,
      32.0,
    ];
  }
}
