// Responsive system exports
export 'mp_responsive_breakpoints.dart';
export 'mp_responsive_padding.dart';
export 'mp_responsive_grid.dart';
export 'mp_orientation_aware.dart';
export 'mp_responsive_constraints.dart';
export 'mp_responsive_container.dart';

import 'package:flutter/material.dart';
import 'mp_responsive_breakpoints.dart';
import 'mp_responsive_padding.dart';
import 'package:micropack_ui_kit/src/core/performance/mp_performance_profiler.dart';

/// MPResponsive - Main responsive utilities class
///
/// Provides comprehensive responsive design utilities for all components
/// Combines breakpoint detection, padding, grids, and constraints
class MPResponsive {
  // ============ PERFORMANCE CACHE ============

  // Performance optimization: Cache device size calculations
  static final Map<String, MPDeviceSize> _deviceSizeCache = {};
  static final Map<String, bool> _orientationCache = {};
  static final Map<String, dynamic> _valueCache = {};

  // ============ DEVICE DETECTION ============

  /// Get current device size
  static MPDeviceSize getDeviceSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cacheKey = width.toString();

    // Check cache first
    if (_deviceSizeCache.containsKey(cacheKey)) {
      return _deviceSizeCache[cacheKey]!;
    }

    // Start performance profiling for device size calculation
    MPPerformanceProfiler.instance.startBuild('Responsive.getDeviceSize');

    final deviceSize = MPResponsiveBreakpoints.getDeviceSize(width);

    // Cache the result
    _deviceSizeCache[cacheKey] = deviceSize;

    // Limit cache size with LRU eviction
    if (_deviceSizeCache.length > 50) {
      final keysToRemove = _deviceSizeCache.keys.take(10).toList();
      for (final key in keysToRemove) {
        _deviceSizeCache.remove(key);
      }
    }

    // End performance profiling
    MPPerformanceProfiler.instance
        .endBuild('Responsive.getDeviceSize', metadata: {
      'screenWidth': width,
      'deviceSize': deviceSize.name,
      'cacheHit': false,
    });

