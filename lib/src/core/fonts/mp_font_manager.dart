import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micropack_ui_kit/mp_ui_kit_settings.dart';

/// Font loading state enumeration
enum MPFontLoadingState {
  notLoaded,
  loading,
  loaded,
  failed,
}

/// Font fallback configuration
class MPFontFallback {
  final String primaryFont;
  final List<String> fallbackFonts;
  final String platformFont;

  const MPFontFallback({
    required this.primaryFont,
    this.fallbackFonts = const [],
    this.platformFont = 'system',
  });
}

/// Enhanced font manager with robust fallback system
class MPFontManager {
  static final MPFontManager _instance = MPFontManager._internal();
  factory MPFontManager() => _instance;
  MPFontManager._internal();

  // Font loading state tracking
  final Map<String, MPFontLoadingState> _fontLoadingStates = {};
  final Map<String, TextStyle> _cachedFontStyles = {};
  final Map<String, Completer<void>> _loadingCompleters = {};

  // Platform-specific font configurations
  static const Map<String, MPFontFallback> _fontFallbacks = {
    'Poppins': MPFontFallback(
      primaryFont: 'Poppins',
      fallbackFonts: ['Roboto', 'Arial', 'Helvetica'],
      platformFont: 'system',
    ),
    'Roboto': MPFontFallback(
      primaryFont: 'Roboto',
      fallbackFonts: ['Arial', 'Helvetica', 'system'],
      platformFont: 'Roboto',
    ),
    'Inter': MPFontFallback(
      primaryFont: 'Inter',
      fallbackFonts: ['Roboto', 'Arial', 'Helvetica'],
      platformFont: 'system',
    ),
    'Lato': MPFontFallback(
      primaryFont: 'Lato',
      fallbackFonts: ['Roboto', 'Arial', 'Helvetica'],
      platformFont: 'system',
    ),
    'Open Sans': MPFontFallback(
      primaryFont: 'Open Sans',
      fallbackFonts: ['Roboto', 'Arial', 'Helvetica'],
      platformFont: 'system',
    ),
  };

  /// Get platform-specific font family
  static String getPlatformFontFamily(String? preferredFont) {
    if (preferredFont == null) return _getSystemFont();

    // Check if we have a specific fallback configuration
    final fallback = _fontFallbacks[preferredFont];
    if (fallback != null) {
      return _getPlatformOptimalFont(fallback);
    }

    return preferredFont;
  }

