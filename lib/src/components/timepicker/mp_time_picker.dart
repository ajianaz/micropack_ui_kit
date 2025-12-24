import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_time_picker_enums.dart';

/// A time picker component for selecting times.
///
/// This component provides a flexible time selection interface with multiple variants,
/// sizes, and theme support.
///
/// Example:
/// ```dart
/// MPTimePicker(
///   selectedTime: _selectedTime,
///   onTimeSelected: (time) => setState(() => _selectedTime = time),
///   format: MPTimeFormat.hour24,
/// )
/// ```
class MPTimePicker extends StatefulWidget {
  /// Creates a new [MPTimePicker] widget.
  const MPTimePicker({
    super.key,
    this.selectedTime,
    this.onTimeSelected,
    this.variant = MPTimePickerVariant.dial,
    this.size = MPTimePickerSize.medium,
    this.format = MPTimeFormat.hour12,
    this.minTime,
    this.maxTime,
    this.interval = 1,
    this.errorText,
    this.helperText,
    this.label,
    this.semanticLabel,
    this.enabled = true,
  });

  /// The currently selected time.
  final TimeOfDay? selectedTime;

  /// Callback when a time is selected.
  final ValueChanged<TimeOfDay>? onTimeSelected;

  /// The visual style variant of the time picker.
  final MPTimePickerVariant variant;

  /// The size of the time picker.
  final MPTimePickerSize size;

  /// The time format (12-hour or 24-hour).
  final MPTimeFormat format;

  /// The minimum time that can be selected.
  final TimeOfDay? minTime;

  /// The maximum time that can be selected.
  final TimeOfDay? maxTime;

  /// The interval between selectable times (in minutes).
  final int interval;

  /// Error text to display.
  final String? errorText;

  /// Helper text to display.
  final String? helperText;

  /// Label text for the time picker.
  final String? label;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Whether the time picker is enabled.
  final bool enabled;

  @override
  State<MPTimePicker> createState() => _MPTimePickerState();
}

