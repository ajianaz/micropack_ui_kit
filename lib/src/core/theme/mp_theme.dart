import 'package:flutter/material.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_config.dart';

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

      // Primary colors using MPThemeConfig as single source of truth
      primaryColor: MPThemeConfig.getPrimary(isDarkMode: false),
      primaryColorDark: MPThemeConfig.getPrimaryPressed(isDarkMode: false),
      primaryColorLight: MPThemeConfig.getPrimaryHover(isDarkMode: false),
      colorScheme: ColorScheme.fromSeed(
        seedColor: MPThemeConfig.getPrimary(isDarkMode: false),
        brightness: Brightness.light,
        primary: MPThemeConfig.getPrimary(isDarkMode: false),
        surface: MPThemeConfig.getPrimarySurface(isDarkMode: false),
        onPrimary: MPThemeConfig.getNeutral(10), // Light text on primary
        onSurface: MPThemeConfig.getNeutral(90), // Dark text on light surface
      ),

      // Background colors using MPThemeConfig
      scaffoldBackgroundColor:
          MPThemeConfig.getBackgroundColor(isDarkMode: false),
      cardColor: MPThemeConfig.getCardColor(isDarkMode: false),

      // Text theme for light mode
      textTheme: MPTextStyle.mainTextTheme,

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: MPThemeConfig.getPrimary(isDarkMode: false),
        foregroundColor: MPThemeConfig.getNeutral(10), // Light text on primary
        elevation: 0,
        titleTextStyle: MPTextStyle.heading1(
          color: MPThemeConfig.getNeutral(10),
        ),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MPThemeConfig.getPrimary(isDarkMode: false),
          foregroundColor: MPThemeConfig.getNeutral(10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: MPThemeConfig.getPrimaryBorder(isDarkMode: false)),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MPThemeConfig.getPrimary(isDarkMode: false),
          side: BorderSide(
              color: MPThemeConfig.getPrimaryBorder(isDarkMode: false)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MPThemeConfig.getPrimary(isDarkMode: false),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: MPThemeConfig.getPrimaryBorder(isDarkMode: false)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: MPThemeConfig.getPrimaryFocus(isDarkMode: false)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: MPThemeConfig.getPrimaryBorder(isDarkMode: false)),
        ),
        fillColor: MPThemeConfig.getPrimarySurface(isDarkMode: false),
        filled: true,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: MPThemeConfig.getCardColor(isDarkMode: false),
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

      // Primary colors using MPThemeConfig as single source of truth
      primaryColor: MPThemeConfig.getPrimary(isDarkMode: true),
      primaryColorDark: MPThemeConfig.getPrimaryPressed(isDarkMode: true),
      primaryColorLight: MPThemeConfig.getPrimaryHover(isDarkMode: true),
      colorScheme: ColorScheme.fromSeed(
        seedColor: MPThemeConfig.getPrimary(isDarkMode: true),
        brightness: Brightness.dark,
        primary: MPThemeConfig.getPrimary(isDarkMode: true),
        surface: MPThemeConfig.getPrimarySurface(isDarkMode: true),
        onPrimary: MPThemeConfig.getNeutral(10), // Light text on primary
        onSurface: MPThemeConfig.getNeutral(30), // Light text on dark surface
      ),

      // Background colors using MPThemeConfig
      scaffoldBackgroundColor:
          MPThemeConfig.getBackgroundColor(isDarkMode: true),
      cardColor: MPThemeConfig.getCardColor(isDarkMode: true),

      // Text theme for dark mode
      textTheme: MPTextStyle.darkTextTheme,

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: MPThemeConfig.getPrimary(isDarkMode: true),
        foregroundColor: MPThemeConfig.getNeutral(10), // Light text on primary
        elevation: 0,
        titleTextStyle: MPTextStyle.heading1(
          color: MPThemeConfig.getNeutral(10),
        ),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MPThemeConfig.getPrimary(isDarkMode: true),
          foregroundColor: MPThemeConfig.getNeutral(10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: MPThemeConfig.getPrimaryBorder(isDarkMode: true)),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MPThemeConfig.getPrimary(isDarkMode: true),
          side: BorderSide(
              color: MPThemeConfig.getPrimaryBorder(isDarkMode: true)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MPThemeConfig.getPrimary(isDarkMode: true),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: MPThemeConfig.getPrimaryBorder(isDarkMode: true)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: MPThemeConfig.getPrimaryFocus(isDarkMode: true)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: MPThemeConfig.getPrimaryBorder(isDarkMode: true)),
        ),
        fillColor: MPThemeConfig.getPrimarySurface(isDarkMode: true),
        filled: true,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: MPThemeConfig.getCardColor(isDarkMode: true),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
