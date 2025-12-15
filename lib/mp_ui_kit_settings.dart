// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MpUiKit {
  static void init({
    /// [REQUIRED] Sets the main color
    required Color colorBrand,

    /// [REQUIRED] Sets the secondary color
    required Color colorBrand2,

    /// Sets border color, used for border color in MPButton
    Color? colorStroke,

    /// Sets text color for MPText
    Color? colorText,

    /// Sets disable color, such as used for MPButton disable
    Color? colorDisable,

    /// Sets error color
    Color? colorError,

    /// Sets font name available in Google
    String? fontName,

    /// Sets default style for MPText
    MPTextStyle? textStyle,

    /// Sets radius for MPButton or MPTextField
    double? buttonBorderRadius,

    /// Sets ScreenUtil usage. If true then fontSize will be converted to .sp
    /// Changed default to true for better responsive design
    bool useScreenUtil = true,

    /// Sets boundary. width < limit = Small and width > limit = Medium
    double? limitSmallMediumScreen,

    /// Sets boundary. width < limit = Medium and width > limit = Large
    double? limitMediumLargeScreen,

    /// Sets Success dialog icon when EnumIconDialogType.success
    Widget? iconSuccess,

    /// Sets Failed dialog icon when EnumIconDialogType.failed
    Widget? iconFailed,

    /// Sets Warning dialog icon when EnumIconDialogType.warning
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

  /// Sets Brand color
  static Color colorBrand = Color(0xFF4086EF);

  /// Sets Brand2 (Secondary) color
  static Color colorBrand2 = Color(0xFFFFFFFF);

  /// Sets Stroke color
  static Color colorStroke = colorBrand;

  /// Sets Text color
  static Color colorText = Color(0xFF2F2F2F);

  /// Sets Disable color
  static Color colorDisable = Color(0xFFA9A9A9);

  /// Sets Error color
  static Color colorError = Color(0xFFFF0000);

  /// Sets Screen Util usage (default : false)
  static bool useScreenUtil = false;

  /// Sets font name available in Google
  static String? fontName;

  /// Sets text style [default]
  /// Note: The color property will be overridden by theme-aware colors in components
  /// This ensures proper dark mode support
  static MPTextStyle? textStyle = MPTextStyle(
    minLines: 1,
    textOverflow: TextOverflow.clip,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: colorText, // This will be overridden by theme-aware colors
    fontStyle: FontStyle.normal,
  );

  /// Sets button radius [default]
  static double buttonRadius = 20;

  /// Sets textfield border [default]
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


}
