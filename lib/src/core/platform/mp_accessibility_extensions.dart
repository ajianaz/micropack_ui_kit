import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/semantics.dart';

/// Platform-adaptive accessibility extensions
///
/// Provides enhanced accessibility features that adapt to platform conventions:
/// - iOS: VoiceOver optimizations
/// - Android: TalkBack optimizations
/// - Desktop: Screen reader optimizations (NVDA, JAWS, VoiceOver)
/// - Web: ARIA and screen reader optimizations
class MPAccessibilityExtensions {
  MPAccessibilityExtensions._();

  /// Private singleton instance
  static final MPAccessibilityExtensions _instance =
      MPAccessibilityExtensions._();

  /// Get the singleton instance
  static MPAccessibilityExtensions get instance => _instance;

  /// Current platform
  final MPAccessiblePlatform _currentPlatform = _detectPlatform();

  /// Detect current platform for accessibility
  static MPAccessiblePlatform _detectPlatform() {
    if (kIsWeb) return MPAccessiblePlatform.web;
    if (Platform.isIOS) return MPAccessiblePlatform.iOS;
    if (Platform.isAndroid) return MPAccessiblePlatform.android;
    if (Platform.isMacOS) return MPAccessiblePlatform.macOS;
    if (Platform.isWindows) return MPAccessiblePlatform.windows;
    if (Platform.isLinux) return MPAccessiblePlatform.linux;
    return MPAccessiblePlatform.web;
  }

  /// Get current platform
  MPAccessiblePlatform get currentPlatform => _currentPlatform;

  /// Check if platform prefers semantic announcements
  bool get prefersAnnouncements {
    switch (_currentPlatform) {
      case MPAccessiblePlatform.iOS:
      case MPAccessiblePlatform.macOS:
      case MPAccessiblePlatform.web:
        return true;
      case MPAccessiblePlatform.android:
      case MPAccessiblePlatform.windows:
      case MPAccessiblePlatform.linux:
        return false;
    }
  }

  /// Get recommended text scaling factor for platform
  double get recommendedTextScaleFactor {
    switch (_currentPlatform) {
      case MPAccessiblePlatform.iOS:
      case MPAccessiblePlatform.android:
        return 1.0; // System font scaling
      case MPAccessiblePlatform.macOS:
      case MPAccessiblePlatform.windows:
      case MPAccessiblePlatform.linux:
        return 1.0;
      case MPAccessiblePlatform.web:
        return 1.0;
    }
  }

  /// Check if platform supports semantic gestures
  bool get supportsSemanticGestures {
    switch (_currentPlatform) {
      case MPAccessiblePlatform.iOS:
      case MPAccessiblePlatform.android:
        return true;
      case MPAccessiblePlatform.macOS:
      case MPAccessiblePlatform.windows:
      case MPAccessiblePlatform.linux:
      case MPAccessiblePlatform.web:
        return false;
    }
  }

  /// Get platform-specific hint text for common actions
  String getHintForAction(MPAccessibilityAction action) {
    switch (action) {
      case MPAccessibilityAction.tap:
        switch (_currentPlatform) {
          case MPAccessiblePlatform.iOS:
            return 'Double tap to activate';
          case MPAccessiblePlatform.android:
            return 'Double tap to activate';
          case MPAccessiblePlatform.macOS:
          case MPAccessiblePlatform.windows:
          case MPAccessiblePlatform.linux:
            return 'Press to activate';
          case MPAccessiblePlatform.web:
            return 'Click to activate';
        }
      case MPAccessibilityAction.longPress:
        switch (_currentPlatform) {
          case MPAccessiblePlatform.iOS:
            return 'Long press for options';
          case MPAccessiblePlatform.android:
            return 'Long press for options';
          case MPAccessiblePlatform.macOS:
          case MPAccessiblePlatform.windows:
          case MPAccessiblePlatform.linux:
            return 'Press and hold for options';
          case MPAccessiblePlatform.web:
            return 'Right click for options';
        }
      case MPAccessibilityAction.swipe:
        switch (_currentPlatform) {
          case MPAccessiblePlatform.iOS:
          case MPAccessiblePlatform.android:
            return 'Swipe for more options';
          case MPAccessiblePlatform.macOS:
          case MPAccessiblePlatform.windows:
          case MPAccessiblePlatform.linux:
          case MPAccessiblePlatform.web:
            return 'Scroll for more options';
        }
      case MPAccessibilityAction.scroll:
        return 'Scroll to navigate';
      case MPAccessibilityAction.zoom:
        return 'Pinch to zoom';
    }
  }

