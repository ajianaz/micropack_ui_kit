import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_checkbox_enums.dart';

/// A customizable checkbox component with theme support, animations,
/// and accessibility features.
///
/// This checkbox supports multiple sizes, check states, and provides
/// smooth animations for state changes.
///
/// Example:
/// ```dart
/// MPCheckbox(
///   value: true,
///   onChanged: (value) => print('Checkbox changed: $value'),
/// )
/// ```
class MPCheckbox extends StatefulWidget {
  /// Creates a new [MPCheckbox] widget.
  const MPCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = MPCheckboxSize.medium,
    this.checkState = MPCheckboxCheckState.auto,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
    this.checkColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.semanticLabel,
    this.semanticHint,
    this.animationDuration,
    this.animationCurve,
    this.respectReducedMotion = true,
    this.focusNode,
    this.autofocus = false,
  });

  /// Whether the checkbox is checked or unchecked.
  ///
  /// If [checkState] is [MPCheckboxCheckState.auto], this value
  /// determines the check state.
  final bool value;

  /// Called when the checkbox value should change.
  ///
  /// The checkbox passes the new value to the callback but does not
  /// actually change state until the parent widget updates the value.
  final ValueChanged<bool?>? onChanged;

  /// The size of the checkbox.
  final MPCheckboxSize size;

  /// The check state of the checkbox.
  ///
  /// If set to [MPCheckboxCheckState.auto], the check state is
  /// determined by [value]. Otherwise, the checkbox will display
  /// the specified state regardless of [value].
  final MPCheckboxCheckState checkState;

  /// Whether the checkbox is enabled for interaction.
  final bool enabled;

  /// The color to use when the checkbox is active (checked).
  ///
  /// If null, uses theme primary color.
  final Color? activeColor;

  /// The color to use when the checkbox is inactive (unchecked).
  ///
  /// If null, uses theme appropriate color.
  final Color? inactiveColor;

  /// The color of the check icon.
  ///
  /// If null, uses white or theme appropriate color.
  final Color? checkColor;

  /// The color of the checkbox border.
  ///
  /// If null, uses theme appropriate border color.
  final Color? borderColor;

  /// The width of the checkbox border.
  final double? borderWidth;

  /// The border radius of the checkbox.
  final double? borderRadius;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Semantic hint for accessibility.
  final String? semanticHint;

  /// Duration for state change animations.
  final Duration? animationDuration;

  /// Curve for animations.
  final Curve? animationCurve;

  /// Whether to respect reduced motion accessibility setting.
  final bool respectReducedMotion;

  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Whether this checkbox should autofocus on mount.
  final bool autofocus;

  @override
  State<MPCheckbox> createState() => _MPCheckboxState();

  /// Creates a checkbox that's already checked.
  const MPCheckbox.checked({
    super.key,
    required this.onChanged,
    this.size = MPCheckboxSize.medium,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
    this.checkColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.semanticLabel,
    this.semanticHint,
    this.animationDuration,
    this.animationCurve,
    this.respectReducedMotion = true,
    this.focusNode,
    this.autofocus = false,
  })  : value = true,
        checkState = MPCheckboxCheckState.auto;

  /// Creates a checkbox that's already unchecked.
  const MPCheckbox.unchecked({
    super.key,
    required this.onChanged,
    this.size = MPCheckboxSize.medium,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
    this.checkColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.semanticLabel,
    this.semanticHint,
    this.animationDuration,
    this.animationCurve,
    this.respectReducedMotion = true,
    this.focusNode,
    this.autofocus = false,
  })  : value = false,
        checkState = MPCheckboxCheckState.auto;

  /// Creates an indeterminate checkbox.
  const MPCheckbox.indeterminate({
    super.key,
    required this.onChanged,
    this.size = MPCheckboxSize.medium,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
    this.checkColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.semanticLabel,
    this.semanticHint,
    this.animationDuration,
    this.animationCurve,
    this.respectReducedMotion = true,
    this.focusNode,
    this.autofocus = false,
  })  : value = false,
        checkState = MPCheckboxCheckState.indeterminate;
}

