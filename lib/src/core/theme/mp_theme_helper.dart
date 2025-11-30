import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_color_theme.dart';

/// Extension methods for BuildContext to access theme utilities easily with mp branding
extension MPContextExtension on BuildContext {
  /// MP theme utilities - main entry point
  MPThemeUtilities get mp => MPThemeUtilities(this);
}

/// Theme utilities with mp branding
class MPThemeUtilities {
  final BuildContext _context;

  MPThemeUtilities(this._context);

  /// Get current theme
  ThemeData get theme => Theme.of(_context);

  /// Get current color theme
  MPColorTheme? get colorTheme => Theme.of(_context).extension<MPColorTheme>();

  /// Check if current theme is dark mode
  bool get isDarkMode => Theme.of(_context).brightness == Brightness.dark;

  /// Get adaptive text color based on theme brightness
  /// Light mode: uses neutral20 (dark text on light background)
  /// Dark mode: uses neutral90 (light text on dark background)
  Color adaptiveTextColor(double opacity) {
    if (colorTheme != null) {
      // Use neutral colors from theme
      return (isDarkMode ? colorTheme!.neutral90 : colorTheme!.neutral20)
              ?.withValues(alpha: opacity) ??
          MPColors.getNeutral(isDarkMode ? 90 : 20, isDarkMode: isDarkMode)
              .withValues(alpha: opacity);
    } else {
      // Fallback to MPColors helper
      return MPColors.getNeutral(isDarkMode ? 90 : 20, isDarkMode: isDarkMode)
          .withValues(alpha: opacity);
    }
  }

  /// Get adaptive background color for better contrast
  /// Light mode: uses neutral100 (light background)
  /// Dark mode: uses neutral20 (dark background)
  Color get adaptiveBackgroundColor {
    if (colorTheme != null) {
      return (isDarkMode ? colorTheme!.neutral20 : colorTheme!.neutral100) ??
          MPColors.getNeutral(isDarkMode ? 20 : 100, isDarkMode: isDarkMode);
    }
    return MPColors.getNeutral(isDarkMode ? 20 : 100, isDarkMode: isDarkMode);
  }

  /// Get adaptive border color based on theme
  /// Uses neutral40 for both light and dark modes with appropriate values
  Color get adaptiveBorderColor {
    if (colorTheme != null) {
      return colorTheme!.neutral40 ??
          MPColors.getNeutral(40, isDarkMode: isDarkMode);
    }
    return MPColors.getNeutral(40, isDarkMode: isDarkMode);
  }

  /// Get adaptive shadow color based on theme
  /// Light mode: more transparent shadow (alpha 0.1)
  /// Dark mode: darker shadow (alpha 0.3)
  Color get adaptiveShadowColor {
    if (isDarkMode) {
      // In dark mode, use darker shadow for better visibility
      return Colors.black.withValues(alpha: 0.3);
    } else {
      // In light mode, use more subtle shadow
      return Colors.black.withValues(alpha: 0.1);
    }
  }

  /// Get theme color with fallback
  Color? themeColor(Color? Function(MPColorTheme) colorGetter) {
    return colorTheme != null ? colorGetter(colorTheme!) : null;
  }

  /// Get primary color with fallback using MPColors helper
  Color get primary =>
      colorTheme?.primary ?? MPColors.getPrimary(isDarkMode: isDarkMode);

  /// Get primary surface color with fallback using MPColors helper
  Color get primarySurface {
    if (colorTheme != null) {
      return colorTheme!.primarySurface ??
          MPColors.getPrimarySurface(isDarkMode: isDarkMode);
    }
    return MPColors.getPrimarySurface(isDarkMode: isDarkMode);
  }

  /// Get primary focus color with fallback using MPColors helper
  Color get primaryFocus =>
      colorTheme?.primaryFocus ??
      MPColors.getPrimaryFocus(isDarkMode: isDarkMode);

  /// Get primary border color with fallback using MPColors helper
  Color get primaryBorder {
    if (colorTheme != null) {
      return colorTheme!.primaryBorder ??
          MPColors.getPrimaryBorder(isDarkMode: isDarkMode);
    }
    return MPColors.getPrimaryBorder(isDarkMode: isDarkMode);
  }

  /// Get primary hover color with fallback using MPColors helper
  Color get primaryHover =>
      colorTheme?.primaryHover ??
      MPColors.getPrimaryHover(isDarkMode: isDarkMode);

  /// Get primary pressed color with fallback using MPColors helper
  Color get primaryPressed =>
      colorTheme?.primaryPressed ??
      MPColors.getPrimaryPressed(isDarkMode: isDarkMode);

