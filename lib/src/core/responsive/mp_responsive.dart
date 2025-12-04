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

/// MPResponsive - Main responsive utilities class
///
/// Provides comprehensive responsive design utilities for all components
/// Combines breakpoint detection, padding, grids, and constraints
class MPResponsive {
  // ============ DEVICE DETECTION ============
  
  /// Get current device size
  static MPDeviceSize getDeviceSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MPResponsiveBreakpoints.getDeviceSize(width);
  }
  
  /// Check if current device is mobile
  static bool isMobile(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MPResponsiveBreakpoints.isMobile(width);
  }
  
  /// Check if current device is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MPResponsiveBreakpoints.isTablet(width);
  }
  
  /// Check if current device is desktop
  static bool isDesktop(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MPResponsiveBreakpoints.isDesktop(width);
  }
  
  /// Get current orientation
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }
  
  /// Check if current orientation is portrait
  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }
  
  /// Check if current orientation is landscape
  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
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
    
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
        return smallMobile ?? mobile;
      case MPDeviceSize.mobile:
        return mobile;
      case MPDeviceSize.largeMobile:
        return largeMobile ?? mobile;
      case MPDeviceSize.smallTablet:
        return smallTablet ?? tablet ?? mobile;
      case MPDeviceSize.tablet:
        return tablet ?? mobile;
      case MPDeviceSize.largeTablet:
        return largeTablet ?? tablet ?? mobile;
      case MPDeviceSize.smallDesktop:
        return smallDesktop ?? desktop ?? tablet ?? mobile;
      case MPDeviceSize.desktop:
        return desktop ?? tablet ?? mobile;
      case MPDeviceSize.largeDesktop:
        return largeDesktop ?? desktop ?? tablet ?? mobile;
      case MPDeviceSize.ultraWide:
        return ultraWide ?? largeDesktop ?? desktop ?? tablet ?? mobile;
    }
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
    final deviceSize = getDeviceSize(context);
    
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
        return smallMobile ?? mobile;
      case MPDeviceSize.mobile:
        return mobile;
      case MPDeviceSize.largeMobile:
        return largeMobile ?? mobile;
      case MPDeviceSize.smallTablet:
        return smallTablet ?? tablet ?? mobile;
      case MPDeviceSize.tablet:
        return tablet ?? mobile;
      case MPDeviceSize.largeTablet:
        return largeTablet ?? tablet ?? mobile;
      case MPDeviceSize.smallDesktop:
        return smallDesktop ?? desktop ?? tablet ?? mobile;
      case MPDeviceSize.desktop:
        return desktop ?? tablet ?? mobile;
      case MPDeviceSize.largeDesktop:
        return largeDesktop ?? desktop ?? tablet ?? mobile;
      case MPDeviceSize.ultraWide:
        return ultraWide ?? largeDesktop ?? desktop ?? tablet ?? mobile;
    }
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
      return orientation == Orientation.portrait ? 'phone-portrait' : 'phone-landscape';
    } else if (deviceSize == MPDeviceSize.smallTablet ||
               deviceSize == MPDeviceSize.tablet ||
               deviceSize == MPDeviceSize.largeTablet) {
      return orientation == Orientation.portrait ? 'tablet-portrait' : 'tablet-landscape';
    } else {
      return 'desktop';
    }
  }
  
  /// Check if touch is available
  static bool hasTouch(BuildContext context) {
    return MediaQuery.of(context).navigationMode == NavigationMode.traditional ||
           MediaQuery.of(context).devicePixelRatio > 1.0;
  }
  
  /// Check if mouse is available
  static bool hasMouse(BuildContext context) {
    return MediaQuery.of(context).navigationMode == NavigationMode.traditional ||
           MediaQuery.of(context).devicePixelRatio <= 1.0;
  }
}
