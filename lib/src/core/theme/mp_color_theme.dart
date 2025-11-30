import 'package:flutter/material.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_config.dart';

class MPColorTheme extends ThemeExtension<MPColorTheme> {
  const MPColorTheme({
    this.primary,
    this.primarySurface,
    this.primaryFocus,
    this.primaryBorder,
    this.primaryHover,
    this.primaryPressed,
    this.neutral10,
    this.neutral20,
    this.neutral30,
    this.neutral40,
    this.neutral50,
    this.neutral60,
    this.neutral70,
    this.neutral80,
    this.neutral90,
    this.neutral100,
  });

  final Color? primary;
  final Color? primarySurface;
  final Color? primaryFocus;
  final Color? primaryBorder;
  final Color? primaryHover;
  final Color? primaryPressed;
  final Color? neutral10;
  final Color? neutral20;
  final Color? neutral30;
  final Color? neutral40;
  final Color? neutral50;
  final Color? neutral60;
  final Color? neutral70;
  final Color? neutral80;
  final Color? neutral90;
  final Color? neutral100;

  @override
  ThemeExtension<MPColorTheme> copyWith({
    Color? primary,
    Color? primarySurface,
    Color? primaryFocus,
    Color? primaryBorder,
    Color? primaryHover,
    Color? primaryPressed,
    Color? neutral10,
    Color? neutral20,
    Color? neutral30,
    Color? neutral40,
    Color? neutral50,
    Color? neutral60,
    Color? neutral70,
    Color? neutral80,
    Color? neutral90,
    Color? neutral100,
  }) =>
      MPColorTheme(
        primary: primary ?? this.primary,
        primarySurface: primarySurface ?? this.primarySurface,
        primaryFocus: primaryFocus ?? this.primaryFocus,
        primaryBorder: primaryBorder ?? this.primaryBorder,
        primaryHover: primaryHover ?? this.primaryHover,
        primaryPressed: primaryPressed ?? this.primaryPressed,
        neutral10: neutral10 ?? this.neutral10,
        neutral20: neutral20 ?? this.neutral20,
        neutral30: neutral30 ?? this.neutral30,
        neutral40: neutral40 ?? this.neutral40,
        neutral50: neutral50 ?? this.neutral50,
        neutral60: neutral60 ?? this.neutral60,
        neutral70: neutral70 ?? this.neutral70,
        neutral80: neutral80 ?? this.neutral80,
        neutral90: neutral90 ?? this.neutral90,
        neutral100: neutral100 ?? this.neutral100,
      );

