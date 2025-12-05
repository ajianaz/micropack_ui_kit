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

  /// Creates a text widget with optional styling parameters.
  ///
  /// When no color is explicitly provided, automatically uses context.mp.textColor
  /// for optimal contrast and theme consistency. This makes MPText consistent with
  /// other components in the library that automatically use theme-aware colors.
  ///
  /// The [color] parameter always takes precedence over the theme color.
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

  /// Creates a heading text with default styling.
  /// Uses theme-aware text color when no color is explicitly provided.
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

  /// Creates a subheading text with default styling.
  /// Uses theme-aware text color when no color is explicitly provided.
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

  /// Creates a body text with default styling.
  /// Uses theme-aware text color when no color is explicitly provided.
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

  /// Creates a label text with default styling.
  /// Uses theme-aware text color when no color is explicitly provided.
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

  /// Creates a small text with default styling.
  /// Uses theme-aware text color when no color is explicitly provided.
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

  /// Composes the text style with theme-aware color as default.
  ///
  /// Uses context.mp.textColor when no color is explicitly provided,
  /// ensuring optimal contrast and theme consistency across the application.
  /// Explicit color parameter always takes precedence over theme color.
  TextStyle composeTextStyle(BuildContext context) {
    TextStyle baseStyle = style ?? const TextStyle();

    double? effectiveFontSize = fontSize;
    if (effectiveFontSize != null) {
      effectiveFontSize = ResponsiveFontHelper.getResponsiveFontSize(
          effectiveFontSize, context);
    }

    // Use theme-aware text color as default when no color is explicitly provided
    // Ensure proper contrast by using adaptive text color based on theme
    Color? effectiveColor =
        color ?? baseStyle.color ?? context.mp.adaptiveTextColor(1.0);

    return baseStyle.copyWith(
      fontWeight: fontWeight,
      fontSize: effectiveFontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: effectiveColor,
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
      style: _getCachedStyle(context),
    );
  }

  // Performance optimization: Cache composed style to avoid recalculations
  static final Map<String, TextStyle> _styleCache = {};

  TextStyle _getCachedStyle(BuildContext context) {
    // Create cache key from style parameters
    final params = [
      style?.hashCode ?? 0,
      fontSize?.hashCode ?? 0,
      fontWeight?.hashCode ?? 0,
      color?.hashCode ?? 0,
      fontStyle?.hashCode ?? 0,
      letterSpacing?.hashCode ?? 0,
    ];
    final cacheKey = params.join('_');

    if (_styleCache.containsKey(cacheKey)) {
      return _styleCache[cacheKey]!;
    }

    final composedStyle = composeTextStyle(context);
    _styleCache[cacheKey] = composedStyle;

    // Limit cache size to prevent memory leaks
    if (_styleCache.length > 50) {
      _styleCache.remove(_styleCache.keys.first);
    }

    return composedStyle;
  }
}
