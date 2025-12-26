import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_dropdown_enums.dart';

/// A dropdown select component with theme support.
///
/// This wraps Flutter's DropdownButton with Micropack UI Kit's theme system.
///
/// Example:
/// ```dart
/// MPDropdown<int>(
///   value: 1,
///   items: [
///     MPDropdownItem(value: 1, label: 'Option 1'),
///     MPDropdownItem(value: 2, label: 'Option 2'),
///   ],
///   onChanged: (value) => print('Selected: $value'),
/// )
/// ```
class MPDropdown<T> extends StatefulWidget {
  /// Creates a new [MPDropdown] widget.
  const MPDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
    this.disabledHint,
    this.enabled = true,
    this.size = MPDropdownSize.medium,
    this.variant = MPDropdownVariant.outlined,
    this.icon,
    this.iconSize,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.dropdownColor,
    this.menuMaxHeight,
    this.menuWidth,
    this.borderRadius,
    this.semanticLabel,
    this.semanticHint,
  });

  /// The list of items the user can select.
  final List<MPDropdownItem<T>> items;

  /// Called when the user selects an item.
  final ValueChanged<T?>? onChanged;

  /// The currently selected value.
  final T? value;

  /// A placeholder hint to display when no value is selected.
  final String? hint;

  /// A hint to display when the dropdown is disabled.
  final String? disabledHint;

  /// Whether the dropdown is enabled.
  final bool enabled;

  /// The size of the dropdown.
  final MPDropdownSize size;

  /// The visual variant of the dropdown.
  final MPDropdownVariant variant;

  /// Custom icon for the dropdown button.
  final Widget? icon;

  /// Size of the dropdown icon.
  final double? iconSize;

  /// Color of the dropdown icon when disabled.
  final Color? iconDisabledColor;

  /// Color of the dropdown icon when enabled.
  final Color? iconEnabledColor;

  /// Background color of the dropdown menu.
  final Color? dropdownColor;

  /// Maximum height of the dropdown menu.
  final double? menuMaxHeight;

  /// Width of the dropdown menu.
  final double? menuWidth;

  /// Border radius of the dropdown button and menu.
  final double? borderRadius;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Semantic hint for accessibility.
  final String? semanticHint;

  @override
  State<MPDropdown<T>> createState() => _MPDropdownState<T>();
}

