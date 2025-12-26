part of 'mp_navigation_rail.dart';

/// Navigation rail size variants
enum MPNavigationRailSize {
  /// Compact size (only icons)
  compact,

  /// Medium size (icons with small labels)
  medium,

  /// Expanded size (icons with full labels)
  expanded,
}

/// Navigation rail label types
enum MPNavigationRailLabelType {
  /// No labels (icons only)
  none,

  /// Selected item only
  selected,

  /// All items
  all,
}

/// Navigation rail placement
enum MPNavigationRailPlacement {
  /// Left side of screen
  leading,

  /// Right side of screen
  trailing,
}
