import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'mp_platform_adaptive_enums.dart';

/// MPPlatformAdaptive - Platform-aware widget selector
///
/// This component provides different widgets based on the current platform,
/// with fallback options for unsupported platforms.
///
/// Example:
/// ```dart
/// MPPlatformAdaptive(
///   iOS: CupertinoButton(child: Text('iOS')),
///   android: ElevatedButton(child: Text('Android')),
///   fallback: ElevatedButton(child: Text('Default')),
/// )
/// ```
class MPPlatformAdaptive extends StatelessWidget {
  const MPPlatformAdaptive({
    super.key,
    this.iOS,
    this.android,
    this.macOS,
    this.windows,
    this.linux,
    this.web,
    this.fallback,
    this.fallbackStrategy = MPPlatformFallback.defaultWidget,
    this.debugForcePlatform,
  });

  /// Widget for iOS platform
  final Widget? iOS;

  /// Widget for Android platform
  final Widget? android;

  /// Widget for macOS platform
  final Widget? macOS;

  /// Widget for Windows platform
  final Widget? windows;

  /// Widget for Linux platform
  final Widget? linux;

  /// Widget for Web platform
  final Widget? web;

  /// Fallback widget when platform not specified
  final Widget? fallback;

  /// Strategy for fallback
  final MPPlatformFallback fallbackStrategy;

  /// Force specific platform for debugging
  final MPPlatform? debugForcePlatform;

  @override
  Widget build(BuildContext context) {
    final platform = debugForcePlatform ?? _getCurrentPlatform();
    final widget = _getWidgetForPlatform(platform);

    if (widget != null) {
      return widget!;
    }

    switch (fallbackStrategy) {
      case MPPlatformFallback.defaultWidget:
        return fallback ?? const SizedBox.shrink();

      case MPPlatformFallback.closestPlatform:
        return _getClosestPlatformWidget() ??
            fallback ??
            const SizedBox.shrink();

      case MPPlatformFallback.error:
        throw PlatformException(
          'No widget provided for platform: $platform',
        );
    }
  }

  Widget? _getWidgetForPlatform(MPPlatform platform) {
    switch (platform) {
      case MPPlatform.iOS:
        return iOS;
      case MPPlatform.android:
        return android;
      case MPPlatform.macOS:
        return macOS;
      case MPPlatform.windows:
        return windows;
      case MPPlatform.linux:
        return linux;
      case MPPlatform.web:
        return web;
    }
  }

  Widget? _getClosestPlatformWidget() {
    final platform = _getCurrentPlatform();

    // Web platform fallbacks
    if (platform == MPPlatform.web) {
      return iOS ?? android ?? macOS ?? windows ?? linux;
    }

    // Desktop platforms fallback to each other
    if (platform == MPPlatform.macOS) {
      return windows ?? linux;
    }
    if (platform == MPPlatform.windows) {
      return macOS ?? linux;
    }
    if (platform == MPPlatform.linux) {
      return macOS ?? windows;
    }

    // Mobile platforms fallback to each other
    if (platform == MPPlatform.iOS) {
      return android;
    }
    if (platform == MPPlatform.android) {
      return iOS;
    }

    return null;
  }

  MPPlatform _getCurrentPlatform() {
    if (kIsWeb) {
      return MPPlatform.web;
    }

    if (Platform.isIOS) {
      return MPPlatform.iOS;
    }
    if (Platform.isAndroid) {
      return MPPlatform.android;
    }
    if (Platform.isMacOS) {
      return MPPlatform.macOS;
    }
    if (Platform.isWindows) {
      return MPPlatform.windows;
    }
    if (Platform.isLinux) {
      return MPPlatform.linux;
    }

    return MPPlatform.web; // Default fallback
  }
}

/// Platform-aware builder function
typedef PlatformWidgetBuilder = Widget Function(BuildContext context);

