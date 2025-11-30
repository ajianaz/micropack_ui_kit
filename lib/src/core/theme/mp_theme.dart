import 'package:flutter/material.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MPTheme {
  // ============ MAIN THEME METHOD ============

  /// Main theme method that returns appropriate ThemeData based on isDarkMode parameter
  ///
  /// [isDarkMode] determines which theme to return:
  /// - false (default): Returns light theme
  /// - true: Returns dark theme
  static ThemeData main({bool isDarkMode = false}) {
    return isDarkMode ? _buildDarkTheme() : _buildLightTheme();
  }

  // ============ HELPER METHODS ============

  /// Returns light theme configuration
  /// Uses light mode colors from MPColors helper methods
  static ThemeData lightTheme() => _buildLightTheme();

  /// Returns dark theme configuration
  /// Uses dark mode colors from MPColors helper methods
  static ThemeData darkTheme() => _buildDarkTheme();

  // ============ PRIVATE THEME BUILDERS ============

  /// Builds light theme with appropriate colors and text styles
  static ThemeData _buildLightTheme() {
    return ThemeData(
      // Theme brightness
      brightness: Brightness.light,

      // Primary colors using MPColors helper methods
      primaryColor: MPColors.getPrimary(isDarkMode: false),
      primaryColorDark: MPColors.getPrimaryPressed(isDarkMode: false),
      primaryColorLight: MPColors.getPrimaryHover(isDarkMode: false),
      colorScheme: ColorScheme.fromSeed(
        seedColor: MPColors.getPrimary(isDarkMode: false),
        brightness: Brightness.light,
        primary: MPColors.getPrimary(isDarkMode: false),
        surface: MPColors.getPrimarySurface(isDarkMode: false),
        onPrimary: MPColors.getNeutral(100), // Dark text on light primary
        onSurface: MPColors.getNeutral(90), // Dark text on light surface
      ),

      // Background colors
      scaffoldBackgroundColor: MPColors.getNeutral(10), // Lightest neutral
      cardColor: MPColors.getNeutral(20),

      // Text theme for light mode
      textTheme: MPTextStyle.mainTextTheme,

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: MPColors.getPrimary(isDarkMode: false),
        foregroundColor: MPColors.getNeutral(10), // Light text on dark primary
        elevation: 0,
        titleTextStyle: MPTextStyle.heading1(
          color: MPColors.getNeutral(10),
        ),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MPColors.getPrimary(isDarkMode: false),
          foregroundColor: MPColors.getNeutral(10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side:
                BorderSide(color: MPColors.getPrimaryBorder(isDarkMode: false)),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MPColors.getPrimary(isDarkMode: false),
          side: BorderSide(color: MPColors.getPrimaryBorder(isDarkMode: false)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MPColors.getPrimary(isDarkMode: false),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: MPColors.getPrimaryBorder(isDarkMode: false)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: MPColors.getPrimaryFocus(isDarkMode: false)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: MPColors.getPrimaryBorder(isDarkMode: false)),
        ),
        fillColor: MPColors.getPrimarySurface(isDarkMode: false),
        filled: true,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: MPColors.getNeutral(20),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  /// Builds dark theme with appropriate colors and text styles
  static ThemeData _buildDarkTheme() {
    return ThemeData(
      // Theme brightness
      brightness: Brightness.dark,

      // Primary colors using MPColors helper methods
      primaryColor: MPColors.getPrimary(isDarkMode: true),
      primaryColorDark: MPColors.getPrimaryPressed(isDarkMode: true),
      primaryColorLight: MPColors.getPrimaryHover(isDarkMode: true),
      colorScheme: ColorScheme.fromSeed(
        seedColor: MPColors.getPrimary(isDarkMode: true),
        brightness: Brightness.dark,
        primary: MPColors.getPrimary(isDarkMode: true),
        surface: MPColors.getPrimarySurface(isDarkMode: true),
        onPrimary: MPColors.getNeutral(10), // Light text on dark primary
        onSurface: MPColors.getNeutral(20), // Light text on dark surface
      ),

      // Background colors
      scaffoldBackgroundColor: MPColors.getNeutral(100), // Darkest neutral
      cardColor: MPColors.getNeutral(90),

      // Text theme for dark mode
      textTheme: MPTextStyle.darkTextTheme,

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: MPColors.getPrimary(isDarkMode: true),
        foregroundColor: MPColors.getNeutral(10), // Light text on dark primary
        elevation: 0,
        titleTextStyle: MPTextStyle.heading1(
          color: MPColors.getNeutral(10),
        ),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MPColors.getPrimary(isDarkMode: true),
          foregroundColor: MPColors.getNeutral(10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side:
                BorderSide(color: MPColors.getPrimaryBorder(isDarkMode: true)),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MPColors.getPrimary(isDarkMode: true),
          side: BorderSide(color: MPColors.getPrimaryBorder(isDarkMode: true)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MPColors.getPrimary(isDarkMode: true),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: MPColors.getPrimaryBorder(isDarkMode: true)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: MPColors.getPrimaryFocus(isDarkMode: true)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: MPColors.getPrimaryBorder(isDarkMode: true)),
        ),
        fillColor: MPColors.getPrimarySurface(isDarkMode: true),
        filled: true,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: MPColors.getNeutral(90),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
