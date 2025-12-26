import 'package:flutter/material.dart';

/// MPColors - Legacy color constants class
///
/// This class provides static color constants for the UI kit.
/// Note: This is deprecated and will be removed in future versions.
/// Use MPThemeConfig instead for new implementations.
class MPColors {
  const MPColors._();

  // ============ LIGHT MODE COLORS ============

  // Primary colors for light mode
  /// Main primary color for light mode
  static const Color primary = Color(0xFF303F9F);

  /// Light surface for primary elements
  static const Color primarySurface = Color(0xFFF5F5FA);

  /// Focus state for primary elements
  static const Color primaryFocus = Color(0xFFD6D9EC);

  /// Border color for primary elements
  static const Color primaryBorder = Color(0xFFBABFDF);

  /// Hover state for primary elements
  static const Color primaryHover = Color(0xFF283584);

  /// Pressed state for primary elements
  static const Color primaryPressed = Color(0xFF182050);

  // Neutral colors for light mode (neutral10 = lightest, neutral100 = darkest)
  /// Neutral colors for light mode
  static const MaterialColor neutral = MaterialColor(
    0xFFAEAEAE,
    {
      /// Lightest neutral - almost white
      10: Color(0xFFFFFFFF),

      /// Very light gray
      20: Color(0xFFF5F5F5),

      /// Light gray
      30: Color(0xFFE5E5E5),

      /// Medium-light gray
      40: Color(0xFFD4D4D4),

      /// Medium gray
      50: Color(0xFFAEAEAE),

      /// Medium-dark gray
      60: Color(0xFF8E8E8E),

      /// Dark gray
      70: Color(0xFF696969),

      /// Very dark gray
      80: Color(0xFF535353),

      /// Extremely dark gray
      90: Color(0xFF393939),

      /// Darkest neutral - almost black
      100: Color(0xFF090909),
    },
  );

  // ============ DARK MODE COLORS ============

  // Primary colors for dark mode
  static const Color primaryDark =
      Color(0xFF6366F1); // Main primary color for dark mode (more vibrant)
  static const Color primarySurfaceDark =
      Color(0xFF1E1E1E); // Dark surface for primary elements
  static const Color primaryFocusDark =
      Color(0xFF3730A3); // Focus state for primary elements in dark mode
  static const Color primaryBorderDark =
      Color(0xFF4F46E5); // Border color for primary elements in dark mode
  static const Color primaryHoverDark =
      Color(0xFF4338CA); // Hover state for primary elements in dark mode
  static const Color primaryPressedDark =
      Color(0xFF312E81); // Pressed state for primary elements in dark mode

  // Neutral colors for dark mode (neutral10 = lightest, neutral100 = darkest)
  /// Neutral colors for dark mode
  static const MaterialColor neutralDark = MaterialColor(
    0xFF505050,
    {
      /// Lightest neutral - white for text on dark backgrounds
      10: Color(0xFFFFFFFF),

      /// Very light gray
      20: Color(0xFFF5F5F5),

      /// Light gray
      30: Color(0xFFE5E5E5),

      /// Medium-light gray
      40: Color(0xFFD4D4D4),

      /// Medium gray
      50: Color(0xFFB8B8B8),

      /// Medium-dark gray
      60: Color(0xFF8A8A8A),

      /// Dark gray
      70: Color(0xFF6A6A6A),

      /// Very dark gray
      80: Color(0xFF404040),

      /// Extremely dark gray
      90: Color(0xFF2E2E2E),

      /// Darkest neutral - almost black for backgrounds
      100: Color(0xFF0D0D0D),
    },
  );

  // ============ HELPER METHODS ============

  // Get the appropriate neutral color based on theme mode
  /// Get neutral color by shade and theme mode
  ///
  /// [shade] The neutral shade (10-100)
  /// [isDarkMode] Whether to use dark mode colors
  static Color getNeutral(int shade, {bool isDarkMode = false}) {
    if (isDarkMode) {
      return neutralDark[shade] ?? neutralDark[50]!;
    }
    return neutral[shade] ?? neutral[50]!;
  }

  // Get the appropriate primary color based on theme mode
  /// Get primary color by theme mode
  ///
  /// [isDarkMode] Whether to use dark mode colors
  static Color getPrimary({bool isDarkMode = false}) {
    return isDarkMode ? primaryDark : primary;
  }

  // Get the appropriate primary surface color based on theme mode
  /// Get primary surface color by theme mode
  ///
  /// [isDarkMode] Whether to use dark mode colors
  static Color getPrimarySurface({bool isDarkMode = false}) {
    return isDarkMode ? primarySurfaceDark : primarySurface;
  }

  // Get the appropriate primary focus color based on theme mode
  /// Get primary focus color by theme mode
  ///
  /// [isDarkMode] Whether to use dark mode colors
  static Color getPrimaryFocus({bool isDarkMode = false}) {
    return isDarkMode ? primaryFocusDark : primaryFocus;
  }

  // Get the appropriate primary border color based on theme mode
  /// Get primary border color by theme mode
  ///
  /// [isDarkMode] Whether to use dark mode colors
  static Color getPrimaryBorder({bool isDarkMode = false}) {
    return isDarkMode ? primaryBorderDark : primaryBorder;
  }

  // Get the appropriate primary hover color based on theme mode
  /// Get primary hover color by theme mode
  ///
  /// [isDarkMode] Whether to use dark mode colors
  static Color getPrimaryHover({bool isDarkMode = false}) {
    return isDarkMode ? primaryHoverDark : primaryHover;
  }

  // Get the appropriate primary pressed color based on theme mode
  /// Get primary pressed color by theme mode
  ///
  /// [isDarkMode] Whether to use dark mode colors
  static Color getPrimaryPressed({bool isDarkMode = false}) {
    return isDarkMode ? primaryPressedDark : primaryPressed;
  }
}
