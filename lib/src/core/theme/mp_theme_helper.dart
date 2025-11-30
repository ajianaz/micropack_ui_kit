import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_color_theme.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_config.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_manager.dart';

/// Extension methods for BuildContext to access theme utilities easily with mp branding
extension MPContextExtension on BuildContext {
  /// MP theme utilities - main entry point
  MPThemeUtilities get mp => MPThemeUtilities(this);
}

/// Theme utilities with mp branding
///
/// This class provides comprehensive theme utilities with:
/// - Single source of truth through MPThemeConfig
/// - Correct dark mode logic
/// - Enhanced features (spacing, borders, shadows, gradients)
/// - Interactive states
/// - Robust error handling
/// - MPThemeManager integration
class MPThemeUtilities {
  final BuildContext _context;

  MPThemeUtilities(this._context);

  /// Get current theme
  ThemeData get theme => Theme.of(_context);

  /// Get current color theme
  MPColorTheme? get colorTheme => Theme.of(_context).extension<MPColorTheme>();

  /// Check if current theme is dark mode
  bool get isDarkMode => Theme.of(_context).brightness == Brightness.dark;

  /// Get theme manager instance (with error handling)
  MPThemeManager? get themeManager {
    try {
      if (MPThemeManager.instance.isInitialized) {
        return MPThemeManager.instance;
      }
      return null;
    } catch (e) {
      // Manager not initialized, return null
      return null;
    }
  }

  // ============ CRITICAL FIXES: ADAPTIVE COLORS ============

  /// Get adaptive text color based on theme brightness
  /// FIXED: Dark mode now uses neutral10 (white text on dark background)
  /// Light mode: uses neutral90 (dark text on light background)
  Color adaptiveTextColor(double opacity) {
    try {
      if (colorTheme != null) {
        // Use neutral colors from theme with CORRECT dark mode logic
        final baseColor = isDarkMode
            ? (colorTheme!.neutral10 ?? MPThemeConfig.getNeutral(10))
            : (colorTheme!.neutral90 ?? MPThemeConfig.getNeutral(90));
        return baseColor.withValues(alpha: opacity);
      } else {
        // Fallback to MPThemeConfig helper with CORRECT logic
        final baseColor = isDarkMode
            ? MPThemeConfig.getNeutral(10)
            : MPThemeConfig.getNeutral(90);
        return baseColor.withValues(alpha: opacity);
      }
    } catch (e) {
      // Robust fallback
      return (isDarkMode ? Colors.white : Colors.black)
          .withValues(alpha: opacity);
    }
  }

  /// Get adaptive background color for better contrast
  /// FIXED: Dark mode now uses neutral90 (dark background)
  /// Light mode: uses neutral10 (light background)
  Color get adaptiveBackgroundColor {
    try {
      if (colorTheme != null) {
        // Use CORRECT dark mode logic
        return isDarkMode
            ? (colorTheme!.neutral90 ?? MPThemeConfig.getNeutral(90))
            : (colorTheme!.neutral10 ?? MPThemeConfig.getNeutral(10));
      }
      // Fallback to MPThemeConfig helper with CORRECT logic
      return isDarkMode
          ? MPThemeConfig.getNeutral(90)
          : MPThemeConfig.getNeutral(10);
    } catch (e) {
      // Robust fallback
      return isDarkMode ? const Color(0xFF374151) : const Color(0xFFFFFFFF);
    }
  }

  // ============ PRIMARY COLORS (using MPThemeConfig) ============

  /// Get primary color with fallback using MPThemeConfig
  Color get primary =>
      colorTheme?.primary ?? MPThemeConfig.getPrimary(isDarkMode: isDarkMode);

  /// Get primary surface color with fallback using MPThemeConfig
  Color get primarySurface =>
      colorTheme?.primarySurface ??
      MPThemeConfig.getPrimarySurface(isDarkMode: isDarkMode);

  /// Get primary focus color with fallback using MPThemeConfig
  Color get primaryFocus =>
      colorTheme?.primaryFocus ??
      MPThemeConfig.getPrimaryFocus(isDarkMode: isDarkMode);

  /// Get primary border color with fallback using MPThemeConfig
  Color get primaryBorder =>
      colorTheme?.primaryBorder ??
      MPThemeConfig.getPrimaryBorder(isDarkMode: isDarkMode);