class _MPDropdownState<T> extends State<MPDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    final config = _MPDropdownConfig();

    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: config.getContentPadding(widget.size),
        border: _getBorder(config),
        enabledBorder: _getEnabledBorder(config),
        focusedBorder: _getFocusedBorder(config),
        errorBorder: _getErrorBorder(config),
        disabledBorder: _getDisabledBorder(config),
        filled: widget.variant == MPDropdownVariant.filled,
        fillColor: widget.variant == MPDropdownVariant.filled
            ? config.getFillColor(context, widget.enabled)
            : null,
        isDense: true,
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: context.mp.subtitleColor.withValues(alpha: 0.7),
          fontSize: config.getFontSize(widget.size),
        ),
      ),
      isEmpty: widget.value == null,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: widget.value,
          items: _buildMenuItems(),
          onChanged: widget.enabled
              ? widget.onChanged
              : null,
          hint: widget.hint != null
              ? Text(
                  widget.hint!,
                  style: TextStyle(
                    color: context.mp.subtitleColor.withValues(alpha: 0.7),
                    fontSize: config.getFontSize(widget.size),
                  ),
                )
              : null,
          disabledHint: widget.disabledHint != null
              ? Text(
                  widget.disabledHint!,
                  style: TextStyle(
                    color: context.mp.disabledColor,
                    fontSize: config.getFontSize(widget.size),
                  ),
                )
              : null,
          icon: widget.icon ?? const Icon(Icons.arrow_drop_down),
          iconSize: widget.iconSize ?? config.getIconSize(widget.size),
          iconDisabledColor:
              widget.iconDisabledColor ?? context.mp.disabledColor,
          iconEnabledColor:
              widget.iconEnabledColor ?? context.mp.primary,
          dropdownColor: widget.dropdownColor ?? context.mp.cardColor,
          menuMaxHeight: widget.menuMaxHeight ?? 300,
          isExpanded: true,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? config.getBorderRadius(widget.size)),
          style: TextStyle(
            color: context.mp.textColor,
            fontSize: config.getFontSize(widget.size),
          ),
          focusColor: context.mp.primary.withValues(alpha: 0.1),
          selectedItemBuilder: (BuildContext context) {
            return widget.items.map((item) {
              return Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.label,
                      style: TextStyle(
                        color: context.mp.textColor,
                        fontSize: config.getFontSize(widget.size),
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<T>> _buildMenuItems() {
    return widget.items.map((item) {
      return DropdownMenuItem<T>(
        value: item.value,
        child: Row(
          children: [
            if (item.leading != null) ...[
              item.leading!,
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                item.label,
                style: TextStyle(
                  color: context.mp.textColor,
                  fontSize: _MPDropdownConfig().getFontSize(widget.size),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (item.trailing != null) ...[
              const SizedBox(width: 12),
              item.trailing!,
            ],
          ],
        ),
      );
    }).toList();
  }

  InputBorder _getBorder(_MPDropdownConfig config) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(config.getBorderRadius(widget.size)),
      borderSide: BorderSide(
        color: context.mp.borderColor,
        width: 1.5,
      ),
    );
  }

  InputBorder _getEnabledBorder(_MPDropdownConfig config) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(config.getBorderRadius(widget.size)),
      borderSide: BorderSide(
        color: context.mp.borderColor,
        width: 1.5,
      ),
    );
  }

  InputBorder _getFocusedBorder(_MPDropdownConfig config) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(config.getBorderRadius(widget.size)),
      borderSide: BorderSide(
        color: context.mp.primary,
        width: 2,
      ),
    );
  }

  InputBorder _getErrorBorder(_MPDropdownConfig config) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(config.getBorderRadius(widget.size)),
      borderSide: BorderSide(
        color: context.mp.errorColor,
        width: 2,
      ),
    );
  }

  InputBorder _getDisabledBorder(_MPDropdownConfig config) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(config.getBorderRadius(widget.size)),
      borderSide: BorderSide(
        color: context.mp.disabledColor.withValues(alpha: 0.3),
        width: 1.5,
      ),
    );
  }
}

/// Configuration class for MPDropdown
class _MPDropdownConfig {
  // Size configurations
  static const Map<MPDropdownSize, double> fontSizes = {
    MPDropdownSize.small: 14,
    MPDropdownSize.medium: 16,
    MPDropdownSize.large: 18,
  };

  static const Map<MPDropdownSize, double> borderRadiuses = {
    MPDropdownSize.small: 6,
    MPDropdownSize.medium: 8,
    MPDropdownSize.large: 10,
  };

  static const Map<MPDropdownSize, double> iconSizes = {
    MPDropdownSize.small: 20,
    MPDropdownSize.medium: 24,
    MPDropdownSize.large: 28,
  };

  static const Map<MPDropdownSize, EdgeInsets> contentPaddings = {
    MPDropdownSize.small: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    MPDropdownSize.medium: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    MPDropdownSize.large: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  };

  double getFontSize(MPDropdownSize size) => fontSizes[size]!;
  double getBorderRadius(MPDropdownSize size) => borderRadiuses[size]!;
  double getIconSize(MPDropdownSize size) => iconSizes[size]!;
  EdgeInsets getContentPadding(MPDropdownSize size) => contentPaddings[size]!;

  Color getFillColor(BuildContext context, bool enabled) {
    if (!enabled) return context.mp.disabledColor.withValues(alpha: 0.1);
    return context.mp.isDarkMode
        ? const Color(0xFF374151)
        : const Color(0xFFF3F4F6);
  }
}

/// An item in a dropdown menu.
class MPDropdownItem<T> {
  /// Creates a new dropdown item.
  const MPDropdownItem({
    required this.value,
    required this.label,
    this.leading,
    this.trailing,
    this.enabled = true,
  });

  /// The value to return when this item is selected.
  final T value;

  /// The text label to display.
  final String label;

  /// Optional widget to display before the label.
  final Widget? leading;

  /// Optional widget to display after the label.
  final Widget? trailing;

  /// Whether this item can be selected.
  final bool enabled;
}
