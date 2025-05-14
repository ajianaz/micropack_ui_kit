// ignore_for_file: public_member_api_docs, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/src/core/styles/mp_text_style.dart';

enum MPTextType { HEAD, SUBHEAD, TITLE, BODY, CAPTION, LABEL, SMALL }

class MPText extends StatelessWidget {
  final String text;
  final MPTextStyle? style;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final bool? softWrap;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? fontSize;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final Color? color;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  final double? decorationThickness;

  // ✅ Default constructor
  const MPText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.textOverflow,
    this.softWrap,
    this.textAlign,
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

  // 🔒 Internal constructor (for named constructors only)
  const MPText._internal(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.textOverflow,
    this.softWrap,
    this.textAlign,
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

  // ==== Named constructors ====

  factory MPText.head(
    String text, {
    Key? key,
    MPTextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w800,
    double fontSize = 24,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
  }) {
    return MPText._internal(
      text,
      key: key,
      style: style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }

  factory MPText.subhead(
    String text, {
    Key? key,
    MPTextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 18,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
  }) {
    return MPText._internal(
      text,
      key: key,
      style: style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }

  factory MPText.title(
    String text, {
    Key? key,
    MPTextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.bold,
    double fontSize = 20,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
  }) {
    return MPText._internal(
      text,
      key: key,
      style: style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }

  factory MPText.body(
    String text, {
    Key? key,
    MPTextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.normal,
    double fontSize = 14,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
  }) {
    return MPText._internal(
      text,
      key: key,
      style: style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }

  factory MPText.caption(
    String text, {
    Key? key,
    MPTextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 12,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
  }) {
    return MPText._internal(
      text,
      key: key,
      style: style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }

  factory MPText.label(
    String text, {
    Key? key,
    MPTextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = 13,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
  }) {
    return MPText._internal(
      text,
      key: key,
      style: style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }

  factory MPText.small(
    String text, {
    Key? key,
    MPTextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 10,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
  }) {
    return MPText._internal(
      text,
      key: key,
      style: style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      style: style.toTextStyle(),
    );
  }
}
