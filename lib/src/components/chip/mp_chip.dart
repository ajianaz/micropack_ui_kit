import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_chip_enums.dart';

/// A chip component for displaying labels, tags, or selectable items.
///
/// Similar to badges but with more interactivity options including
/// selection states and dismiss functionality.
///
/// Example:
/// ```dart
/// MPChip(
///   label: 'Flutter',
///   variant: MPChipVariant.primary,
///   onDeleted: () => print('Chip deleted'),
/// )
/// ```
class MPChip extends StatefulWidget {
  /// Creates a new [MPChip] widget.
  const MPChip({
    super.key,
    required this.label,
    this.variant = MPChipVariant.primary,
    this.size = MPChipSize.medium,
    this.leading,
    this.trailing,
    this.onPressed,
    this.onDeleted,
    this.selected = false,
    this.enabled = true,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.avatar,
    this.avatarBorderColor,
    this.deleteIcon,
    this.semanticLabel,
  });

  /// The text or widget to display as the chip label.
  final String label;

  /// The visual style variant of the chip.
  final MPChipVariant variant;

  /// The size of the chip.
  final MPChipSize size;

  /// Optional widget to display before the label.
  final Widget? leading;

  /// Optional widget to display after the label.
  final Widget? trailing;

  /// Called when the chip is tapped.
  ///
  /// If null, the chip is not tappable.
  final VoidCallback? onPressed;

  /// Called when the delete button is tapped.
  final VoidCallback? onDeleted;

  /// Whether the chip is in a selected state.
  ///
  /// Only applicable for selectable chips.
  final bool selected;

  /// Whether the chip is enabled for interaction.
  final bool enabled;

  /// Custom background color.
  final Color? backgroundColor;

  /// Custom text color.
  final Color? textColor;

  /// Custom border color.
  final Color? borderColor;

  /// Optional avatar widget to display.
  final Widget? avatar;

  /// Border color for avatar.
  final Color? avatarBorderColor;

  /// Custom delete icon widget.
  final Widget? deleteIcon;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  @override
  State<MPChip> createState() => _MPChipState();
}

