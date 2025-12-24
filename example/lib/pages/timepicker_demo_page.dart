import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class TimePickerDemoPage extends StatefulWidget {
  const TimePickerDemoPage({super.key});

  @override
  State<TimePickerDemoPage> createState() => _TimePickerDemoPageState();
}

class _TimePickerDemoPageState extends State<TimePickerDemoPage> {
  // Variant times
  TimeOfDay? _dialTime;
  TimeOfDay? _dropdownTime;
  TimeOfDay? _inputTime;

  // Size times
  TimeOfDay? _smallTime;
  TimeOfDay? _mediumTime;
  TimeOfDay? _largeTime;

  // Format times
  TimeOfDay? _hour12Time;
  TimeOfDay? _hour24Time;

  // State examples
  TimeOfDay? _enabledTime;
  TimeOfDay? _disabledTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Time Picker Demo',
          style: TextStyle(color: context.mp.textColor),
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVariants(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildSizes(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildFormats(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildStates(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildExamples(context),
          ],
        ),
      ),
    );
  }

  Widget _buildVariants(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Time Picker Variants',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _TimePickerCard(
          title: 'Dial',
          description: 'Dial-style time input field',
          child: MPTimePicker(
            selectedTime: _dialTime,
            onTimeSelected: (time) => setState(() => _dialTime = time),
            variant: MPTimePickerVariant.dial,
            label: 'Select Time',
          ),
        ),
        SizedBox(height: 16),
        _TimePickerCard(
          title: 'Dropdown',
          description: 'Dropdown-style time picker',
          child: MPTimePicker(
            selectedTime: _dropdownTime,
            onTimeSelected: (time) => setState(() => _dropdownTime = time),
            variant: MPTimePickerVariant.dropdown,
          ),
        ),
        SizedBox(height: 16),
        _TimePickerCard(
          title: 'Input',
          description: 'Input field-style time picker',
          child: MPTimePicker(
            selectedTime: _inputTime,
            onTimeSelected: (time) => setState(() => _inputTime = time),
            variant: MPTimePickerVariant.input,
            label: 'Wake up time',
          ),
        ),
      ],
    );
  }

  Widget _buildSizes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Time Picker Sizes',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _TimePickerCard(
          title: 'Small',
          description: 'Compact size time picker',
          child: MPTimePicker(
            selectedTime: _smallTime,
            onTimeSelected: (time) => setState(() => _smallTime = time),
            size: MPTimePickerSize.small,
          ),
        ),
        SizedBox(height: 16),
        _TimePickerCard(
          title: 'Medium',
          description: 'Default medium size',
          child: MPTimePicker(
            selectedTime: _mediumTime,
            onTimeSelected: (time) => setState(() => _mediumTime = time),
            size: MPTimePickerSize.medium,
          ),
        ),
        SizedBox(height: 16),
        _TimePickerCard(
          title: 'Large',
          description: 'Prominent large size',
          child: MPTimePicker(
            selectedTime: _largeTime,
            onTimeSelected: (time) => setState(() => _largeTime = time),
            size: MPTimePickerSize.large,
          ),
        ),
      ],
    );
  }

  Widget _buildFormats(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Time Formats',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _TimePickerCard(
          title: '12-Hour Format',
          description: 'AM/PM time format',
          timeText: _hour12Time != null
              ? _formatTime(_hour12Time!, MPTimeFormat.hour12)
              : null,
          child: MPTimePicker(
            selectedTime: _hour12Time,
            onTimeSelected: (time) => setState(() => _hour12Time = time),
            format: MPTimeFormat.hour12,
          ),
        ),
        SizedBox(height: 16),
        _TimePickerCard(
          title: '24-Hour Format',
          description: 'Military time format',
          timeText: _hour24Time != null
              ? _formatTime(_hour24Time!, MPTimeFormat.hour24)
              : null,
          child: MPTimePicker(
            selectedTime: _hour24Time,
            onTimeSelected: (time) => setState(() => _hour24Time = time),
            format: MPTimeFormat.hour24,
          ),
        ),
      ],
    );
  }

  Widget _buildStates(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Time Picker States',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _TimePickerCard(
          title: 'Enabled',
          description: 'Active and interactive',
          timeText: _enabledTime != null
              ? _formatTime(_enabledTime!, MPTimeFormat.hour12)
              : null,
          child: MPTimePicker(
            selectedTime: _enabledTime,
            onTimeSelected: (time) => setState(() => _enabledTime = time),
            enabled: true,
          ),
        ),
        SizedBox(height: 16),
        _TimePickerCard(
          title: 'Disabled',
          description: 'Non-interactive display',
          timeText: _disabledTime != null
              ? _formatTime(_disabledTime!, MPTimeFormat.hour12)
              : null,
          child: MPTimePicker(
            selectedTime: _disabledTime,
            enabled: false,
          ),
        ),
      ],
    );
  }

  Widget _buildExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Practical Examples',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _ExampleCard(
          title: 'Alarm Time',
          description: 'Set your alarm',
          subtitle: 'Wake up at this time',
          icon: Icons.alarm,
          time: const TimeOfDay(hour: 7, minute: 0),
          format: MPTimeFormat.hour12,
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Meeting Time',
          description: 'Schedule a meeting',
          subtitle: 'Meeting starts at',
          icon: Icons.meeting_room,
          time: const TimeOfDay(hour: 14, minute: 30),
          variant: MPTimePickerVariant.dropdown,
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Bed Time',
          description: 'Set reminder for bed',
          subtitle: 'Time to sleep',
          icon: Icons.bedtime,
          time: const TimeOfDay(hour: 22, minute: 0),
          variant: MPTimePickerVariant.input,
          format: MPTimeFormat.hour12,
        ),
      ],
    );
  }

  Widget _TimePickerCard({
    required String title,
    required String description,
    required Widget child,
    String? timeText,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.mp.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MPText.head(
                title,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              if (timeText != null)
                MPText.label(
                  timeText,
                  style: TextStyle(
                    color: context.mp.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          SizedBox(height: 4),
          MPText.label(
            description,
            style: TextStyle(
              color: context.mp.subtitleColor,
            ),
          ),
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _ExampleCard({
    required String title,
    required String description,
    required String subtitle,
    required IconData icon,
    TimeOfDay? time,
    MPTimePickerVariant variant = MPTimePickerVariant.dial,
    MPTimeFormat format = MPTimeFormat.hour12,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.mp.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.mp.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: context.mp.primary, size: 20),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPText.head(title, fontSize: 16),
                    SizedBox(height: 2),
                    MPText.label(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.mp.subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          MPTimePicker(
            selectedTime: time,
            variant: variant,
            format: format,
          ),
          SizedBox(height: 4),
          MPText.label(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: context.mp.captionColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(TimeOfDay time, MPTimeFormat format) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    if (format == MPTimeFormat.hour24) {
      return '${time.hour.toString().padLeft(2, '0')}:$minute';
    } else {
      return '$hour:$minute $period';
    }
  }
}
