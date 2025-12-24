import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_helper.dart';

/// An expansion tile with adaptive theming
///
/// Follows theme rules:
/// - Uses adaptive background colors
/// - Icon uses semantic text color
/// - Dividers use adaptive divider color
class MPExpansionTile extends StatelessWidget {
  /// The primary title widget
  final Widget title;

  /// Optional subtitle
  final Widget? subtitle;

  /// Optional leading widget
  final Widget? leading;

  /// Optional trailing widget (replaces expand/collapse icon)
  final Widget? trailing;

  /// Children to show when expanded
  final List<Widget> children;

  /// Initially expanded
  final bool initiallyExpanded;

  /// Border radius when expanded
  final BorderRadius? borderRadius;

  /// Enable/disable expansion
  final bool enabled;

  const MPExpansionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    required this.children,
    this.initiallyExpanded = false,
    this.borderRadius,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.mp;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: Border.all(
          color: theme.borderColor,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: theme.primary.withValues(alpha: 0.1),
            highlightColor: theme.primary.withValues(alpha: 0.05),
          ),
          child: ExpansionTile(
            title: DefaultTextStyle(
              style: TextStyle(
                color: theme.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              child: title,
            ),
            subtitle: subtitle != null
                ? DefaultTextStyle(
                    style: TextStyle(
                      color: theme.subtitleColor,
                      fontSize: 14,
                    ),
                    child: subtitle!,
                  )
                : null,
            leading: leading != null
                ? IconTheme(
                    data: IconThemeData(color: theme.subtitleColor),
                    child: leading!,
                  )
                : null,
            trailing: trailing != null
                ? IconTheme(
                    data: IconThemeData(color: theme.subtitleColor),
                    child: trailing!,
                  )
                : null,
            initiallyExpanded: initiallyExpanded,
            enabled: enabled,
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            childrenPadding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              16,
            ),
            iconColor: theme.primary,
            collapsedIconColor: theme.subtitleColor,
            children: children,
          ),
        ),
      ),
    );
  }
}
