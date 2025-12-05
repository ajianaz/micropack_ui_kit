import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropack_ui_kit/mp_ui_kit_settings.dart';

/// Responsive font helper utility
///
/// Provides enhanced breakpoint-based font scaling with improved responsiveness
/// and better typography scaling across all screen sizes.
///
/// Enhanced Breakpoints:
/// - Small Mobile (< 360px): Scale factor 0.9
/// - Mobile (360-600px): Scale factor 1.0 (full ScreenUtil scaling)
/// - Large Mobile/Small Tablet (600-768px): Scale factor 0.95
/// - Tablet (768-1024px): Scale factor 0.85
/// - Large Tablet/Small Desktop (1024-1440px): Scale factor 0.75
/// - Desktop (> 1440px): Scale factor 0.65
class ResponsiveFontHelper {
  /// Get appropriate scale factor based on screen width
  ///
  /// Uses enhanced breakpoints for better typography scaling:
  /// - limitSmallMediumScreen: 600px (mobile/tablet boundary)
  /// - limitMediumLargeScreen: 1024px (tablet/desktop boundary)
  /// - Additional breakpoints for finer control
  static double getScaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 360) {
      // Small Mobile: slight reduction to prevent overflow
      return 0.9;
    } else if (width < MpUiKit.limitSmallMediumScreen) {
      // Mobile: full scaling
      return 1.0;
    } else if (width < 768) {
      // Large Mobile/Small Tablet: slight reduction
      return 0.95;
    } else if (width < MpUiKit.limitMediumLargeScreen) {
      // Tablet: moderate reduction
      return 0.85;
    } else if (width < 1440) {
      // Large Tablet/Small Desktop: more reduction
      return 0.75;
    } else {
      // Desktop: significant reduction to prevent huge fonts
      return 0.65;
    }
  }

  /// Get responsive font size based on base size and current screen width
  ///
  /// [baseFontSize] The design font size (in logical pixels)
  /// [context] BuildContext for accessing screen dimensions
  ///
  /// Returns scaled font size appropriate for current screen size
  static double getResponsiveFontSize(
    double baseFontSize,
    BuildContext context,
  ) {
    if (!MpUiKit.useScreenUtil) {
      // If ScreenUtil is disabled, return base size
      return baseFontSize;
    }

    // Get scale factor for current screen size
    final scaleFactor = getScaleFactor(context);

    // Apply ScreenUtil scaling with breakpoint-based reduction
    return (baseFontSize.sp * scaleFactor);
  }

  /// Get responsive font size with explicit scale factor override
  ///
  /// [baseFontSize] The design font size (in logical pixels)
  /// [scaleFactor] Custom scale factor (0.0 to 1.0)
  ///
  /// Returns scaled font size with custom factor
  static double getResponsiveFontSizeWithFactor(
    double baseFontSize,
    double scaleFactor,
  ) {
    if (!MpUiKit.useScreenUtil) {
      return baseFontSize;
    }

    return (baseFontSize.sp * scaleFactor);
  }

  /// Check if current screen is mobile size
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < MpUiKit.limitSmallMediumScreen;
  }

  /// Check if current screen is tablet size
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= MpUiKit.limitSmallMediumScreen &&
        width < MpUiKit.limitMediumLargeScreen;
  }

  /// Check if current screen is desktop size
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= MpUiKit.limitMediumLargeScreen;
  }

  /// Get screen size category as string (useful for debugging)
  static String getScreenCategory(BuildContext context) {
    if (isMobile(context)) return 'Mobile';
    if (isTablet(context)) return 'Tablet';
    return 'Desktop';
  }

  /// Get responsive line height based on font size and screen size
  ///
  /// [fontSize] The font size (in logical pixels)
  /// [context] BuildContext for accessing screen dimensions
  ///
  /// Returns appropriate line height for better readability
  static double getResponsiveLineHeight(
    double fontSize,
    BuildContext context,
  ) {
    // Adjust line height based on screen size for better readability
    if (isMobile(context)) {
      // Mobile: Slightly tighter spacing for smaller screens
      return 1.2;
    } else if (isTablet(context)) {
      // Tablet: Standard line height
      return 1.3;
    } else {
      // Desktop: More generous spacing for larger screens
      return 1.4;
    }
  }

  /// Get responsive letter spacing based on font size and screen size
  ///
  /// [fontSize] The font size (in logical pixels)
  /// [context] BuildContext for accessing screen dimensions
  ///
  /// Returns appropriate letter spacing for better readability
  static double getResponsiveLetterSpacing(
    double fontSize,
    BuildContext context,
  ) {
    // Adjust letter spacing based on screen size for better readability
    if (isMobile(context)) {
      // Mobile: Slightly tighter spacing for smaller screens
      return 0.0;
    } else if (isTablet(context)) {
      // Tablet: Standard letter spacing
      return 0.2;
    } else {
      // Desktop: More generous spacing for larger screens
      return 0.4;
    }
  }

  /// Get responsive font weight based on screen size
  ///
  /// [baseWeight] The base font weight
  /// [context] BuildContext for accessing screen dimensions
  ///
  /// Returns appropriate font weight for better readability
  static FontWeight getResponsiveFontWeight(
    FontWeight baseWeight,
    BuildContext context,
  ) {
    // Adjust font weight based on screen size for better readability
    if (isMobile(context)) {
      // Mobile: Slightly bolder for better readability on small screens
      switch (baseWeight) {
        case FontWeight.w100:
        case FontWeight.w200:
          return FontWeight.w300;
        case FontWeight.w300:
          return FontWeight.w400;
        case FontWeight.w400:
          return FontWeight.w500;
        case FontWeight.w500:
          return FontWeight.w600;
        case FontWeight.w600:
          return FontWeight.w700;
        case FontWeight.w700:
          return FontWeight.w800;
        case FontWeight.w800:
          return FontWeight.w900;
        default:
          return baseWeight;
      }
    } else {
      // Tablet/Desktop: Use base weight
      return baseWeight;
    }
  }
}
