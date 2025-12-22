import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

/// Mock factories for Micropack UI Kit testing
///
/// Provides mock objects for theme manager, responsive system,
/// and other core services used in component testing
class MPMocks {
  MPMocks._();

  /// Get mock utilities
  static const _mockUtils = _MockUtils();

  /// Convenience accessor
  static _MockUtils get utils => _mockUtils;
}

/// Mock utility methods
class _MockUtils {
  const _MockUtils();

  /// Create mock theme data
  static ThemeData createMockTheme({
    Brightness brightness = Brightness.light,
    Color? primaryColor,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor ?? const Color(0xFF6366F1),
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor ?? const Color(0xFF6366F1),
        brightness: brightness,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: textColor),
      ),
    );
  }

  /// Create mock MediaQueryData
  static MediaQueryData createMockMediaQuery({
    Size? size,
    Brightness? brightness,
    double? textScaleFactor,
    bool? highContrast,
    bool? disableAnimations,
    bool? accessibleNavigation,
    EdgeInsets? padding,
  }) {
    return MediaQueryData(
      size: size ?? const Size(375, 667),
      platform: TargetPlatform.android,
      brightness: brightness ?? Brightness.light,
      textScaleFactor: textScaleFactor ?? 1.0,
      highContrast: highContrast ?? false,
      disableAnimations: disableAnimations ?? false,
      accessibleNavigation: accessibleNavigation ?? false,
      padding: padding ?? EdgeInsets.zero,
      viewInsets: EdgeInsets.zero,
      systemGestureInsets: EdgeInsets.zero,
    );
  }

  /// Create mock box constraints
  static BoxConstraints createMockConstraints({
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) {
    return BoxConstraints(
      minWidth: minWidth ?? 0,
      maxWidth: maxWidth ?? double.infinity,
      minHeight: minHeight ?? 0,
      maxHeight: maxHeight ?? double.infinity,
    );
  }

  /// Create mock size for responsive testing
  static Size createMockSize({
    double? width,
    double? height,
    MPDeviceSize? deviceSize,
  }) {
    if (deviceSize != null) {
      return _getSizeForDevice(deviceSize);
    }
    return Size(width ?? 375, height ?? 667);
  }

  /// Get size for device type
  static Size _getSizeForDevice(MPDeviceSize deviceSize) {
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
        return const Size(320, 568);
      case MPDeviceSize.mobile:
        return const Size(375, 667);
      case MPDeviceSize.largeMobile:
        return const Size(414, 896);
      case MPDeviceSize.smallTablet:
        return const Size(600, 800);
      case MPDeviceSize.tablet:
        return const Size(768, 1024);
      case MPDeviceSize.largeTablet:
        return const Size(1024, 1366);
      case MPDeviceSize.smallDesktop:
        return const Size(1280, 720);
      case MPDeviceSize.desktop:
        return const Size(1920, 1080);
      case MPDeviceSize.largeDesktop:
        return const Size(2560, 1440);
      case MPDeviceSize.ultraWide:
        return const Size(3440, 1440);
    }
  }
}

/// Device size enum for responsive testing
enum MPDeviceSize {
  smallMobile,
  mobile,
  largeMobile,
  smallTablet,
  tablet,
  largeTablet,
  smallDesktop,
  desktop,
  largeDesktop,
  ultraWide,
}

/// Mock NavigatorObserver for testing navigation
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

/// Mock Route for testing navigation
class MockRoute extends Mock implements Route {}

/// Mock AnimationController for testing animations
class MockAnimationController extends Mock
    implements AnimationController {
  @override
  Duration get duration => const Duration(milliseconds: 300);

  @override
  double get value => 0.5;
}

/// Mock Animation for testing animations
class MockAnimation extends Mock implements Animation<double> {
  @override
  double get value => 0.5;

  @override
  AnimationStatus get status => AnimationStatus.forward;
}

/// Mock VoidCallback for testing callbacks
class MockVoidCallback extends Mock {
  void call() => super.call();
}

/// Mock ValueChanged for testing value changes
class MockValueChanged<T> extends Mock {
  void call(T value) => super.call(value);
}

/// Mock GestureRecognizer for testing gestures
class MockGestureRecognizer extends Mock
    implements GestureRecognizer {
  @override
  void addPointer(PointerDownEvent event) {}

  @override
  void dispose() {}
}

