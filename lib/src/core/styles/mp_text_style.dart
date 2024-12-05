import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MPTextStyle {
  // const MPTextStyle._();

  /// [maxLines] Mengatur maksimal baris dari teks
  int? maxLines;

  /// [minLines] Mengatur minimal baris dari teks.
  /// Saat ini hanya berlaku di penggunaan [MPTextField]
  int? minLines;

  /// [textAlign] Mengatur perataan dari teks
  TextAlign? textAlign;

  /// [textOverflow] Mengatur luapan teks
  TextOverflow? textOverflow;

  /// [softWrap] mengatur text soft warp
  bool? softWrap;

  /// [fontWeight] Mengatur ketebalan font
  FontWeight? fontWeight;

  /// [fontSize] Mengatur ukuran font
  double? fontSize;

  /// [fontStyle] mengatur bentuk font
  FontStyle? fontStyle;

  /// [letterSpacing] mengatur jarak pada huruf
  double? letterSpacing;

  /// [color] Mengatur warna font
  Color? color;

  /// [decoration] mengatur dekorasi dari teks
  TextDecoration? decoration;

  /// [decorationStyle] mengatur gaya dari dekorasi (dashed, dotted, double atau combine)
  TextDecorationStyle? decorationStyle;

  /// [decorationColor] mengatur warna dari dekorasi
  Color? decorationColor;

  /// [decorationThickness] mengatur ketebalan dari dekorasi
  double? decorationThickness;

  MPTextStyle({
    this.maxLines,
    this.minLines,
    this.textAlign,
    this.textOverflow,
    this.softWrap,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.letterSpacing,
    this.color,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
  });

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
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
  }) {
    return MPTextStyle(
      maxLines: maxLines ?? this.maxLines,
      minLines: maxLines ?? this.minLines,
      textAlign: textAlign ?? this.textAlign,
      textOverflow: textOverflow ?? this.textOverflow,
      softWrap: softWrap ?? this.softWrap,
      fontWeight: fontWeight ?? this.fontWeight,
      fontSize: fontSize ?? this.fontSize,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      color: color ?? this.color,
      decoration: decoration ?? this.decoration,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationThickness: decorationThickness ?? this.decorationThickness,
    );
  }

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

extension MPTextStyleExtension on MPTextStyle? {
  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: this?.fontSize,
      fontWeight: this?.fontWeight,
      color: this?.color,
      fontStyle: this?.fontStyle,
      overflow: this?.textOverflow,
      letterSpacing: this?.letterSpacing,
      decoration: this?.decoration,
      decorationStyle: this?.decorationStyle,
      decorationColor: this?.decorationColor,
      decorationThickness: this?.decorationThickness,
    );
  }
}
