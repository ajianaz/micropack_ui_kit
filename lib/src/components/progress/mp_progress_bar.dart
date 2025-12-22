import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_progress_bar_enums.dart';

/// A progress bar component with theme support and multiple variants.
///
/// Supports both linear and circular progress indicators.
///
/// Example:
/// ```dart
/// MPProgressBar(
///   value: 0.7,
///   variant: MPProgressBarVariant.primary,
/// )
/// ```
class MPProgressBar extends StatelessWidget {
  /// Creates a new linear [MPProgressBar] widget.
  const MPProgressBar.linear({
    super.key,
    required this.value,
    this.variant = MPProgressBarVariant.primary,
    this.size = MPProgressBarSize.medium,
    this.minHeight,
    this.backgroundColor,
    this.progressColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.borderRadius,
  })  : type = MPProgressBarType.linear,
        strokeWidth = null;

  /// Creates a new circular [MPProgressBar] widget.
  const MPProgressBar.circular({
    super.key,
    required this.value,
    this.variant = MPProgressBarVariant.primary,
    this.size = MPProgressBarSize.medium,
    this.strokeWidth,
    this.backgroundColor,
    this.progressColor,
    this.semanticsLabel,
    this.semanticsValue,
  }) : type = MPProgressBarType.circular,
       minHeight = null,
       borderRadius = null;

  /// The progress value (0.0 to 1.0).
  final double value;

  /// The visual style variant of the progress bar.
  final MPProgressBarVariant variant;

  /// The size of the progress bar.
  final MPProgressBarSize size;

  /// The type of progress bar (linear or circular).
  final MPProgressBarType type;

  /// The minimum height of the linear progress bar.
  final double? minHeight;

  /// The background color of the progress bar track.
  final Color? backgroundColor;

  /// The color of the progress indicator.
  final Color? progressColor;

  /// Semantic label for accessibility.
  final String? semanticsLabel;

  /// The value for semantics (e.g., "70%").
  final String? semanticsValue;

  /// The stroke width of the circular progress indicator.
  final double? strokeWidth;

  /// The border radius of the linear progress bar.
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      value: semanticsValue ?? '${(value * 100).toInt()}%',
      child: type == MPProgressBarType.linear
          ? _buildLinearProgress(context)
          : _buildCircularProgress(context),
    );
  }

  Widget _buildLinearProgress(BuildContext context) {
    final config = _MPProgressBarConfig();

    return Container(
      height: minHeight ?? config.getLinearHeight(size),
      decoration: BoxDecoration(
        color: backgroundColor ?? config.getTrackColor(context),
        borderRadius: BorderRadius.circular(borderRadius ?? config.getBorderRadius(size)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? config.getBorderRadius(size)),
        child: LinearProgressIndicator(
          value: value.clamp(0.0, 1.0),
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(
            progressColor ?? config.getProgressColor(variant, context),
          ),
          minHeight: minHeight ?? config.getLinearHeight(size),
        ),
      ),
    );
  }

  Widget _buildCircularProgress(BuildContext context) {
    final config = _MPProgressBarConfig();

    return SizedBox(
      width: config.getCircularSize(size),
      height: config.getCircularSize(size),
      child: CircularProgressIndicator(
        value: value.clamp(0.0, 1.0),
        backgroundColor: backgroundColor ?? config.getTrackColor(context),
        valueColor: AlwaysStoppedAnimation<Color>(
          progressColor ?? config.getProgressColor(variant, context),
        ),
        strokeWidth: strokeWidth ?? config.getStrokeWidth(size),
      ),
    );
  }
}

/// Configuration class for MPProgressBar
class _MPProgressBarConfig {
  // Size configurations
  static const Map<MPProgressBarSize, double> linearHeights = {
    MPProgressBarSize.small: 4.0,
    MPProgressBarSize.medium: 6.0,
    MPProgressBarSize.large: 8.0,
  };

  static const Map<MPProgressBarSize, double> circularSizes = {
    MPProgressBarSize.small: 20.0,
    MPProgressBarSize.medium: 32.0,
    MPProgressBarSize.large: 48.0,
  };

  static const Map<MPProgressBarSize, double> strokeWidths = {
    MPProgressBarSize.small: 2.0,
    MPProgressBarSize.medium: 3.0,
    MPProgressBarSize.large: 4.0,
  };

  static const Map<MPProgressBarSize, double> borderRadiuses = {
    MPProgressBarSize.small: 2.0,
    MPProgressBarSize.medium: 3.0,
    MPProgressBarSize.large: 4.0,
  };

  double getLinearHeight(MPProgressBarSize size) => linearHeights[size]!;
  double getCircularSize(MPProgressBarSize size) => circularSizes[size]!;
  double getStrokeWidth(MPProgressBarSize size) => strokeWidths[size]!;
  double getBorderRadius(MPProgressBarSize size) => borderRadiuses[size]!;

  Color getTrackColor(BuildContext context) {
    return context.mp.isDarkMode
        ? const Color(0xFF374151)
        : const Color(0xFFE5E7EB);
  }

  Color getProgressColor(MPProgressBarVariant variant, BuildContext context) {
    switch (variant) {
      case MPProgressBarVariant.primary:
        return context.mp.primary;
      case MPProgressBarVariant.secondary:
        return context.mp.subtitleColor;
      case MPProgressBarVariant.success:
        return context.mp.successColor;
      case MPProgressBarVariant.warning:
        return context.mp.warningColor;
      case MPProgressBarVariant.error:
        return context.mp.errorColor;
      case MPProgressBarVariant.info:
        return context.mp.infoColor;
    }
  }
}
