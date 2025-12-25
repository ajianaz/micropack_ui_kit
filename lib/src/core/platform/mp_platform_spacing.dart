import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Platform-adaptive spacing and sizing utilities
///
/// Provides optimized spacing and sizing for different platforms:
/// - Mobile: More generous spacing for touch interfaces
/// - Desktop: Tighter spacing for mouse interfaces
/// - Web: Balanced approach for both input types
class MPPlatformSpacing {
  MPPlatformSpacing._();

  /// Private singleton instance
  static final MPPlatformSpacing _instance = MPPlatformSpacing._();

  /// Get the singleton instance
  static MPPlatformSpacing get instance => _instance;

  /// Current platform
  final MPPlatformSize _currentPlatform = _detectPlatform();

  /// Detect current platform for sizing
  static MPPlatformSize _detectPlatform() {
    if (kIsWeb) return MPPlatformSize.web;
    if (Platform.isIOS) return MPPlatformSize.mobile;
    if (Platform.isAndroid) return MPPlatformSize.mobile;
    if (Platform.isMacOS) return MPPlatformSize.desktop;
    if (Platform.isWindows) return MPPlatformSize.desktop;
    if (Platform.isLinux) return MPPlatformSize.desktop;
    return MPPlatformSize.web;
  }

  /// Get current platform size category
  MPPlatformSize get currentPlatform => _currentPlatform;

  /// Scale factor for spacing (1.0 = base, higher = more spacing)
  double get spacingScale {
    switch (_currentPlatform) {
      case MPPlatformSize.mobile:
        return 1.2; // More spacing for touch
      case MPPlatformSize.desktop:
        return 0.9; // Tighter spacing for mouse
      case MPPlatformSize.web:
        return 1.0; // Base spacing
    }
  }

  /// Scale factor for sizing (1.0 = base, higher = larger)
  double get sizingScale {
    switch (_currentPlatform) {
      case MPPlatformSize.mobile:
        return 1.1; // Slightly larger for touch
      case MPPlatformSize.desktop:
        return 0.95; // Slightly smaller for dense layouts
      case MPPlatformSize.web:
        return 1.0; // Base size
    }
  }

  /// Base spacing unit (4px * scale)
  double get base => 4.0 * spacingScale;

  /// Extra small spacing (2px * scale)
  double get xs => 2.0 * spacingScale;

  /// Small spacing (4px * scale)
  double get sm => 4.0 * spacingScale;

  /// Medium spacing (8px * scale)
  double get md => 8.0 * spacingScale;

  /// Large spacing (16px * scale)
  double get lg => 16.0 * spacingScale;

  /// Extra large spacing (24px * scale)
  double get xl => 24.0 * spacingScale;

  /// Double extra large spacing (32px * scale)
  double get xxl => 32.0 * spacingScale;

  /// Triple extra large spacing (48px * scale)
  double get xxxl => 48.0 * spacingScale;

  /// Get padding for a card
  EdgeInsets get cardPadding => EdgeInsets.all(lg);

  /// Get margin for a card
  EdgeInsets get cardMargin => EdgeInsets.all(md);

  /// Get padding for a page
  EdgeInsets get pagePadding => EdgeInsets.all(lg);

  /// Get padding for a section
  EdgeInsets get sectionPadding => EdgeInsets.symmetric(
        horizontal: lg,
        vertical: xl,
      );

  /// Get gap between items
  double get itemGap => md;

  /// Get gap between form fields
  double get formFieldGap => md;

  /// Get gap between list items
  double get listItemGap => sm;

  /// Get icon size (small)
  double get iconSizeSm => 16.0 * sizingScale;

  /// Get icon size (medium)
  double get iconSizeMd => 24.0 * sizingScale;

  /// Get icon size (large)
  double get iconSizeLg => 32.0 * sizingScale;

  /// Get button height (small)
  double get buttonHeightSm => 32.0 * sizingScale;

  /// Get button height (medium)
  double get buttonHeightMd => 40.0 * sizingScale;

  /// Get button height (large)
  double get buttonHeightLg => 48.0 * sizingScale;

  /// Get border radius (small)
  double get borderRadiusSm => 4.0;

  /// Get border radius (medium)
  double get borderRadiusMd => 8.0;

  /// Get border radius (large)
  double get borderRadiusLg => 12.0;

  /// Get avatar size (small)
  double get avatarSizeSm => 32.0 * sizingScale;