class _MPTimePickerState extends State<MPTimePicker> {
  late TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.selectedTime;
  }

  @override
  void didUpdateWidget(MPTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedTime != oldWidget.selectedTime) {
      _selectedTime = widget.selectedTime;
    }
  }

  Future<void> _selectTime() async {
    if (!widget.enabled) return;

    final initialTime = _selectedTime ?? TimeOfDay.now();

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: widget.format == MPTimeFormat.hour24,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Check constraints
      if (widget.minTime != null &&
          _compareTime(picked, widget.minTime!) < 0) {
        return; // Before minimum time
      }
      if (widget.maxTime != null &&
          _compareTime(picked, widget.maxTime!) > 0) {
        return; // After maximum time
      }

      setState(() {
        _selectedTime = picked;
      });
      widget.onTimeSelected?.call(picked);
    }
  }

  /// Compare two times.
  /// Returns -1 if t1 < t2, 0 if t1 == t2, 1 if t1 > t2
  int _compareTime(TimeOfDay t1, TimeOfDay t2) {
    final t1Minutes = t1.hour * 60 + t1.minute;
    final t2Minutes = t2.hour * 60 + t2.minute;
    return t1Minutes.compareTo(t2Minutes);
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    if (widget.format == MPTimeFormat.hour24) {
      return '${time.hour.toString().padLeft(2, '0')}:$minute';
    } else {
      return '$hour:$minute $period';
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = _MPTimePickerConfig();

    if (!widget.enabled && widget.variant == MPTimePickerVariant.dropdown) {
      return _buildDisabledDisplay(config);
    }

    return Semantics(
      label: widget.semanticLabel ?? 'Time picker',
      button: true,
      enabled: widget.enabled,
      value: _selectedTime != null ? _formatTime(_selectedTime!) : 'Not set',
      child: GestureDetector(
        onTap: widget.enabled ? _selectTime : null,
        child: _buildContent(config),
      ),
    );
  }

  Widget _buildContent(_MPTimePickerConfig config) {
    switch (widget.variant) {
      case MPTimePickerVariant.dial:
        return _buildDialVariant(config);
      case MPTimePickerVariant.dropdown:
        return _buildButtonVariant(config);
      case MPTimePickerVariant.input:
        return _buildInputVariant(config);
    }
  }

  Widget _buildDialVariant(_MPTimePickerConfig config) {
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
          onTap: widget.enabled ? _selectTime : null,
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
                  Icons.access_time,
                  size: config.getIconSize(widget.size),
                  color: widget.enabled
                      ? context.mp.primary
                      : context.mp.disabledColor,
                ),
                SizedBox(width: config.getSpacing(widget.size)),
                Expanded(
                  child: MPText.body(
                    _selectedTime != null
                        ? _formatTime(_selectedTime!)
                        : 'Select time',
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

  Widget _buildButtonVariant(_MPTimePickerConfig config) {
    return MPButton(
      text: _selectedTime != null ? _formatTime(_selectedTime!) : 'Select time',
      onPressed: _selectTime,
      variant: MPButtonVariant.outlined,
      size: config.getButtonSize(widget.size),
      icon: Icons.access_time,
      iconColor: context.mp.primary,
      textSize: config.getTextSize(widget.size),
    );
  }

  Widget _buildInputVariant(_MPTimePickerConfig config) {
    return InkWell(
      onTap: widget.enabled ? _selectTime : null,
      borderRadius: BorderRadius.circular(
        config.getBorderRadius(widget.size),
      ),
      child: IgnorePointer(
        child: MPTextField(
          TextEditingController(
            text: _selectedTime != null ? _formatTime(_selectedTime!) : '',
          ),
          label: widget.label,
          hint: 'Select time',
          enabled: false,
          icon: Icon(
            Icons.access_time,
            size: config.getIconSize(widget.size),
            color: widget.enabled
                ? context.mp.primary
                : context.mp.disabledColor,
          ),
        ),
      ),
    );
  }

  Widget _buildDisabledDisplay(_MPTimePickerConfig config) {
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
            Icons.access_time,
            size: config.getIconSize(widget.size),
            color: context.mp.disabledColor,
          ),
          SizedBox(width: config.getSpacing(widget.size)),
          Expanded(
            child: MPText.body(
              _selectedTime != null ? _formatTime(_selectedTime!) : 'Select time',
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

/// Configuration class for MPTimePicker
class _MPTimePickerConfig {
  double getTextSize(MPTimePickerSize size) {
    switch (size) {
      case MPTimePickerSize.small:
        return 14;
      case MPTimePickerSize.medium:
        return 16;
      case MPTimePickerSize.large:
        return 18;
    }
  }

  double getLabelSize(MPTimePickerSize size) {
    switch (size) {
      case MPTimePickerSize.small:
        return 12;
      case MPTimePickerSize.medium:
        return 14;
      case MPTimePickerSize.large:
        return 16;
    }
  }

  double getIconSize(MPTimePickerSize size) {
    switch (size) {
      case MPTimePickerSize.small:
        return 18;
      case MPTimePickerSize.medium:
        return 20;
      case MPTimePickerSize.large:
        return 24;
    }
  }

  double getSpacing(MPTimePickerSize size) {
    switch (size) {
      case MPTimePickerSize.small:
        return 8;
      case MPTimePickerSize.medium:
        return 12;
      case MPTimePickerSize.large:
        return 16;
    }
  }

  EdgeInsets getPadding(MPTimePickerSize size) {
    switch (size) {
      case MPTimePickerSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case MPTimePickerSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case MPTimePickerSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    }
  }

  double getBorderRadius(MPTimePickerSize size) {
    switch (size) {
      case MPTimePickerSize.small:
        return 6;
      case MPTimePickerSize.medium:
        return 8;
      case MPTimePickerSize.large:
        return 12;
    }
  }

  MPButtonSize getButtonSize(MPTimePickerSize size) {
    switch (size) {
      case MPTimePickerSize.small:
        return MPButtonSize.small;
      case MPTimePickerSize.medium:
        return MPButtonSize.medium;
      case MPTimePickerSize.large:
        return MPButtonSize.large;
    }
  }
}
