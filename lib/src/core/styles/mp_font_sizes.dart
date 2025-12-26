// ignore_for_file: public_member_api_docs

/// Centralized font size constants for the UI kit.
///
/// This class provides a single source of truth for font sizes used across
/// the application, making it easier to maintain and update typography globally.
class MPFontSizes {
  const MPFontSizes._();

  // === Headings ===

  /// Large page title (Display Large)
  /// Previously: 24
  static const double title = 24.0;

  /// Heading 1 (Title Large)
  /// Previously: 34
  static const double heading1 = 34.0;

  /// Heading 2 (Title Medium)
  /// Previously: 27
  static const double heading2 = 27.0;

  /// Heading 3 (Title Small)
  /// Previously: 21
  static const double heading3 = 21.0;

  // === Body Text ===

  /// Subhead / Body Medium (Body Medium)
  /// Previously: 18 (MPText.subhead), 17 (MPTextStyle.body1)
  static const double subhead = 18.0;
  static const double body1 = 17.0;

  /// Body / Standard Text (Body Large)
  /// Previously: 14
  static const double body2 = 14.0;
  static const double body = 14.0;

  /// Label Text
  /// Previously: 13
  static const double label = 13.0;

  // === Small Text ===

  /// Caption / Helper Text (Body Small)
  /// Previously: 11
  static const double caption = 11.0;

  /// Small Text
  /// Previously: 10
  static const double small = 10.0;

  /// Overline Text (Label Small)
  /// Previously: 8
  static const double overline = 8.0;

  // === Component Specific ===

  // Article Card
  static const double articleCardSmall = 12.0;
  static const double articleCardMedium = 14.0;
  static const double articleCardLarge = 16.0;
}