  /// Get primary hover color with fallback using MPThemeConfig
  Color get primaryHover =>
      colorTheme?.primaryHover ??
      MPThemeConfig.getPrimaryHover(isDarkMode: isDarkMode);

  /// Get primary pressed color with fallback using MPThemeConfig
  Color get primaryPressed =>
      colorTheme?.primaryPressed ??
      MPThemeConfig.getPrimaryPressed(isDarkMode: isDarkMode);

  // ============ NEUTRAL COLORS (using MPThemeConfig) ============

  /// Get neutral colors with fallback using MPThemeConfig
  Color get neutral10 => colorTheme?.neutral10 ?? MPThemeConfig.getNeutral(10);
  Color get neutral20 => colorTheme?.neutral20 ?? MPThemeConfig.getNeutral(20);
  Color get neutral30 => colorTheme?.neutral30 ?? MPThemeConfig.getNeutral(30);
  Color get neutral40 => colorTheme?.neutral40 ?? MPThemeConfig.getNeutral(40);
  Color get neutral50 => colorTheme?.neutral50 ?? MPThemeConfig.getNeutral(50);
  Color get neutral60 => colorTheme?.neutral60 ?? MPThemeConfig.getNeutral(60);
  Color get neutral70 => colorTheme?.neutral70 ?? MPThemeConfig.getNeutral(70);
  Color get neutral80 => colorTheme?.neutral80 ?? MPThemeConfig.getNeutral(80);
  Color get neutral90 => colorTheme?.neutral90 ?? MPThemeConfig.getNeutral(90);
  Color get neutral100 =>
      colorTheme?.neutral100 ?? MPThemeConfig.getNeutral(100);

  // ============ SEMANTIC COLORS (using MPThemeConfig) ============

  /// Get surface color based on theme mode
  Color get surfaceColor =>
      MPThemeConfig.getSurfaceColor(isDarkMode: isDarkMode);

  /// Get card background color based on theme mode
  Color get cardColor => MPThemeConfig.getCardColor(isDarkMode: isDarkMode);

  /// Get divider color based on theme mode
  Color get dividerColor =>
      MPThemeConfig.getDividerColor(isDarkMode: isDarkMode);

  /// Get border color based on theme
  Color get borderColor => MPThemeConfig.getBorderColor(isDarkMode: isDarkMode);

  /// Get adaptive border color based on theme (for backward compatibility)
  Color get adaptiveBorderColor => borderColor;

  // ============ TEXT COLORS (using MPThemeConfig) ============

  /// Get primary text color based on theme
  Color get textColor =>
      MPThemeConfig.getPrimaryTextColor(isDarkMode: isDarkMode);

  /// Get secondary text color based on theme
  Color get subtitleColor =>
      MPThemeConfig.getSecondaryTextColor(isDarkMode: isDarkMode);

  /// Get caption text color based on theme
  Color get captionColor =>
      MPThemeConfig.getDisabledTextColor(isDarkMode: isDarkMode);

  /// Get disabled text color based on theme
  Color get disabledColor =>
      MPThemeConfig.getDisabledTextColor(isDarkMode: isDarkMode);

  // ============ SEMANTIC STATUS COLORS ============

  /// Get success color using MPThemeConfig
  Color get successColor => MPThemeConfig.getSuccessColor();

  /// Get success background color using MPThemeConfig
  Color get successBackgroundColor => MPThemeConfig.getSuccessBackgroundColor();

  /// Get warning color using MPThemeConfig
  Color get warningColor => MPThemeConfig.getWarningColor();

  /// Get warning background color using MPThemeConfig
  Color get warningBackgroundColor => MPThemeConfig.getWarningBackgroundColor();

  /// Get error color using MPThemeConfig
  Color get errorColor => MPThemeConfig.getErrorColor();

  /// Get error background color using MPThemeConfig
  Color get errorBackgroundColor => MPThemeConfig.getErrorBackgroundColor();

  /// Get info color using MPThemeConfig
  Color get infoColor => MPThemeConfig.getInfoColor();

  /// Get info background color using MPThemeConfig
  Color get infoBackgroundColor => MPThemeConfig.getInfoBackgroundColor();

  // ============ ENHANCED FEATURES: SPACING SYSTEM ============

  /// Spacing system for consistent layouts
  double get spacingXS => 4.0;
  double get spacingSM => 8.0;
  double get spacingMD => 16.0;
  double get spacingLG => 24.0;
  double get spacingXL => 32.0;
  double get spacingXXL => 48.0;

