import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_date_picker_enums.dart';

/// A date picker component for selecting dates.
///
/// This component provides a flexible date selection interface with multiple variants,
/// sizes, and theme support.
///
/// Example:
/// ```dart
/// MPDatePicker(
///   selectedDate: _selectedDate,
///   onDateSelected: (date) => setState(() => _selectedDate = date),
///   minDate: DateTime.now(),
///   maxDate: DateTime.now().add(Duration(days: 365)),
/// )
/// ```
class MPDatePicker extends StatefulWidget {
  /// Creates a new [MPDatePicker] widget.
  const MPDatePicker({
    super.key,
    this.selectedDate,
    this.onDateSelected,
    this.minDate,
    this.maxDate,
    this.variant = MPDatePickerVariant.calendar,
    this.size = MPDatePickerSize.medium,
    this.dateFormat,
    this.disabledDates,
    this.firstDate,
    this.lastDate,
    this.selectableDayPredicate,
    this.initialDatePickerMode = DatePickerMode.day,
    this.errorText,
    this.helperText,
    this.label,
    this.semanticLabel,
    this.enabled = true,
  });

  /// The currently selected date.
  final DateTime? selectedDate;

  /// Callback when a date is selected.
  final ValueChanged<DateTime>? onDateSelected;

  /// The minimum date that can be selected.
  final DateTime? minDate;

  /// The maximum date that can be selected.
  final DateTime? maxDate;

  /// The visual style variant of the date picker.
  final MPDatePickerVariant variant;

  /// The size of the date picker.
  final MPDatePickerSize size;

  /// Custom date format string.
  final String? dateFormat;

  /// List of dates that should be disabled.
  final List<DateTime>? disabledDates;

  /// First selectable date (alias for minDate).
  final DateTime? firstDate;

  /// Last selectable date (alias for maxDate).
  final DateTime? lastDate;

  /// Predicate to determine if a day is selectable.
  final SelectableDayPredicate? selectableDayPredicate;

  /// Initial date picker mode (day/year).
  final DatePickerMode initialDatePickerMode;

  /// Error text to display.
  final String? errorText;

  /// Helper text to display.
  final String? helperText;

  /// Label text for the date picker.
  final String? label;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Whether the date picker is enabled.
  final bool enabled;

  @override
  State<MPDatePicker> createState() => _MPDatePickerState();
}