  /// Get platform-specific live region announcement mode
  MPA11yLiveRegion get liveRegionMode {
    switch (_currentPlatform) {
      case MPAccessiblePlatform.iOS:
      case MPAccessiblePlatform.macOS:
        return MPA11yLiveRegion.polite;
      case MPAccessiblePlatform.android:
      case MPAccessiblePlatform.windows:
      case MPAccessiblePlatform.linux:
        return MPA11yLiveRegion.polite;
      case MPAccessiblePlatform.web:
        return MPA11yLiveRegion.polite;
    }
  }

  /// Check if semantic labels should be verbose
  bool get useVerboseLabels {
    switch (_currentPlatform) {
      case MPAccessiblePlatform.iOS:
      case MPAccessiblePlatform.macOS:
        return true;
      case MPAccessiblePlatform.android:
      case MPAccessiblePlatform.windows:
      case MPAccessiblePlatform.linux:
      case MPAccessiblePlatform.web:
        return false;
    }
  }

  /// Get platform-specific heading level order
  bool get isHeadingLevelStrict {
    switch (_currentPlatform) {
      case MPAccessiblePlatform.web:
        return true; // Web requires strict heading hierarchy
      case MPAccessiblePlatform.iOS:
      case MPAccessiblePlatform.macOS:
      case MPAccessiblePlatform.android:
      case MPAccessiblePlatform.windows:
      case MPAccessiblePlatform.linux:
        return false;
    }
  }
}

/// Platform type for accessibility
enum MPAccessiblePlatform {
  iOS,
  android,
  macOS,
  windows,
  linux,
  web,
}

/// Common accessibility actions
enum MPAccessibilityAction {
  tap,
  longPress,
  swipe,
  scroll,
  zoom,
}

/// Live region announcement modes
enum MPA11yLiveRegion {
  /// Interrupts current speech for announcement
  assertive,

  /// Waits for current speech to finish
  polite,

  /// No announcement
  off,
}

/// Extension on SemanticsProperties for platform-specific enhancements
extension MPSemanticsPropertiesExtension on SemanticsProperties {
  /// Create platform-adaptive hint text
  String? adaptiveHint({
    required String baseHint,
    MPAccessibilityAction? action,
  }) {
    final platform = MPAccessibilityExtensions.instance.currentPlatform;
    final actionHint = action != null
        ? MPAccessibilityExtensions.instance.getHintForAction(action)
        : null;

    if (actionHint != null) {
      return '$baseHint. $actionHint';
    }
    return baseHint;
  }
}

/// Extension on Widget for accessibility wrapping
extension MPAccessibilityWidgetExtension on Widget {
  /// Wrap with platform-adaptive semantics
  Widget withAccessibility({
    String? label,
    String? hint,
    MPAccessibilityAction? action,
    bool? enabled,
    bool? selected,
    bool? checked,
    bool? inMutuallyExclusiveGroup,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
  }) {
    final adaptiveHint = hint != null
        ? MPAccessibilityExtensions.instance.getHintForAction(
            action ?? MPAccessibilityAction.tap,
          )
        : null;

    return Semantics(
      label: label,
      hint: adaptiveHint ?? hint,
      enabled: enabled,
      selected: selected,
      checked: checked,
      inMutuallyExclusiveGroup: inMutuallyExclusiveGroup,
      button: onTap != null,
      link: onTap != null,
      onTap: onTap,
      onLongPress: onLongPress,
      child: this,
    );
  }

  /// Wrap with live region semantics
  Widget withLiveRegion({
    required MPA11yLiveRegion mode,
    String? label,
  }) {
    return Semantics(
      liveRegion: mode != MPA11yLiveRegion.off,
      label: label,
      child: this,
    );
  }

  /// Mark as heading with platform-appropriate level
  Widget asHeading({
    int level = 1,
    String? text,
  }) {
    final extensions = MPAccessibilityExtensions.instance;
    final useStrictLevel = extensions.isHeadingLevelStrict;

    return Semantics(
      headingLevel: useStrictLevel ? level : 1,
      header: true,
      label: text,
      child: this,
    );
  }

