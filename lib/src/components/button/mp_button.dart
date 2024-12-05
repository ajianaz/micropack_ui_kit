import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/mp_ui_kit_settings.dart';

class MPButton extends StatelessWidget {
  const MPButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.size = MPButtonSize.small,
    this.variant = MPButtonVariant.primary,
    this.enabled = true,
    this.background,
    this.foreground,
    this.padding,
    this.radius,
    this.strokeWidth = 0,
    this.strokeColor,
    this.widthInfinity = false,
    this.child,
    this.textStyle,
    this.textColor = Colors.white,
    this.textSize,
    this.fontWeight,
  });

  final String? text;

  final void Function()? onPressed;

  final MPButtonSize size;

  final MPButtonVariant variant;

  final bool enabled;

  final Color? background;

  final Color? foreground;

  final EdgeInsets? padding;

  final double? radius;

  final double? strokeWidth;

  final Color? strokeColor;

  final bool? widthInfinity;

  final Widget? child;

  /// Mengatur gaya teks. Jika [child] != null maka [textStyle] diabaikan.
  /// Jika [textStyle] != null maka [textColor],[textSize],[fontWeight],[fontFamily] diabaikan.
  final MPTextStyle? textStyle;

  /// Mengatur warna dari teks.
  /// Jika [child] != null atau [textStyle] != null maka [textColor] diabaikan
  final Color? textColor;

  /// Mengatur ukuran font.
  /// Jika [child] != null atau [textStyle] != null maka [textSize] diabaikan
  final double? textSize;

  /// Mengatur ketebalan font.
  /// Jika [child] != null atau [textStyle] != null maka [fontWeight] diabaikan
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background ?? MpUiKit.colorBrand,
          foregroundColor: foreground ?? MpUiKit.colorBrand2,
          padding: padding ?? const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? MpUiKit.buttonRadius),
            side: strokeWidth == 0
                ? BorderSide.none
                : BorderSide(
                    color: strokeColor ?? MpUiKit.colorStroke,
                    width: strokeWidth ?? 1.5,
                  ),
          ),
        ),
        child: widthInfinity == true
            ? Container(
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: child ?? _defaultText(),
                ))
            : (child ?? _defaultText()));
  }

  Widget _defaultText() => MPText(
        text ?? "",
        style: textStyle,
        color: textColor,
        fontSize: textSize,
        fontWeight: fontWeight,
      );
}