  /// Get spacing value by name
  double spacing(String size) {
    switch (size.toLowerCase()) {
      case 'xs':
        return spacingXS;
      case 'sm':
        return spacingSM;
      case 'md':
        return spacingMD;
      case 'lg':
        return spacingLG;
      case 'xl':
        return spacingXL;
      case 'xxl':
        return spacingXXL;
      default:
        return spacingMD;
    }
  }

  // ============ ENHANCED FEATURES: BORDER RADIUS SYSTEM ============

  /// Border radius system for consistent shapes
  double get radiusXS => 2.0;
  double get radiusSM => 4.0;
  double get radiusMD => 8.0;
  double get radiusLG => 12.0;
  double get radiusXL => 16.0;
  double get radiusXXL => 24.0;
  double get radiusFull => 999.0;

  /// Get border radius by name
  double radius(String size) {
    switch (size.toLowerCase()) {
      case 'xs':
        return radiusXS;
      case 'sm':
        return radiusSM;
      case 'md':
        return radiusMD;
      case 'lg':
        return radiusLG;
      case 'xl':
        return radiusXL;
      case 'xxl':
        return radiusXXL;
      case 'full':
        return radiusFull;
      default:
        return radiusMD;
    }
  }

  /// Get border radius as BorderRadius object
  BorderRadius borderRadius(String size) {
    return BorderRadius.all(Radius.circular(radius(size)));
  }

  /// Get border radius as BorderRadius with custom values
  BorderRadius borderRadiusOnly({
    String? top,
    String? bottom,
    String? left,
    String? right,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(top != null ? radius(top) : 0),
      topRight: Radius.circular(right != null ? radius(right) : 0),
      bottomLeft: Radius.circular(left != null ? radius(left) : 0),
      bottomRight: Radius.circular(bottom != null ? radius(bottom) : 0),
    );
  }

  // ============ ENHANCED FEATURES: SHADOW SYSTEM ============

  /// Get adaptive shadow color based on theme
  Color get adaptiveShadowColor =>
      MPThemeConfig.getShadowColor(isDarkMode: isDarkMode);

