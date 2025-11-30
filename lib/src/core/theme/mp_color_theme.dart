import 'package:flutter/material.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';

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
  /// Uses light mode colors with proper neutral scale (neutral10 = white, neutral100 = black)
  static final MPColorTheme light = MPColorTheme(
    // Primary colors for light mode
    primary: MPColors.getPrimary(
        isDarkMode: false), // Main primary color for light mode
    primarySurface: MPColors.getPrimarySurface(
        isDarkMode: false), // Light surface for primary elements
    primaryFocus: MPColors.getPrimaryFocus(
        isDarkMode: false), // Focus state for primary elements
    primaryBorder: MPColors.getPrimaryBorder(
        isDarkMode: false), // Border color for primary elements
    primaryHover: MPColors.getPrimaryHover(
        isDarkMode: false), // Hover state for primary elements
    primaryPressed: MPColors.getPrimaryPressed(
        isDarkMode: false), // Pressed state for primary elements

    // Neutral colors for light mode (neutral10 = lightest/white, neutral100 = darkest/black)
    neutral10:
        MPColors.getNeutral(10, isDarkMode: false), // White - lightest neutral
    neutral20: MPColors.getNeutral(20, isDarkMode: false), // Very light gray
    neutral30: MPColors.getNeutral(30, isDarkMode: false), // Light gray
    neutral40: MPColors.getNeutral(40, isDarkMode: false), // Medium-light gray
    neutral50: MPColors.getNeutral(50, isDarkMode: false), // Medium gray
    neutral60: MPColors.getNeutral(60, isDarkMode: false), // Medium-dark gray
    neutral70: MPColors.getNeutral(70, isDarkMode: false), // Dark gray
    neutral80: MPColors.getNeutral(80, isDarkMode: false), // Very dark gray
    neutral90:
        MPColors.getNeutral(90, isDarkMode: false), // Extremely dark gray
    neutral100:
        MPColors.getNeutral(100, isDarkMode: false), // Black - darkest neutral
  );

  /// Dark color scheme
  /// Uses dark mode colors with proper neutral scale (neutral10 = white, neutral100 = black)
  static final MPColorTheme dark = MPColorTheme(
    // Primary colors for dark mode
    primary: MPColors.getPrimary(
        isDarkMode: true), // Main primary color for dark mode
    primarySurface: MPColors.getPrimarySurface(
        isDarkMode: true), // Dark surface for primary elements
    primaryFocus: MPColors.getPrimaryFocus(
        isDarkMode: true), // Focus state for primary elements in dark mode
    primaryBorder: MPColors.getPrimaryBorder(
        isDarkMode: true), // Border color for primary elements in dark mode
    primaryHover: MPColors.getPrimaryHover(
        isDarkMode: true), // Hover state for primary elements in dark mode
    primaryPressed: MPColors.getPrimaryPressed(
        isDarkMode: true), // Pressed state for primary elements in dark mode

    // Neutral colors for dark mode (neutral10 = lightest/white, neutral100 = darkest/black)
    // Note: In dark mode, we still use the same neutral scale where neutral10 is white (for text)
    // and neutral100 is black (for backgrounds), but the context of how they're used changes
    neutral10: MPColors.getNeutral(10,
        isDarkMode:
            true), // White - lightest neutral for text on dark backgrounds
    neutral20: MPColors.getNeutral(20, isDarkMode: true), // Very light gray
    neutral30: MPColors.getNeutral(30, isDarkMode: true), // Light gray
    neutral40: MPColors.getNeutral(40, isDarkMode: true), // Medium-light gray
    neutral50: MPColors.getNeutral(50, isDarkMode: true), // Medium gray
    neutral60: MPColors.getNeutral(60, isDarkMode: true), // Medium-dark gray
    neutral70: MPColors.getNeutral(70, isDarkMode: true), // Dark gray
    neutral80: MPColors.getNeutral(80, isDarkMode: true), // Very dark gray
    neutral90: MPColors.getNeutral(90, isDarkMode: true), // Extremely dark gray
    neutral100: MPColors.getNeutral(100,
        isDarkMode: true), // Black - darkest neutral for backgrounds
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