class _MPChipState extends State<MPChip> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final config = _MPChipConfig();

    final isClickable = widget.enabled && widget.onPressed != null;
    final isDeletable = widget.enabled && widget.onDeleted != null;

    return MouseRegion(
      onEnter: isClickable ? (_) => setState(() => _isHovered = true) : null,
      onExit: isClickable ? (_) => setState(() => _isHovered = false) : null,
      cursor: isClickable ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: isClickable ? _handleTap : null,
        onTapDown: isClickable ? (_) => setState(() => _isPressed = true) : null,
        onTapUp: isClickable ? (_) => setState(() => _isPressed = false) : null,
        onTapCancel: isClickable ? () => setState(() => _isPressed = false) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          padding: config.getPadding(widget.size),
          decoration: BoxDecoration(
            color: _getBackgroundColor(config),
            borderRadius: BorderRadius.circular(config.getBorderRadius(widget.size)),
            border: Border.all(
              color: widget.borderColor ?? _getBorderColor(config),
              width: config.getBorderWidth(widget.variant),
            ),
            boxShadow: _isHovered && isClickable
                ? [
                    BoxShadow(
                      color: context.mp.primary.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.avatar != null) ...[
                _buildAvatar(config),
                SizedBox(width: config.getSpacing(widget.size)),
              ],
              if (widget.leading != null) ...[
                Transform.scale(
                  scale: config.getIconScale(widget.size),
                  child: IconTheme(
                    data: IconThemeData(
                      color: widget.textColor ?? config.getTextColor(widget.variant, widget.enabled, context),
                      size: config.getIconSize(widget.size),
                    ),
                    child: widget.leading!,
                  ),
                ),
                SizedBox(width: config.getSpacing(widget.size)),
              ],
              Flexible(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: widget.textColor ?? config.getTextColor(widget.variant, widget.enabled, context),
                    fontWeight: config.getFontWeight(widget.size),
                    fontSize: config.getFontSize(widget.size),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.trailing != null && widget.onDeleted == null) ...[
                SizedBox(width: config.getSpacing(widget.size)),
                Transform.scale(
                  scale: config.getIconScale(widget.size),
                  child: IconTheme(
                    data: IconThemeData(
                      color: widget.textColor ?? config.getTextColor(widget.variant, widget.enabled, context),
                      size: config.getIconSize(widget.size),
                    ),
                    child: widget.trailing!,
                  ),
                ),
              ],
              if (isDeletable) ...[
                SizedBox(width: config.getSpacing(widget.size)),
                _buildDeleteButton(config),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(_MPChipConfig config) {
    return Container(
      width: config.getAvatarSize(widget.size),
      height: config.getAvatarSize(widget.size),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: widget.avatarBorderColor ?? context.mp.borderColor,
          width: 1,
        ),
      ),
      child: ClipOval(
        child: FittedBox(
          fit: BoxFit.cover,
          child: widget.avatar!,
        ),
      ),
    );
  }

  Widget _buildDeleteButton(_MPChipConfig config) {
    return InkWell(
      onTap: widget.onDeleted,
      borderRadius: BorderRadius.circular(config.getBorderRadius(widget.size) / 2),
      child: Padding(
        padding: EdgeInsets.all(config.getDeleteButtonPadding(widget.size)),
        child: widget.deleteIcon ??
            Icon(
              Icons.close,
              size: config.getIconSize(widget.size),
              color: widget.textColor ?? config.getTextColor(widget.variant, widget.enabled, context),
            ),
      ),
    );
  }

  Color _getBackgroundColor(_MPChipConfig config) {
    if (widget.backgroundColor != null) return widget.backgroundColor!;
    if (_isPressed && widget.enabled) return config.getPressedColor(widget.variant, context);
    if (widget.selected) return config.getSelectedColor(widget.variant, context);
    return config.getBackgroundColor(widget.variant, widget.enabled, context);
  }

  Color _getBorderColor(_MPChipConfig config) {
    if (widget.borderColor != null) return widget.borderColor!;
    if (widget.selected) return config.getSelectedColor(widget.variant, context);
    return config.getBorderColor(widget.variant, widget.enabled, context);
  }

  void _handleTap() {
    if (!widget.enabled || widget.onPressed == null) return;
    widget.onPressed!();
  }
}

/// Configuration class for MPChip
class _MPChipConfig {
  // Size configurations
  static final Map<MPChipSize, double> fontSizes = {
    MPChipSize.small: 12,
    MPChipSize.medium: 14,
    MPChipSize.large: 16,
  };

  static final Map<MPChipSize, double> borderRadiuses = {
    MPChipSize.small: 12,
    MPChipSize.medium: 16,
    MPChipSize.large: 20,
  };

  static final Map<MPChipSize, double> iconScales = {
    MPChipSize.small: 0.85,
    MPChipSize.medium: 0.95,
    MPChipSize.large: 1.0,
  };

  static final Map<MPChipSize, EdgeInsets> paddings = {
    MPChipSize.small: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    MPChipSize.medium: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    MPChipSize.large: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  };

  static final Map<MPChipSize, double> spacing = {
    MPChipSize.small: 4,
    MPChipSize.medium: 6,
    MPChipSize.large: 8,
  };

  static final Map<MPChipSize, double> avatarSizes = {
    MPChipSize.small: 20,
    MPChipSize.medium: 24,
    MPChipSize.large: 28,
  };

  static final Map<MPChipSize, double> iconSizes = {
    MPChipSize.small: 16,
    MPChipSize.medium: 18,
    MPChipSize.large: 20,
  };

  static final Map<MPChipSize, double> deleteButtonPaddings = {
    MPChipSize.small: 2,
    MPChipSize.medium: 3,
    MPChipSize.large: 4,
  };

  double getFontSize(MPChipSize size) => fontSizes[size]!;
  double getBorderRadius(MPChipSize size) => borderRadiuses[size]!;
  double getIconScale(MPChipSize size) => iconScales[size]!;
  double getIconSize(MPChipSize size) => iconSizes[size]!;
  EdgeInsets getPadding(MPChipSize size) => paddings[size]!;
  double getSpacing(MPChipSize size) => spacing[size]!;
  double getAvatarSize(MPChipSize size) => avatarSizes[size]!;
  double getDeleteButtonPadding(MPChipSize size) => deleteButtonPaddings[size]!;

  FontWeight getFontWeight(MPChipSize size) {
    switch (size) {
      case MPChipSize.small:
      case MPChipSize.medium:
        return FontWeight.w500;
      case MPChipSize.large:
        return FontWeight.w600;
    }
  }

  double getBorderWidth(MPChipVariant variant) {
    return variant == MPChipVariant.outlined ? 1.5 : 1.0;
  }

  // Variant colors
  Color getBackgroundColor(MPChipVariant variant, bool enabled, BuildContext context) {
    if (!enabled) return context.mp.disabledColor.withValues(alpha: 0.3);

    switch (variant) {
      case MPChipVariant.primary:
        return context.mp.primary.withValues(alpha: 0.1);
      case MPChipVariant.secondary:
        return context.mp.isDarkMode
            ? const Color(0xFF374151)
            : const Color(0xFFF3F4F6);
      case MPChipVariant.success:
        return context.mp.successColor.withValues(alpha: 0.1);
      case MPChipVariant.warning:
        return context.mp.warningColor.withValues(alpha: 0.1);
      case MPChipVariant.error:
        return context.mp.errorColor.withValues(alpha: 0.1);
      case MPChipVariant.info:
        return context.mp.infoColor.withValues(alpha: 0.1);
      case MPChipVariant.outlined:
        return Colors.transparent;
      case MPChipVariant.filled:
        return context.mp.isDarkMode
            ? const Color(0xFFD1D5DB)
            : const Color(0xFF374151);
    }
  }

  Color getPressedColor(MPChipVariant variant, BuildContext context) {
    switch (variant) {
      case MPChipVariant.primary:
        return context.mp.primary.withValues(alpha: 0.2);
      case MPChipVariant.secondary:
        return context.mp.isDarkMode
            ? const Color(0xFF4B5563)
            : const Color(0xFFE5E7EB);
      case MPChipVariant.success:
        return context.mp.successColor.withValues(alpha: 0.2);
      case MPChipVariant.warning:
        return context.mp.warningColor.withValues(alpha: 0.2);
      case MPChipVariant.error:
        return context.mp.errorColor.withValues(alpha: 0.2);
      case MPChipVariant.info:
        return context.mp.infoColor.withValues(alpha: 0.2);
      case MPChipVariant.outlined:
        return context.mp.primary.withValues(alpha: 0.05);
      case MPChipVariant.filled:
        return context.mp.isDarkMode
            ? const Color(0xFFE5E7EB)
            : const Color(0xFF4B5563);
    }
  }

  Color getSelectedColor(MPChipVariant variant, BuildContext context) {
    switch (variant) {
      case MPChipVariant.primary:
        return context.mp.primary;
      case MPChipVariant.secondary:
        return context.mp.isDarkMode
            ? const Color(0xFFD1D5DB)
            : const Color(0xFF374151);
      case MPChipVariant.success:
        return context.mp.successColor;
      case MPChipVariant.warning:
        return context.mp.warningColor;
      case MPChipVariant.error:
        return context.mp.errorColor;
      case MPChipVariant.info:
        return context.mp.infoColor;
      case MPChipVariant.outlined:
        return context.mp.primary.withValues(alpha: 0.1);
      case MPChipVariant.filled:
        return context.mp.isDarkMode
            ? const Color(0xFFF3F4F6)
            : const Color(0xFF111827);
    }
  }

  Color getTextColor(MPChipVariant variant, bool enabled, BuildContext context) {
    if (!enabled) return context.mp.disabledColor.withValues(alpha: 0.7);

    switch (variant) {
      case MPChipVariant.primary:
        return context.mp.primary;
      case MPChipVariant.secondary:
        return context.mp.textColor;
      case MPChipVariant.success:
        return context.mp.successColor;
      case MPChipVariant.warning:
        return context.mp.warningColor;
      case MPChipVariant.error:
        return context.mp.errorColor;
      case MPChipVariant.info:
        return context.mp.infoColor;
      case MPChipVariant.outlined:
        return context.mp.primary;
      case MPChipVariant.filled:
        return context.mp.isDarkMode
            ? const Color(0xFF374151)
            : Colors.white;
    }
  }

  Color getBorderColor(MPChipVariant variant, bool enabled, BuildContext context) {
    if (!enabled) return context.mp.disabledColor.withValues(alpha: 0.3);

    switch (variant) {
      case MPChipVariant.primary:
        return context.mp.primary;
      case MPChipVariant.secondary:
        return context.mp.borderColor;
      case MPChipVariant.success:
        return context.mp.successColor;
      case MPChipVariant.warning:
        return context.mp.warningColor;
      case MPChipVariant.error:
        return context.mp.errorColor;
      case MPChipVariant.info:
        return context.mp.infoColor;
      case MPChipVariant.outlined:
        return context.mp.primary;
      case MPChipVariant.filled:
        return Colors.transparent;
    }
  }
}
