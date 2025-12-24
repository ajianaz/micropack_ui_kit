import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_helper.dart';

import 'mp_slidable_action.dart';

/// A slidable list item with adaptive theming
///
/// Follows theme rules:
/// - Actions use semantic colors (error for destructive, primary otherwise)
/// - Background uses adaptive colors
/// - Supports all theme modes
class MPSlidable extends StatelessWidget {
  /// The child widget to display (typically a ListTile)
  final Widget child;

  /// Actions to show on the left/start side
  final List<MPSlidableAction>? startActions;

  /// Actions to show on the right/end side
  final List<MPSlidableAction>? endActions;

  const MPSlidable({
    super.key,
    required this.child,
    this.startActions,
    this.endActions,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      startActionPane: startActions != null
          ? ActionPane(
              motion: const DrawerMotion(),
              children: startActions!.map((action) {
                final slidableAction = action.toSlidableAction(context);
                return SlidableAction(
                  onPressed: slidableAction.onPressed,
                  backgroundColor: slidableAction.backgroundColor,
                  foregroundColor: slidableAction.foregroundColor,
                  icon: slidableAction.icon,
                  label: slidableAction.label,
                );
              }).toList(),
            )
          : null,
      endActionPane: endActions != null
          ? ActionPane(
              motion: const DrawerMotion(),
              children: endActions!.map((action) {
                final slidableAction = action.toSlidableAction(context);
                return SlidableAction(
                  onPressed: slidableAction.onPressed,
                  backgroundColor: slidableAction.backgroundColor,
                  foregroundColor: slidableAction.foregroundColor,
                  icon: slidableAction.icon,
                  label: slidableAction.label,
                );
              }).toList(),
            )
          : null,
      child: child,
    );
  }
}
