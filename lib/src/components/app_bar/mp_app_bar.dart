import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_app_bar_enums.dart';

/// MPAppBar - Theme-aware app bar component
///
/// This component provides a platform-adaptive app bar with theme integration,
/// custom actions, and responsive design.
///
/// Example:
/// ```dart
/// MPAppBar(
///   title: 'My App',
///   leading: IconButton(icon: Icons.menu, onPressed: () {}),
///   actions: [
///     IconButton(icon: Icons.search, onPressed: () {}),
///   ],
/// )
/// ```
class MPAppBar extends StatelessWidget {
  const MPAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.actions,
    this.variant = MPAppBarVariant.standard,
    this.scrollBehavior = MPAppBarScrollBehavior.pinned,
    this.actionAlignment = MPAppBarActionAlignment.end,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.borderRadius,
    this.semanticLabel,
    this.centerTitle = false,
    this.height,
  });

  /// Title widget or text
  final Widget? title;

  /// Optional subtitle
  final Widget? subtitle;

  /// Leading widget (usually menu or back button)
  final Widget? leading;

  /// Trailing widget (single widget)
  final Widget? trailing;

  /// List of action widgets
  final List<Widget>? actions;

  /// App bar variant
  final MPAppBarVariant variant;

  /// Scroll behavior
  final MPAppBarScrollBehavior scrollBehavior;

  /// Action alignment
  final MPAppBarActionAlignment actionAlignment;

  /// Background color
  final Color? backgroundColor;

  /// Foreground color (text and icons)
  final Color? foregroundColor;

  /// Custom elevation
  final double? elevation;

  /// Custom border radius
  final double? borderRadius;

  /// Semantic label for accessibility
  final String? semanticLabel;

  /// Whether to center the title
  final bool centerTitle;

  /// Custom height
  final double? height;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ??
        (variant == MPAppBarVariant.transparent
            ? Colors.transparent
            : context.mp.adaptiveBackgroundColor);
    final fgColor = foregroundColor ?? context.mp.textColor;
    final elev = elevation ?? _getElevation(variant);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: variant == MPAppBarVariant.standard
            ? Border(
                bottom: BorderSide(
                  color: context.mp.dividerColor,
                  width: 1,
                ),
              )
            : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        boxShadow: variant == MPAppBarVariant.elevated
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        bottom: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: height ?? kToolbarHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                if (leading != null) ...[
                  _buildLeading(context),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: centerTitle
                      ? Center(
                          child: _buildTitle(context),
                        )
                      : _buildTitle(context),
                ),
                if (actions != null || trailing != null) ...[
                  const SizedBox(width: 8),
                  _buildActions(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    return leading!;
  }

  Widget _buildTitle(BuildContext context) {
    if (title == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title is String)
          MPText.head(
            title as String,
            style: TextStyle(
              color: foregroundColor ?? context.mp.textColor,
            ),
          )
        else
          title!,
        if (subtitle != null) ...[
          SizedBox(height: 2),
          if (subtitle is String)
            MPText.label(
              subtitle as String,
              style: TextStyle(
                fontSize: 12,
                color: (foregroundColor ?? context.mp.textColor)
                    .withValues(alpha: 0.7),
              ),
            )
          else
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 12,
                color: (foregroundColor ?? context.mp.textColor)
                    .withValues(alpha: 0.7),
              ),
              child: subtitle!,
            ),
        ],
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    final actionWidgets = actions ?? [];

    if (trailing != null) {
      actionWidgets.insert(0, trailing!);
    }

    if (actionWidgets.isEmpty) {
      return const SizedBox.shrink();
    }

    switch (actionAlignment) {
      case MPAppBarActionAlignment.start:
        return Row(
          children: actionWidgets,
        );
      case MPAppBarActionAlignment.end:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: actionWidgets,
        );
      case MPAppBarActionAlignment.spaceEvenly:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: actionWidgets,
        );
    }
  }

  double _getElevation(MPAppBarVariant variant) {
    switch (variant) {
      case MPAppBarVariant.standard:
        return 0;
      case MPAppBarVariant.elevated:
        return 4;
      case MPAppBarVariant.transparent:
        return 0;
    }
  }
}
