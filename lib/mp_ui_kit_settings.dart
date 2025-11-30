// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/styles/mp_text_field_border.dart';

class MpUiKit {
  static void init({
    /// [REQUIRED] Mengatur warna utama
    required Color colorBrand,

    /// [REQUIRED] Mengatur warna sekunder
    required Color colorBrand2,

    /// Mengatur warna border, digunakan untuk warna border di MPButton
    Color? colorStroke,

    /// Mengatur warna teks untuk MPText
    Color? colorText,

    /// Mengatur warna disable, seperti digunakan untuk MPButton disable
    Color? colorDisable,

    /// Mengatur warna error
    Color? colorError,

    /// Mengatur nama font yang ada di google
    String? fontName,

    /// Mengatur style default untuk MPText
    MPTextStyle? textStyle,

    /// Mengatur radius untuk MPButton atau MPTextField
    double? buttonBorderRadius,

    /// Mengatur penggunaan ScreenUtil. Jika bernilai true maka fontSize akan dikonversi ke .sp
    /// Changed default to true for better responsive design
    bool useScreenUtil = true,

    /// Mengatur batas. width < limit = Small dan width > limit = Medium
    double? limitSmallMediumScreen,

    /// Mengatur batas. width < limit = Medium dan width > limit = Large
    double? limitMediumLargeScreen,

    /// Mengatur icon Success dialog ketika EnumIconDialogType.success
    Widget? iconSuccess,

    /// Mengatur icon Success dialog ketika EnumIconDialogType.failed
    Widget? iconFailed,

    /// Mengatur icon Success dialog ketika EnumIconDialogType.warning
    Widget? iconWarning,
  }) {
    MpUiKit.colorBrand = colorBrand;
    MpUiKit.colorBrand2 = colorBrand2;
    if (colorStroke != null) MpUiKit.colorStroke = colorStroke;
    if (colorText != null) MpUiKit.colorText = colorText;
    if (colorDisable != null) MpUiKit.colorDisable = colorDisable;
    if (colorError != null) MpUiKit.colorError = colorError;
    if (fontName != null) MpUiKit.fontName = fontName;
    if (textStyle != null) MpUiKit.textStyle = textStyle;
    if (buttonBorderRadius != null) {
      MpUiKit.buttonRadius = buttonBorderRadius;
    }
    MpUiKit.useScreenUtil = useScreenUtil;
    if (limitSmallMediumScreen != null) {
      MpUiKit.limitSmallMediumScreen = limitSmallMediumScreen;
    }
    if (limitMediumLargeScreen != null) {
      MpUiKit.limitMediumLargeScreen = limitMediumLargeScreen;
    }
    if (iconSuccess != null) MpUiKit.iconSuccess = iconSuccess;
    if (iconFailed != null) MpUiKit.iconFailed = iconFailed;
    if (iconWarning != null) MpUiKit.iconWarning = iconWarning;
  }

  /// Mengatur warna Brand
  static Color colorBrand = Color(0xFF4086EF);

  /// Mengatur warna Brand2 (Secondary)
  static Color colorBrand2 = Color(0xFFFFFFFF);

  /// Mengatur warna Stroke
  static Color colorStroke = colorBrand;

  /// Mengatur warna Text
  static Color colorText = Color(0xFF2F2F2F);

  /// Mengatur warna Disable
  static Color colorDisable = Color(0xFFA9A9A9);

  /// Mengatur warna Error
  static Color colorError = Color(0xFFFF0000);

  /// Mengatur penggunaan Screen Util (default : false)
  static bool useScreenUtil = false;

  /// Mengatur nama font yang ada di google
  static String? fontName;

  /// Mengatur gaya teks [default]
  static MPTextStyle? textStyle = MPTextStyle(
    minLines: 1,
    textOverflow: TextOverflow.clip,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: colorText,
    fontStyle: FontStyle.normal,
  );

  /// Mengatur radius tombol [default]
  static double buttonRadius = 20;

  /// Mengatur border textfield [default]
  static MPTextFieldBorder border = MPTextFieldBorder(
    border: MPTextFieldBorderProperty(
        type: MPTextFieldBorderType.OUTLINE,
        sideColor: colorBrand,
        sideWidth: 1,
        radiusAll: buttonRadius),
    enableBorder: MPTextFieldBorderProperty(
        type: MPTextFieldBorderType.OUTLINE,
        sideColor: colorBrand,
        sideWidth: 1,
        radiusAll: buttonRadius),
    disableBorder: MPTextFieldBorderProperty(
        type: MPTextFieldBorderType.OUTLINE,
        sideColor: colorDisable,
        sideWidth: 1,
        radiusAll: buttonRadius),
    focusedBorder: MPTextFieldBorderProperty(
        type: MPTextFieldBorderType.OUTLINE,
        sideColor: colorBrand,
        sideWidth: 1,
        radiusAll: buttonRadius),
    errorBorder: MPTextFieldBorderProperty(
        type: MPTextFieldBorderType.OUTLINE,
        sideColor: colorError,
        sideWidth: 1,
        radiusAll: buttonRadius),
    focusedErrorBorder: MPTextFieldBorderProperty(
        type: MPTextFieldBorderType.OUTLINE,
        sideColor: colorError,
        sideWidth: 2,
        radiusAll: buttonRadius),
  );

  /// Layout Builder - Optimized breakpoints for better responsive design
  static double limitSmallMediumScreen = 600;
  static double limitMediumLargeScreen = 1024;

  /// Dialog
  static Widget iconSuccess = Image.asset(
    "assets/checked.png",
    width: 48,
    height: 48,
    package: 'micropack_ui_kit',
  );
  static Widget iconFailed = Image.asset(
    "assets/cancel.png",
    width: 48,
    height: 48,
    package: 'micropack_ui_kit',
  );
  static Widget iconWarning = Image.asset(
    "assets/warning.png",
    width: 48,
    height: 48,
    package: 'micropack_ui_kit',
  );

  static void initScreen(BuildContext context) {
    ScreenUtil.init(context, designSize: MediaQuery.of(context).size);
  }
}
