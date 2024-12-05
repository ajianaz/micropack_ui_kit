import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/mp_ui_kit_settings.dart';

enum MPTextFieldBorderType { NONE, UNDERLINE, OUTLINE }

class MPTextFieldBorder {
  final MPTextFieldBorderProperty? border;
  final MPTextFieldBorderProperty? enableBorder;
  final MPTextFieldBorderProperty? disableBorder;
  final MPTextFieldBorderProperty? focusedBorder;
  final MPTextFieldBorderProperty? errorBorder;
  final MPTextFieldBorderProperty? focusedErrorBorder;

  MPTextFieldBorder({
    this.border,
    this.enableBorder,
    this.disableBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
  });

  MPTextFieldBorder copyWith({
    MPTextFieldBorderProperty? border,
    MPTextFieldBorderProperty? enableBorder,
    MPTextFieldBorderProperty? disableBorder,
    MPTextFieldBorderProperty? focusedBorder,
    MPTextFieldBorderProperty? errorBorder,
    MPTextFieldBorderProperty? focusedErrorBorder,
  }) {
    return MPTextFieldBorder(
      border: border ?? this.border,
      enableBorder: enableBorder ?? this.enableBorder,
      disableBorder: disableBorder ?? this.disableBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      errorBorder: errorBorder ?? this.errorBorder,
      focusedErrorBorder: focusedErrorBorder ?? this.focusedErrorBorder,
    );
  }
}

class MPTextFieldBorderProperty {
  final MPTextFieldBorderType type;

  final Color? sideColor;
  final double? sideWidth;
  final double? radiusAll;
  final double? radiusTopLeft;
  final double? radiusTopRight;
  final double? radiusBottomLeft;
  final double? radiusBottomRight;

  MPTextFieldBorderProperty(
      {this.type = MPTextFieldBorderType.NONE,
      this.sideColor,
      this.sideWidth,
      this.radiusAll,
      this.radiusTopLeft,
      this.radiusTopRight,
      this.radiusBottomLeft,
      this.radiusBottomRight});

  MPTextFieldBorderProperty copyWith({
    MPTextFieldBorderType? type,
    Color? sideColor,
    double? sideWidth,
    double? radiusAll,
    double? radiusTopLeft,
    double? radiusTopRight,
    double? radiusBottomLeft,
    double? radiusBottomRight,
  }) {
    return MPTextFieldBorderProperty(
      type: type ?? this.type,
      sideColor: sideColor ?? this.sideColor,
      sideWidth: sideWidth ?? this.sideWidth,
      radiusAll: radiusAll ?? this.radiusAll,
      radiusTopLeft: radiusTopLeft ?? this.radiusTopLeft,
      radiusTopRight: radiusTopRight ?? this.radiusTopRight,
      radiusBottomLeft: radiusBottomLeft ?? this.radiusBottomLeft,
      radiusBottomRight: radiusBottomRight ?? this.radiusBottomRight,
    );
  }
}

extension MPTextFieldBorderPropertyExtension on MPTextFieldBorderProperty {
  InputBorder toBorder() {
    BorderSide borderSide = BorderSide(
        color: sideColor ?? MpUiKit.colorBrand, width: sideWidth ?? 1);

    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(radiusAll ?? radiusTopLeft ?? 0),
      topRight: Radius.circular(radiusAll ?? radiusTopRight ?? 0),
      bottomLeft: Radius.circular(radiusAll ?? radiusBottomLeft ?? 0),
      bottomRight: Radius.circular(radiusAll ?? radiusBottomRight ?? 0),
    );

    if (type == MPTextFieldBorderType.UNDERLINE) {
      return UnderlineInputBorder(
          borderSide: borderSide, borderRadius: borderRadius);
    }
    if (type == MPTextFieldBorderType.OUTLINE) {
      return OutlineInputBorder(
          borderSide: borderSide, borderRadius: borderRadius);
    }

    return InputBorder.none;
  }
}