  /// Get avatar size (medium)
  double get avatarSizeMd => 48.0 * sizingScale;

  /// Get avatar size (large)
  double get avatarSizeLg => 64.0 * sizingScale;

  /// Scale a spacing value by platform scale
  double scaleSpacing(double value) => value * spacingScale;

  /// Scale a sizing value by platform scale
  double scaleSizing(double value) => value * sizingScale;

  /// Get responsive value based on screen width
  double responsive(
    double mobile, {
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    // This would typically use MediaQuery for actual responsiveness
    // For now, use platform as a proxy
    switch (_currentPlatform) {
      case MPPlatformSize.mobile:
        return mobile;
      case MPPlatformSize.desktop:
        return desktop ?? tablet ?? mobile;
      case MPPlatformSize.web:
        return tablet ?? mobile;
    }
  }

  /// Get screen size category from constraints
  static MPScreenSize getScreenSize(BoxConstraints constraints) {
    final width = constraints.maxWidth;

    if (width < 576) {
      return MPScreenSize.mobile;
    } else if (width < 768) {
      return MPScreenSize.mobileLarge;
    } else if (width < 992) {
      return MPScreenSize.tablet;
    } else if (width < 1200) {
      return MPScreenSize.desktop;
    } else {
      return MPScreenSize.desktopLarge;
    }
  }

  /// Get responsive padding based on screen size
  static EdgeInsets responsivePaddingForScreen(MPScreenSize size) {
    switch (size) {
      case MPScreenSize.mobile:
        return const EdgeInsets.all(16);
      case MPScreenSize.mobileLarge:
        return const EdgeInsets.all(20);
      case MPScreenSize.tablet:
        return const EdgeInsets.all(24);
      case MPScreenSize.desktop:
        return const EdgeInsets.all(32);
      case MPScreenSize.desktopLarge:
        return const EdgeInsets.all(40);
    }
  }

  /// Get number of columns for grid based on screen width
  static int gridColumnsForWidth(double width) {
    if (width < 576) return 1;
    if (width < 768) return 2;
    if (width < 992) return 3;
    if (width < 1200) return 4;
    return 5;
  }
}

/// Platform size category
enum MPPlatformSize {
  /// Mobile devices (phones)
  mobile,

  /// Desktop devices (macOS, Windows, Linux)
  desktop,

  /// Web platform
  web,
}

/// Screen size category for responsive design
enum MPScreenSize {
  /// Small mobile screens (< 576px)
  mobile,

  /// Large mobile screens (576px - 768px)
  mobileLarge,

  /// Tablet screens (768px - 992px)
  tablet,

  /// Desktop screens (992px - 1200px)
  desktop,

  /// Large desktop screens (> 1200px)
  desktopLarge,
}

/// Extension on BuildContext for platform spacing
extension MPPlatformSpacingContext on BuildContext {
  /// Get platform spacing utilities
  MPPlatformSpacing get platformSpacing => MPPlatformSpacing.instance;

  /// Get base spacing unit
  double get baseSpacing => platformSpacing.base;

  /// Get extra small spacing
  double get spacingXs => platformSpacing.xs;

  /// Get small spacing
  double get spacingSm => platformSpacing.sm;

  /// Get medium spacing
  double get spacingMd => platformSpacing.md;

  /// Get large spacing
  double get spacingLg => platformSpacing.lg;

  /// Get extra large spacing
  double get spacingXl => platformSpacing.xl;

  /// Get card padding
  EdgeInsets get cardPadding => platformSpacing.cardPadding;

  /// Get page padding
  EdgeInsets get pagePadding => platformSpacing.pagePadding;

  /// Get screen size from media query
  MPScreenSize get screenSize {
    final constraints = BoxConstraints(
      maxWidth: MediaQuery.of(this).size.width,
    );
    return MPPlatformSpacing.getScreenSize(constraints);
  }

  /// Get responsive padding for current screen size
  EdgeInsets get responsivePadding {
    return MPPlatformSpacing.responsivePaddingForScreen(screenSize);
  }

  /// Check if screen is mobile size
  bool get isMobileScreen =>
      screenSize == MPScreenSize.mobile ||
      screenSize == MPScreenSize.mobileLarge;

  /// Check if screen is desktop size
  bool get isDesktopScreen =>
      screenSize == MPScreenSize.desktop ||
      screenSize == MPScreenSize.desktopLarge;

  /// Check if screen is tablet size
  bool get isTabletScreen => screenSize == MPScreenSize.tablet;
}
