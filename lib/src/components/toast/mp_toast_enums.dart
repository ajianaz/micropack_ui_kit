part of 'mp_toast.dart';

/// Position variants for toast notifications
enum MPToastPosition {
  /// Toast appears at the top of the screen
  top,

  /// Toast appears at the bottom of the screen (default)
  bottom,

  /// Toast appears in the center of the screen
  center,
}

/// Visual style variants for toast notifications
enum MPToastVariant {
  /// Primary brand color toast
  primary,

  /// Success state toast (green)
  success,

  /// Warning state toast (amber)
  warning,

  /// Error state toast (red)
  error,

  /// Information toast (blue)
  info,
}

/// Duration presets for toast auto-dismissal
enum MPToastDuration {
  /// Short duration (2 seconds)
  short,

  /// Medium duration (3 seconds, default)
  medium,

  /// Long duration (5 seconds)
  long,
}
