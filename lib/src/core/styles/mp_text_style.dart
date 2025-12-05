// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/fonts/mp_font_manager.dart';
import 'mp_font_sizes.dart';

class MPTextStyle {
  /// Configurable text style for dynamic text usage
  static String defaultFontFamily = 'Poppins'; // Default global font

  final String? fontFamily;
  final int? maxLines;
  final int? minLines;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final bool? softWrap;
  final FontWeight? fontWeight;
  final double? fontSize;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final TextBaseline? textBaseline;
  final Color? color;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  final double? decorationThickness;

  const MPTextStyle({
    this.fontFamily,
    this.maxLines,
    this.minLines,
    this.textAlign,
    this.textOverflow,
    this.softWrap,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.textBaseline,
    this.color,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
  });

  /// Clone the style with override properties
  MPTextStyle copyWith({
    String? fontFamily,
    int? maxLines,
    int? minLines,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    bool? softWrap,
    FontWeight? fontWeight,
    double? fontSize,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    TextBaseline? textBaseline,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
  }) {
    return MPTextStyle(
      fontFamily: fontFamily ?? this.fontFamily,
      maxLines: maxLines ?? this.maxLines,
      minLines: minLines ?? this.minLines,
      textAlign: textAlign ?? this.textAlign,
      textOverflow: textOverflow ?? this.textOverflow,
      softWrap: softWrap ?? this.softWrap,
      fontWeight: fontWeight ?? this.fontWeight,
      fontSize: fontSize ?? this.fontSize,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      height: height ?? this.height,
      textBaseline: textBaseline ?? this.textBaseline,
      color: color ?? this.color,
      decoration: decoration ?? this.decoration,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationThickness: decorationThickness ?? this.decorationThickness,
    );
  }

  /// Internal base text style with robust font fallback system
  static TextStyle _base({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    double letterSpacing = 0.0,
    TextDecoration? decoration,
    Color? color,
    double? height,
    String? fontFamily,
  }) {
    final fontManager = MPFontManager();
    final effectiveFontFamily =
        MpUiKit.fontName ?? fontFamily ?? defaultFontFamily;

    // Use the enhanced font manager with fallback system and error handling
    try {
      return fontManager.getTextStyle(
        fontFamily: effectiveFontFamily,
        fontSize: fontSize * 1.sp,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing * 1.sp,
        height: height,
        color: color,
        decoration: decoration,
      );
    } catch (e) {
      // Graceful error handling with fallback to system font
      debugPrint(
          'Font style error for $effectiveFontFamily: $e. Using fallback.');
      return TextStyle(
        fontFamily: MPFontManager.getPlatformFontFamily(effectiveFontFamily),
        fontSize: fontSize * 1.sp,
        fontWeight: fontWeight,
        fontStyle: FontStyle.normal, // Ensure consistent style on error
        letterSpacing: letterSpacing * 1.sp,
        height: height,
        color: color,
        decoration: decoration,
        // Add fallback font chain for maximum compatibility
        fontFamilyFallback: ['system', 'Roboto', 'Arial', 'Helvetica'],
      );
    }
  }

  // === Text Variants ===

  /// Big page title
  static TextStyle title({
    Color? color,
    FontWeight fontWeight = FontWeight.w800,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      _base(
        fontSize: MPFontSizes
            .title, // Reduced from 42 to 24 for better app bar sizing
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
        fontFamily: fontFamily ?? defaultFontFamily,
      );

  /// Heading level 1
  static TextStyle heading1({
    Color? color,
    FontWeight fontWeight = FontWeight.w700,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      _base(
        fontSize: MPFontSizes.heading1,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
        fontFamily: fontFamily ?? defaultFontFamily,
      );

  /// Heading level 2
  static TextStyle heading2({
    Color? color,
    FontWeight fontWeight = FontWeight.w700,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      _base(
        fontSize: MPFontSizes.heading2,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
        fontFamily: fontFamily ?? defaultFontFamily,
      );

  /// Heading level 3
  static TextStyle heading3({
    Color? color,
    FontWeight fontWeight = FontWeight.w700,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      _base(
        fontSize: MPFontSizes.heading3,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
        fontFamily: fontFamily ?? defaultFontFamily,
      );

  /// Normal body text
  static TextStyle body1({
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      _base(
        fontSize: MPFontSizes.body1,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
        fontFamily: fontFamily ?? defaultFontFamily,
      );

  /// Secondary body text
  static TextStyle body2({
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
    String fontFamily = 'Poppins',
  }) =>
      _base(
        fontSize: MPFontSizes.body2,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
        fontFamily: fontFamily,
      );

  /// Caption / helper text
  static TextStyle caption({
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      _base(
        fontSize: MPFontSizes.caption,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
        fontFamily: fontFamily ?? defaultFontFamily,
      );

  /// Overline text
  static TextStyle overline({
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration decoration = TextDecoration.underline,
    String? fontFamily,
  }) =>
      _base(
          fontSize: MPFontSizes.overline,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration,
          fontFamily: fontFamily ?? defaultFontFamily);

  /// Light theme text theme
  static final TextTheme mainTextTheme = TextTheme(
    displayLarge: title(),
    displayMedium: title(fontWeight: FontWeight.w600),
    displaySmall: title(fontWeight: FontWeight.w400),
    titleLarge: heading1(),
    titleMedium: heading2(),
    titleSmall: heading3(),
    bodyLarge: body2(),
    bodyMedium: body1(),
    bodySmall: caption(),
    labelSmall: overline(),
  );

  /// Dark theme text theme
  static final TextTheme darkTextTheme = mainTextTheme;
}

/// Extension method to convert `MPTextStyle` to Flutter `TextStyle`
extension MPTextStyleExtension on MPTextStyle? {
  TextStyle toTextStyle([BuildContext? context]) {
    double? fontSize = this?.fontSize;

    // Apply responsive scaling if context is provided
    if (context != null && fontSize != null) {
      fontSize = ResponsiveFontHelper.getResponsiveFontSize(fontSize, context);
    }

    return TextStyle(
      fontFamily: this?.fontFamily,
      fontSize: fontSize,
      fontWeight: this?.fontWeight,
      fontStyle: this?.fontStyle,
      color: this?.color,
      letterSpacing: this?.letterSpacing,
      wordSpacing: this?.wordSpacing,
      height: this?.height,
      textBaseline: this?.textBaseline,
      overflow: this?.textOverflow,
      decoration: this?.decoration,
      decorationStyle: this?.decorationStyle,
      decorationColor: this?.decorationColor,
      decorationThickness: this?.decorationThickness,
    );
  }
}
