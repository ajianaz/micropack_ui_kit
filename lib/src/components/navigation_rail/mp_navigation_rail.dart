import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_navigation_rail_enums.dart';

/// MPNavigationRail - Theme-aware navigation rail component
///
/// This component provides a macOS-style navigation rail with theme integration,
/// animations, and accessibility features. Ideal for desktop and tablet apps.
///
/// Example:
/// ```dart
/// MPNavigationRail(
///   selectedIndex: 0,
///   onDestinationSelected: (index) {},
///   destinations: [
///     MPNavigationRailDestination(
///       icon: Icons.home,
///       label: 'Home',
///     ),
///     MPNavigationRailDestination(
///       icon: Icons.settings,
///       label: 'Settings',
///     ),
///   ],
/// )
/// ```
class MPNavigationRail extends StatefulWidget {
  const MPNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    this.size = MPNavigationRailSize.expanded,
    this.labelType = MPNavigationRailLabelType.all,
    this.placement = MPNavigationRailPlacement.leading,
    this.minWidth,
    this.maxWidth,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.borderRadius,
    this.semanticLabel,
  });

  /// Currently selected destination index
  final int selectedIndex;

  /// Callback when a destination is selected
  final ValueChanged<int> onDestinationSelected;

  /// List of navigation destinations
  final List<MPNavigationRailDestination> destinations;

  /// Size of the navigation rail
  final MPNavigationRailSize size;

  /// When to show labels
  final MPNavigationRailLabelType labelType;

  /// Placement of navigation rail
  final MPNavigationRailPlacement placement;

  /// Minimum width of the rail
  final double? minWidth;

  /// Maximum width of the rail
  final double? maxWidth;

  /// Background color
  final Color? backgroundColor;

  /// Color for selected destination
  final Color? selectedColor;

  /// Color for unselected destinations
  final Color? unselectedColor;

  /// Border radius for destination items
  final double? borderRadius;

  /// Semantic label for the rail
  final String? semanticLabel;

  @override
  State<MPNavigationRail> createState() => _MPNavigationRailState();
}

class _MPNavigationRailState extends State<MPNavigationRail>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void didUpdateWidget(MPNavigationRail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.backgroundColor ?? context.mp.cardColor;
    final selColor = widget.selectedColor ?? context.mp.primary;
    final unselColor = widget.unselectedColor ?? context.mp.captionColor;

    final rail = Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          ...widget.destinations.asMap().entries.map((entry) {
            final index = entry.key;
            final destination = entry.value;
            final isSelected = index == widget.selectedIndex;

            return AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return _buildDestination(
                  context,
                  index,
                  destination,
                  isSelected,
                  selColor,
                  unselColor,
                );
              },
            );
          }).toList(),
          _buildFooter(context),
        ],
      ),
    );

    if (widget.placement == MPNavigationRailPlacement.trailing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [rail],
      );
    }

    return Row(
      children: [rail],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox.shrink(); // Placeholder for custom header widget
  }

  Widget _buildFooter(BuildContext context) {
    return SizedBox.shrink(); // Placeholder for custom footer widget
  }

  Widget _buildDestination(
    BuildContext context,
    int index,
    MPNavigationRailDestination destination,
    bool isSelected,
    Color selectedColor,
    Color unselectedColor,
  ) {
    final shouldShowLabel = _shouldShowLabel(isSelected);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: GestureDetector(
        onTap: () => widget.onDestinationSelected(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? selectedColor.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          ),
          padding: EdgeInsets.symmetric(
            vertical: shouldShowLabel ? 8 : 12,
            horizontal: shouldShowLabel ? 12 : 12,
          ),
          child: Row(
            children: [
              Icon(
                destination.icon,
                size: _getIconSize(),
                color: isSelected ? selectedColor : unselectedColor,
              ),
              if (shouldShowLabel) ...[
                SizedBox(width: 8),
                Expanded(
                  child: MPText.label(
                    destination.label,
                    style: TextStyle(
                      color: isSelected ? selectedColor : unselectedColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              if (destination.badge != null) ...[
                SizedBox(width: 4),
                destination.badge!,
              ],
            ],
          ),
        ),
      ),
    );
  }

  bool _shouldShowLabel(bool isSelected) {
    switch (widget.labelType) {
      case MPNavigationRailLabelType.none:
        return false;
      case MPNavigationRailLabelType.selected:
        return isSelected;
      case MPNavigationRailLabelType.all:
        return true;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case MPNavigationRailSize.compact:
        return 20;
      case MPNavigationRailSize.medium:
        return 24;
      case MPNavigationRailSize.expanded:
        return 24;
    }
  }
}

/// Destination for navigation rail
class MPNavigationRailDestination {
  const MPNavigationRailDestination({
    required this.icon,
    required this.label,
    this.badge,
    this.semanticLabel,
  });

  /// Icon for the destination
  final IconData icon;

  /// Label text
  final String label;

  /// Optional badge widget
  final Widget? badge;

  /// Semantic label for accessibility
  final String? semanticLabel;
}
