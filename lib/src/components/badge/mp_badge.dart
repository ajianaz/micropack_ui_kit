import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_badge_enums.dart';

/// A badge component for displaying status indicators, counts, or labels.
///
/// This component provides a flexible badge with multiple variants,
/// sizes, and theme support.
///
/// Example:
/// ```dart
/// MPBadge(
///   label: 'New',
///   variant: MPBadgeVariant.primary,
/// )
/// ```
class MPBadge extends StatelessWidget {
  /// Creates a new [MPBadge] widget.
  const MPBadge({
    super.key,
    required this.label,
    this.variant = MPBadgeVariant.primary,
    this.size = MPBadgeSize.medium,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.semanticLabel,
  });

  /// The text or widget to display as the badge label.
  final String label;

  /// The visual style variant of the badge.
  final MPBadgeVariant variant;

  /// The size of the badge.
  final MPBadgeSize size;

  /// Optional widget to display before the label.
  final Widget? leading;

  /// Optional widget to display after the label.
  final Widget? trailing;

  /// Whether the badge is enabled for interaction.
  final bool enabled;

  /// Custom background color.
  ///
  /// If null, uses theme color based on [variant].
  final Color? backgroundColor;

  /// Custom text color.
  ///
  /// If null, uses theme color based on [variant].
  final Color? textColor;

  /// Custom border color.
  ///
  /// If null, uses theme color based on [variant].
  final Color? borderColor;

  /// Custom border width.
  ///
  /// If null, uses default based on [variant].
  final double? borderWidth;

  /// Custom border radius.
  ///
  /// If null, uses default based on [size].
  final double? borderRadius;

  /// Custom padding.
  ///
  /// If null, uses default based on [size].
  final EdgeInsets? padding;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? label,
      container: true,
      child: _buildBadge(context),
    );
  }

  Widget _buildBadge(BuildContext context) {
    final config = _MPBadgeConfig();

    return Container(
      padding: padding ?? config.getPadding(size),
      decoration: BoxDecoration(
        color: backgroundColor ?? config.getBackgroundColor(variant, enabled, context),
        borderRadius: BorderRadius.circular(borderRadius ?? config.getBorderRadius(size)),
        border: borderColor != null || config.getShowBorder(variant)
            ? Border.all(
                color: borderColor ?? config.getBorderColor(variant, enabled, context),
                width: borderWidth ?? config.getBorderWidth(variant),
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            Transform.scale(
              scale: config.getIconScale(size),
              child: leading,
            ),
            SizedBox(width: config.getSpacing(size)),
          ],
          MPText(
            label,
            style: TextStyle(
              color: textColor ?? config.getTextColor(variant, enabled, context),
              fontWeight: config.getFontWeight(size),
              fontSize: config.getFontSize(size),
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: config.getSpacing(size)),
            Transform.scale(
              scale: config.getIconScale(size),
              child: trailing,
            ),
          ],
        ],
      ),
    );
  }
}

/// Configuration class for MPBadge
class _MPBadgeConfig {
  _MPBadgeConfig();

  // Size configurations
  static final Map<MPBadgeSize, double> fontSizes = {
    MPBadgeSize.small: 11,
    MPBadgeSize.medium: 12,
    MPBadgeSize.large: 14,
  };

  static final Map<MPBadgeSize, double> borderRadiuses = {
    MPBadgeSize.small: 4,
    MPBadgeSize.medium: 6,
    MPBadgeSize.large: 8,
  };

  static final Map<MPBadgeSize, double> iconScales = {
    MPBadgeSize.small: 0.8,
    MPBadgeSize.medium: 0.9,
    MPBadgeSize.large: 1.0,
  };

  static final Map<MPBadgeSize, EdgeInsets> paddings = {
    MPBadgeSize.small: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    MPBadgeSize.medium: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    MPBadgeSize.large: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  };

  static final Map<MPBadgeSize, double> spacing = {
    MPBadgeSize.small: 4,
    MPBadgeSize.medium: 6,
    MPBadgeSize.large: 8,
  };

  double getFontSize(MPBadgeSize size) => fontSizes[size]!;
  double getBorderRadius(MPBadgeSize size) => borderRadiuses[size]!;
  double getIconScale(MPBadgeSize size) => iconScales[size]!;
  EdgeInsets getPadding(MPBadgeSize size) => paddings[size]!;
  double getSpacing(MPBadgeSize size) => spacing[size]!;

  FontWeight getFontWeight(MPBadgeSize size) {
    switch (size) {
      case MPBadgeSize.small:
      case MPBadgeSize.medium:
        return FontWeight.w500;
      case MPBadgeSize.large:
        return FontWeight.w600;
    }
  }

  // Variant configurations
  Color getBackgroundColor(MPBadgeVariant variant, bool enabled, BuildContext context) {
    if (!enabled) return context.mp.disabledColor;

    switch (variant) {
      case MPBadgeVariant.primary:
        return context.mp.primary;
      case MPBadgeVariant.secondary:
        return context.mp.isDarkMode
            ? const Color(0xFF374151)
            : const Color(0xFFF3F4F6);
      case MPBadgeVariant.success:
        return context.mp.successColor;
      case MPBadgeVariant.warning:
        return context.mp.warningColor;
      case MPBadgeVariant.error:
        return context.mp.errorColor;
      case MPBadgeVariant.info:
        return context.mp.infoColor;
      case MPBadgeVariant.outlined:
        return Colors.transparent;
      case MPBadgeVariant.filled:
        return context.mp.isDarkMode
            ? const Color(0xFFD1D5DB)
            : const Color(0xFF374151);
    }
  }

  Color getTextColor(MPBadgeVariant variant, bool enabled, BuildContext context) {
    if (!enabled) {
      return context.mp.disabledColor.withValues(alpha: 0.7);
    }

    switch (variant) {
      case MPBadgeVariant.primary:
      case MPBadgeVariant.success:
      case MPBadgeVariant.warning:
      case MPBadgeVariant.error:
      case MPBadgeVariant.info:
        return Colors.white;
      case MPBadgeVariant.secondary:
        return context.mp.textColor;
      case MPBadgeVariant.outlined:
        return context.mp.primary;
      case MPBadgeVariant.filled:
        return context.mp.isDarkMode
            ? const Color(0xFF374151)
            : Colors.white;
    }
  }

  Color getBorderColor(MPBadgeVariant variant, bool enabled, BuildContext context) {
    if (!enabled) {
      return context.mp.disabledColor.withValues(alpha: 0.3);
    }

    switch (variant) {
      case MPBadgeVariant.primary:
        return context.mp.primary;
      case MPBadgeVariant.secondary:
        return context.mp.borderColor;
      case MPBadgeVariant.success:
        return context.mp.successColor;
      case MPBadgeVariant.warning:
        return context.mp.warningColor;
      case MPBadgeVariant.error:
        return context.mp.errorColor;
      case MPBadgeVariant.info:
        return context.mp.infoColor;
      case MPBadgeVariant.outlined:
        return context.mp.primary;
      case MPBadgeVariant.filled:
        return Colors.transparent;
    }
  }

  bool getShowBorder(MPBadgeVariant variant) {
    return variant == MPBadgeVariant.secondary ||
        variant == MPBadgeVariant.outlined;
  }

  double getBorderWidth(MPBadgeVariant variant) {
    return variant == MPBadgeVariant.outlined ? 1.5 : 1.0;
  }
}
