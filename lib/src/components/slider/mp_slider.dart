import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_slider_enums.dart';

/// A slider component for selecting a single value from a range.
///
/// This component provides a flexible slider with theme support,
/// multiple variants, and accessibility features.
///
/// Example:
/// ```dart
/// MPSlider(
///   value: _sliderValue,
///   onChanged: (value) => setState(() => _sliderValue = value),
///   min: 0,
///   max: 100,
///   divisions: 10,
/// )
/// ```
class MPSlider extends StatelessWidget {
  /// Creates a new [MPSlider] widget.
  const MPSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.variant = MPSliderVariant.primary,
    this.size = MPSliderSize.medium,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.overlayColor,
    this.semanticLabel,
    this.semanticValue,
    this.enabled = true,
    this.autofocus = false,
  });

  /// The current value of the slider.
  ///
  /// Must be between [min] and [max].
  final double value;

  /// Callback when the slider value changes.
  final ValueChanged<double>? onChanged;

  /// The visual style variant of the slider.
  final MPSliderVariant variant;

  /// The size of the slider.
  final MPSliderSize size;

  /// The minimum value the slider can represent.
  final double min;

  /// The maximum value the slider can represent.
  final double max;

  /// The number of discrete divisions.
  ///
  /// If null, the slider is continuous.
  final int? divisions;

  /// A label to show above the thumb when the slider is active.
  ///
  /// If null, the value is displayed as a percentage.
  final String? label;

  /// The color of the active portion of the slider track.
  ///
  /// If null, uses theme color based on [variant].
  final Color? activeColor;

  /// The color of the inactive portion of the slider track.
  ///
  /// If null, uses theme color.
  final Color? inactiveColor;

  /// The color of the slider thumb.
  ///
  /// If null, uses theme color based on [variant].
  final Color? thumbColor;

  /// The color of the slider thumb overlay (ripple effect).
  ///
  /// If null, uses theme color based on [variant].
  final Color? overlayColor;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Semantic value for accessibility (e.g., "50%").
  final String? semanticValue;

  /// Whether the slider is enabled for interaction.
  final bool enabled;

  /// Whether the slider should autofocus on mount.
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    // Handle edge case: if min equals max, return empty widget
    if (min >= max) {
      return const SizedBox.shrink();
    }

    final config = _MPSliderConfig();

    final slider = Slider(
      value: value.clamp(min, max),
      min: min,
      max: max,
      divisions: divisions,
      label: label ?? _getLabel(config),
      activeColor: activeColor ?? config.getActiveColor(variant, context),
      inactiveColor: inactiveColor ?? config.getInactiveColor(context),
      onChanged: enabled ? onChanged : null,
      autofocus: autofocus,
      semanticFormatterCallback: (value) {
        return semanticValue ?? '${value.toInt()}%';
      },
    );

    // Wrap with Semantics widget if semanticLabel is provided
    if (semanticLabel != null) {
      return Semantics(
        label: semanticLabel,
        container: true,
        child: slider,
      );
    }

    return slider;
  }

  String _getLabel(_MPSliderConfig config) {
    final range = max - min;
    if (range == 0) return '${value.toInt()}%';
    final percentage = ((value - min) / range * 100).toInt();
    return '$percentage%';
  }
}

/// Configuration class for MPSlider
class _MPSliderConfig {
  Color getActiveColor(MPSliderVariant variant, BuildContext context) {
    switch (variant) {
      case MPSliderVariant.primary:
        return context.mp.primary;
      case MPSliderVariant.secondary:
        return context.mp.subtitleColor;
      case MPSliderVariant.success:
        return context.mp.successColor;
      case MPSliderVariant.warning:
        return context.mp.warningColor;
      case MPSliderVariant.error:
        return context.mp.errorColor;
      case MPSliderVariant.info:
        return context.mp.infoColor;
    }
  }

  Color getInactiveColor(BuildContext context) {
    return context.mp.isDarkMode
        ? const Color(0xFF374151)
        : const Color(0xFFE5E7EB);
  }
}
