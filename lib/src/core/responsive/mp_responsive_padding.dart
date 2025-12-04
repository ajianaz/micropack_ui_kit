import 'package:flutter/material.dart';
import 'mp_responsive_breakpoints.dart';

/// MPResponsivePadding - Responsive padding system based on screen size
///
/// Provides consistent padding values that scale appropriately
/// across different device sizes following mobile-first principles
class MPResponsivePadding {
  // ============ BASE PADDING VALUES ============
  
  /// Extra small padding (4px base)
  /// Usage: Tight spacing between elements
  static const double xs = 4.0;
  
  /// Small padding (8px base)
  /// Usage: Minimal spacing for dense layouts
  static const double sm = 8.0;
  
  /// Medium padding (16px base)
  /// Usage: Standard spacing between sections
  static const double md = 16.0;
  
  /// Large padding (24px base)
  /// Usage: Spacious spacing for desktop layouts
  static const double lg = 24.0;
  
  /// Extra large padding (32px base)
  /// Usage: Maximum spacing for emphasis
  static const double xl = 32.0;
  
  /// Ultra large padding (48px base)
  /// Usage: Hero sections and major spacing
  static const double xxl = 48.0;
  
  // ============ RESPONSIVE SCALING FACTORS ============
  
  /// Scaling factors for different device sizes
  static const Map<MPDeviceSize, double> _scaleFactors = {
    MPDeviceSize.smallMobile: 0.75,
    MPDeviceSize.mobile: 0.875,
    MPDeviceSize.largeMobile: 1.0,
    MPDeviceSize.smallTablet: 1.125,
    MPDeviceSize.tablet: 1.25,
    MPDeviceSize.largeTablet: 1.375,
    MPDeviceSize.smallDesktop: 1.5,
    MPDeviceSize.desktop: 1.75,
    MPDeviceSize.largeDesktop: 2.0,
    MPDeviceSize.ultraWide: 2.25,
  };
  
  // ============ RESPONSIVE PADDING METHODS ============
  
  /// Get responsive padding based on screen width
  static double getPadding(double baseValue, double screenWidth) {
    final deviceSize = MPResponsiveBreakpoints.getDeviceSize(screenWidth);
    final scaleFactor = _scaleFactors[deviceSize] ?? 1.0;
    return baseValue * scaleFactor;
  }
  
  /// Get extra small responsive padding
  static double getXs(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return getPadding(xs, width);
  }
  
  /// Get small responsive padding
  static double getSm(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return getPadding(sm, width);
  }
  
  /// Get medium responsive padding
  static double getMd(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return getPadding(md, width);
  }
  
  /// Get large responsive padding
  static double getLg(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return getPadding(lg, width);
  }
  
  /// Get extra large responsive padding
  static double getXl(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return getPadding(xl, width);
  }
  
  /// Get ultra large responsive padding
  static double getXxl(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return getPadding(xxl, width);
  }
  
  // ============ EDGE INSET HELPERS ============
  
  /// Get all-around responsive padding
  static EdgeInsets all(double baseValue, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final responsiveValue = getPadding(baseValue, width);
    return EdgeInsets.all(responsiveValue);
  }
  
  /// Get horizontal responsive padding
  static EdgeInsets horizontal(double baseValue, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final responsiveValue = getPadding(baseValue, width);
    return EdgeInsets.symmetric(horizontal: responsiveValue);
  }
  
  /// Get vertical responsive padding
  static EdgeInsets vertical(double baseValue, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final responsiveValue = getPadding(baseValue, width);
    return EdgeInsets.symmetric(vertical: responsiveValue);
  }
  
  /// Get responsive padding with different horizontal and vertical values
  static EdgeInsets symmetric({
    required double horizontal,
    required double vertical,
    required BuildContext context,
  }) {
    final width = MediaQuery.of(context).size.width;
    final responsiveHorizontal = getPadding(horizontal, width);
    final responsiveVertical = getPadding(vertical, width);
    return EdgeInsets.symmetric(
      horizontal: responsiveHorizontal,
      vertical: responsiveVertical,
    );
  }
  
  /// Get responsive padding with individual values
  static EdgeInsets only({
    double? left,
    double? top,
    double? right,
    double? bottom,
    required BuildContext context,
  }) {
    final width = MediaQuery.of(context).size.width;
    return EdgeInsets.only(
      left: left != null ? getPadding(left, width) : 0,
      top: top != null ? getPadding(top, width) : 0,
      right: right != null ? getPadding(right, width) : 0,
      bottom: bottom != null ? getPadding(bottom, width) : 0,
    );
  }
  
  // ============ PREDEFINED PADDING SETS ============
  
  /// Compact padding set for dense layouts
  static EdgeInsets compact(BuildContext context) => all(sm, context);
  
  /// Standard padding set for normal layouts
  static EdgeInsets standard(BuildContext context) => all(md, context);
  
  /// Spacious padding set for desktop layouts
  static EdgeInsets spacious(BuildContext context) => all(lg, context);
  
  /// Minimal padding set for very tight layouts
  static EdgeInsets minimal(BuildContext context) => all(xs, context);
  
  /// Extra padding set for hero sections
  static EdgeInsets extra(BuildContext context) => all(xl, context);
  
  /// Card padding set (horizontal medium, vertical small)
  static EdgeInsets card(BuildContext context) => symmetric(
    horizontal: md,
    vertical: sm,
    context: context,
  );
  
  /// Section padding set (horizontal medium, vertical large)
  static EdgeInsets section(BuildContext context) => symmetric(
    horizontal: md,
    vertical: lg,
    context: context,
  );
  
  /// Page padding set (horizontal large, vertical medium)
  static EdgeInsets page(BuildContext context) => symmetric(
    horizontal: lg,
    vertical: md,
    context: context,
  );
  
  /// Container padding set (all medium)
  static EdgeInsets container(BuildContext context) => all(md, context);
  
  /// List item padding set (horizontal medium, vertical small)
  static EdgeInsets listItem(BuildContext context) => symmetric(
    horizontal: md,
    vertical: sm,
    context: context,
  );
}

/// MPResponsiveEdgeInsets - Extension for EdgeInsets to support responsive values
extension MPResponsiveEdgeInsets on EdgeInsets {
  /// Scale the current EdgeInsets based on screen size
  EdgeInsets scale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scaleFactor = MPResponsivePadding._scaleFactors[
      MPResponsiveBreakpoints.getDeviceSize(width)
    ] ?? 1.0;
    
    return EdgeInsets.only(
      left: left * scaleFactor,
      top: top * scaleFactor,
      right: right * scaleFactor,
      bottom: bottom * scaleFactor,
    );
  }
}