/// Mock WidgetTester extensions
extension MPMockWidgetTesterExtensions on WidgetTester {
  /// Pump widget with mock theme
  Future<void> pumpWidgetWithMockTheme({
    required Widget child,
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode? themeMode,
  }) async {
    await pumpWidget(
      MaterialApp(
        title: 'Mock Test',
        theme: theme ?? MPMocks.utils.createMockTheme(),
        darkTheme: darkTheme ?? MPMocks.utils.createMockTheme(brightness: Brightness.dark),
        themeMode: themeMode ?? ThemeMode.light,
        home: Scaffold(body: child),
      ),
    );
    await pumpAndSettle();
  }

  /// Pump widget with mock MediaQuery
  Future<void> pumpWidgetWithMockMediaQuery({
    required Widget child,
    MediaQueryData? mediaQueryData,
    ThemeData? theme,
  }) async {
    await pumpWidget(
      MediaQuery(
        data: mediaQueryData ?? MPMocks.utils.createMockMediaQuery(),
        child: MaterialApp(
          theme: theme ?? MPMocks.utils.createMockTheme(),
          home: Scaffold(body: child),
        ),
      ),
    );
    await pumpAndSettle();
  }

  /// Pump widget with specific device size
  Future<void> pumpWidgetWithDeviceSize({
    required Widget child,
    required MPDeviceSize deviceSize,
    ThemeData? theme,
  }) async {
    final size = MPMocks.utils.createMockSize(deviceSize: deviceSize);
    await pumpWidget(
      MediaQuery(
        data: MediaQueryData(size: size),
        child: MaterialApp(
          theme: theme ?? MPMocks.utils.createMockTheme(),
          home: Scaffold(body: child),
        ),
      ),
    );
    await pumpAndSettle();
  }

  /// Pump responsive widget with multiple breakpoints
  Future<void> pumpResponsiveWidget({
    required Widget child,
    required Map<MPDeviceSize, void Function()> assertions,
    ThemeData? theme,
  }) async {
    for (final entry in assertions.entries) {
      final deviceSize = entry.key;
      final assertion = entry.value;

      await pumpWidgetWithDeviceSize(
        child: child,
        deviceSize: deviceSize,
        theme: theme,
      );

      assertion();
    }
  }
}

/// Mock ThemeManager for testing theme behavior
class MockThemeManager {
  MockThemeManager({
    Brightness brightness = Brightness.light,
    Color? primaryColor,
  }) : _brightness = brightness,
       _primaryColor = primaryColor ?? const Color(0xFF6366F1);

  final Brightness _brightness;
  final Color _primaryColor;

  Brightness get brightness => _brightness;
  Color get primaryColor => _primaryColor;

  bool get isDarkMode => _brightness == Brightness.dark;

  MockThemeManager copyWith({
    Brightness? brightness,
    Color? primaryColor,
  }) {
    return MockThemeManager(
      brightness: brightness ?? _brightness,
      primaryColor: primaryColor ?? _primaryColor,
    );
  }
}

/// Mock ResponsiveSystem for testing responsive behavior
class MockResponsiveSystem {
  MockResponsiveSystem({
    required Size size,
  }) : _size = size;

  final Size _size;

  Size get size => _size;
  double get width => _size.width;
  double get height => _size.height;

  MPDeviceSize get deviceSize {
    return _getDeviceSize(width);
  }

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;

  bool get isPortrait => _size.height > _size.width;
  bool get isLandscape => _size.width > _size.height;

  MPDeviceSize _getDeviceSize(double width) {
    if (width < 320) return MPDeviceSize.smallMobile;
    if (width < 375) return MPDeviceSize.mobile;
    if (width < 414) return MPDeviceSize.largeMobile;
    if (width < 600) return MPDeviceSize.smallTablet;
    if (width < 768) return MPDeviceSize.tablet;
    if (width < 1024) return MPDeviceSize.largeTablet;
    if (width < 1280) return MPDeviceSize.smallDesktop;
    if (width < 1920) return MPDeviceSize.desktop;
    if (width < 2560) return MPDeviceSize.largeDesktop;
    return MPDeviceSize.ultraWide;
  }

  T getValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop) return desktop ?? tablet ?? mobile;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }
}

/// Common mock test scenarios
class MPMockTestScenarios {
  MPMockTestScenarios._();

