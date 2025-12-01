import 'package:flutter/material.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_config.dart';

/// MPTheme - Main theme builder for the UI kit
///
/// Provides light and dark theme configurations using MPThemeConfig
/// as the single source of truth for all colors
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
      primaryColor: MPThemeConfig.getPrimary(),
      primaryColorDark: MPThemeConfig.getPrimaryPressed(),
      primaryColorLight: MPThemeConfig.getPrimaryHover(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: MPThemeConfig.getPrimary(),
        brightness: Brightness.light,
        primary: MPThemeConfig.getPrimary(),
        surface: MPThemeConfig.getPrimarySurface(),
        onPrimary: MPThemeConfig.getNeutral(10), // Light text on primary
        onSurface: MPThemeConfig.getNeutral(90), // Dark text on light surface
      ),

      // Background colors using MPThemeConfig
      scaffoldBackgroundColor: MPThemeConfig.getBackgroundColor(),
      cardColor: MPThemeConfig.getCardColor(),

      // Text theme for light mode
      textTheme: MPTextStyle.mainTextTheme,

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: MPThemeConfig.getBackgroundColor(),
        foregroundColor: MPThemeConfig.getNeutral(90),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: MPTextStyle.heading2(
          color: MPThemeConfig.getNeutral(90),
        ),
        toolbarHeight: 56, // Standard app bar height
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MPThemeConfig.getPrimary(),
          foregroundColor: MPThemeConfig.getNeutral(10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: MPThemeConfig.getPrimaryBorder()),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MPThemeConfig.getPrimary(),
          side: BorderSide(color: MPThemeConfig.getPrimaryBorder()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MPThemeConfig.getPrimary(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MPThemeConfig.getPrimaryBorder()),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MPThemeConfig.getPrimaryFocus()),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MPThemeConfig.getPrimaryBorder()),
        ),
        fillColor: MPThemeConfig.getPrimarySurface(),
        filled: true,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: MPThemeConfig.getCardColor(),
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
      primaryColor: MPThemeConfig.getPrimary(),
      primaryColorDark: MPThemeConfig.getPrimaryPressed(),
      primaryColorLight: MPThemeConfig.getPrimaryHover(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: MPThemeConfig.getPrimary(),
        brightness: Brightness.dark,
        primary: MPThemeConfig.getPrimary(),
        surface: MPThemeConfig.getPrimarySurface(),
        onPrimary: MPThemeConfig.getNeutral(10), // Light text on primary
        onSurface: MPThemeConfig.getNeutral(30), // Light text on dark surface
      ),

      // Background colors using MPThemeConfig
      scaffoldBackgroundColor: MPThemeConfig.getBackgroundColor(),
      cardColor: MPThemeConfig.getCardColor(),

      // Text theme for dark mode
      textTheme: MPTextStyle.darkTextTheme,

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: MPThemeConfig.getBackgroundColor(),
        foregroundColor: MPThemeConfig.getNeutral(10),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: MPTextStyle.heading2(
          color: MPThemeConfig.getNeutral(10),
        ),
        toolbarHeight: 56, // Standard app bar height
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MPThemeConfig.getPrimary(),
          foregroundColor: MPThemeConfig.getNeutral(10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: MPThemeConfig.getPrimaryBorder()),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MPThemeConfig.getPrimary(),
          side: BorderSide(color: MPThemeConfig.getPrimaryBorder()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MPThemeConfig.getPrimary(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MPThemeConfig.getPrimaryBorder()),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MPThemeConfig.getPrimaryFocus()),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MPThemeConfig.getPrimaryBorder()),
        ),
        fillColor: MPThemeConfig.getPrimarySurface(),
        filled: true,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: MPThemeConfig.getCardColor(),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
