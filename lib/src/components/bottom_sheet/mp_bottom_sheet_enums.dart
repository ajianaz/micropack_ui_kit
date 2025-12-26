part of 'mp_bottom_sheet.dart';

/// Bottom sheet variants for different visual styles
enum MPBottomSheetVariant {
  /// Standard Material Design bottom sheet
  standard,

  /// Rounded corners for modern look
  rounded,

  /// Fullscreen bottom sheet (useful for mobile)
  fullscreen,
}

/// Bottom sheet size variants
enum MPBottomSheetSize {
  /// Compact bottom sheet (less vertical space)
  compact,

  /// Medium sized bottom sheet
  medium,

  /// Large bottom sheet (more vertical space)
  large,

  /// Auto-size based on content
  auto,
}

/// Bottom sheet action styles
enum MPBottomSheetActionStyle {
  /// Primary action style
  primary,

  /// Secondary/Cancel action style
  secondary,

  /// Destructive action style
  destructive,
}

/// Bottom sheet edge behavior
enum MPBottomSheetEdgeBehavior {
  /// Dismissible by tapping outside
  tapToDismiss,

  /// Dismissible by swiping down
  swipeToDismiss,

  /// Dismissible by both tap and swipe
  both,

  /// Not dismissible by user interaction (must use close button)
  none,
}
