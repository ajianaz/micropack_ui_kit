// ignore_for_file: public_member_api_docs, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/styles/mp_font_sizes.dart';

enum MPTextType { HEAD, SUBHEAD, TITLE, BODY, CAPTION, LABEL, SMALL }

class MPText extends StatelessWidget {
  final String text;
  final TextStyle? style;
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
    TextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w800,
    double fontSize = MPFontSizes.title,
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
      style: style ?? MPTextStyle.heading3(fontWeight: FontWeight.w500),
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
    TextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = MPFontSizes.subhead,
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
      style: style ?? MPTextStyle.body1(fontWeight: FontWeight.w500),
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
    TextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.normal,
    double fontSize = MPFontSizes.body,
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
      style: style ?? MPTextStyle.body2(),
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
    TextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = MPFontSizes.label,
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
      style: style ?? MPTextStyle.body2(fontWeight: FontWeight.w500),
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
    TextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = MPFontSizes.small,
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
      style: style ?? MPTextStyle.caption(),
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

  TextStyle composeTextStyle(BuildContext context) {
    TextStyle baseStyle = style ?? const TextStyle();

    double? effectiveFontSize = fontSize;
    if (effectiveFontSize != null) {
      effectiveFontSize = ResponsiveFontHelper.getResponsiveFontSize(
          effectiveFontSize, context);
    }

    return baseStyle.copyWith(
      fontWeight: fontWeight,
      fontSize: effectiveFontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      overflow: textOverflow,
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
      overflow:
          textOverflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
      softWrap: softWrap ?? true,
      textAlign: textAlign,
      style: composeTextStyle(context),
    );
  }
}