  /// Create test scenarios for all device sizes
  static Map<MPDeviceSize, String> getDeviceSizeLabels() {
    return {
      MPDeviceSize.smallMobile: 'Small Mobile (< 320px)',
      MPDeviceSize.mobile: 'Mobile (320-375px)',
      MPDeviceSize.largeMobile: 'Large Mobile (375-414px)',
      MPDeviceSize.smallTablet: 'Small Tablet (414-600px)',
      MPDeviceSize.tablet: 'Tablet (600-768px)',
      MPDeviceSize.largeTablet: 'Large Tablet (768-1024px)',
      MPDeviceSize.smallDesktop: 'Small Desktop (1024-1280px)',
      MPDeviceSize.desktop: 'Desktop (1280-1920px)',
      MPDeviceSize.largeDesktop: 'Large Desktop (1920-2560px)',
      MPDeviceSize.ultraWide: 'Ultra Wide (> 2560px)',
    };
  }

  /// Create test scenarios for all orientations
  static Map<Orientation, String> getOrientationLabels() {
    return {
      Orientation.portrait: 'Portrait (height > width)',
      Orientation.landscape: 'Landscape (width > height)',
    };
  }

  /// Create test scenarios for all theme modes
  static Map<ThemeMode, String> getThemeModeLabels() {
    return {
      ThemeMode.light: 'Light Mode',
      ThemeMode.dark: 'Dark Mode',
      ThemeMode.system: 'System Mode',
    };
  }

  /// Get all mock device sizes
  static List<MPDeviceSize> getAllDeviceSizes() {
    return MPDeviceSize.values;
  }

  /// Get all mock orientations
  static List<Orientation> getAllOrientations() {
    return Orientation.values;
  }

  /// Get all mock theme modes
  static List<ThemeMode> getAllThemeModes() {
    return ThemeMode.values;
  }
}

/// Matcher for comparing widget properties
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

/// Custom matchers for widget testing
class MPMockMatchers {
  MPMockMatchers._();

  /// Matcher for widget with specific key
  static Matcher hasKey(Key key) {
    return WidgetPropertyMatcher(
      propertyName: 'key',
      expectedValue: key,
      getProperty: (widget) => widget.key,
    );
  }

  /// Matcher for enabled widget
  static Matcher isEnabled() {
    return const _IsEnabledMatcher();
  }

  /// Matcher for disabled widget
  static Matcher isDisabled() {
    return const _IsDisabledMatcher();
  }
}

/// Matcher for enabled widgets
class _IsEnabledMatcher extends Matcher {
  const _IsEnabledMatcher();

  @override
  bool matches(covariant Object? obj, Map matchState) {
    if (obj is! Widget) return false;
    // Widget is enabled by default unless it's IgnorePointer with ignoring=true
    if (obj is IgnorePointer) {
      return !obj.ignoring;
    }
    return true;
  }

  @override
  Description describe(Description description) {
    return description.add('is enabled');
  }

  @override
  Description describeMismatch(
    covariant Object? obj,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    return mismatchDescription.add('is disabled');
  }
}

/// Matcher for disabled widgets
class _IsDisabledMatcher extends Matcher {
  const _IsDisabledMatcher();

  @override
  bool matches(covariant Object? obj, Map matchState) {
    if (obj is! Widget) return false;
    // Widget is disabled if it's IgnorePointer with ignoring=true
    if (obj is IgnorePointer) {
      return obj.ignoring;
    }
    return false;
  }

  @override
  Description describe(Description description) {
    return description.add('is disabled');
  }

  @override
  Description describeMismatch(
    covariant Object? obj,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    return mismatchDescription.add('is enabled');
  }
}

/// Extensions for MPDeviceSize
extension MPDeviceSizeExtension on MPDeviceSize {
  String get label => MPMockTestScenarios.getDeviceSizeLabels()[this] ?? 'Unknown';
  Size get size => MPMocks.utils.createMockSize(deviceSize: this);
  bool get isMobile => this == MPDeviceSize.smallMobile ||
      this == MPDeviceSize.mobile ||
      this == MPDeviceSize.largeMobile;
  bool get isTablet => this == MPDeviceSize.smallTablet ||
      this == MPDeviceSize.tablet ||
      this == MPDeviceSize.largeTablet;
  bool get isDesktop => this == MPDeviceSize.smallDesktop ||
      this == MPDeviceSize.desktop ||
      this == MPDeviceSize.largeDesktop ||
      this == MPDeviceSize.ultraWide;
}
