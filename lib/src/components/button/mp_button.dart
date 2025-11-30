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

  /// Mengatur gaya teks. Jika child tidak null maka textStyle diabaikan.
  /// Jika textStyle tidak null maka textColor, textSize, fontWeight diabaikan.
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
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_getBackgroundColor()),
        foregroundColor:
            WidgetStateProperty.all(widget.textColor ?? _getTextColor()),
        padding: WidgetStateProperty.all(widget.padding ?? _getPadding()),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: widget.borderRadius ??
                BorderRadius.circular(widget.radius ?? 8),
            side: _getBorderSide(),
          ),
        ),
        elevation: WidgetStateProperty.all(widget.elevation ??
            (widget.variant == MPButtonVariant.primary ? 4 : 0)),
        shadowColor: WidgetStateProperty.all(widget.shadowColor),
        splashFactory:
            widget.splashColor != null ? InkSplash.splashFactory : null,
        animationDuration: widget.animationDuration,
        minimumSize: WidgetStateProperty.all(widget.minimumSize),
        maximumSize: WidgetStateProperty.all(widget.maximumSize),
        // Theme-aware state colors
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return context.mp.disabledColor;
          }
          if (states.contains(WidgetState.hovered)) {
            return _getHoverColor();
          }
          if (states.contains(WidgetState.pressed)) {
            return _getPressedColor();
          }
          if (states.contains(WidgetState.focused)) {
            return _getFocusColor();
          }
          return null;
        }),
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

  /// Builds loading content with theme-aware spinner color
  /// Uses the appropriate text color for the spinner based on button variant
  Widget _buildLoadingContent() {
    if (widget.loadingWidget != null) {
      return widget.loadingWidget!;
    }

    return SizedBox(
      height: _getLoadingSize(),
      width: _getLoadingSize(),
      child: Center(
        child: SpinKitThreeBounce(
          color: widget.textColor ?? _getTextColor(),
          size: _getLoadingSize() * 0.6,
        ),
      ),
    );
  }

  /// Gets theme-aware background color based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary: uses theme primary color
  /// - outlined/ghost/text: transparent background
  /// - danger/success/warning/info: uses respective theme colors
  Color _getBackgroundColor() {
    switch (widget.variant) {
      case MPButtonVariant.primary:
        return widget.background ?? context.mp.primary;
      case MPButtonVariant.outlined:
        return Colors.transparent;
      case MPButtonVariant.ghost:
        return Colors.transparent;
      case MPButtonVariant.text:
        return Colors.transparent;
      case MPButtonVariant.danger:
        return widget.background ?? context.mp.errorColor;
      case MPButtonVariant.success:
        return widget.background ?? context.mp.successColor;
      case MPButtonVariant.warning:
        return widget.background ?? context.mp.warningColor;
      case MPButtonVariant.info:
        return widget.background ?? context.mp.infoColor;
    }
  }

  /// Gets theme-aware border side based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary/danger/success/warning/info: uses primaryBorder or respective color borders
  /// - outlined/ghost: uses primary color for border
  /// - text: transparent border
  BorderSide _getBorderSide() {
    if (widget.variant == MPButtonVariant.primary ||
        widget.variant == MPButtonVariant.danger ||
        widget.variant == MPButtonVariant.success ||
        widget.variant == MPButtonVariant.warning ||
        widget.variant == MPButtonVariant.info) {
      return widget.strokeWidth == 0
          ? BorderSide.none
          : BorderSide(
              color: widget.strokeColor ?? context.mp.primaryBorder,
              width: widget.strokeWidth ?? 1.5,
            );
    } else {
      Color borderColor;
      switch (widget.variant) {
        case MPButtonVariant.primary:
          borderColor = widget.strokeColor ?? context.mp.primaryBorder;
          break;
        case MPButtonVariant.outlined:
          borderColor = widget.strokeColor ?? context.mp.primary;
          break;
        case MPButtonVariant.ghost:
          borderColor = widget.strokeColor ?? context.mp.primary;
          break;
        case MPButtonVariant.text:
          borderColor = Colors.transparent;
          break;
        case MPButtonVariant.danger:
          borderColor = widget.strokeColor ?? context.mp.errorColor;
          break;
        case MPButtonVariant.success:
          borderColor = widget.strokeColor ?? context.mp.successColor;
          break;
        case MPButtonVariant.warning:
          borderColor = widget.strokeColor ?? context.mp.warningColor;
          break;
        case MPButtonVariant.info:
          borderColor = widget.strokeColor ?? context.mp.infoColor;
          break;
      }

      return BorderSide(
        color: borderColor,
        width: widget.strokeWidth ?? 1.5,
      );
    }
  }

  /// Gets theme-aware text color based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary/danger/success/warning/info: uses neutral100 (light text on colored background)
  /// - outlined/ghost/text: uses primary color for transparent buttons
  Color _getTextColor() {
    if (widget.textColor != null) return widget.textColor!;

    switch (widget.variant) {
      case MPButtonVariant.primary:
      case MPButtonVariant.danger:
      case MPButtonVariant.success:
      case MPButtonVariant.warning:
      case MPButtonVariant.info:
        return context.mp.neutral100; // Light text on colored background
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        return context.mp.primary; // Primary color for transparent buttons
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
        widget.text ?? '',
        style: widget.textStyle,
        color: widget.textColor,
        fontSize: widget.textSize,
        fontWeight: widget.fontWeight,
      );

      switch (widget.iconPosition) {
        case MPButtonIconPosition.left:
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [icon, const SizedBox(width: 8), text],
          );
        case MPButtonIconPosition.right:
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [text, const SizedBox(width: 8), icon],
          );
        case MPButtonIconPosition.top:
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [icon, const SizedBox(height: 4), text],
          );
        case MPButtonIconPosition.bottom:
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [text, const SizedBox(height: 4), icon],
          );
      }
    }

    // Default text only
    return MPText(
      widget.text ?? '',
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

  /// Gets theme-aware icon color based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary/danger/success/warning/info: uses neutral100 (light icon on colored background)
  /// - outlined/ghost/text: uses primary color for transparent buttons
  Color _getIconColor() {
    if (widget.iconColor != null) return widget.iconColor!;

    switch (widget.variant) {
      case MPButtonVariant.primary:
      case MPButtonVariant.danger:
      case MPButtonVariant.success:
      case MPButtonVariant.warning:
      case MPButtonVariant.info:
        return context.mp.neutral100; // Light icon on colored background
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        return widget.textColor ??
            context.mp.primary; // Primary color for transparent buttons
    }
  }

  /// Gets padding based on button size
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

  /// Gets loading spinner size based on button size
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

  /// Gets theme-aware hover color based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary: uses primaryHover
  /// - danger/success/warning/info: uses respective color with 0.8 opacity
  /// - outlined/ghost/text: uses primaryHover with 0.1 opacity
  Color _getHoverColor() {
    switch (widget.variant) {
      case MPButtonVariant.primary:
        return context.mp.primaryHover;
      case MPButtonVariant.danger:
        return context.mp.errorColor.withValues(alpha: 0.8);
      case MPButtonVariant.success:
        return context.mp.successColor.withValues(alpha: 0.8);
      case MPButtonVariant.warning:
        return context.mp.warningColor.withValues(alpha: 0.8);
      case MPButtonVariant.info:
        return context.mp.infoColor.withValues(alpha: 0.8);
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        return context.mp.primaryHover.withValues(alpha: 0.1);
    }
  }

  /// Gets theme-aware pressed color based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary: uses primaryPressed
  /// - danger/success/warning/info: uses respective color with 0.6 opacity
  /// - outlined/ghost/text: uses primaryPressed with 0.2 opacity
  Color _getPressedColor() {
    switch (widget.variant) {
      case MPButtonVariant.primary:
        return context.mp.primaryPressed;
      case MPButtonVariant.danger:
        return context.mp.errorColor.withValues(alpha: 0.6);
      case MPButtonVariant.success:
        return context.mp.successColor.withValues(alpha: 0.6);
      case MPButtonVariant.warning:
        return context.mp.warningColor.withValues(alpha: 0.6);
      case MPButtonVariant.info:
        return context.mp.infoColor.withValues(alpha: 0.6);
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        return context.mp.primaryPressed.withValues(alpha: 0.2);
    }
  }

  /// Gets theme-aware focus color based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary: uses primaryFocus
  /// - danger/success/warning/info: uses respective color with 0.3 opacity
  /// - outlined/ghost/text: uses primaryFocus with 0.1 opacity
  Color _getFocusColor() {
    switch (widget.variant) {
      case MPButtonVariant.primary:
        return context.mp.primaryFocus;
      case MPButtonVariant.danger:
        return context.mp.errorColor.withValues(alpha: 0.3);
      case MPButtonVariant.success:
        return context.mp.successColor.withValues(alpha: 0.3);
      case MPButtonVariant.warning:
        return context.mp.warningColor.withValues(alpha: 0.3);
      case MPButtonVariant.info:
        return context.mp.infoColor.withValues(alpha: 0.3);
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        return context.mp.primaryFocus.withValues(alpha: 0.1);
    }
  }
}
