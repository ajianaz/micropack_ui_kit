import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Platform-specific interaction configurations
///
/// Provides optimized interaction settings for different platforms:
/// - Mobile (iOS/Android): Touch-optimized with larger tap targets
/// - Desktop (macOS/Windows/Linux): Mouse/keyboard optimized
/// - Web: Hybrid approach with hover states
class MPPlatformInteraction {
  MPPlatformInteraction._();

  /// Private singleton instance
  static final MPPlatformInteraction _instance = MPPlatformInteraction._();

  /// Get the singleton instance
  static MPPlatformInteraction get instance => _instance;

  /// Current platform
  MPPlatform _currentPlatform = _detectPlatform();

  /// Detect current platform
  static MPPlatform _detectPlatform() {
    if (kIsWeb) return MPPlatform.web;
    if (Platform.isIOS) return MPPlatform.iOS;
    if (Platform.isAndroid) return MPPlatform.android;
    if (Platform.isMacOS) return MPPlatform.macOS;
    if (Platform.isWindows) return MPPlatform.windows;
    if (Platform.isLinux) return MPPlatform.linux;
    return MPPlatform.web;
  }

  /// Get current platform
  MPPlatform get currentPlatform => _currentPlatform;

  /// Check if running on mobile platform
  bool get isMobile =>
      _currentPlatform == MPPlatform.iOS ||
      _currentPlatform == MPPlatform.android;

  /// Check if running on desktop platform
  bool get isDesktop =>
      _currentPlatform == MPPlatform.macOS ||
      _currentPlatform == MPPlatform.windows ||
      _currentPlatform == MPPlatform.linux;

  /// Check if running on web
  bool get isWeb => kIsWeb;

  /// Get minimum tap target size for current platform
  ///
  /// Returns larger sizes for mobile platforms to meet accessibility guidelines
  double get minTapTargetSize {
    switch (_currentPlatform) {
      case MPPlatform.iOS:
      case MPPlatform.android:
        return 48.0; // WCAG 2.1 AAA recommendation
      case MPPlatform.macOS:
      case MPPlatform.windows:
      case MPPlatform.linux:
        return 32.0; // Desktop can use smaller targets
      case MPPlatform.web:
        return 44.0; // Web intermediate size
    }
  }

  /// Get recommended button padding for current platform
  EdgeInsetsGeometry get buttonPadding {
    switch (_currentPlatform) {
      case MPPlatform.iOS:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
      case MPPlatform.android:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case MPPlatform.macOS:
      case MPPlatform.windows:
      case MPPlatform.linux:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case MPPlatform.web:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    }
  }

  /// Get recommended border radius for current platform
  double get borderRadius {
    switch (_currentPlatform) {
      case MPPlatform.iOS:
        return 8.0; // iOS uses more rounded corners
      case MPPlatform.android:
        return 4.0; // Material Design uses less rounding
      case MPPlatform.macOS:
      case MPPlatform.windows:
      case MPPlatform.linux:
        return 6.0; // Desktop intermediate
      case MPPlatform.web:
        return 8.0; // Web follows iOS conventions
    }
  }

  /// Check if hover effects should be enabled
  bool get enableHoverEffects => isDesktop || isWeb;

  /// Check if ripple effects should be enabled
  bool get enableRippleEffects {
    switch (_currentPlatform) {
      case MPPlatform.android:
      case MPPlatform.web:
        return true;
      case MPPlatform.iOS:
      case MPPlatform.macOS:
      case MPPlatform.windows:
      case MPPlatform.linux:
        return false;
    }
  }

  /// Get cursor type for interactive elements
  static MouseCursor get interactiveCursor => SystemMouseCursors.click;

  /// Check if platform supports haptic feedback
  bool get supportsHaptics {
    switch (_currentPlatform) {
      case MPPlatform.iOS:
      case MPPlatform.android:
        return true;
      case MPPlatform.macOS:
      case MPPlatform.windows:
      case MPPlatform.linux:
      case MPPlatform.web:
        return false;
    }
  }