  /// Get platform-optimal font family
  static String _getPlatformOptimalFont(MPFontFallback fallback) {
    // Platform-specific optimizations
    final platform = _getCurrentPlatform();
    if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
      // iOS/macOS: Use system font as primary fallback
      return fallback.platformFont == 'system'
          ? 'San Francisco'
          : fallback.primaryFont;
    } else if (platform == TargetPlatform.android) {
      // Android: Use Roboto as primary fallback
      return fallback.platformFont == 'system'
          ? 'Roboto'
          : fallback.primaryFont;
    } else {
      // Web/Desktop: Use primary font with system fallback
      return fallback.primaryFont;
    }
  }

  /// Get current platform safely
  static TargetPlatform _getCurrentPlatform() {
    try {
      return defaultTargetPlatform;
    } catch (e) {
      return TargetPlatform.android; // Default fallback
    }
  }

  /// Get system font based on platform
  static String _getSystemFont() {
    try {
      final platform = _getCurrentPlatform();
      switch (platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return 'San Francisco';
        case TargetPlatform.android:
          return 'Roboto';
        case TargetPlatform.windows:
          return 'Segoe UI';
        case TargetPlatform.linux:
          return 'Ubuntu';
        default:
          return 'system';
      }
    } catch (e) {
      return 'system';
    }
  }

  /// Get font loading state for a specific font
  MPFontLoadingState getFontLoadingState(String fontFamily) {
    return _fontLoadingStates[fontFamily] ?? MPFontLoadingState.notLoaded;
  }

  /// Load font with fallback mechanism
  Future<void> loadFontWithFallback(String fontFamily) async {
    if (_fontLoadingStates[fontFamily] == MPFontLoadingState.loaded) {
      return;
    }

    if (_fontLoadingStates[fontFamily] == MPFontLoadingState.loading) {
      return _loadingCompleters[fontFamily]?.future;
    }

    _fontLoadingStates[fontFamily] = MPFontLoadingState.loading;
    final completer = Completer<void>();
    _loadingCompleters[fontFamily] = completer;

    try {
      // Try to load Google Font first
      await GoogleFonts.pendingFonts([GoogleFonts.getFont(fontFamily)]);
      _fontLoadingStates[fontFamily] = MPFontLoadingState.loaded;
      completer.complete();
    } catch (e) {
      // Fallback to system font
      debugPrint('Failed to load font $fontFamily: $e. Using fallback.');
      _fontLoadingStates[fontFamily] = MPFontLoadingState.failed;
      completer.complete();
    }
  }

  /// Get text style with robust fallback system
  TextStyle getTextStyle({
    required String fontFamily,
    required double fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? height,
    Color? color,
    TextDecoration? decoration,
  }) {
    final cacheKey = _generateCacheKey(
      fontFamily,
      fontSize,
      fontWeight,
      fontStyle,
      letterSpacing,
      height,
      color,
      decoration,
    );

    if (_cachedFontStyles.containsKey(cacheKey)) {
      return _cachedFontStyles[cacheKey]!;
    }

    TextStyle textStyle;

    // Try Google Fonts first
    if (_fontLoadingStates[fontFamily] != MPFontLoadingState.failed) {
      try {
        textStyle = GoogleFonts.getFont(
          fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          height: height,
          color: color,
          decoration: decoration,
        );
      } catch (e) {
        // Mark as failed and use fallback
        _fontLoadingStates[fontFamily] = MPFontLoadingState.failed;
        textStyle = _createFallbackTextStyle(
          fontFamily,
          fontSize,
          fontWeight,
          fontStyle,
          letterSpacing,
          height,
          color,
          decoration,
        );
      }
    } else {
      // Use fallback directly
      textStyle = _createFallbackTextStyle(
        fontFamily,
        fontSize,
        fontWeight,
        fontStyle,
        letterSpacing,
        height,
        color,
        decoration,
      );
    }

    // Cache result
    _cachedFontStyles[cacheKey] = textStyle;

    // Limit cache size
    if (_cachedFontStyles.length > 100) {
      _cachedFontStyles.remove(_cachedFontStyles.keys.first);
    }

    return textStyle;
  }

  /// Create fallback text style with platform-specific optimizations
  TextStyle _createFallbackTextStyle(
    String fontFamily,
    double fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? height,
    Color? color,
    TextDecoration? decoration,
  ) {
    final fallback = _fontFallbacks[fontFamily];
    final fallbackFontFamily = getPlatformFontFamily(fontFamily);
    final platform = _getCurrentPlatform();

    // Platform-specific optimizations
    double optimizedFontSize =
        _getPlatformOptimizedFontSize(fontSize, platform);
    double? optimizedLetterSpacing =
        _getPlatformOptimizedLetterSpacing(letterSpacing, platform);
    double? optimizedHeight = _getPlatformOptimizedLineHeight(height, platform);
    FontWeight? optimizedFontWeight =
        _getPlatformOptimizedFontWeight(fontWeight, platform);

    return TextStyle(
      fontFamily: fallbackFontFamily,
      fontSize: optimizedFontSize,
      fontWeight: optimizedFontWeight,
      fontStyle: fontStyle,
      letterSpacing: optimizedLetterSpacing,
      height: optimizedHeight,
      color: color,
      decoration: decoration,
      // Add font family fallback chain for better compatibility
      fontFamilyFallback: fallback?.fallbackFonts ?? ['system'],
      // Platform-specific rendering optimizations
      leadingDistribution: _getPlatformOptimalLeadingDistribution(platform),
      debugLabel: '${fallbackFontFamily}_${platform.name}',
    );
  }

  /// Get platform-optimized font size
  static double _getPlatformOptimizedFontSize(
      double fontSize, TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        // Apple platforms: Use exact size, system handles scaling
        return fontSize;
      case TargetPlatform.android:
        // Android: Slightly larger for better readability
        return fontSize * 1.02;
      case TargetPlatform.windows:
        // Windows: Slightly smaller to account for different rendering
        return fontSize * 0.98;
      case TargetPlatform.linux:
        // Linux: Use exact size
        return fontSize;
      default:
        // Web: Use exact size
        return fontSize;
    }
  }

  /// Get platform-optimized letter spacing
  static double? _getPlatformOptimizedLetterSpacing(
      double? letterSpacing, TargetPlatform platform) {
    if (letterSpacing == null) return null;

    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        // Apple platforms: Slightly tighter spacing
        return letterSpacing * 0.9;
      case TargetPlatform.android:
        // Android: Standard spacing
        return letterSpacing;
      case TargetPlatform.windows:
        // Windows: Slightly looser spacing
        return letterSpacing * 1.1;
      case TargetPlatform.linux:
        // Linux: Standard spacing
        return letterSpacing;
      default:
        // Web: Standard spacing
        return letterSpacing;
    }
  }

  /// Get platform-optimized line height
  static double? _getPlatformOptimizedLineHeight(
      double? height, TargetPlatform platform) {
    if (height == null) return null;

    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        // Apple platforms: Slightly tighter line height
        return height * 0.95;
      case TargetPlatform.android:
        // Android: Standard line height
        return height;
      case TargetPlatform.windows:
        // Windows: Slightly looser line height
        return height * 1.05;
      case TargetPlatform.linux:
        // Linux: Standard line height
        return height;
      default:
        // Web: Standard line height
        return height;
    }
  }

  /// Get platform-optimized font weight
  static FontWeight? _getPlatformOptimizedFontWeight(
      FontWeight? fontWeight, TargetPlatform platform) {
    if (fontWeight == null) return null;

    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        // Apple platforms: Use exact weight
        return fontWeight;
      case TargetPlatform.android:
        // Android: Slightly bolder for better readability
        return _increaseFontWeight(fontWeight);
      case TargetPlatform.windows:
        // Windows: Standard weight
        return fontWeight;
      case TargetPlatform.linux:
        // Linux: Standard weight
        return fontWeight;
      default:
        // Web: Standard weight
        return fontWeight;
    }
  }

  /// Increase font weight by one step
  static FontWeight _increaseFontWeight(FontWeight weight) {
    switch (weight) {
      case FontWeight.w100:
        return FontWeight.w200;
      case FontWeight.w200:
        return FontWeight.w300;
      case FontWeight.w300:
        return FontWeight.w400;
      case FontWeight.w400:
        return FontWeight.w500;
      case FontWeight.w500:
        return FontWeight.w600;
      case FontWeight.w600:
        return FontWeight.w700;
      case FontWeight.w700:
        return FontWeight.w800;
      case FontWeight.w800:
        return FontWeight.w900;
      default:
        return weight;
    }
  }

  /// Get platform-optimal leading distribution for text rendering
  static TextLeadingDistribution? _getPlatformOptimalLeadingDistribution(
      TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        // Apple platforms: Use proportional leading
        return TextLeadingDistribution.proportional;
      case TargetPlatform.android:
        // Android: Use even leading
        return TextLeadingDistribution.even;
      case TargetPlatform.windows:
        // Windows: Use even leading
        return TextLeadingDistribution.even;
      case TargetPlatform.linux:
        // Linux: Use even leading
        return TextLeadingDistribution.even;
      default:
        // Web: Use even leading
        return TextLeadingDistribution.even;
    }
  }

  /// Generate cache key for text style
  String _generateCacheKey(
    String fontFamily,
    double fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? height,
    Color? color,
    TextDecoration? decoration,
  ) {
    return '${fontFamily}_${fontSize}_${fontWeight?.hashCode ?? 0}_${fontStyle?.hashCode ?? 0}_${letterSpacing ?? 0}_${height ?? 0}_${color?.hashCode ?? 0}_${decoration?.hashCode ?? 0}';
  }

  /// Preload critical fonts
  Future<void> preloadCriticalFonts(List<String> fontFamilies) async {
    final futures =
        fontFamilies.map((fontFamily) => loadFontWithFallback(fontFamily));
    await Future.wait(futures);
  }

  /// Clear font cache
  void clearCache() {
    _cachedFontStyles.clear();
    _fontLoadingStates.clear();
    _loadingCompleters.clear();
  }

  /// Get font loading statistics
  Map<String, dynamic> getFontStats() {
    return {
      'totalFonts': _fontLoadingStates.length,
      'loadedFonts': _fontLoadingStates.values
          .where((state) => state == MPFontLoadingState.loaded)
          .length,
      'failedFonts': _fontLoadingStates.values
          .where((state) => state == MPFontLoadingState.failed)
          .length,
      'cachedStyles': _cachedFontStyles.length,
    };
  }
}