    return deviceSize;
  }

  /// Check if current device is mobile
  static bool isMobile(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cacheKey = 'mobile_${width.toString()}';

    // Check cache first
    if (_orientationCache.containsKey(cacheKey)) {
      return _orientationCache[cacheKey]!;
    }

    final isMobile = MPResponsiveBreakpoints.isMobile(width);

    // Cache the result
    _orientationCache[cacheKey] = isMobile;

    // Limit cache size
    if (_orientationCache.length > 30) {
      _orientationCache.remove(_orientationCache.keys.first);
    }

    return isMobile;
  }

  /// Check if current device is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cacheKey = 'tablet_${width.toString()}';

    // Check cache first
    if (_orientationCache.containsKey(cacheKey)) {
      return _orientationCache[cacheKey]!;
    }

    final isTablet = MPResponsiveBreakpoints.isTablet(width);

    // Cache the result
    _orientationCache[cacheKey] = isTablet;

    // Limit cache size
    if (_orientationCache.length > 30) {
      _orientationCache.remove(_orientationCache.keys.first);
    }

    return isTablet;
  }

  /// Check if current device is desktop
  static bool isDesktop(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cacheKey = 'desktop_${width.toString()}';

    // Check cache first
    if (_orientationCache.containsKey(cacheKey)) {
      return _orientationCache[cacheKey]!;
    }

    final isDesktop = MPResponsiveBreakpoints.isDesktop(width);

    // Cache the result
    _orientationCache[cacheKey] = isDesktop;

    // Limit cache size
    if (_orientationCache.length > 30) {
      _orientationCache.remove(_orientationCache.keys.first);
    }

    return isDesktop;
  }

  /// Get current orientation
  static Orientation getOrientation(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final cacheKey =
        'orientation_${mediaQuery.size.width}_${mediaQuery.size.height}';

    // Check cache first
    if (_orientationCache.containsKey(cacheKey)) {
      return _orientationCache[cacheKey]!
          ? Orientation.portrait
          : Orientation.landscape;
    }

    final orientation = mediaQuery.orientation;
    final isPortrait = orientation == Orientation.portrait;

    // Cache the result
    _orientationCache[cacheKey] = isPortrait;

    // Limit cache size
    if (_orientationCache.length > 30) {
      _orientationCache.remove(_orientationCache.keys.first);
    }

    return orientation;
  }

  /// Check if current orientation is portrait
  static bool isPortrait(BuildContext context) {
    final isPortrait = getOrientation(context) == Orientation.portrait;
    return isPortrait;
  }

  /// Check if current orientation is landscape
  static bool isLandscape(BuildContext context) {
    final isLandscape = getOrientation(context) == Orientation.landscape;
    return isLandscape;
  }

  // ============ RESPONSIVE VALUES ============

  /// Get responsive value based on device size
  static T getValue<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
    T? smallMobile,
    T? largeMobile,
    T? smallTablet,
    T? largeTablet,
    T? smallDesktop,
    T? largeDesktop,
    T? ultraWide,
  }) {
    final deviceSize = getDeviceSize(context);
    final cacheKey =
        'value_${deviceSize.name}_${mobile.hashCode}_${tablet?.hashCode ?? 0}_${desktop?.hashCode ?? 0}';

    // Check cache first (only for simple types)
    if (T == double || T == int) {
      if (_valueCache.containsKey(cacheKey)) {
        return _valueCache[cacheKey] as T;
      }
    }

    T value;
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
        value = smallMobile ?? mobile;
        break;
      case MPDeviceSize.mobile:
        value = mobile;
        break;
      case MPDeviceSize.largeMobile:
        value = largeMobile ?? mobile;
        break;
      case MPDeviceSize.smallTablet:
        value = smallTablet ?? tablet ?? mobile;
        break;
      case MPDeviceSize.tablet:
        value = tablet ?? mobile;
        break;
      case MPDeviceSize.largeTablet:
        value = largeTablet ?? tablet ?? mobile;
        break;
      case MPDeviceSize.smallDesktop:
        value = smallDesktop ?? desktop ?? tablet ?? mobile;
        break;
      case MPDeviceSize.desktop:
        value = desktop ?? tablet ?? mobile;
        break;
      case MPDeviceSize.largeDesktop:
        value = largeDesktop ?? desktop ?? tablet ?? mobile;
        break;
      case MPDeviceSize.ultraWide:
        value = ultraWide ?? largeDesktop ?? desktop ?? tablet ?? mobile;
        break;
    }

    // Cache the result (only for simple types)
    if (T == double || T == int) {
      _valueCache[cacheKey] = value as dynamic;

      // Limit cache size
      if (_valueCache.length > 50) {
        _valueCache.remove(_valueCache.keys.first);
      }
    }

    return value;
  }

  /// Get responsive value based on orientation
  static T getValueByOrientation<T>({
    required BuildContext context,
    required T portrait,
    required T landscape,
  }) {
    return isPortrait(context) ? portrait : landscape;
  }

  /// Get responsive font size
  static double getFontSize({
    required BuildContext context,
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return getValue<double>(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get responsive spacing
  static double getSpacing({
    required BuildContext context,
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return getValue<double>(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get responsive border radius
  static double getBorderRadius({
    required BuildContext context,
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return getValue<double>(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  // ============ RESPONSIVE LAYOUTS ============

  /// Build responsive layout based on device size
  static Widget buildLayout({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
    Widget? smallMobile,
    Widget? largeMobile,
    Widget? smallTablet,
    Widget? largeTablet,
    Widget? smallDesktop,
    Widget? largeDesktop,
    Widget? ultraWide,
  }) {
    // Start performance profiling for layout building
    MPPerformanceProfiler.instance.startBuild('Responsive.buildLayout');

    final deviceSize = getDeviceSize(context);

    Widget selectedWidget;
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
        selectedWidget = smallMobile ?? mobile;
        break;
      case MPDeviceSize.mobile:
        selectedWidget = mobile;
        break;
      case MPDeviceSize.largeMobile:
        selectedWidget = largeMobile ?? mobile;
        break;
      case MPDeviceSize.smallTablet:
        selectedWidget = smallTablet ?? tablet ?? mobile;
        break;
      case MPDeviceSize.tablet:
        selectedWidget = tablet ?? mobile;
        break;
      case MPDeviceSize.largeTablet:
        selectedWidget = largeTablet ?? tablet ?? mobile;
        break;
      case MPDeviceSize.smallDesktop:
        selectedWidget = smallDesktop ?? desktop ?? tablet ?? mobile;
        break;
      case MPDeviceSize.desktop:
        selectedWidget = desktop ?? tablet ?? mobile;
        break;
      case MPDeviceSize.largeDesktop:
        selectedWidget = largeDesktop ?? desktop ?? tablet ?? mobile;
        break;
      case MPDeviceSize.ultraWide:
        selectedWidget =
            ultraWide ?? largeDesktop ?? desktop ?? tablet ?? mobile;
        break;
    }

    // End performance profiling
    MPPerformanceProfiler.instance
        .endBuild('Responsive.buildLayout', metadata: {
      'deviceSize': deviceSize.name,
      'widgetType': selectedWidget.runtimeType.toString(),
    });

    return selectedWidget;
  }

  /// Build orientation-aware layout
  static Widget buildOrientationLayout({
    required BuildContext context,
    required Widget portrait,
    required Widget landscape,
  }) {
    return isPortrait(context) ? portrait : landscape;
  }

  // ============ LAYOUT BUILDERS ============

  /// Builder for responsive layouts
  static Widget builder({
    required BuildContext context,
    required Widget Function(
      BuildContext context,
      MPDeviceSize deviceSize,
      BoxConstraints constraints,
    ) builder,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceSize = getDeviceSize(context);
        return builder(context, deviceSize, constraints);
      },
    );
  }

  /// Builder for orientation-aware layouts
  static Widget orientationBuilder({
    required BuildContext context,
    required Widget Function(
      BuildContext context,
      Orientation orientation,
      BoxConstraints constraints,
    ) builder,
  }) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return builder(context, orientation, constraints);
          },
        );
      },
    );
  }

  /// Combined responsive and orientation builder
  static Widget combinedBuilder({
    required BuildContext context,
    required Widget Function(
      BuildContext context,
      MPDeviceSize deviceSize,
      Orientation orientation,
      BoxConstraints constraints,
    ) builder,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceSize = getDeviceSize(context);
        final orientation = getOrientation(context);
        return builder(context, deviceSize, orientation, constraints);
      },
    );
  }

  // ============ MEDIA QUERY HELPERS ============

  /// Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get view insets
  static EdgeInsets getViewInsets(BuildContext context) {
    return MediaQuery.of(context).viewInsets;
  }

  /// Check if device has notch
  static bool hasNotch(BuildContext context) {
    return MediaQuery.of(context).padding.top > 24;
  }

  /// Get text scale factor
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor.clamp(0.8, 2.0);
  }

  /// Check if device has high contrast
  static bool isHighContrast(BuildContext context) {
    return MediaQuery.of(context).highContrast;
  }

  /// Check if reduced motion is enabled
  static bool isReducedMotion(BuildContext context) {
    return MediaQuery.of(context).accessibleNavigation ||
        MediaQuery.of(context).disableAnimations;
  }

  // ============ RESPONSIVE FORM FACTORS ============

  /// Get platform-specific form factor
  static String getFormFactor(BuildContext context) {
    final deviceSize = getDeviceSize(context);
    final orientation = getOrientation(context);

    if (deviceSize == MPDeviceSize.smallMobile ||
        deviceSize == MPDeviceSize.mobile ||
        deviceSize == MPDeviceSize.largeMobile) {
      return orientation == Orientation.portrait
          ? 'phone-portrait'
          : 'phone-landscape';
    } else if (deviceSize == MPDeviceSize.smallTablet ||
        deviceSize == MPDeviceSize.tablet ||
        deviceSize == MPDeviceSize.largeTablet) {
      return orientation == Orientation.portrait
          ? 'tablet-portrait'
          : 'tablet-landscape';
    } else {
      return 'desktop';
    }
  }

  /// Check if touch is available
  static bool hasTouch(BuildContext context) {
    return MediaQuery.of(context).navigationMode ==
            NavigationMode.traditional ||
        MediaQuery.of(context).devicePixelRatio > 1.0;
  }

  /// Check if mouse is available
  static bool hasMouse(BuildContext context) {
    return MediaQuery.of(context).navigationMode ==
            NavigationMode.traditional ||
        MediaQuery.of(context).devicePixelRatio <= 1.0;
  }

  /// Clear all caches with performance tracking
  static void clearCaches() {
    MPPerformanceProfiler.instance.startBuild('Responsive.clearCaches');

    final deviceSizeCacheSize = _deviceSizeCache.length;
    final orientationCacheSize = _orientationCache.length;
    final valueCacheSize = _valueCache.length;

    _deviceSizeCache.clear();
    _orientationCache.clear();
    _valueCache.clear();

    MPPerformanceProfiler.instance
        .endBuild('Responsive.clearCaches', metadata: {
      'deviceSizeCacheSize': deviceSizeCacheSize,
      'orientationCacheSize': orientationCacheSize,
      'valueCacheSize': valueCacheSize,
    });
  }

  /// Get cache statistics with performance metrics
  static Map<String, dynamic> getCacheStats() {
    return {
      'deviceSizeCacheSize': _deviceSizeCache.length,
      'orientationCacheSize': _orientationCache.length,
      'valueCacheSize': _valueCache.length,
      'performanceMetrics': {
        'averageDeviceSizeTime': _getAverageDeviceSizeTime(),
        'averageValueTime': _getAverageValueTime(),
        'cacheHitRatio': _getCacheHitRatio(),
      },
    };
  }

  /// Get average device size calculation time
  static double _getAverageDeviceSizeTime() {
    final metrics = MPPerformanceProfiler.instance
        .getAllMetrics()
        .entries
        .where((entry) => entry.key == 'Responsive.getDeviceSize')
        .map((entry) => entry.value.buildTime)
        .toList();

    if (metrics.isEmpty) return 0.0;

    final total = metrics.reduce((a, b) => a + b);
    return total / metrics.length;
  }

  /// Get average value calculation time
  static double _getAverageValueTime() {
    final metrics = MPPerformanceProfiler.instance
        .getAllMetrics()
        .entries
        .where((entry) => entry.key == 'Responsive.getValue')
        .map((entry) => entry.value.buildTime)
        .toList();

    if (metrics.isEmpty) return 0.0;

    final total = metrics.reduce((a, b) => a + b);
    return total / metrics.length;
  }

  /// Get cache hit ratio
  static double _getCacheHitRatio() {
    final allMetrics = MPPerformanceProfiler.instance
        .getAllMetrics()
        .entries
        .where((entry) => entry.key.startsWith('Responsive.'))
        .toList();

    if (allMetrics.isEmpty) return 0.0;

    final totalCalls = allMetrics.length;
    final cacheHits = allMetrics
        .where((entry) => entry.value.metadata['cacheHit'] == true)
        .length;

    return totalCalls > 0 ? (cacheHits / totalCalls) * 100 : 0.0;
  }

  /// Initialize performance monitoring for responsive calculations
  static void initializePerformanceMonitoring() {
    MPPerformanceProfiler.instance
        .startMonitoring(interval: Duration(seconds: 10));
  }
}
