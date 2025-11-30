import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropack_ui_kit/mp_ui_kit_settings.dart';

/// Responsive font helper utility
///
/// Provides breakpoint-based font scaling to prevent excessive font sizes
/// on larger screens while maintaining responsive design principles.
///
/// Breakpoints:
/// - Mobile (< 600px): Scale factor 1.0 (full ScreenUtil scaling)
/// - Tablet (600-1024px): Scale factor 0.85
/// - Desktop (> 1024px): Scale factor 0.7
class ResponsiveFontHelper {
  /// Get the appropriate scale factor based on screen width
  ///
  /// Uses breakpoints from MpUiKit settings:
  /// - limitSmallMediumScreen: 600px (mobile/tablet boundary)
  /// - limitMediumLargeScreen: 1024px (tablet/desktop boundary)
  static double getScaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < MpUiKit.limitSmallMediumScreen) {
      // Mobile: full scaling
      return 1.0;
    } else if (width < MpUiKit.limitMediumLargeScreen) {
      // Tablet: moderate reduction
      return 0.85;
    } else {
      // Desktop: significant reduction to prevent huge fonts
      return 0.7;
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

    // Get the scale factor for current screen size
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
}
