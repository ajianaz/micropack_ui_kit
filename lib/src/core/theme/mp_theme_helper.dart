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

  /// Get adaptive text color based on theme brightness and color scheme
  Color adaptiveTextColor(double opacity) {
    if (isDarkMode) {
      // In dark mode, use lighter colors with better opacity
      return Colors.white.withValues(alpha: opacity);
    } else if (colorTheme != null) {
      // Use neutral colors from theme
      return colorTheme!.neutral80 ?? MpUiKit.colorText.withValues(alpha: opacity);
    } else {
      // Fallback to MpUiKit colorText
      return MpUiKit.colorText.withValues(alpha: opacity);
    }
  }

  /// Get adaptive background color for better contrast
  Color get adaptiveBackgroundColor {
    if (isDarkMode) {
      // In dark mode, use darker neutral from theme
      return colorTheme?.neutral20 ?? const Color(0xFF1A1A1A);
    } else {
      // In light mode, use lighter neutral from theme
      return colorTheme?.neutral100 ?? const Color(0xFFD9D9D9);
    }
  }

  /// Get adaptive border color for dark mode
  Color get adaptiveBorderColor {
    if (isDarkMode) {
      // In dark mode, use lighter border from theme
      return colorTheme?.neutral40 ?? const Color(0xFF3A3A3A);
    } else {
      // In light mode, use darker border from theme
      return colorTheme?.neutral40 ?? const Color(0xFFC9C9C9);
    }
  }

  /// Get adaptive shadow color
  Color get adaptiveShadowColor {
    if (isDarkMode) {
      // In dark mode, use subtle shadow
      return Colors.black.withValues(alpha: 0.3);
    } else {
      // In light mode, use standard shadow
      return Colors.black.withValues(alpha: 0.1);
    }
  }

  /// Get theme color with fallback
  Color? themeColor(Color? Function(MPColorTheme) colorGetter) {
    return colorTheme != null ? colorGetter(colorTheme!) : null;
  }

  /// Get primary color with fallback
  Color get primary => colorTheme?.primary ?? MpUiKit.colorBrand;

  /// Get primary surface color with fallback
  Color get primarySurface => colorTheme?.primarySurface ?? MpUiKit.colorBrand;

  /// Get primary focus color with fallback
  Color get primaryFocus => colorTheme?.primaryFocus ?? MpUiKit.colorBrand;

  /// Get primary border color with fallback
  Color get primaryBorder => colorTheme?.primaryBorder ?? MpUiKit.colorStroke;

  /// Get primary hover color with fallback
  Color get primaryHover => colorTheme?.primaryHover ?? MpUiKit.colorBrand;

  /// Get primary pressed color with fallback
  Color get primaryPressed => colorTheme?.primaryPressed ?? MpUiKit.colorBrand;

  /// Get neutral colors with fallback
  Color get neutral10 => colorTheme?.neutral10 ?? (isDarkMode ? const Color(0xFF090909) : const Color(0xFFD9D9D9));
  Color get neutral20 => colorTheme?.neutral20 ?? (isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFDCDCDC));
  Color get neutral30 => colorTheme?.neutral30 ?? (isDarkMode ? const Color(0xFF2A2A2A) : const Color(0xFFD5D5D5));
  Color get neutral40 => colorTheme?.neutral40 ?? (isDarkMode ? const Color(0xFF3A3A3A) : const Color(0xFFC9C9C9));
  Color get neutral50 => colorTheme?.neutral50 ?? (isDarkMode ? const Color(0xFF4A4A4A) : const Color(0xFFAEAEAE));
  Color get neutral60 => colorTheme?.neutral60 ?? (isDarkMode ? const Color(0xFF5A5A5A) : const Color(0xFF8E8E8E));
  Color get neutral70 => colorTheme?.neutral70 ?? (isDarkMode ? const Color(0xFF6A6A6A) : const Color(0xFF696969));
  Color get neutral80 => colorTheme?.neutral80 ?? (isDarkMode ? const Color(0xFF9A9A9A) : const Color(0xFF535353));
  Color get neutral90 => colorTheme?.neutral90 ?? (isDarkMode ? const Color(0xFFBABABA) : const Color(0xFF393939));
  Color get neutral100 => colorTheme?.neutral100 ?? (isDarkMode ? const Color(0xFFE5E5E5) : const Color(0xFF090909));

  /// Get text color based on theme
  Color get textColor => isDarkMode ? neutral90 : neutral20;

  /// Get subtitle text color based on theme
  Color get subtitleColor => isDarkMode ? neutral80 : neutral40;

  /// Get caption text color based on theme
  Color get captionColor => isDarkMode ? neutral70 : neutral50;

  /// Get disabled color based on theme
  Color get disabledColor => isDarkMode ? neutral50 : neutral30;

  /// Get success color
  Color get successColor => Colors.green;

  /// Get warning color
  Color get warningColor => Colors.orange;

  /// Get error color
  Color get errorColor => Colors.red;

  /// Get info color
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
  static TextStyle getAdaptiveTextStyle(BuildContext context, {
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
  static Color? getThemeColor(BuildContext context, Color? Function(MPColorTheme) colorGetter) {
    final theme = Theme.of(context);
    final colorTheme = theme.extension<MPColorTheme>();
    return colorTheme != null ? colorGetter(colorTheme) : null;
  }
}
