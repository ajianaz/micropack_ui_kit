import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// A tooltip component with theme support and customizable styling.
///
/// This wraps Flutter's Tooltip with Micropack UI Kit's theme system.
///
/// Example:
/// ```dart
/// MPTooltip(
///   message: 'This is a helpful tooltip',
///   child: Icon(Icons.info),
/// )
/// ```
class MPTooltip extends StatelessWidget {
  /// Creates a new [MPTooltip] widget.
  const MPTooltip({
    super.key,
    required this.message,
    required this.child,
    this.variant = MPTooltipVariant.primary,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.waitDuration,
    this.showDuration,
    this.triggerMode,
    this.enableFeedback,
    this.onTriggered,
    this.textStyle,
    this.decoration,
    this.textStyleResolver,
  });

  /// The text to display in the tooltip.
  final String message;

  /// The widget below this widget in the tree.
  final Widget child;

  /// The visual style variant of the tooltip.
  final MPTooltipVariant variant;

  /// The height of the tooltip's child.
  ///
  /// If null, uses default tooltip height.
  final double? height;

  /// The padding of the tooltip's child.
  final EdgeInsets? padding;

  /// The empty space that surrounds the tooltip.
  final EdgeInsets? margin;

  /// The vertical gap between the widget and the displayed tooltip.
  final double? verticalOffset;

  /// Whether the tooltip defaults to being displayed below the widget.
  ///
  /// Defaults to false.
  final bool? preferBelow;

  /// Whether to exclude the tooltip message from the semantics tree.
  final bool? excludeFromSemantics;

  /// The length of time that a pointer must hover over the tooltip's widget
  /// before the tooltip is shown.
  final Duration? waitDuration;

  /// The length of time that the tooltip will remain visible after being shown.
  final Duration? showDuration;

  /// The trigger mode for showing the tooltip.
  final TooltipTriggerMode? triggerMode;

  /// Whether the tooltip should provide feedback (e.g., sound/vibration).
  final bool? enableFeedback;

  /// Called when the tooltip is triggered.
  final VoidCallback? onTriggered;

  /// Custom text style for the tooltip message.
  final TextStyle? textStyle;

  /// Custom decoration for the tooltip.
  final BoxDecoration? decoration;

  /// Optional function to resolve text style based on variant.
  final TextStyle? Function(BuildContext, MPTooltipVariant)? textStyleResolver;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      height: height,
      padding: padding ?? _getPadding(context),
      margin: margin,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
      excludeFromSemantics: excludeFromSemantics,
      waitDuration: waitDuration ?? const Duration(milliseconds: 500),
      showDuration: showDuration ?? const Duration(milliseconds: 1500),
      triggerMode: triggerMode ?? TooltipTriggerMode.longPress,
      enableFeedback: enableFeedback ?? true,
      onTriggered: onTriggered,
      decoration: decoration ?? _getDecoration(context),
      textStyle: textStyle ?? _getTextStyle(context),
      child: child,
    );
  }

  EdgeInsets _getPadding(BuildContext context) {
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  }

  BoxDecoration _getDecoration(BuildContext context) {
    return BoxDecoration(
      color: _getBackgroundColor(context),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: _getBorderColor(context),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: context.mp.adaptiveShadowColor,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (textStyleResolver != null) {
      return textStyleResolver!(context, variant) ??
          TextStyle(
            color: _getTextColor(context),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          );
    }

    return TextStyle(
      color: _getTextColor(context),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (variant) {
      case MPTooltipVariant.primary:
        return context.mp.primary;
      case MPTooltipVariant.secondary:
        return context.mp.isDarkMode
            ? const Color(0xFF374151)
            : const Color(0xFF1F2937);
      case MPTooltipVariant.success:
        return context.mp.successColor;
      case MPTooltipVariant.warning:
        return context.mp.warningColor;
      case MPTooltipVariant.error:
        return context.mp.errorColor;
      case MPTooltipVariant.info:
        return context.mp.infoColor;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (variant) {
      case MPTooltipVariant.primary:
      case MPTooltipVariant.secondary:
      case MPTooltipVariant.error:
        return Colors.white;
      case MPTooltipVariant.success:
      case MPTooltipVariant.warning:
      case MPTooltipVariant.info:
        return Colors.white;
    }
  }

  Color _getBorderColor(BuildContext context) {
    switch (variant) {
      case MPTooltipVariant.primary:
        return context.mp.primary;
      case MPTooltipVariant.secondary:
        return context.mp.isDarkMode
            ? const Color(0xFF4B5563)
            : const Color(0xFF374151);
      case MPTooltipVariant.success:
        return context.mp.successColor;
      case MPTooltipVariant.warning:
        return context.mp.warningColor;
      case MPTooltipVariant.error:
        return context.mp.errorColor;
      case MPTooltipVariant.info:
        return context.mp.infoColor;
    }
  }
}

/// Visual style variants for MPTooltip
enum MPTooltipVariant {
  /// Primary brand color
  primary,

  /// Secondary/dark color
  secondary,

  /// Success color (green)
  success,

  /// Warning color (orange/amber)
  warning,

  /// Error color (red)
  error,

  /// Info color (blue)
  info,
}
