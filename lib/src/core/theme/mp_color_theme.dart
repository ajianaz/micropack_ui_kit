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
  static final MPColorTheme light = MPColorTheme(
    primary: MPColors.primary,
    primarySurface: MPColors.primarySurface,
    primaryFocus: MPColors.primaryFocus,
    primaryBorder: MPColors.primaryBorder,
    primaryHover: MPColors.primaryHover,
    primaryPressed: MPColors.primaryPressed,
    neutral10: MPColors.neutral[10],
    neutral20: MPColors.neutral[20],
    neutral30: MPColors.neutral[30],
    neutral40: MPColors.neutral[40],
    neutral50: MPColors.neutral[50],
    neutral60: MPColors.neutral[60],
    neutral70: MPColors.neutral[70],
    neutral80: MPColors.neutral[80],
    neutral90: MPColors.neutral[90],
    neutral100: MPColors.neutral[100],
  );

  /// Dark color scheme
  static final MPColorTheme dark = MPColorTheme(
    primary: MPColors.primary,
    primarySurface: MPColors.primarySurface,
    primaryFocus: MPColors.primaryFocus,
    primaryBorder: MPColors.primaryBorder,
    primaryHover: MPColors.primaryHover,
    primaryPressed: MPColors.primaryPressed,
    neutral10: MPColors.neutral[10],
    neutral20: MPColors.neutral[20],
    neutral30: MPColors.neutral[30],
    neutral40: MPColors.neutral[40],
    neutral50: MPColors.neutral[50],
    neutral60: MPColors.neutral[60],
    neutral70: MPColors.neutral[70],
    neutral80: MPColors.neutral[80],
    neutral90: MPColors.neutral[90],
    neutral100: MPColors.neutral[100],
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
