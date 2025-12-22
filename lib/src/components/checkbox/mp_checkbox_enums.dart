/// Enum definitions for MPCheckbox component
part of 'mp_checkbox.dart';

/// Size variants for MPCheckbox
enum MPCheckboxSize {
  /// Small checkbox (24x24)
  small,

  /// Medium checkbox (32x32)
  medium,

  /// Large checkbox (40x40)
  large,
}

/// Check state for MPCheckbox
enum MPCheckboxCheckState {
  /// Automatically determine state from [value]
  auto,

  /// Checkbox is unchecked
  unchecked,

  /// Checkbox is checked
  checked,

  /// Checkbox is in indeterminate state
  indeterminate,
}
