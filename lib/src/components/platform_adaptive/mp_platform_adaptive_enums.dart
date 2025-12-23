part of 'mp_platform_adaptive.dart';

/// Supported platforms
enum MPPlatform {
  /// iOS platform
  iOS,

  /// Android platform
  android,

  /// macOS platform
  macOS,

  /// Windows platform
  windows,

  /// Linux platform
  linux,

  /// Web platform
  web,
}

/// Fallback strategy when platform widget not available
enum MPPlatformFallback {
  /// Return default widget
  defaultWidget,

  /// Return closest platform widget (e.g., Windows → Desktop)
  closestPlatform,

  /// Throw error
  error,
}