class _MPDatePickerState extends State<MPDatePicker> {
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  void didUpdateWidget(MPDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _selectedDate = widget.selectedDate;
    }
  }

  Future<void> _selectDate() async {
    if (!widget.enabled) return;

    final initialDate = _selectedDate ?? DateTime.now();
    final firstDate = widget.firstDate ?? widget.minDate ?? DateTime(2000);
    final lastDate = widget.lastDate ?? widget.maxDate ?? DateTime(2101);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDatePickerMode: widget.initialDatePickerMode,
      selectableDayPredicate: widget.selectableDayPredicate ??
          (day) {
            if (widget.minDate != null && day.isBefore(widget.minDate!)) {
              return false;
            }
            if (widget.maxDate != null && day.isAfter(widget.maxDate!)) {
              return false;
            }
            if (widget.disabledDates != null) {
              return !widget.disabledDates!.any((disabled) =>
                  day.year == disabled.year &&
                  day.month == disabled.month &&
                  day.day == disabled.day);
            }
            return true;
          },
      helpText: widget.label,
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected?.call(picked);
    }
  }

  String _formatDate(DateTime date) {
    if (widget.dateFormat != null) {
      return _formatCustomDate(date, widget.dateFormat!);
    }

    // Default format based on locale
    final config = _MPDatePickerConfig();
    return config.getDefaultFormat(date);
  }

  String _formatCustomDate(DateTime date, String format) {
    // Simple custom formatting - order matters! Longer patterns first.
    String result = format;
    result = result.replaceAll('MMM', _getMonthName(date.month, true));
    result = result.replaceAll('MM', date.month.toString().padLeft(2, '0'));
    result = result.replaceAll('dd', date.day.toString().padLeft(2, '0'));
    result = result.replaceAll('yyyy', date.year.toString());
    result = result.replaceAll('yy', date.year.toString().substring(2));
    return result;
  }

  String _getMonthName(int month, bool abbreviated) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final abbreviatedMonths = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return abbreviated
        ? abbreviatedMonths[month - 1]
        : months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final config = _MPDatePickerConfig();

    if (!widget.enabled && widget.variant == MPDatePickerVariant.button) {
      return _buildDisabledDisplay(config);
    }

    return Semantics(
      label: widget.semanticLabel ?? 'Date picker',
      button: true,
      enabled: widget.enabled,
      value: _selectedDate != null ? _formatDate(_selectedDate!) : 'Not set',
      child: GestureDetector(
        onTap: widget.enabled ? _selectDate : null,
        child: _buildContent(config),
      ),
    );
  }

  Widget _buildContent(_MPDatePickerConfig config) {
    switch (widget.variant) {
      case MPDatePickerVariant.calendar:
        return _buildCalendarVariant(config);
      case MPDatePickerVariant.button:
        return _buildButtonVariant(config);
      case MPDatePickerVariant.input:
        return _buildInputVariant(config);
    }
  }

  Widget _buildCalendarVariant(_MPDatePickerConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          MPText.label(
            widget.label!,
            style: TextStyle(
              color: widget.enabled
                  ? context.mp.textColor
                  : context.mp.disabledColor,
              fontSize: config.getLabelSize(widget.size),
            ),
          ),
          SizedBox(height: config.getSpacing(widget.size)),
        ],
        GestureDetector(
          onTap: widget.enabled ? _selectDate : null,
          child: Container(
            padding: config.getPadding(widget.size),
            decoration: BoxDecoration(
              color: widget.enabled
                  ? context.mp.cardColor
                  : context.mp.disabledColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(config.getBorderRadius(widget.size)),
              border: Border.all(
                color: widget.errorText != null
                    ? context.mp.errorColor
                    : context.mp.borderColor,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: config.getIconSize(widget.size),
                  color: widget.enabled
                      ? context.mp.primary
                      : context.mp.disabledColor,
                ),
                SizedBox(width: config.getSpacing(widget.size)),
                Expanded(
                  child: MPText.body(
                    _selectedDate != null
                        ? _formatDate(_selectedDate!)
                        : 'Select date',
                    style: TextStyle(
                      color: widget.enabled
                          ? context.mp.textColor
                          : context.mp.disabledColor,
                      fontSize: config.getTextSize(widget.size),
                    ),
                  ),
                ),
                if (widget.enabled) ...[
                  Icon(
                    Icons.arrow_drop_down,
                    size: config.getIconSize(widget.size),
                    color: context.mp.subtitleColor,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          SizedBox(height: 4),
          MPText.label(
            widget.errorText!,
            style: TextStyle(
              color: context.mp.errorColor,
              fontSize: 12,
            ),
          ),
        ],
        if (widget.helperText != null && widget.errorText == null) ...[
          SizedBox(height: 4),
          MPText.label(
            widget.helperText!,
            style: TextStyle(
              color: context.mp.subtitleColor,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildButtonVariant(_MPDatePickerConfig config) {
    return MPButton(
      text: _selectedDate != null ? _formatDate(_selectedDate!) : 'Select date',
      onPressed: _selectDate,
      variant: MPButtonVariant.outlined,
      size: config.getButtonSize(widget.size),
      icon: Icons.calendar_today,
      iconColor: context.mp.primary,
      textSize: config.getTextSize(widget.size),
    );
  }

  Widget _buildInputVariant(_MPDatePickerConfig config) {
    return InkWell(
      onTap: widget.enabled ? _selectDate : null,
      borderRadius: BorderRadius.circular(
        config.getBorderRadius(widget.size),
      ),
      child: IgnorePointer(
        child: MPTextField(
          TextEditingController(
            text: _selectedDate != null ? _formatDate(_selectedDate!) : '',
          ),
          label: widget.label,
          hint: 'Select date',
          enabled: false,
          icon: Icon(
            Icons.calendar_today,
            size: config.getIconSize(widget.size),
            color: widget.enabled
                ? context.mp.primary
                : context.mp.disabledColor,
          ),
        ),
      ),
    );
  }

  Widget _buildDisabledDisplay(_MPDatePickerConfig config) {
    return Container(
      padding: config.getPadding(widget.size),
      decoration: BoxDecoration(
        color: context.mp.disabledColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(config.getBorderRadius(widget.size)),
        border: Border.all(
          color: context.mp.borderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            size: config.getIconSize(widget.size),
            color: context.mp.disabledColor,
          ),
          SizedBox(width: config.getSpacing(widget.size)),
          Expanded(
            child: MPText.body(
              _selectedDate != null ? _formatDate(_selectedDate!) : 'Select date',
              style: TextStyle(
                color: context.mp.disabledColor,
                fontSize: config.getTextSize(widget.size),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Configuration class for MPDatePicker
class _MPDatePickerConfig {
  double getTextSize(MPDatePickerSize size) {
    switch (size) {
      case MPDatePickerSize.small:
        return 14;
      case MPDatePickerSize.medium:
        return 16;
      case MPDatePickerSize.large:
        return 18;
    }
  }

  double getLabelSize(MPDatePickerSize size) {
    switch (size) {
      case MPDatePickerSize.small:
        return 12;
      case MPDatePickerSize.medium:
        return 14;
      case MPDatePickerSize.large:
        return 16;
    }
  }

  double getIconSize(MPDatePickerSize size) {
    switch (size) {
      case MPDatePickerSize.small:
        return 18;
      case MPDatePickerSize.medium:
        return 20;
      case MPDatePickerSize.large:
        return 24;
    }
  }

  double getSpacing(MPDatePickerSize size) {
    switch (size) {
      case MPDatePickerSize.small:
        return 8;
      case MPDatePickerSize.medium:
        return 12;
      case MPDatePickerSize.large:
        return 16;
    }
  }

  EdgeInsets getPadding(MPDatePickerSize size) {
    switch (size) {
      case MPDatePickerSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case MPDatePickerSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case MPDatePickerSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    }
  }

  double getBorderRadius(MPDatePickerSize size) {
    switch (size) {
      case MPDatePickerSize.small:
        return 6;
      case MPDatePickerSize.medium:
        return 8;
      case MPDatePickerSize.large:
        return 12;
    }
  }

  MPButtonSize getButtonSize(MPDatePickerSize size) {
    switch (size) {
      case MPDatePickerSize.small:
        return MPButtonSize.small;
      case MPDatePickerSize.medium:
        return MPButtonSize.medium;
      case MPDatePickerSize.large:
        return MPButtonSize.large;
    }
  }

  String getDefaultFormat(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
