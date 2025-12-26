part of 'mp_empty_state.dart';

/// Predefined variants for empty states
enum MPEmptyStateVariant {
  /// No data available
  noData,

  /// No search results
  noResults,

  /// No network connection
  noNetwork,

  /// Error occurred
  error,

  /// Custom empty state
  custom,
}

/// Size variants for empty state
enum MPEmptyStateSize {
  /// Compact empty state
  small,

  /// Standard empty state
  medium,

  /// Large empty state
  large,
}
