part of 'mp_time_picker.dart';

/// Time picker variant options
enum MPTimePickerVariant {
  /// Dial-style time picker
  dial,

  /// Dropdown-style time picker
  dropdown,

  /// Input field-style time picker
  input,
}

/// Time picker size options
enum MPTimePickerSize {
  /// Small size (compact)
  small,

  /// Medium size (default)
  medium,

  /// Large size (prominent)
  large,
}

/// Time format options
enum MPTimeFormat {
  /// 12-hour format (AM/PM)
  hour12,

  /// 24-hour format
  hour24,
}