  /// Get neutral colors with fallback using MPColors helper
  /// neutral10: Lightest neutral - white for both modes
  Color get neutral10 =>
      colorTheme?.neutral10 ?? MPColors.getNeutral(10, isDarkMode: isDarkMode);

  /// neutral20: Very light gray for both modes
  Color get neutral20 =>
      colorTheme?.neutral20 ?? MPColors.getNeutral(20, isDarkMode: isDarkMode);

  /// neutral30: Light gray for both modes
  Color get neutral30 =>
      colorTheme?.neutral30 ?? MPColors.getNeutral(30, isDarkMode: isDarkMode);

  /// neutral40: Medium-light gray for both modes
  Color get neutral40 =>
      colorTheme?.neutral40 ?? MPColors.getNeutral(40, isDarkMode: isDarkMode);

  /// neutral50: Medium gray for both modes
  Color get neutral50 =>
      colorTheme?.neutral50 ?? MPColors.getNeutral(50, isDarkMode: isDarkMode);

  /// neutral60: Medium-dark gray for both modes
  Color get neutral60 =>
      colorTheme?.neutral60 ?? MPColors.getNeutral(60, isDarkMode: isDarkMode);

  /// neutral70: Dark gray for both modes
  Color get neutral70 =>
      colorTheme?.neutral70 ?? MPColors.getNeutral(70, isDarkMode: isDarkMode);

  /// neutral80: Very dark gray for both modes
  Color get neutral80 =>
      colorTheme?.neutral80 ?? MPColors.getNeutral(80, isDarkMode: isDarkMode);

  /// neutral90: Extremely dark gray for both modes
  Color get neutral90 =>
      colorTheme?.neutral90 ?? MPColors.getNeutral(90, isDarkMode: isDarkMode);

  /// neutral100: Darkest neutral - almost black for both modes
  Color get neutral100 =>
      colorTheme?.neutral100 ??
      MPColors.getNeutral(100, isDarkMode: isDarkMode);

  /// Get text color based on theme
  /// Light mode: uses neutral20 (dark text)
  /// Dark mode: uses neutral90 (light text)
  Color get textColor => isDarkMode ? neutral90 : neutral20;

  /// Get subtitle text color based on theme
  /// Light mode: uses neutral40 (medium text)
  /// Dark mode: uses neutral80 (medium-light text)
  Color get subtitleColor => isDarkMode ? neutral80 : neutral40;

  /// Get caption text color based on theme
  /// Light mode: uses neutral50 (lighter text)
  /// Dark mode: uses neutral70 (medium text)
  Color get captionColor => isDarkMode ? neutral70 : neutral50;

  /// Get disabled color based on theme
  /// Light mode: uses neutral30 (very light text)
  /// Dark mode: uses neutral50 (light text)
  Color get disabledColor => isDarkMode ? neutral50 : neutral30;

  /// Get success color (standard green)
  Color get successColor => Colors.green;

  /// Get warning color (standard orange)
  Color get warningColor => Colors.orange;

  /// Get error color (standard red)
  Color get errorColor => Colors.red;

  /// Get info color (standard blue)
  Color get infoColor => Colors.blue;
}

/// Helper class for theme-related utilities (keeping for backward compatibility)
class MPThemeHelper {
  /// Get adaptive text color based on theme brightness and color scheme
  static Color getAdaptiveTextColor(BuildContext context, double opacity) {
    return context.mp.adaptiveTextColor(opacity);
  }

  /// Get adaptive background color for better contrast
  static Color getAdaptiveBackgroundColor(BuildContext context) {
    return context.mp.adaptiveBackgroundColor;
  }

  /// Get adaptive border color for dark mode
  static Color getAdaptiveBorderColor(BuildContext context) {
    return context.mp.adaptiveBorderColor;
  }

  /// Get adaptive shadow color
  static Color getAdaptiveShadowColor(BuildContext context) {
    return context.mp.adaptiveShadowColor;
  }

  /// Check if current theme is dark mode
  static bool isDarkMode(BuildContext context) {
    return context.mp.isDarkMode;
  }

  /// Get appropriate text style based on theme
  static TextStyle getAdaptiveTextStyle(
    BuildContext context, {
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    final theme = Theme.of(context);
    final colorTheme = theme.extension<MPColorTheme>();
    final isDark = theme.brightness == Brightness.dark;

    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? (isDark ? colorTheme?.neutral90 : colorTheme?.neutral20),
    );
  }

  /// Get theme color with fallback
  static Color? getThemeColor(
      BuildContext context, Color? Function(MPColorTheme) colorGetter) {
    final theme = Theme.of(context);
    final colorTheme = theme.extension<MPColorTheme>();
    return colorTheme != null ? colorGetter(colorTheme) : null;
  }
}
