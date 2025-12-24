import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class DatePickerDemoPage extends StatefulWidget {
  const DatePickerDemoPage({super.key});

  @override
  State<DatePickerDemoPage> createState() => _DatePickerDemoPageState();
}

class _DatePickerDemoPageState extends State<DatePickerDemoPage> {
  // Variant dates
  DateTime? _calendarDate;
  DateTime? _buttonDate;
  DateTime? _inputDate;

  // Size dates
  DateTime? _smallDate;
  DateTime? _mediumDate;
  DateTime? _largeDate;

  // Custom format dates
  DateTime? _formatDate1;
  DateTime? _formatDate2;
  DateTime? _formatDate3;

  // Date constraints
  DateTime? _constrainedDate;
  DateTime? _pastDate;
  DateTime? _futureDate;

  // State examples
  DateTime? _enabledDate;
  DateTime? _disabledDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Date Picker Demo',
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
            _buildConstraints(context),
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
          'Date Picker Variants',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _DatePickerCard(
          title: 'Calendar',
          description: 'Calendar-style date input field',
          child: MPDatePicker(
            selectedDate: _calendarDate,
            onDateSelected: (date) => setState(() => _calendarDate = date),
            variant: MPDatePickerVariant.calendar,
            label: 'Select Date',
          ),
        ),
        SizedBox(height: 16),
        _DatePickerCard(
          title: 'Button',
          description: 'Button-style date picker',
          child: MPDatePicker(
            selectedDate: _buttonDate,
            onDateSelected: (date) => setState(() => _buttonDate = date),
            variant: MPDatePickerVariant.button,
          ),
        ),
        SizedBox(height: 16),
        _DatePickerCard(
          title: 'Input',
          description: 'Input field-style date picker',
          child: MPDatePicker(
            selectedDate: _inputDate,
            onDateSelected: (date) => setState(() => _inputDate = date),
            variant: MPDatePickerVariant.input,
            label: 'Birth Date',
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
          'Date Picker Sizes',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _DatePickerCard(
          title: 'Small',
          description: 'Compact size date picker',
          child: MPDatePicker(
            selectedDate: _smallDate,
            onDateSelected: (date) => setState(() => _smallDate = date),
            size: MPDatePickerSize.small,
          ),
        ),
        SizedBox(height: 16),
        _DatePickerCard(
          title: 'Medium',
          description: 'Default medium size',
          child: MPDatePicker(
            selectedDate: _mediumDate,
            onDateSelected: (date) => setState(() => _mediumDate = date),
            size: MPDatePickerSize.medium,
          ),
        ),
        SizedBox(height: 16),
        _DatePickerCard(
          title: 'Large',
          description: 'Prominent large size',
          child: MPDatePicker(
            selectedDate: _largeDate,
            onDateSelected: (date) => setState(() => _largeDate = date),
            size: MPDatePickerSize.large,
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
          'Date Formats',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _DatePickerCard(
          title: 'dd-MM-yyyy',
          description: 'Day-Month-Year format',
          dateText: _formatDate1 != null
              ? '${_formatDate1!.day}/${_formatDate1!.month}/${_formatDate1!.year}'
              : null,
          child: MPDatePicker(
            selectedDate: _formatDate1,
            onDateSelected: (date) => setState(() => _formatDate1 = date),
            dateFormat: 'dd-MM-yyyy',
          ),
        ),
        SizedBox(height: 16),
        _DatePickerCard(
          title: 'dd MMM yyyy',
          description: 'Day Month Abbr-Year format',
          dateText: _formatDate2 != null
              ? '${_formatDate2!.day} ${_getMonthAbbr(_formatDate2!.month)} ${_formatDate2!.year}'
              : null,
          child: MPDatePicker(
            selectedDate: _formatDate2,
            onDateSelected: (date) => setState(() => _formatDate2 = date),
            dateFormat: 'dd MMM yyyy',
          ),
        ),
        SizedBox(height: 16),
        _DatePickerCard(
          title: 'yyyy/MM/dd',
          description: 'Year/Month/Day format',
          dateText: _formatDate3 != null
              ? '${_formatDate3!.year}/${_formatDate3!.month}/${_formatDate3!.day}'
              : null,
          child: MPDatePicker(
            selectedDate: _formatDate3,
            onDateSelected: (date) => setState(() => _formatDate3 = date),
            dateFormat: 'yyyy/MM/dd',
          ),
        ),
      ],
    );
  }

  Widget _buildConstraints(BuildContext context) {
    final now = DateTime.now();
    final nextWeek = now.add(const Duration(days: 7));
    final lastWeek = now.subtract(const Duration(days: 7));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Date Constraints',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _DatePickerCard(
          title: 'Future Dates Only',
          description: 'Select a date within next 7 days',
          dateText: _constrainedDate?.toString().split(' ')[0],
          child: MPDatePicker(
            selectedDate: _constrainedDate,
            onDateSelected: (date) => setState(() => _constrainedDate = date),
            firstDate: now,
            lastDate: nextWeek,
            label: 'Select Appointment',
          ),
        ),
        SizedBox(height: 16),
        _DatePickerCard(
          title: 'Past Dates Only',
          description: 'Select a date from last 7 days',
          dateText: _pastDate?.toString().split(' ')[0],
          child: MPDatePicker(
            selectedDate: _pastDate,
            onDateSelected: (date) => setState(() => _pastDate = date),
            minDate: lastWeek,
            maxDate: now,
            label: 'Select Date',
          ),
        ),
        SizedBox(height: 16),
        _DatePickerCard(
          title: 'Min/Max Date',
          description: 'Between specific dates',
          dateText: _futureDate?.toString().split(' ')[0],
          child: MPDatePicker(
            selectedDate: _futureDate,
            onDateSelected: (date) => setState(() => _futureDate = date),
            minDate: DateTime(2025, 1, 1),
            maxDate: DateTime(2025, 12, 31),
            label: 'Select Date',
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
          'Date Picker States',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _DatePickerCard(
          title: 'Enabled',
          description: 'Active and interactive',
          dateText: _enabledDate?.toString().split(' ')[0],
          child: MPDatePicker(
            selectedDate: _enabledDate,
            onDateSelected: (date) => setState(() => _enabledDate = date),
            enabled: true,
          ),
        ),
        SizedBox(height: 16),
        _DatePickerCard(
          title: 'Disabled',
          description: 'Non-interactive display',
          dateText: _disabledDate?.toString().split(' ')[0],
          child: MPDatePicker(
            selectedDate: _disabledDate,
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
          title: 'Event Date',
          description: 'Select event date',
          subtitle: 'Choose a date for your event',
          icon: Icons.event,
          date: DateTime.now().add(const Duration(days: 14)),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Booking Date',
          description: 'Hotel booking date',
          subtitle: 'Select your check-in date',
          icon: Icons.hotel,
          variant: MPDatePickerVariant.button,
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Birth Date',
          description: 'Date of birth',
          subtitle: 'Select your birth date',
          icon: Icons.cake,
          variant: MPDatePickerVariant.input,
          maxDate: DateTime.now(),
        ),
      ],
    );
  }

  Widget _DatePickerCard({
    required String title,
    required String description,
    required Widget child,
    String? dateText,
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
              if (dateText != null)
                MPText.label(
                  dateText,
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
    DateTime? date,
    MPDatePickerVariant variant = MPDatePickerVariant.calendar,
    DateTime? minDate,
    DateTime? maxDate,
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
          MPDatePicker(
            selectedDate: date,
            variant: variant,
            minDate: minDate,
            maxDate: maxDate,
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

  String _getMonthAbbr(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
