import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MPTextStyle {
  /// Configurable text style for dynamic text usage

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

  /// Internal base text style
  static TextStyle _base({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    double letterSpacing = 0.0,
    TextDecoration? decoration,
    Color? color,
    double? height,
  }) =>
      GoogleFonts.montserrat(
        fontSize: fontSize * 1.sp,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing * 1.sp,
        height: height,
        textBaseline: TextBaseline.alphabetic,
        decoration: decoration,
        locale: const Locale('en', 'US'),
        color: color,
      );

  // === Text Variants ===

  /// Big page title
  static TextStyle title({
    Color? color,
    FontWeight fontWeight = FontWeight.w800,
    TextDecoration? decoration,
  }) =>
      _base(
          fontSize: 42,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration);

  /// Heading level 1
  static TextStyle heading1({
    Color? color,
    FontWeight fontWeight = FontWeight.w700,
    TextDecoration? decoration,
  }) =>
      _base(
          fontSize: 34,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration);

  /// Heading level 2
  static TextStyle heading2({
    Color? color,
    FontWeight fontWeight = FontWeight.w700,
    TextDecoration? decoration,
  }) =>
      _base(
          fontSize: 27,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration);

  /// Heading level 3
  static TextStyle heading3({
    Color? color,
    FontWeight fontWeight = FontWeight.w700,
    TextDecoration? decoration,
  }) =>
      _base(
          fontSize: 21,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration);

  /// Normal body text
  static TextStyle body1({
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
  }) =>
      _base(
          fontSize: 17,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration);

  /// Secondary body text
  static TextStyle body2({
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
  }) =>
      _base(
          fontSize: 14,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration);

  /// Caption / helper text
  static TextStyle caption({
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
  }) =>
      _base(
          fontSize: 11,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration);

  /// Overline text
  static TextStyle overline({
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration decoration = TextDecoration.underline,
  }) =>
      _base(
          fontSize: 8,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration);

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
  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: this?.fontSize,
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
