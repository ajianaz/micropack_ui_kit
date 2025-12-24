import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_helper.dart';

/// An action that appears when sliding a list item
class MPSlidableAction {
  /// Icon to display
  final IconData icon;

  /// Label text
  final String? label;

  /// Background color (optional, uses semantic colors if null)
  final Color? backgroundColor;

  /// Foreground color
  final Color? foregroundColor;

  /// Callback when pressed
  final SlidableActionCallback onPressed;

  /// Whether this is a destructive action (red/error color)
  final bool isDestructive;

  const MPSlidableAction({
    required this.icon,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
    this.isDestructive = false,
  });
}

/// Extension to convert MPSlidableAction to SlidableAction
extension MPSlidableActionExtension on MPSlidableAction {
  SlidableAction toSlidableAction(BuildContext context) {
    final theme = context.mp;

    // Determine background color
    Color bgColor = backgroundColor ??
        (isDestructive ? theme.errorColor : theme.primary);

    // Determine foreground color
    Color fgColor = foregroundColor ?? Colors.white;

    return SlidableAction(
      onPressed: onPressed,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      icon: icon,
      label: label,
      spacing: 4,
    );
  }
}