  /// Mark as image with accessibility label
  Widget asImage({
    String? label,
    bool decorative = false,
  }) {
    return Semantics(
      image: true,
      label: decorative ? null : label,
      child: this,
    );
  }

  /// Mark as interactive element
  Widget asInteractive({
    String? label,
    String? hint,
    VoidCallback? onTap,
  }) {
    return Semantics(
      button: true,
      label: label,
      hint: hint,
      onTap: onTap,
      child: this,
    );
  }

  /// Exclude from semantics
  Widget excludeFromSemantics() {
    return Semantics(
      container: false,
      child: this,
    );
  }
}

/// Extension on BuildContext for accessibility utilities
extension MPAccessibilityContext on BuildContext {
  /// Announce message to screen reader
  void announceToScreenReader(
    String message, {
    MPA11yLiveRegion mode = MPA11yLiveRegion.polite,
  }) {
    // This would typically use a proper announcement mechanism
    // For now, we'll use the Semantics service
    try {
      SemanticsService.announce(message, TextDirection.ltr);
    } catch (e) {
      debugPrint('Failed to announce: $e');
    }
  }

  /// Check if screen reader is active
  bool get isScreenReaderActive {
    return MediaQuery.of(this).accessibleNavigation;
  }

  /// Check if reduce motion is enabled
  bool get reduceMotion {
    return MediaQuery.of(this).disableAnimations;
  }

  /// Check if high contrast is enabled
  bool get highContrast {
    return MediaQuery.of(this).highContrast;
  }

  /// Get text scale factor
  double get textScaleFactor {
    return MediaQuery.of(this).textScaler.scale(1.0);
  }

  /// Check if bold text is preferred
  bool get preferBoldText {
    return MediaQuery.of(this).boldText;
  }

  /// Check if platform is in accessibility mode
  bool get isInAccessibilityMode {
    return isScreenReaderActive ||
        reduceMotion ||
        highContrast ||
        preferBoldText;
  }
}

/// Helper for creating platform-adfocus widgets
class MPFocusWidget extends StatefulWidget {
  const MPFocusWidget({
    super.key,
    required this.child,
    this.autofocus = false,
    this.onFocusChange,
  });

  final Widget child;
  final bool autofocus;
  final ValueChanged<bool>? onFocusChange;

  @override
  State<MPFocusWidget> createState() => _MPFocusWidgetState();
}

class _MPFocusWidgetState extends State<MPFocusWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    if (widget.autofocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    widget.onFocusChange?.call(_focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      child: widget.child,
    );
  }
}

/// Helper for keyboard navigation
class MPKeyboardNavigationHandler extends StatelessWidget {
  const MPKeyboardNavigationHandler({
    super.key,
    required this.child,
    this.focusNode,
    this.onKeyPress,
    this.shortcuts,
  });

  final Widget child;
  final FocusNode? focusNode;
  final ValueChanged<KeyEvent>? onKeyPress;
  final Map<ShortcutActivator, Intent>? shortcuts;

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      onKeyEvent: (node, event) {
        onKeyPress?.call(event);
        return KeyEventResult.ignored;
      },
      child: Shortcuts(
        shortcuts: shortcuts ?? _defaultShortcuts(),
        child: child,
      ),
    );
  }

  static Map<ShortcutActivator, Intent> _defaultShortcuts() {
    return {
      const SingleActivator(LogicalKeyboardKey.tab): const MPNextFocusIntent(),
      const SingleActivator(LogicalKeyboardKey.arrowRight):
          const MPNextFocusIntent(),
      const SingleActivator(LogicalKeyboardKey.arrowDown):
          const MPNextFocusIntent(),
      const SingleActivator(LogicalKeyboardKey.space):
          const MPActivateIntent(),
      const SingleActivator(LogicalKeyboardKey.enter):
          const MPActivateIntent(),
    };
  }
}

/// Intent for activating focused widget
class MPActivateIntent extends Intent {
  const MPActivateIntent();
}

/// Intent for moving to next focusable widget
class MPNextFocusIntent extends Intent {
  const MPNextFocusIntent();
}