  /// Trigger haptic feedback based on platform
  Future<void> hapticFeedback({
    MPHapticType type = MPHapticType.medium,
  }) async {
    if (!supportsHaptics) return;

    try {
      switch (type) {
        case MPHapticType.light:
          await HapticFeedback.lightImpact();
          break;
        case MPHapticType.medium:
          await HapticFeedback.mediumImpact();
          break;
        case MPHapticType.heavy:
          await HapticFeedback.heavyImpact();
          break;
        case MPHapticType.selection:
          await HapticFeedback.selectionClick();
          break;
      }
    } catch (e) {
      // Haptic feedback not supported or failed silently
      debugPrint('Haptic feedback failed: $e');
    }
  }

  /// Get scroll physics for current platform
  ScrollPhysics get scrollPhysics {
    switch (_currentPlatform) {
      case MPPlatform.iOS:
        return const BouncingScrollPhysics();
      case MPPlatform.android:
        return const ClampingScrollPhysics();
      case MPPlatform.macOS:
        return const BouncingScrollPhysics();
      case MPPlatform.windows:
      case MPPlatform.linux:
        return const ClampingScrollPhysics();
      case MPPlatform.web:
        return const BouncingScrollPhysics();
    }
  }

  /// Get drag start behavior for current platform
  /// Note: Returns true for down behavior, false for start behavior
  bool get useDownDragStartBehavior {
    switch (_currentPlatform) {
      case MPPlatform.iOS:
      case MPPlatform.android:
        return true;
      case MPPlatform.macOS:
      case MPPlatform.windows:
      case MPPlatform.linux:
      case MPPlatform.web:
        return false;
    }
  }

  /// Check if platform supports keyboard shortcuts
  bool get supportsKeyboardShortcuts => isDesktop || isWeb;

  /// Get default dialog animation duration for platform
  Duration get dialogAnimationDuration {
    switch (_currentPlatform) {
      case MPPlatform.iOS:
        return const Duration(milliseconds: 350);
      case MPPlatform.android:
        return const Duration(milliseconds: 250);
      case MPPlatform.macOS:
      case MPPlatform.windows:
      case MPPlatform.linux:
        return const Duration(milliseconds: 200);
      case MPPlatform.web:
        return const Duration(milliseconds: 250);
    }
  }

  /// Get page transition duration for platform
  Duration get pageTransitionDuration {
    switch (_currentPlatform) {
      case MPPlatform.iOS:
        return const Duration(milliseconds: 350);
      case MPPlatform.android:
        return const Duration(milliseconds: 300);
      case MPPlatform.macOS:
      case MPPlatform.windows:
      case MPPlatform.linux:
        return const Duration(milliseconds: 200);
      case MPPlatform.web:
        return const Duration(milliseconds: 250);
    }
  }
}

/// Supported platforms
enum MPPlatform {
  iOS,
  android,
  macOS,
  windows,
  linux,
  web,
}

/// Haptic feedback types
enum MPHapticType {
  /// Light impact for subtle feedback
  light,

  /// Medium impact for standard feedback
  medium,

  /// Heavy impact for strong feedback
  heavy,

  /// Selection click feedback
  selection,
}

/// Extension on BuildContext to easily access platform interaction settings
extension MPPlatformInteractionContext on BuildContext {
  /// Get platform interaction settings
  MPPlatformInteraction get platformInteraction =>
      MPPlatformInteraction.instance;

  /// Check if current platform is mobile
  bool get isMobile => platformInteraction.isMobile;

  /// Check if current platform is desktop
  bool get isDesktop => platformInteraction.isDesktop;

  /// Check if current platform is web
  bool get isWeb => platformInteraction.isWeb;

  /// Get minimum tap target size
  double get minTapTargetSize => platformInteraction.minTapTargetSize;

  /// Check if hover effects should be enabled
  bool get enableHoverEffects => platformInteraction.enableHoverEffects;

  /// Check if ripple effects should be enabled
  bool get enableRippleEffects => platformInteraction.enableRippleEffects;

  /// Get scroll physics for current platform
  ScrollPhysics get platformScrollPhysics =>
      platformInteraction.scrollPhysics;

  /// Trigger haptic feedback
  Future<void> hapticFeedback({
    MPHapticType type = MPHapticType.medium,
  }) =>
      platformInteraction.hapticFeedback(type: type);

  /// Get drag start behavior for current platform
  bool get useDownDragStartBehavior =>
      platformInteraction.useDownDragStartBehavior;
}
