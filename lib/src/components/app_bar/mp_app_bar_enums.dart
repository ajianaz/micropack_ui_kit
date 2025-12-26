part of 'mp_app_bar.dart';

/// App bar variants
enum MPAppBarVariant {
  /// Standard app bar with elevation
  standard,

  /// Elevated app bar (modern shadow)
  elevated,

  /// Transparent app bar (no background)
  transparent,
}

/// App bar scroll behavior
enum MPAppBarScrollBehavior {
  /// App bar scrolls off screen
  scrollOff,

  /// App bar stays pinned at top
  pinned,

  /// App bar floats above content
  floating,
}

/// App bar action alignment
enum MPAppBarActionAlignment {
  /// Actions aligned to start
  start,

  /// Actions aligned to end
  end,

  /// Actions distributed evenly
  spaceEvenly,
}
