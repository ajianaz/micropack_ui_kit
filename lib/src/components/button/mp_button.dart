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
    this.icon,
    this.iconPosition = MPButtonIconPosition.left,
    this.iconSize,
    this.iconColor,
    this.shadowColor,
    this.elevation,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.onLongPress,
    this.onHover,
    this.semanticLabel,
    this.animationDuration,
    this.borderRadius,
    this.minimumSize,
    this.maximumSize,
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

  /// Button icon
  final IconData? icon;

  /// Icon position relative to text
  final MPButtonIconPosition iconPosition;

  /// Icon size
  final double? iconSize;

  /// Icon color
  final Color? iconColor;

  /// Shadow color
  final Color? shadowColor;

  /// Button elevation
  final double? elevation;

  /// Hover color
  final Color? hoverColor;

  /// Splash color
  final Color? splashColor;

  /// Focus node
  final FocusNode? focusNode;

  /// Long press callback
  final VoidCallback? onLongPress;

  /// Hover callback
  final ValueChanged<bool>? onHover;

  /// Semantic label for accessibility
  final String? semanticLabel;

  /// Animation duration
  final Duration? animationDuration;

  /// Border radius
  final BorderRadius? borderRadius;

  /// Minimum size
  final Size? minimumSize;

  /// Maximum size
  final Size? maximumSize;

  @override
  State<MPButton> createState() => _MPButtonState();
}

class _MPButtonState extends State<MPButton> {
  @override
  Widget build(BuildContext context) {
    final buttonContent = widget.loading
        ? _buildLoadingContent()
        : (widget.child ?? _buildButtonContent());

    return ElevatedButton(
      onPressed:
          widget.loading ? null : (widget.enabled ? widget.onPressed : null),
      style: ElevatedButton.styleFrom(
        backgroundColor: _getBackgroundColor(),
        foregroundColor: widget.textColor ?? _getTextColor(),
        padding: widget.padding ?? _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ??
              BorderRadius.circular(widget.radius ?? MpUiKit.buttonRadius),
          side: _getBorderSide(),
        ),
        elevation: widget.elevation ??
            (widget.variant == MPButtonVariant.primary ? 4 : 0),
        shadowColor: widget.shadowColor,
        splashFactory:
            widget.splashColor != null ? InkSplash.splashFactory : null,
        animationDuration: widget.animationDuration,
        minimumSize: widget.minimumSize,
        maximumSize: widget.maximumSize,
      ),
      focusNode: widget.focusNode,
      onLongPress: widget.onLongPress,
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
      case MPButtonVariant.text:
        return Colors.transparent;
      case MPButtonVariant.danger:
        return widget.background ?? Colors.red;
      case MPButtonVariant.success:
        return widget.background ?? Colors.green;
      case MPButtonVariant.warning:
        return widget.background ?? Colors.orange;
      case MPButtonVariant.info:
        return widget.background ?? Colors.blue;
    }
  }

  BorderSide _getBorderSide() {
    if (widget.variant == MPButtonVariant.primary ||
        widget.variant == MPButtonVariant.danger ||
        widget.variant == MPButtonVariant.success ||
        widget.variant == MPButtonVariant.warning ||
        widget.variant == MPButtonVariant.info) {
      return widget.strokeWidth == 0
          ? BorderSide.none
          : BorderSide(
              color: widget.strokeColor ?? MpUiKit.colorStroke,
              width: widget.strokeWidth ?? 1.5,
            );
    } else {
      Color borderColor;
      switch (widget.variant) {
        case MPButtonVariant.outlined:
          borderColor = widget.strokeColor ?? MpUiKit.colorBrand;
          break;
        case MPButtonVariant.ghost:
          borderColor = widget.strokeColor ?? MpUiKit.colorBrand;
          break;
        case MPButtonVariant.text:
          borderColor = Colors.transparent;
          break;
        case MPButtonVariant.danger:
          borderColor = widget.strokeColor ?? Colors.red;
          break;
        case MPButtonVariant.success:
          borderColor = widget.strokeColor ?? Colors.green;
          break;
        case MPButtonVariant.warning:
          borderColor = widget.strokeColor ?? Colors.orange;
          break;
        case MPButtonVariant.info:
          borderColor = widget.strokeColor ?? Colors.blue;
          break;
        default:
          borderColor = widget.strokeColor ?? MpUiKit.colorBrand;
          break;
      }

      return BorderSide(
        color: borderColor,
        width: widget.strokeWidth ?? 1.5,
      );
    }
  }

  Color _getTextColor() {
    if (widget.textColor != null) return widget.textColor!;

    switch (widget.variant) {
      case MPButtonVariant.primary:
      case MPButtonVariant.danger:
      case MPButtonVariant.success:
      case MPButtonVariant.warning:
      case MPButtonVariant.info:
        return Colors.white;
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
        return MpUiKit.colorBrand;
      case MPButtonVariant.text:
        return MpUiKit.colorBrand;
    }
  }

  Widget _buildButtonContent() {
    // If custom child is provided, use it
    if (widget.child != null) {
      return widget.child!;
    }

    // Build text with icon if provided
    if (widget.icon != null) {
      final icon = Icon(
        widget.icon,
        size: widget.iconSize ?? _getIconSize(),
        color: widget.iconColor ?? _getIconColor(),
      );

      final text = MPText(
        widget.text ?? "",
        style: widget.textStyle,
        color: widget.textColor,
        fontSize: widget.textSize,
        fontWeight: widget.fontWeight,
      );

      switch (widget.iconPosition) {
        case MPButtonIconPosition.left:
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              SizedBox(width: 8),
              text,
            ],
          );
        case MPButtonIconPosition.right:
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              text,
              SizedBox(width: 8),
              icon,
            ],
          );
        case MPButtonIconPosition.top:
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              SizedBox(height: 4),
              text,
            ],
          );
        case MPButtonIconPosition.bottom:
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              text,
              SizedBox(height: 4),
              icon,
            ],
          );
      }
    }

    // Default text only
    return MPText(
      widget.text ?? "",
      style: widget.textStyle,
      color: widget.textColor,
      fontSize: widget.textSize,
      fontWeight: widget.fontWeight,
    );
  }

  double _getIconSize() {
    switch (widget.size) {
      case MPButtonSize.small:
        return 16;
      case MPButtonSize.regular:
        return 18;
      case MPButtonSize.medium:
        return 20;
      case MPButtonSize.large:
        return 22;
    }
  }

  Color _getIconColor() {
    if (widget.iconColor != null) return widget.iconColor!;

    switch (widget.variant) {
      case MPButtonVariant.primary:
      case MPButtonVariant.danger:
      case MPButtonVariant.success:
      case MPButtonVariant.warning:
      case MPButtonVariant.info:
        return Colors.white;
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
        return MpUiKit.colorBrand;
      case MPButtonVariant.text:
        return widget.textColor ?? MpUiKit.colorBrand;
    }
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case MPButtonSize.small:
        return widget.padding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case MPButtonSize.regular:
        return widget.padding ??
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case MPButtonSize.medium:
        return widget.padding ??
            const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
      case MPButtonSize.large:
        return widget.padding ??
            const EdgeInsets.symmetric(horizontal: 40, vertical: 20);
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
