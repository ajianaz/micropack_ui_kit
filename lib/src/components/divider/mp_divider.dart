import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_divider_enums.dart';

/// MPDivider - Theme-aware divider component
///
/// This component provides a simple, styled divider with support for
/// multiple orientations, thicknesses, and styles.
///
/// Example:
/// ```dart
/// MPDivider(
///   orientation: MPDividerOrientation.horizontal,
///   thickness: MPDividerThickness.medium,
/// )
/// ```
class MPDivider extends StatelessWidget {
  const MPDivider({
    super.key,
    this.orientation = MPDividerOrientation.horizontal,
    this.thickness = MPDividerThickness.thin,
    this.style = MPDividerStyle.solid,
    this.color,
    this.height,
    this.width,
    this.indent,
    this.endIndent,
    this.label,
    this.semanticLabel,
  });

  /// The orientation of the divider.
  final MPDividerOrientation orientation;

  /// The thickness of the divider.
  final MPDividerThickness thickness;

  /// The style of the divider line.
  final MPDividerStyle style;

  /// Custom color for the divider.
  ///
  /// If null, uses theme divider color.
  final Color? color;

  /// Height constraint for horizontal dividers.
  final double? height;

  /// Width constraint for vertical dividers.
  final double? width;

  /// Leading indentation for horizontal dividers.
  final double? indent;

  /// Trailing indentation for horizontal dividers.
  final double? endIndent;

  /// Optional label to display in the divider.
  final String? label;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final config = _MPDividerConfig();
    final dividerColor = color ?? context.mp.dividerColor;
    final lineThickness = config.getThickness(thickness);

    if (label != null) {
      return _buildLabeledDivider(
        context,
        config,
        dividerColor,
        lineThickness,
      );
    }

    return Semantics(
      label: semanticLabel ?? 'Divider',
      child: Container(
        width: orientation == MPDividerOrientation.vertical
            ? (width ?? config.getDefaultWidth(thickness))
            : null,
        height: orientation == MPDividerOrientation.horizontal
            ? (height ?? config.getDefaultHeight(thickness))
            : null,
        margin: orientation == MPDividerOrientation.horizontal
            ? EdgeInsetsDirectional.only(
                start: indent ?? 0,
                end: endIndent ?? 0,
              )
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: dividerColor,
          border: style == MPDividerStyle.dashed
              ? Border.all(
                  color: dividerColor,
                  width: lineThickness,
                  style: BorderStyle.solid,
                )
              : null,
        ),
        child: style == MPDividerStyle.solid
            ? null
            : Padding(
                padding: EdgeInsets.all(lineThickness / 2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: dividerColor,
                      width: lineThickness,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildLabeledDivider(
    BuildContext context,
    _MPDividerConfig config,
    Color dividerColor,
    double lineThickness,
  ) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: lineThickness,
            margin: orientation == MPDividerOrientation.horizontal
                ? EdgeInsetsDirectional.only(
                    start: indent ?? 0,
                  )
                : null,
            decoration: BoxDecoration(color: dividerColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MPText(
            label!,
            style: TextStyle(
              color: context.mp.subtitleColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: lineThickness,
            margin: orientation == MPDividerOrientation.horizontal
                ? EdgeInsetsDirectional.only(
                    end: endIndent ?? 0,
                  )
                : null,
            decoration: BoxDecoration(color: dividerColor),
          ),
        ),
      ],
    );
  }
}

/// Configuration class for MPDivider
class _MPDividerConfig {
  double getThickness(MPDividerThickness thickness) {
    switch (thickness) {
      case MPDividerThickness.thin:
        return 1.0;
      case MPDividerThickness.medium:
        return 2.0;
      case MPDividerThickness.thick:
        return 3.0;
    }
  }

  double getDefaultHeight(MPDividerThickness thickness) {
    switch (thickness) {
      case MPDividerThickness.thin:
        return 8.0;
      case MPDividerThickness.medium:
        return 16.0;
      case MPDividerThickness.thick:
        return 24.0;
    }
  }

  double getDefaultWidth(MPDividerThickness thickness) {
    switch (thickness) {
      case MPDividerThickness.thin:
        return 8.0;
      case MPDividerThickness.medium:
        return 16.0;
      case MPDividerThickness.thick:
        return 24.0;
    }
  }
}