/// MPPlatformAdaptiveBuilder - Platform-aware widget builder
///
/// Alternative to MPPlatformAdaptive that uses builder functions
/// for lazy widget construction.
///
/// Example:
/// ```dart
/// MPPlatformAdaptiveBuilder(
///   iOS: (context) => CupertinoButton(child: Text('iOS')),
///   android: (context) => ElevatedButton(child: Text('Android')),
/// )
/// ```
class MPPlatformAdaptiveBuilder extends StatelessWidget {
  const MPPlatformAdaptiveBuilder({
    super.key,
    this.iOS,
    this.android,
    this.macOS,
    this.windows,
    this.linux,
    this.web,
    this.fallback,
    this.fallbackStrategy = MPPlatformFallback.defaultWidget,
    this.debugForcePlatform,
  });

  /// Builder for iOS platform
  final PlatformWidgetBuilder? iOS;

  /// Builder for Android platform
  final PlatformWidgetBuilder? android;

  /// Builder for macOS platform
  final PlatformWidgetBuilder? macOS;

  /// Builder for Windows platform
  final PlatformWidgetBuilder? windows;

  /// Builder for Linux platform
  final PlatformWidgetBuilder? linux;

  /// Builder for Web platform
  final PlatformWidgetBuilder? web;

  /// Fallback builder
  final PlatformWidgetBuilder? fallback;

  /// Strategy for fallback
  final MPPlatformFallback fallbackStrategy;

  /// Force specific platform for debugging
  final MPPlatform? debugForcePlatform;

  @override
  Widget build(BuildContext context) {
    final platform = debugForcePlatform ?? _getCurrentPlatform();
    final builder = _getBuilderForPlatform(platform);

    if (builder != null) {
      return builder!(context);
    }

    switch (fallbackStrategy) {
      case MPPlatformFallback.defaultWidget:
        return fallback?.call(context) ?? const SizedBox.shrink();

      case MPPlatformFallback.closestPlatform:
        final closestBuilder = _getClosestPlatformBuilder();
        return closestBuilder?.call(context) ??
            fallback?.call(context) ??
            const SizedBox.shrink();

      case MPPlatformFallback.error:
        throw PlatformException(
          'No builder provided for platform: $platform',
        );
    }
  }

  PlatformWidgetBuilder? _getBuilderForPlatform(MPPlatform platform) {
    switch (platform) {
      case MPPlatform.iOS:
        return iOS;
      case MPPlatform.android:
        return android;
      case MPPlatform.macOS:
        return macOS;
      case MPPlatform.windows:
        return windows;
      case MPPlatform.linux:
        return linux;
      case MPPlatform.web:
        return web;
    }
  }

  PlatformWidgetBuilder? _getClosestPlatformBuilder() {
    final platform = _getCurrentPlatform();

    if (platform == MPPlatform.web) {
      return iOS ?? android ?? macOS ?? windows ?? linux;
    }
    if (platform == MPPlatform.macOS) {
      return windows ?? linux;
    }
    if (platform == MPPlatform.windows) {
      return macOS ?? linux;
    }
    if (platform == MPPlatform.linux) {
      return macOS ?? windows;
    }
    if (platform == MPPlatform.iOS) {
      return android;
    }
    if (platform == MPPlatform.android) {
      return iOS;
    }

    return null;
  }

  MPPlatform _getCurrentPlatform() {
    if (kIsWeb) {
      return MPPlatform.web;
    }

    if (Platform.isIOS) {
      return MPPlatform.iOS;
    }
    if (Platform.isAndroid) {
      return MPPlatform.android;
    }
    if (Platform.isMacOS) {
      return MPPlatform.macOS;
    }
    if (Platform.isWindows) {
      return MPPlatform.windows;
    }
    if (Platform.isLinux) {
      return MPPlatform.linux;
    }

    return MPPlatform.web;
  }
}

/// Exception thrown when platform not supported
class PlatformException implements Exception {
  final String message;

  PlatformException(this.message);

  @override
  String toString() => 'PlatformException: $message';
}