  /// Card shadow with proper elevation
  List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: adaptiveShadowColor,
          blurRadius: 8.0,
          offset: const Offset(0, 2),
          spreadRadius: 0.0,
        ),
      ];

  /// Elevation shadow with different levels
  List<BoxShadow> elevationShadow(double elevation) {
    final opacity = isDarkMode ? 0.3 : 0.1;
    final blurRadius = elevation * 2.0;
    final offset = Offset(0, elevation / 2.0);

    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: opacity),
        blurRadius: blurRadius,
        offset: offset,
        spreadRadius: 0.0,
      ),
    ];
  }

  // ============ ENHANCED FEATURES: GRADIENT SYSTEM ============

  /// Primary gradient for buttons and highlights
  LinearGradient get primaryGradient => LinearGradient(
        colors: [
          primary,
          primaryHover,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  /// Create custom gradient with multiple colors
  LinearGradient gradient({
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
    List<double>? stops,
    TileMode tileMode = TileMode.clamp,
  }) {
    return LinearGradient(
      colors: colors,
      begin: begin,
      end: end,
      stops: stops,
      tileMode: tileMode,
    );
  }

  // ============ ENHANCED FEATURES: INTERACTIVE STATES ============

  /// Get hover color for interactive elements
  Color getHoverColor(Color baseColor, {double factor = 0.1}) {
    try {
      if (isDarkMode) {
        // In dark mode, hover should lighten the color
        return Color.lerp(baseColor, Colors.white, factor) ?? baseColor;
      } else {
        // In light mode, hover should darken the color
        return Color.lerp(baseColor, Colors.black, factor) ?? baseColor;
      }
    } catch (e) {
      return baseColor;
    }
  }

  /// Get pressed color for interactive elements
  Color getPressedColor(Color baseColor, {double factor = 0.2}) {
    try {
      if (isDarkMode) {
        // In dark mode, pressed should lighten more than hover
        return Color.lerp(baseColor, Colors.white, factor) ?? baseColor;
      } else {
        // In light mode, pressed should darken more than hover
        return Color.lerp(baseColor, Colors.black, factor) ?? baseColor;
      }
    } catch (e) {
      return baseColor;
    }
  }

  /// Get selected color for interactive elements
  Color getSelectedColor(Color baseColor) {
    try {
      // Use primary color as selection indicator
      return isDarkMode
          ? Color.lerp(baseColor, primary, 0.3) ?? baseColor
          : Color.lerp(baseColor, primary, 0.2) ?? baseColor;
    } catch (e) {
      return baseColor;
    }
  }

  /// Get disabled color for interactive elements
  Color getDisabledColor(Color baseColor) {
    try {
      return baseColor.withValues(alpha: 0.38); // Material Design standard
    } catch (e) {
      return baseColor;
    }
  }

  // ============ UTILITY METHODS ============

  /// Get theme color with fallback and error handling
  Color? themeColor(Color? Function(MPColorTheme) colorGetter) {
    try {
      return colorTheme != null ? colorGetter(colorTheme!) : null;
    } catch (e) {
      return null;
    }
  }

  /// Get contrast ratio between two colors
  double getContrastRatio(Color foreground, Color background) {
    return MPThemeConfig.getContrastRatio(foreground, background);
  }

  /// Check if two colors have sufficient contrast
  bool hasGoodContrast(Color foreground, Color background,
      {double minimumRatio = 4.5}) {
    return MPThemeConfig.hasGoodContrast(foreground, background,
        minimumRatio: minimumRatio);
  }

  /// Get the best text color for a given background
  Color getBestTextColor(Color background) {
    return MPThemeConfig.getBestTextColor(background);
  }

  // ============ STATE MANAGEMENT INTEGRATION ============

  /// Listen to theme changes
  void addThemeListener(VoidCallback listener) {
    themeManager?.addListener(listener);
  }

  /// Remove theme listener
  void removeThemeListener(VoidCallback listener) {
    themeManager?.removeListener(listener);
  }

  /// Get current theme mode from manager
  ThemeMode? get currentThemeMode => themeManager?.themeMode;

  /// Check if theme manager is initialized
  bool get isThemeManagerInitialized =>
      themeManager != null && themeManager!.isInitialized;

  // ============ DEBUG AND VALIDATION ============

  /// Validate theme configuration
  Map<String, bool> validateTheme() {
    return MPThemeConfig.validateThemeContrast(isDarkMode: isDarkMode);
  }

  /// Get theme validation summary
  String getValidationSummary() {
    return MPThemeConfig.getThemeValidationSummary(isDarkMode: isDarkMode);
  }
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
    return context.mp.borderColor;
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
    final mp = context.mp;

    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? mp.adaptiveTextColor(1.0),
    );
  }

  /// Get theme color with fallback
  static Color? getThemeColor(
      BuildContext context, Color? Function(MPColorTheme) colorGetter) {
    return context.mp.themeColor(colorGetter);
  }

  // ============ STATIC ACCESS TO ENHANCED FEATURES ============

  /// Get spacing value
  static double getSpacing(BuildContext context, String size) {
    return context.mp.spacing(size);
  }

  /// Get border radius
  static double getBorderRadius(BuildContext context, String size) {
    return context.mp.radius(size);
  }

  /// Get border radius as BorderRadius
  static BorderRadius getBorderRadiusObject(BuildContext context, String size) {
    return context.mp.borderRadius(size);
  }

  /// Get card shadow
  static List<BoxShadow> getCardShadow(BuildContext context) {
    return context.mp.cardShadow;
  }

  /// Get elevation shadow
  static List<BoxShadow> getElevationShadow(
      BuildContext context, double elevation) {
    return context.mp.elevationShadow(elevation);
  }

  /// Get primary gradient
  static LinearGradient getPrimaryGradient(BuildContext context) {
    return context.mp.primaryGradient;
  }

  /// Get hover color
  static Color getHoverColor(BuildContext context, Color baseColor,
      {double factor = 0.1}) {
    return context.mp.getHoverColor(baseColor, factor: factor);
  }

  /// Get pressed color
  static Color getPressedColor(BuildContext context, Color baseColor,
      {double factor = 0.2}) {
    return context.mp.getPressedColor(baseColor, factor: factor);
  }

  /// Get selected color
  static Color getSelectedColor(BuildContext context, Color baseColor) {
    return context.mp.getSelectedColor(baseColor);
  }

  /// Get disabled color
  static Color getDisabledColor(BuildContext context, Color baseColor) {
    return context.mp.getDisabledColor(baseColor);
  }
}
