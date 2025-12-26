import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_list_tile_enums.dart';

/// MPListTile - Theme-aware list tile component
///
/// This component provides a standard Material Design 3 list tile pattern
/// with multiple variants, sizes, and interaction states.
///
/// Example:
/// ```dart
/// MPListTile(
///   title: 'John Doe',
///   subtitle: 'Software Engineer',
///   leading: MPAvatar(
///     name: 'John Doe',
///     size: MPAvatarSize.medium,
///   ),
///   trailing: Icon(Icons.chevron_right),
///   onTap: () {
///     // Handle tap
///   },
/// )
/// ```
class MPListTile extends StatelessWidget {
  const MPListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.tertiary,
    this.leading,
    this.trailing,
    this.variant = MPListTileVariant.standard,
    this.size = MPListTileSize.medium,
    this.enabled = true,
    this.selected = false,
    this.onTap,
    this.onLongPress,
    this.dense = false,
    this.padding,
    this.contentPadding,
    this.borderRadius,
    this.backgroundColor,
    this.semanticLabel,
  });

  /// The primary title text of the list tile.
  final String title;

  /// Optional subtitle text.
  final String? subtitle;

  /// Optional tertiary text (additional info).
  final String? tertiary;

  /// Optional widget to display before the title (avatar, icon, etc.).
  final Widget? leading;

  /// Optional widget to display after the content (icon, switch, etc.).
  final Widget? trailing;

  /// The visual style variant of the list tile.
  final MPListTileVariant variant;

  /// The size of the list tile.
  final MPListTileSize size;

  /// Whether the list tile is enabled for interaction.
  final bool enabled;

  /// Whether the list tile is selected.
  final bool selected;

  /// Callback when the list tile is tapped.
  final VoidCallback? onTap;

  /// Callback when the list tile is long-pressed.
  final VoidCallback? onLongPress;

  /// Whether to use dense layout (less padding).
  final bool dense;

  /// Custom padding for the list tile.
  final EdgeInsets? padding;

  /// Custom padding for the inner content (title, subtitle, tertiary).
  ///
  /// Useful for controlling spacing between elements independently of outer padding.
  final EdgeInsets? contentPadding;

  /// Custom border radius.
  final double? borderRadius;

  /// Custom background color.
  final Color? backgroundColor;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final config = _MPListTileConfig();

    return Semantics(
      label: semanticLabel ?? title,
      button: onTap != null,
      child: MPInteractionAnimator(
        enabled: enabled && (onTap != null || onLongPress != null),
        onTap: onTap,
        onLongPress: onLongPress,
        pressScale: 0.98,
        hoverScale: 1.01,
        pressDuration: const Duration(milliseconds: 100),
        hoverDuration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            color: enabled
                ? (backgroundColor ?? config.getBackgroundColor(variant, selected, context))
                : context.mp.disabledColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(
              borderRadius ?? config.getBorderRadius(size),
            ),
            border: config.getShowBorder(variant, selected)
                ? Border.all(
                    color: config.getBorderColor(variant, selected, context),
                    width: 1.5,
                  )
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: enabled ? onTap : null,
              onLongPress: enabled ? onLongPress : null,
              borderRadius: BorderRadius.circular(
                borderRadius ?? config.getBorderRadius(size),
              ),
              child: Padding(
                padding: padding ?? config.getPadding(size, dense),
                child: Row(
                  children: [
                    if (leading != null) ...[
                      SizedBox(
                        width: config.getLeadingWidth(size),
                        child: leading!,
                      ),
                      SizedBox(width: config.getSpacing(size)),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildTitle(context),
                          if (subtitle != null) ...[
                            SizedBox(height: config.getTextSpacing(size)),
                            _buildSubtitle(context),
                          ],
                          if (tertiary != null) ...[
                            SizedBox(height: config.getTextSpacing(size)),
                            _buildTertiary(context),
                          ],
                        ],
                      ),
                    ),
                    if (trailing != null) ...[
                      SizedBox(width: config.getSpacing(size)),
                      trailing!,
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return MPText(
      title,
      style: TextStyle(
        fontSize: _MPListTileConfig().getTitleFontSize(size),
        fontWeight: FontWeight.w600,
        color: context.mp.textColor,
      ),
      maxLines: 1,
      textOverflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return MPText(
      subtitle!,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: context.mp.subtitleColor,
      ),
      maxLines: 2,
      textOverflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTertiary(BuildContext context) {
    return MPText(
      tertiary!,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: context.mp.captionColor,
      ),
      maxLines: 1,
      textOverflow: TextOverflow.ellipsis,
    );
  }
}

/// Configuration class for MPListTile
class _MPListTileConfig {
  double getLeadingWidth(MPListTileSize size) {
    switch (size) {
      case MPListTileSize.small:
        return 40;
      case MPListTileSize.medium:
        return 48;
      case MPListTileSize.large:
        return 64;
    }
  }

  double getSpacing(MPListTileSize size) {
    switch (size) {
      case MPListTileSize.small:
        return 12;
      case MPListTileSize.medium:
        return 16;
      case MPListTileSize.large:
        return 20;
    }
  }

  double getTextSpacing(MPListTileSize size) {
    switch (size) {
      case MPListTileSize.small:
        return 4;
      case MPListTileSize.medium:
        return 6;
      case MPListTileSize.large:
        return 8;
    }
  }

  double getBorderRadius(MPListTileSize size) {
    switch (size) {
      case MPListTileSize.small:
        return 8;
      case MPListTileSize.medium:
        return 12;
      case MPListTileSize.large:
        return 12;
    }
  }

  double getTitleFontSize(MPListTileSize size) {
    switch (size) {
      case MPListTileSize.small:
        return 14;
      case MPListTileSize.medium:
        return 16;
      case MPListTileSize.large:
        return 18;
    }
  }

  EdgeInsets getPadding(MPListTileSize size, bool dense) {
    final vertical = dense ? 8.0 : getVerticalPadding(size);
    final horizontal = 16.0;
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  double getVerticalPadding(MPListTileSize size) {
    switch (size) {
      case MPListTileSize.small:
        return 10.0;
      case MPListTileSize.medium:
        return 12.0;
      case MPListTileSize.large:
        return 16.0;
    }
  }

  Color getBackgroundColor(
    MPListTileVariant variant,
    bool selected,
    BuildContext context,
  ) {
    if (selected) {
      return context.mp.primary.withValues(alpha: 0.08);
    }

    switch (variant) {
      case MPListTileVariant.primary:
        return context.mp.primary.withValues(alpha: 0.05);
      case MPListTileVariant.subtle:
        return context.mp.adaptiveBackgroundColor;
      case MPListTileVariant.standard:
        return Colors.transparent;
    }
  }

  Color getBorderColor(
    MPListTileVariant variant,
    bool selected,
    BuildContext context,
  ) {
    if (selected) {
      return context.mp.primary;
    }

    switch (variant) {
      case MPListTileVariant.primary:
        return context.mp.primary;
      case MPListTileVariant.subtle:
      case MPListTileVariant.standard:
        return context.mp.borderColor;
    }
  }

  bool getShowBorder(MPListTileVariant variant, bool selected) {
    return variant == MPListTileVariant.primary || selected;
  }
}
