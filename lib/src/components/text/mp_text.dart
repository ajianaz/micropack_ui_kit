// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/mp_ui_kit_settings.dart';

class MPText extends StatelessWidget {
  /// Teks yang akan ditampilkan
  final String text;

  /// [style] Mengatur gaya dari teks secara paket
  ///
  /// Lihat juga :
  ///
  /// class [MPTextStyle] untuk melihat lebih detail isinya
  final MPTextStyle? style;

  /// [maxLines] Mengatur maksimal baris dari teks
  final int? maxLines;

  /// [textAlign] Mengatur perataan dari teks
  final TextAlign? textAlign;

  /// [textOverflow] Mengatur luapan teks
  final TextOverflow? textOverflow;

  /// [softWrap] mengatur text soft warp
  final bool? softWrap;

  /// [fontWeight] Mengatur ketebalan font
  final FontWeight? fontWeight;

  /// [fontSize] Mengatur ukuran font
  final double? fontSize;

  /// [fontStyle] mengatur bentuk font
  final FontStyle? fontStyle;

  /// [letterSpacing] mengatur jarak pada huruf
  double? letterSpacing;

  /// [color] Mengatur warna font
  final Color? color;

  /// [decoration] mengatur dekorasi dari teks
  final TextDecoration? decoration;

  /// [decorationStyle] mengatur gaya dari dekorasi (dashed, dotted, double atau combine)
  final TextDecorationStyle? decorationStyle;

  /// [decorationColor] mengatur warna dari dekorasi
  final Color? decorationColor;

  /// [decorationThickness] mengatur ketebalan dari dekorasi
  final double? decorationThickness;

  /// Default Constructor of MPText
  MPText(
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
  }) {
    MPTextAssertion.assertStyleConfiguration(
      MPTextType.BODY,
      style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }

  /// Constructor MPText yang mengatur untuk teks judul
  /// dengan nilai default untuk fontSize = 18 dan fontWeight = FontWeight.bold
  MPText.head(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.textOverflow,
    this.softWrap,
    this.textAlign,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 18,
    this.fontStyle,
    this.letterSpacing,
    this.color,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
  }) {
    MPTextAssertion.assertStyleConfiguration(
      MPTextType.HEAD,
      style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }

  /// Constructor MPText yang mengatur untuk teks subjudul
  /// dengan nilai default untuk fontSize = 16 dan fontWeight = FontWeight.w600
  MPText.subhead(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.textOverflow,
    this.softWrap,
    this.textAlign,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 16,
    this.fontStyle,
    this.letterSpacing,
    this.color,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
  }) {
    MPTextAssertion.assertStyleConfiguration(
      MPTextType.SUBHEAD,
      style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }

  /// Constructor MPText yang mengatur untuk teks hint
  /// dengan nilai default untuk fontSize = 12 dan fontWeight = FontWeight.w400
  MPText.hint(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.textOverflow,
    this.softWrap,
    this.textAlign,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 12,
    this.fontStyle,
    this.letterSpacing,
    this.color,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
  }) {
    MPTextAssertion.assertStyleConfiguration(
      MPTextType.HINT,
      style,
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
    MPTextStyle? defaultTextStyle = _defaultStyle();

    return Text(
      text,
      maxLines: defaultTextStyle?.maxLines,
      textAlign: defaultTextStyle?.textAlign,
      overflow: defaultTextStyle?.textOverflow,
      softWrap: defaultTextStyle?.softWrap,
      style: GoogleFonts.getFont(MpUiKit.fontName ?? "Lato",
          fontWeight: defaultTextStyle?.fontWeight,
          fontSize: MpUiKit.useScreenUtil
              ? (defaultTextStyle?.fontSize)?.sp
              : defaultTextStyle?.fontSize,
          fontStyle: defaultTextStyle?.fontStyle,
          color: defaultTextStyle?.color,
          decoration: defaultTextStyle?.decoration,
          decorationStyle: defaultTextStyle?.decorationStyle,
          decorationColor: defaultTextStyle?.decorationColor,
          decorationThickness: defaultTextStyle?.decorationThickness,
          letterSpacing: defaultTextStyle?.letterSpacing),
    );
  }

  MPTextStyle? _defaultStyle() {
    var defaultTextStyle = MpUiKit.textStyle?.copyWith();
    if (style != null) {
      defaultTextStyle = style;
    } else {
      defaultTextStyle?.maxLines = maxLines ?? defaultTextStyle.maxLines;
      defaultTextStyle?.textAlign = textAlign ?? defaultTextStyle.textAlign;
      defaultTextStyle?.textOverflow =
          textOverflow ?? defaultTextStyle.textOverflow;
      defaultTextStyle?.softWrap = softWrap ?? defaultTextStyle.softWrap;
      defaultTextStyle?.fontWeight = fontWeight ?? defaultTextStyle.fontWeight;
      defaultTextStyle?.fontSize = (fontSize ?? defaultTextStyle.fontSize);
      defaultTextStyle?.fontStyle = fontStyle ?? defaultTextStyle.fontStyle;
      defaultTextStyle?.letterSpacing =
          letterSpacing ?? defaultTextStyle.letterSpacing;
      defaultTextStyle?.color = color ?? defaultTextStyle.color;
      defaultTextStyle?.decoration = decoration ?? defaultTextStyle.decoration;
      defaultTextStyle?.decorationStyle =
          decorationStyle ?? defaultTextStyle.decorationStyle;
      defaultTextStyle?.decorationThickness =
          decorationThickness ?? defaultTextStyle.decorationThickness;
      defaultTextStyle?.decorationColor =
          decorationColor ?? defaultTextStyle.decorationColor;
    }
    return defaultTextStyle;
  }
}

/// Menyediakan tipe dari MPText yang akan dipakai
enum MPTextType { BODY, HEAD, SUBHEAD, HINT }

/// Mengatur 'assert' atau kondisi untuk penggunaan MPText
class MPTextAssertion {
  static void assertStyleConfiguration(
    MPTextType type,
    MPTextStyle? style, {
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
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
    if (type == MPTextType.BODY) {
      assert(
          style == null ||
              (maxLines == null &&
                  textOverflow == null &&
                  softWrap == null &&
                  textAlign == null &&
                  fontWeight == null &&
                  fontSize == null &&
                  fontStyle == null &&
                  letterSpacing == null &&
                  color == null &&
                  decoration == null &&
                  decorationColor == null &&
                  decorationThickness == null &&
                  decorationStyle == null),
          'Invalid configuration: If style is not null, all other properties must be null.');
    } else {
      assert(
          style == null ||
              (maxLines == null &&
                  textOverflow == null &&
                  softWrap == null &&
                  textAlign == null &&
                  fontStyle == null &&
                  letterSpacing == null &&
                  color == null &&
                  decoration == null &&
                  decorationColor == null &&
                  decorationThickness == null &&
                  decorationStyle == null),
          'Invalid configuration: If style is not null, all other properties must be null.');
    }
  }
}