class _MPCheckboxState extends State<MPCheckbox>
    with TickerProviderStateMixin {
  late AnimationController _checkController;
  late AnimationController _borderController;
  late Animation<double> _checkAnimation;
  late Animation<double> _scaleAnimation;

  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  // Performance optimization: cache expensive calculations
  double? _cachedSize;
  Color? _cachedActiveColor;
  Color? _cachedInactiveColor;
  Color? _cachedCheckColor;
  Color? _cachedBorderColor;
  double? _cachedBorderWidth;
  double? _cachedBorderRadius;
  bool _isCacheValid = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  @override
  void dispose() {
    _checkController.dispose();
    _borderController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    final duration = widget.respectReducedMotion &&
            MediaQuery.maybeOf(context)?.disableAnimations == true
        ? const Duration(milliseconds: 50)
        : (widget.animationDuration ?? const Duration(milliseconds: 200));

    _checkController = AnimationController(
      duration: duration,
      vsync: this,
    );

    _borderController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _checkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _checkController,
      curve: widget.animationCurve ?? Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _borderController,
      curve: Curves.easeOut,
    ));

    _updateAnimationState();
  }

  void _updateAnimationState() {
    if (_isChecked || _isIndeterminate) {
      _checkController.forward();
    } else {
      _checkController.reverse();
    }
  }

  @override
  void didUpdateWidget(MPCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _invalidateCache();

    if (oldWidget.value != widget.value ||
        oldWidget.checkState != widget.checkState) {
      _updateAnimationState();
    }
  }

  void _invalidateCache() {
    _isCacheValid = false;
  }

  void _initializeCache() {
    if (_isCacheValid) return;

    _cachedSize = _getSize();
    _cachedActiveColor = _getActiveColor();
    _cachedInactiveColor = _getInactiveColor();
    _cachedCheckColor = _getCheckColor();
    _cachedBorderColor = _getBorderColor();
    _cachedBorderWidth = _getBorderWidth();
    _cachedBorderRadius = _getBorderRadius();
    _isCacheValid = true;
  }

  MPCheckboxCheckState get _effectiveCheckState {
    if (widget.checkState == MPCheckboxCheckState.auto) {
      return widget.value ? MPCheckboxCheckState.checked : MPCheckboxCheckState.unchecked;
    }
    return widget.checkState;
  }

  bool get _isChecked => _effectiveCheckState == MPCheckboxCheckState.checked;
  bool get _isIndeterminate => _effectiveCheckState == MPCheckboxCheckState.indeterminate;

  double _getSize() {
    switch (widget.size) {
      case MPCheckboxSize.small:
        return 24.0;
      case MPCheckboxSize.medium:
        return 32.0;
      case MPCheckboxSize.large:
        return 40.0;
    }
  }

  Color _getActiveColor() {
    if (!widget.enabled) return context.mp.disabledColor;
    return widget.activeColor ?? context.mp.primary;
  }

  Color _getInactiveColor() {
    if (!widget.enabled) return context.mp.disabledColor.withOpacity(0.3);
    return widget.inactiveColor ?? Colors.transparent;
  }

  Color _getCheckColor() {
    if (!widget.enabled) return context.mp.disabledColor.withOpacity(0.6);
    return widget.checkColor ?? Colors.white;
  }

  Color _getBorderColor() {
    if (!widget.enabled) return context.mp.disabledColor.withOpacity(0.3);
    if (_isChecked || _isIndeterminate) return _getActiveColor();
    return widget.borderColor ?? context.mp.borderColor;
  }

  double _getBorderWidth() {
    return widget.borderWidth ?? (_isChecked || _isIndeterminate ? 0.0 : 2.0);
  }

  double _getBorderRadius() {
    return widget.borderRadius ?? 4.0;
  }

  IconData? _getCheckIcon() {
    if (_isIndeterminate) return Icons.remove;
    if (_isChecked) return Icons.check;
    return null;
  }

  void _handleTap() {
    if (!widget.enabled || widget.onChanged == null) return;
    widget.onChanged!(!widget.value);
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  void _handleFocusChange(bool isFocused) {
    setState(() {
      _isFocused = isFocused;
    });

    if (isFocused) {
      _borderController.forward();
    } else {
      _borderController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializeCache();

    return RepaintBoundary(
      child: FocusableActionDetector(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        enabled: widget.enabled,
        onShowFocusHighlight: _handleFocusChange,
        onFocusChange: _handleFocusChange,
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              _handleTap();
              return null;
            },
          ),
        },
        child: MouseRegion(
          onEnter: widget.enabled ? (_) => _handleHover(true) : null,
          onExit: widget.enabled ? (_) => _handleHover(false) : null,
          cursor: widget.enabled
              ? SystemMouseCursors.click
              : MouseCursor.defer,
          child: GestureDetector(
            onTap: widget.enabled ? _handleTap : null,
            onTapDown: widget.enabled ? (_) {
              setState(() => _isPressed = true);
            } : null,
            onTapUp: widget.enabled ? (_) {
              setState(() => _isPressed = false);
            } : null,
            onTapCancel: widget.enabled ? () {
              setState(() => _isPressed = false);
            } : null,
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _checkController,
                _borderController,
              ]),
              builder: (context, child) {
                return Semantics(
                  label: widget.semanticLabel ??
                      (_isChecked ? 'Checked' : 'Unchecked'),
                  hint: widget.semanticHint ?? 'Checkbox',
                  checked: _isChecked,
                  button: true,
                  enabled: widget.enabled,
                  child: _buildCheckbox(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox() {
    final size = _cachedSize!;
    final iconSize = size * 0.6;

    return Transform.scale(
      scale: _isPressed ? 0.95 : (_isHovered ? 1.05 : _scaleAnimation.value),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          border: Border.all(
            color: _cachedBorderColor!,
            width: _cachedBorderWidth!,
          ),
          borderRadius: BorderRadius.circular(_cachedBorderRadius!),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                    color: (_cachedActiveColor ?? context.mp.primary)
                        .withValues(alpha: 0.4),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: _checkAnimation.value,
          child: Icon(
            _getCheckIcon(),
            size: iconSize,
            color: _cachedCheckColor!,
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (_isChecked || _isIndeterminate) {
      return _cachedActiveColor!;
    }
    return _cachedInactiveColor!;
  }
}
