import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// A customizable switch component with theme support and animations.
///
/// This component wraps [flutter_switch] with Micropack UI Kit's
/// theme system, providing consistent styling across the app.
///
/// Example:
/// ```dart
/// MPSwitch(
///   value: true,
///   onToggle: (value) => print('Switch toggled: $value'),
/// )
/// ```
class MPSwitch extends StatefulWidget {
  /// Creates a new [MPSwitch] widget.
  const MPSwitch({
    super.key,
    required this.value,
    required this.onToggle,
    this.width = 50.0,
    this.height = 28.0,
    this.toggleSize = 25.0,
    this.borderRadius = 30.0,
    this.padding = 4.0,
    this.showOnOff = false,
    this.activeColor,
    this.inactiveColor,
    this.toggleColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.duration = const Duration(milliseconds: 200),
    this.disabled = false,
    this.semanticLabel,
    this.semanticHint,
    this.focusNode,
    this.autofocus = false,
    this.switchBorder,
    this.activeBorder,
    this.inactiveBorder,
    this.activeIcon,
    this.inactiveIcon,
  });

  /// Whether the switch is on or off.
  final bool value;

  /// Called when the switch value should change.
  final ValueChanged<bool>? onToggle;

  /// Total width of the switch.
  final double width;

  /// Total height of the switch.
  final double height;

  /// Size of the toggle circle.
  final double toggleSize;

  /// Border radius of the switch container.
  final double borderRadius;

  /// Padding between toggle and border.
  final double padding;

  /// Whether to show ON/OFF text indicators.
  final bool showOnOff;

  /// Color when switch is on (active).
  ///
  /// If null, uses theme primary color.
  final Color? activeColor;

  /// Color when switch is off (inactive).
  ///
  /// If null, uses theme appropriate color.
  final Color? inactiveColor;

  /// Color of the toggle circle.
  final Color? toggleColor;

  /// Text color when switch is on.
  ///
  /// Only used if [showOnOff] is true.
  final Color? activeTextColor;

  /// Text color when switch is off.
  ///
  /// Only used if [showOnOff] is true.
  final Color? inactiveTextColor;

  /// Duration of toggle animation.
  final Duration duration;

  /// Whether the switch is disabled.
  final bool disabled;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Semantic hint for accessibility.
  final String? semanticHint;

  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Whether this switch should autofocus on mount.
  final bool autofocus;

  /// Border for all states.
  final BoxBorder? switchBorder;

  /// Border when switch is on.
  final BoxBorder? activeBorder;

  /// Border when switch is off.
  final BoxBorder? inactiveBorder;

  /// Icon to show when switch is on.
  final Widget? activeIcon;

  /// Icon to show when switch is off.
  final Widget? inactiveIcon;

  @override
  State<MPSwitch> createState() => _MPSwitchState();
}

class _MPSwitchState extends State<MPSwitch> {
  bool get _disabled => widget.onToggle == null || widget.disabled;

  Color _getActiveColor() {
    if (_disabled) return context.mp.disabledColor.withOpacity(0.5);
    return widget.activeColor ?? context.mp.primary;
  }

  Color _getInactiveColor() {
    if (_disabled) return context.mp.disabledColor.withOpacity(0.3);
    return widget.inactiveColor ?? context.mp.neutral70;
  }

  Color _getToggleColor() {
    if (widget.toggleColor != null) return widget.toggleColor!;
    if (_disabled) return Colors.white.withOpacity(0.5);
    return Colors.white;
  }

  Color _getActiveTextColor() {
    if (widget.activeTextColor != null) return widget.activeTextColor!;
    return Colors.white;
  }

  Color _getInactiveTextColor() {
    if (widget.inactiveTextColor != null) return widget.inactiveTextColor!;
    return context.mp.textColor;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel ?? (widget.value ? 'On' : 'Off'),
      hint: widget.semanticHint ?? 'Switch',
      checked: widget.value,
      button: true,
      enabled: !_disabled,
      child: Focus(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        child: FlutterSwitch(
          value: widget.value,
          onToggle: _disabled ? (_) => {} : widget.onToggle!,
          width: widget.width,
          height: widget.height,
          toggleSize: widget.toggleSize,
          borderRadius: widget.borderRadius,
          padding: widget.padding,
          showOnOff: widget.showOnOff,
          activeColor: _getActiveColor(),
          inactiveColor: _getInactiveColor(),
          activeToggleColor: _getToggleColor(),
          inactiveToggleColor: _getToggleColor(),
          activeText: 'ON',
          inactiveText: 'OFF',
          activeTextColor: _getActiveTextColor(),
          inactiveTextColor: _getInactiveTextColor(),
          duration: widget.duration,
          disabled: _disabled,
          switchBorder: widget.switchBorder,
          activeIcon: widget.activeIcon,
          inactiveIcon: widget.inactiveIcon,
        ),
      ),
    );
  }
}
