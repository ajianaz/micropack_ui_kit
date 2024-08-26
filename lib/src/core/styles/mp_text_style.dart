import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MPTextStyle {
  const MPTextStyle._();

  static TextStyle _base({
    double fontSize = 14,
    FontWeight? fontWeight = FontWeight.w400,
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

  //TODO: Define your text style variant and your main text theme

  static TextTheme mainTextTheme = TextTheme(
    displayLarge: MPTextStyle.title(),
    displayMedium: MPTextStyle.title(
      fontWeight: FontWeight.w600,
    ),
    displaySmall: MPTextStyle.title(
      fontWeight: FontWeight.w400,
    ),
    titleLarge: MPTextStyle.heading1(),
    titleMedium: MPTextStyle.heading2(),
    titleSmall: MPTextStyle.heading3(),
    bodyLarge: MPTextStyle.body2(),
    bodyMedium: MPTextStyle.body1(),
    bodySmall: MPTextStyle.caption(),
  );
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: MPTextStyle.title(),
    displayMedium: MPTextStyle.title(
      fontWeight: FontWeight.w600,
    ),
    displaySmall: MPTextStyle.title(
      fontWeight: FontWeight.w400,
    ),
    titleLarge: MPTextStyle.heading1(),
    titleMedium: MPTextStyle.heading2(),
    titleSmall: MPTextStyle.heading3(),
    bodyLarge: MPTextStyle.body2(),
    bodyMedium: MPTextStyle.body1(),
    bodySmall: MPTextStyle.caption(),
  );

  static TextStyle title({
    Color? color,
    FontWeight? fontWeight = FontWeight.w800,
    TextDecoration? decoration,
  }) =>
      _base(
        fontSize: 42,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      );

  static TextStyle heading1({
    Color? color,
    FontWeight? fontWeight = FontWeight.w700,
    TextDecoration? decoration,
  }) =>
      _base(
        fontSize: 34,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      );

  static TextStyle heading2({
    Color? color,
    FontWeight? fontWeight = FontWeight.w700,
    TextDecoration? decoration,
  }) =>
      _base(
        fontSize: 27,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      );

  static TextStyle heading3({
    Color? color,
    FontWeight? fontWeight = FontWeight.w700,
    TextDecoration? decoration,
  }) =>
      _base(
        fontSize: 21,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      );

  static TextStyle body1({
    Color? color,
    FontWeight? fontWeight = FontWeight.w400,
    TextDecoration? decoration,
  }) =>
      _base(
        fontSize: 17,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      );

  static TextStyle body2({
    Color? color,
    FontWeight? fontWeight = FontWeight.w400,
    TextDecoration? decoration,
  }) =>
      _base(
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      );

  static TextStyle caption({
    Color? color,
    FontWeight? fontWeight = FontWeight.w400,
    TextDecoration? decoration,
  }) =>
      _base(
        fontSize: 11,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      );

  static TextStyle overline({
    Color? color,
    FontWeight? fontWeight = FontWeight.w400,
    TextDecoration? decoration = TextDecoration.underline,
  }) =>
      _base(
        fontSize: 8,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      );
}
