import 'package:flutter/material.dart';

/// Device size categories for responsive behavior
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

/// MPResponsiveBreakpoints - Unified breakpoint system for responsive design
///
/// Provides consistent breakpoint definitions across all components
/// Based on modern device sizes and responsive design principles
class MPResponsiveBreakpoints {
  // ============ CORE BREAKPOINTS ============
  
  /// Mobile breakpoint (default)
  /// Devices: 0px to 599px
  /// Examples: iPhone SE, iPhone 12, Samsung Galaxy S series
  static const double mobile = 600;
  
  /// Tablet breakpoint
  /// Devices: 600px to 1023px
  /// Examples: iPad, iPad Mini, Android tablets
  static const double tablet = 1024;
  
  /// Desktop breakpoint
  /// Devices: 1024px and above
  /// Examples: Desktop monitors, large tablets in landscape
  static const double desktop = 1024;
  
  // ============ EXTENDED BREAKPOINTS ============
  
  /// Small mobile breakpoint
  /// Devices: 0px to 359px
  /// Examples: iPhone SE, very small phones
  static const double smallMobile = 360;
  
  /// Large mobile breakpoint
  /// Devices: 360px to 599px
  /// Examples: Most modern smartphones
  static const double largeMobile = 600;
  
  /// Small tablet breakpoint
  /// Devices: 600px to 767px
  /// Examples: iPad Mini, small tablets
  static const double smallTablet = 768;
  
  /// Large tablet breakpoint
  /// Devices: 768px to 1023px
  /// Examples: iPad, standard tablets
  static const double largeTablet = 1024;
  
  /// Small desktop breakpoint
  /// Devices: 1024px to 1439px
  /// Examples: Small desktop monitors
  static const double smallDesktop = 1440;
  
  /// Large desktop breakpoint
  /// Devices: 1440px and above
  /// Examples: Large desktop monitors, 4K displays
  static const double largeDesktop = 1440;
  
  /// Ultra-wide breakpoint for very large displays
  /// Devices: 1920px and above
  /// Examples: Ultra-wide monitors, 4K displays
  static const double ultraWide = 1920;
  
  // ============ BREAKPOINT CATEGORIES ============
  
  // ============ BREAKPOINT DETECTION METHODS ============
  
  /// Determine device size category based on width
  static MPDeviceSize getDeviceSize(double width) {
    if (width < smallMobile) return MPDeviceSize.smallMobile;
    if (width < largeMobile) return MPDeviceSize.mobile;
    if (width < smallTablet) return MPDeviceSize.largeMobile;
    if (width < tablet) return MPDeviceSize.smallTablet;
    if (width < largeTablet) return MPDeviceSize.tablet;
    if (width < smallDesktop) return MPDeviceSize.largeTablet;
    if (width < largeDesktop) return MPDeviceSize.smallDesktop;
    if (width < ultraWide) return MPDeviceSize.desktop;
    return MPDeviceSize.largeDesktop;
  }
  
  /// Check if width is in mobile range
  static bool isMobile(double width) => width < mobile;
  
  /// Check if width is in tablet range
  static bool isTablet(double width) => width >= mobile && width < desktop;
  
  /// Check if width is in desktop range
  static bool isDesktop(double width) => width >= desktop;
  
  /// Check if width is small mobile
  static bool isSmallMobile(double width) => width < smallMobile;
  
  /// Check if width is large mobile
  static bool isLargeMobile(double width) => width >= smallMobile && width < mobile;
  
  /// Check if width is small tablet
  static bool isSmallTablet(double width) => width >= mobile && width < smallTablet;
  
  /// Check if width is large tablet
  static bool isLargeTablet(double width) => width >= smallTablet && width < desktop;
  
  /// Check if width is small desktop
  static bool isSmallDesktop(double width) => width >= desktop && width < largeDesktop;
  
  /// Check if width is large desktop
  static bool isLargeDesktop(double width) => width >= largeDesktop && width < ultraWide;
  
  /// Check if width is ultra-wide
  static bool isUltraWide(double width) => width >= ultraWide;
  
  // ============ BREAKPOINT RANGES ============
  
  /// Get mobile range
  static RangeValues getMobileRange() => const RangeValues(0, mobile);
  
  /// Get tablet range
  static RangeValues getTabletRange() => const RangeValues(mobile, desktop);
  
  /// Get desktop range
  static RangeValues getDesktopRange() => const RangeValues(desktop, double.infinity);
  
  // ============ LAYOUT HELPERS ============
  
  /// Get appropriate column count for grid based on width
  static int getGridColumnCount(double width, {int maxColumns = 4}) {
    if (width < smallMobile) return 1;
    if (width < mobile) return 2;
    if (width < tablet) return 2;
    if (width < desktop) return 3;
    return maxColumns;
  }
  
  /// Get appropriate spacing based on screen size
  static double getSpacing(double width) {
    if (width < smallMobile) return 8.0;
    if (width < mobile) return 12.0;
    if (width < tablet) return 16.0;
    if (width < desktop) return 20.0;
    return 24.0;
  }
  
  /// Get appropriate padding based on screen size
  static double getPadding(double width) {
    if (width < smallMobile) return 12.0;
    if (width < mobile) return 16.0;
    if (width < tablet) return 20.0;
    if (width < desktop) return 24.0;
    return 32.0;
  }
  
  /// Get appropriate border radius based on screen size
  static double getBorderRadius(double width) {
    if (width < smallMobile) return 4.0;
    if (width < mobile) return 6.0;
    if (width < tablet) return 8.0;
    if (width < desktop) return 10.0;
    return 12.0;
  }
}

/// Range values helper for breakpoint ranges
class RangeValues {
  final double start;
  final double end;
  
  const RangeValues(this.start, this.end);
  
  bool contains(double value) => value >= start && value < end;
  
  @override
  String toString() => 'Range($start, $end)';
}