  @override
  ThemeExtension<MPColorTheme> lerp(
    covariant ThemeExtension<MPColorTheme>? other,
    double t,
  ) {
    if (other is! MPColorTheme) {
      return this;
    }

    return MPColorTheme(
      primary: Color.lerp(primary, other.primary, t),
      primarySurface: Color.lerp(primarySurface, other.primarySurface, t),
      primaryFocus: Color.lerp(primaryFocus, other.primaryFocus, t),
      primaryBorder: Color.lerp(primaryBorder, other.primaryBorder, t),
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t),
      primaryPressed: Color.lerp(primaryPressed, other.primaryPressed, t),
      neutral10: Color.lerp(neutral10, other.neutral10, t),
      neutral20: Color.lerp(neutral20, other.neutral20, t),
      neutral30: Color.lerp(neutral30, other.neutral30, t),
      neutral40: Color.lerp(neutral40, other.neutral40, t),
      neutral50: Color.lerp(neutral50, other.neutral50, t),
      neutral60: Color.lerp(neutral60, other.neutral60, t),
      neutral70: Color.lerp(neutral70, other.neutral70, t),
      neutral80: Color.lerp(neutral80, other.neutral80, t),
      neutral90: Color.lerp(neutral90, other.neutral90, t),
      neutral100: Color.lerp(neutral100, other.neutral100, t),
    );
  }

  /// Light color scheme
  /// Uses MPThemeConfig as single source of truth for all colors
  static final MPColorTheme light = MPColorTheme(
    // Primary colors for light mode from MPThemeConfig
    primary: MPThemeConfig.getPrimary(isDarkMode: false), // Main primary color
    primarySurface:
        MPThemeConfig.getPrimarySurface(isDarkMode: false), // Light surface
    primaryFocus:
        MPThemeConfig.getPrimaryFocus(isDarkMode: false), // Focus state
    primaryBorder:
        MPThemeConfig.getPrimaryBorder(isDarkMode: false), // Border color
    primaryHover:
        MPThemeConfig.getPrimaryHover(isDarkMode: false), // Hover state
    primaryPressed:
        MPThemeConfig.getPrimaryPressed(isDarkMode: false), // Pressed state

    // Neutral colors for light mode from MPThemeConfig
    neutral10: MPThemeConfig.getNeutral(10), // White - lightest neutral
    neutral20: MPThemeConfig.getNeutral(20), // Very light gray
    neutral30: MPThemeConfig.getNeutral(30), // Light gray
    neutral40: MPThemeConfig.getNeutral(40), // Medium-light gray
    neutral50: MPThemeConfig.getNeutral(50), // Medium gray
    neutral60: MPThemeConfig.getNeutral(60), // Medium-dark gray
    neutral70: MPThemeConfig.getNeutral(70), // Dark gray
    neutral80: MPThemeConfig.getNeutral(80), // Very dark gray
    neutral90: MPThemeConfig.getNeutral(90), // Extremely dark gray
    neutral100: MPThemeConfig.getNeutral(100), // Black - darkest neutral
  );

  /// Dark color scheme
  /// Uses MPThemeConfig as single source of truth for all colors
  /// Fixed dark mode neutral scale with proper color usage
  static final MPColorTheme dark = MPColorTheme(
    // Primary colors for dark mode from MPThemeConfig (consistent with light mode)
    primary: MPThemeConfig.getPrimary(isDarkMode: true), // Main primary color
    primarySurface:
        MPThemeConfig.getPrimarySurface(isDarkMode: true), // Dark surface
    primaryFocus:
        MPThemeConfig.getPrimaryFocus(isDarkMode: true), // Focus state
    primaryBorder:
        MPThemeConfig.getPrimaryBorder(isDarkMode: true), // Border color
    primaryHover:
        MPThemeConfig.getPrimaryHover(isDarkMode: true), // Hover state
    primaryPressed:
        MPThemeConfig.getPrimaryPressed(isDarkMode: true), // Pressed state

    // Neutral colors for dark mode from MPThemeConfig
    // Fixed: Using proper neutral scale where neutral10 is white (for text)
    // and neutral100 is dark (for backgrounds)
    neutral10:
        MPThemeConfig.getNeutral(10), // White - for text on dark backgrounds
    neutral20: MPThemeConfig.getNeutral(20), // Very light gray
    neutral30: MPThemeConfig.getNeutral(30), // Light gray
    neutral40: MPThemeConfig.getNeutral(40), // Medium-light gray
    neutral50: MPThemeConfig.getNeutral(50), // Medium gray
    neutral60: MPThemeConfig.getNeutral(60), // Medium-dark gray
    neutral70: MPThemeConfig.getNeutral(70), // Dark gray
    neutral80: MPThemeConfig.getNeutral(80), // Very dark gray
    neutral90: MPThemeConfig.getNeutral(90), // Extremely dark gray
    neutral100: MPThemeConfig.getNeutral(100), // Dark gray - for backgrounds
  );

  @override
  String toString() {
    return 'MPColorTheme('
        'primary: $primary, '
        'primarySurface: $primarySurface, '
        'primaryFocus: $primaryFocus, '
        'primaryBorder: $primaryBorder, '
        'primaryHover: $primaryHover, '
        'primaryPressed: $primaryPressed, '
        'neutral10: $neutral10, '
        'neutral20: $neutral20, '
        'neutral30: $neutral30, '
        'neutral40: $neutral40, '
        'neutral50: $neutral50, '
        'neutral60: $neutral60, '
        'neutral70: $neutral70, '
        'neutral80: $neutral80, '
        'neutral90: $neutral90, '
        'neutral100: $neutral100, '
        ')';
  }
}
