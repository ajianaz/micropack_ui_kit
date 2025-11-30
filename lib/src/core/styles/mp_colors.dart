import 'package:flutter/material.dart';

class MPColors {
  const MPColors._();

  // ============ LIGHT MODE COLORS ============

  // Primary colors for light mode
  static const Color primary =
      Color(0xFF303F9F); // Main primary color for light mode
  static const Color primarySurface =
      Color(0xFFF5F5FA); // Light surface for primary elements
  static const Color primaryFocus =
      Color(0xFFD6D9EC); // Focus state for primary elements
  static const Color primaryBorder =
      Color(0xFFBABFDF); // Border color for primary elements
  static const Color primaryHover =
      Color(0xFF283584); // Hover state for primary elements
  static const Color primaryPressed =
      Color(0xFF182050); // Pressed state for primary elements

  // Neutral colors for light mode (neutral10 = lightest, neutral100 = darkest)
  static const MaterialColor neutral = MaterialColor(
    0xFFAEAEAE,
    {
      10: Color(0xFFFFFFFF), // Lightest neutral - almost white
      20: Color(0xFFF5F5F5), // Very light gray
      30: Color(0xFFE5E5E5), // Light gray
      40: Color(0xFFD4D4D4), // Medium-light gray
      50: Color(0xFFAEAEAE), // Medium gray
      60: Color(0xFF8E8E8E), // Medium-dark gray
      70: Color(0xFF696969), // Dark gray
      80: Color(0xFF535353), // Very dark gray
      90: Color(0xFF393939), // Extremely dark gray
      100: Color(0xFF090909), // Darkest neutral - almost black
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
  static const MaterialColor neutralDark = MaterialColor(
    0xFF505050,
    {
      10: Color(
          0xFFFFFFFF), // Lightest neutral - white for text on dark backgrounds
      20: Color(0xFFF5F5F5), // Very light gray
      30: Color(0xFFE5E5E5), // Light gray
      40: Color(0xFFD4D4D4), // Medium-light gray
      50: Color(0xFFB8B8B8), // Medium gray
      60: Color(0xFF8A8A8A), // Medium-dark gray
      70: Color(0xFF6A6A6A), // Dark gray
      80: Color(0xFF404040), // Very dark gray
      90: Color(0xFF2E2E2E), // Extremely dark gray
      100: Color(0xFF0D0D0D), // Darkest neutral - almost black for backgrounds
    },
  );

  // ============ HELPER METHODS ============

  // Get the appropriate neutral color based on theme mode
  static Color getNeutral(int shade, {bool isDarkMode = false}) {
    if (isDarkMode) {
      return neutralDark[shade] ?? neutralDark[50]!;
    }
    return neutral[shade] ?? neutral[50]!;
  }

  // Get the appropriate primary color based on theme mode
  static Color getPrimary({bool isDarkMode = false}) {
    return isDarkMode ? primaryDark : primary;
  }

  // Get the appropriate primary surface color based on theme mode
  static Color getPrimarySurface({bool isDarkMode = false}) {
    return isDarkMode ? primarySurfaceDark : primarySurface;
  }

  // Get the appropriate primary focus color based on theme mode
  static Color getPrimaryFocus({bool isDarkMode = false}) {
    return isDarkMode ? primaryFocusDark : primaryFocus;
  }

  // Get the appropriate primary border color based on theme mode
  static Color getPrimaryBorder({bool isDarkMode = false}) {
    return isDarkMode ? primaryBorderDark : primaryBorder;
  }

  // Get the appropriate primary hover color based on theme mode
  static Color getPrimaryHover({bool isDarkMode = false}) {
    return isDarkMode ? primaryHoverDark : primaryHover;
  }

  // Get the appropriate primary pressed color based on theme mode
  static Color getPrimaryPressed({bool isDarkMode = false}) {
    return isDarkMode ? primaryPressedDark : primaryPressed;
  }
}
