// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MPButton extends StatefulWidget {
  const MPButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.size = MPButtonSize.small,
    this.variant = MPButtonVariant.primary,
    this.enabled = true,
    this.background,
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
    this.loading = false,
    this.loadingWidget,
  });

  final String? text;

  final void Function()? onPressed;

  final MPButtonSize size;

  final MPButtonVariant variant;

  final bool enabled;

  final Color? background;

  final EdgeInsets? padding;

  final double? radius;

  final double? strokeWidth;

  final Color? strokeColor;

  final bool? widthInfinity;

  final Widget? child;

  /// Mengatur gaya teks. Jika [child] != null maka [textStyle] diabaikan.
  /// Jika [textStyle] != null maka [textColor],[textSize],[fontWeight],[fontFamily] diabaikan.
  final TextStyle? textStyle;

  /// Mengatur warna dari teks.
  /// Jika [child] != null atau [textStyle] != null maka [textColor] diabaikan
  final Color? textColor;

  /// Mengatur ukuran font.
  /// Jika [child] != null atau [textStyle] != null maka [textSize] diabaikan
  final double? textSize;

  /// Mengatur ketebalan font.
  /// Jika [child] != null atau [textStyle] != null maka [fontWeight] diabaikan
  final FontWeight? fontWeight;

  /// Loading state
  final bool loading;

  /// Custom loading widget
  final Widget? loadingWidget;

  @override
  State<MPButton> createState() => _MPButtonState();
}

class _MPButtonState extends State<MPButton> {
  @override
  Widget build(BuildContext context) {
    final buttonContent = widget.loading
        ? _buildLoadingContent()
        : (widget.child ?? _defaultText());

    return ElevatedButton(
      onPressed: widget.loading ? null : (widget.enabled ? widget.onPressed : null),
      style: ElevatedButton.styleFrom(
        backgroundColor: _getBackgroundColor(),
        foregroundColor: widget.textColor ?? MpUiKit.colorBrand2,
        padding: widget.padding ?? _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? MpUiKit.buttonRadius),
          side: _getBorderSide(),
        ),
        elevation: widget.variant == MPButtonVariant.primary ? 4 : 0,
      ),
      child: (widget.widthInfinity ?? false)
          ? Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: buttonContent,
            )
          : buttonContent,
    );
  }

  Widget _buildLoadingContent() {
    if (widget.loadingWidget != null) {
      return widget.loadingWidget!;
    }

    return SizedBox(
      height: _getLoadingSize(),
      width: _getLoadingSize(),
      child: Center(
        child: SpinKitThreeBounce(
          color: widget.textColor ?? MpUiKit.colorBrand2,
          size: _getLoadingSize() * 0.6,
        ),
      ),
    );
  }

  Widget _defaultText() => MPText(
        widget.text ?? "",
        style: widget.textStyle,
        color: widget.textColor,
        fontSize: widget.textSize,
        fontWeight: widget.fontWeight,
      );

  Color _getBackgroundColor() {
    switch (widget.variant) {
      case MPButtonVariant.primary:
        return widget.background ?? MpUiKit.colorBrand;
      case MPButtonVariant.outlined:
        return Colors.transparent;
      case MPButtonVariant.ghost:
        return Colors.transparent;
    }
  }

  BorderSide _getBorderSide() {
    if (widget.variant == MPButtonVariant.primary) {
      return widget.strokeWidth == 0
          ? BorderSide.none
          : BorderSide(
              color: widget.strokeColor ?? MpUiKit.colorStroke,
              width: widget.strokeWidth ?? 1.5,
            );
    } else {
      return BorderSide(
        color: widget.strokeColor ?? MpUiKit.colorBrand,
        width: widget.strokeWidth ?? 1.5,
      );
    }
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case MPButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case MPButtonSize.regular:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case MPButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
      case MPButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 40, vertical: 20);
    }
  }

  double _getLoadingSize() {
    switch (widget.size) {
      case MPButtonSize.small:
        return 16;
      case MPButtonSize.regular:
        return 20;
      case MPButtonSize.medium:
        return 24;
      case MPButtonSize.large:
        return 28;
    }
  }
}
