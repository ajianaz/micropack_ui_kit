import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:micropack_ui_kit/src/core/theme/mp_color_theme.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme.dart';
import 'package:micropack_ui_kit/src/core/error/mp_error_handler.dart';
import 'package:micropack_ui_kit/src/core/performance/mp_performance_profiler.dart';

/// MPThemeManager - Provider-free theme manager with singleton pattern
///
/// Features:
/// - Singleton pattern for global access
/// - Basic listener system without Provider
/// - Theme persistence with SharedPreferences (optional)
/// - Custom themes support
/// - Robust error handling
/// - Reset functionality
/// - Thread-safe async operations
/// - Initialization state management
class MPThemeManager {
  // ============ SINGLETON PATTERN ============

  static MPThemeManager? _instance;
  static final _lock = _Mutex();

  MPThemeManager._();

  /// Get singleton instance
  static MPThemeManager get instance {
    if (_instance == null) {
      throw StateError(
        'MPThemeManager must be initialized first. Call initialize() before accessing '
        'instance.',
      );
    }
    return _instance!;
  }

  /// Initialize theme manager
  static Future<MPThemeManager> initialize() async {
    if (_instance == null) {
      await _lock.acquire();
      try {
        if (_instance == null) {
          _instance = MPThemeManager._();
          await _instance!._initialize();
        }
      } finally {
        _lock.release();
      }
    }
    return _instance!;
  }

  // ============ STATE MANAGEMENT ============

  ThemeMode _themeMode = ThemeMode.system;
  bool _isInitialized = false;
  bool _isInitializing = false;
  String? _initializationError;

  // Performance optimization: Theme data cache
  final Map<String, ThemeData> _themeDataCache = {};
  final Map<String, MPColorTheme?> _colorThemeCache = {};

  /// Current theme mode
  ThemeMode get themeMode => _themeMode;

  /// Whether manager is initialized
  bool get isInitialized => _isInitialized;

  /// Whether manager is currently initializing
  bool get isInitializing => _isInitializing;

  /// Initialization error if any
  String? get initializationError => _initializationError;

  // ============ CUSTOM THEMES ============

  MPColorTheme? _customLightTheme;
  MPColorTheme? _customDarkTheme;

  /// Custom light theme
  MPColorTheme? get customLightTheme => _customLightTheme;

  /// Custom dark theme
  MPColorTheme? get customDarkTheme => _customDarkTheme;

  /// Whether custom themes are available
  bool get hasCustomThemes =>
      _customLightTheme != null && _customDarkTheme != null;

  // ============ LISTENER PATTERN ============

  final List<VoidCallback> _listeners = [];
  final _Mutex _listenerMutex = _Mutex();

  /// Add a listener for theme changes
  void addListener(VoidCallback listener) {
    _listenerMutex.acquire().then((_) {
      try {
        _listeners.add(listener);
      } finally {
        _listenerMutex.release();
      }
    });
  }

  /// Remove a listener
  void removeListener(VoidCallback listener) {
    _listenerMutex.acquire().then((_) {
      try {
        _listeners.remove(listener);
      } finally {
        _listenerMutex.release();
      }
    });
  }

  /// Notify all listeners of theme changes
  void _notifyListeners() {
    _listenerMutex.acquire().then((_) {
      try {
        for (final listener in _listeners) {
          try {
            listener();
          } catch (e) {
            debugPrint('Error in theme listener: $e');
          }
        }
      } finally {
        _listenerMutex.release();
      }
    });
  }

  // ============ PERSISTENCE KEYS ============

  static const String _themeModeKey = 'mp_theme_mode';
  static const String _customLightThemeKey = 'mp_custom_light_theme';
  static const String _customDarkThemeKey = 'mp_custom_dark_theme';

  // ============ INITIALIZATION ============

  Future<void> _initialize() async {
    if (_isInitialized || _isInitializing) return;

    _isInitializing = true;
    _initializationError = null;

    try {
      await _loadThemeFromStorage();
      _isInitialized = true;
    } catch (e, stackTrace) {
      _initializationError = e.toString();

      // Handle theme initialization error
      MPErrorHandler.instance.handleThemeError(
        code: 'THEME_INIT_FAILED',
        message: 'Failed to initialize theme manager',
        technicalDetails: e.toString(),
        originalError: e,
        stackTrace: stackTrace,
        context: {
          'themeMode': _themeMode.toString(),
          'hasCustomThemes': hasCustomThemes,
        },
      );

      debugPrint('Failed to initialize MPThemeManager: $e');
      // Set default values as fallback
      _themeMode = ThemeMode.system;
      _isInitialized = true;
    } finally {
      _isInitializing = false;
    }
  }

  // ============ THEME SWITCHING ============

  /// Set theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    if (!_isInitialized) {
      throw StateError(
        'MPThemeManager is not initialized. Call initialize() first.',
      );
    }

    // Performance optimization: Start profiling
    MPPerformanceProfiler.instance.startBuild('ThemeManager.setThemeMode');

    await _lock.acquire();
    try {
      if (_themeMode != mode) {
        // Clear cache when theme changes
        _themeDataCache.clear();
        _colorThemeCache.clear();

        _themeMode = mode;
        await _saveThemeToStorage();
        _notifyListeners();
      }
    } catch (e, stackTrace) {
      // Handle theme switching error
      MPErrorHandler.instance.handleThemeError(
        code: 'THEME_SWITCH_FAILED',
        message: 'Failed to switch theme mode',
        technicalDetails: e.toString(),
        originalError: e,
        stackTrace: stackTrace,
        context: {
          'fromThemeMode': _themeMode.toString(),
          'toThemeMode': mode.toString(),
        },
      );
    } finally {
      _lock.release();

      // Performance optimization: End profiling
      MPPerformanceProfiler.instance.endBuild('ThemeManager.setThemeMode');
    }
  }

  /// Set light theme
  Future<void> setLightTheme() async {
    await setThemeMode(ThemeMode.light);
  }

  /// Set dark theme
  Future<void> setDarkTheme() async {
    await setThemeMode(ThemeMode.dark);
  }

  /// Set system theme
  Future<void> setSystemTheme() async {
    await setThemeMode(ThemeMode.system);
  }

  // ============ CUSTOM THEMES ============

  /// Set custom themes
  Future<void> setCustomThemes({
    MPColorTheme? lightTheme,
    MPColorTheme? darkTheme,
  }) async {
    if (!_isInitialized) {
      throw StateError(
        'MPThemeManager is not initialized. Call initialize() first.',
      );
    }

    // Performance optimization: Start profiling
    MPPerformanceProfiler.instance.startBuild('ThemeManager.setCustomThemes');

    await _lock.acquire();
    try {
      var hasChanges = false;

      if (_customLightTheme != lightTheme) {
        _customLightTheme = lightTheme;
        hasChanges = true;
      }

      if (_customDarkTheme != darkTheme) {
        _customDarkTheme = darkTheme;
        hasChanges = true;
      }

      if (hasChanges) {
        // Clear cache when custom themes change
        _themeDataCache.clear();
        _colorThemeCache.clear();

        await _saveCustomThemesToStorage();
        _notifyListeners();
      }
    } finally {
      _lock.release();

      // Performance optimization: End profiling
      MPPerformanceProfiler.instance.endBuild('ThemeManager.setCustomThemes');
    }
  }

  /// Clear custom themes
  Future<void> clearCustomThemes() async {
    await setCustomThemes(lightTheme: null, darkTheme: null);
  }

  // ============ THEME DATA ACCESS ============

  /// Get current theme data based on context and theme mode
  ThemeData getCurrentThemeData(BuildContext context) {
    if (!_isInitialized) {
      debugPrint(
        'Warning: MPThemeManager not initialized, using default theme',
      );
      return MPTheme.main(isDarkMode: _isDarkMode(context));
    }

    final isDark = _isDarkMode(context);
    final cacheKey = '${isDark ? 'dark' : 'light'}_${_themeMode.toString()}';

    // Check cache first
    if (_themeDataCache.containsKey(cacheKey)) {
      return _themeDataCache[cacheKey]!;
    }

    // Use custom theme if available, otherwise use default
    ThemeData themeData;
    if (hasCustomThemes) {
      final customTheme = isDark ? _customDarkTheme! : _customLightTheme!;
      themeData = MPTheme.main(isDarkMode: isDark).copyWith(
        extensions: [customTheme],
      );
    } else {
      themeData = MPTheme.main(isDarkMode: isDark);
    }

    // Cache the result
    _themeDataCache[cacheKey] = themeData;

    return themeData;
  }

  /// Get current color theme
  MPColorTheme? getCurrentColorTheme(BuildContext context) {
    if (!_isInitialized) return null;

    final isDark = _isDarkMode(context);
    final cacheKey = '${isDark ? 'dark' : 'light'}_color';

    // Check cache first
    if (_colorThemeCache.containsKey(cacheKey)) {
      return _colorThemeCache[cacheKey];
    }

    MPColorTheme? colorTheme;
    if (hasCustomThemes) {
      colorTheme = isDark ? _customDarkTheme : _customLightTheme;
    } else {
      colorTheme = isDark ? MPColorTheme.dark : MPColorTheme.light;
    }

    // Cache the result
    _colorThemeCache[cacheKey] = colorTheme;

    return colorTheme;
  }

  /// Check if current theme is dark
  bool _isDarkMode(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }

  /// Get current brightness
  Brightness getCurrentBrightness(BuildContext context) {
    return _isDarkMode(context) ? Brightness.dark : Brightness.light;
  }

  // ============ UTILITY METHODS ============

  /// Get theme icon based on current theme mode
  IconData getThemeIcon() {
    switch (_themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings_brightness;
    }
  }

  /// Get theme name based on current theme mode
  String getThemeName() {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  /// Get current brightness name as string
  String getCurrentBrightnessName(BuildContext context) {
    return getCurrentBrightness(context) == Brightness.dark ? 'Dark' : 'Light';
  }

  // ============ PERSISTENCE ============

  Future<void> _loadThemeFromStorage() async {
    try {
      final prefs = await _getSharedPreferences();
      if (prefs == null) {
        debugPrint('SharedPreferences not available, using defaults');
        return;
      }

      // Load theme mode
      final savedThemeMode = prefs!.getString(_themeModeKey);
      if (savedThemeMode != null) {
        _themeMode = _parseThemeMode(savedThemeMode as String);
      }

      // Load custom themes
      final customLightJson = prefs!.getString(_customLightThemeKey);
      final customDarkJson = prefs!.getString(_customDarkThemeKey);

      if (customLightJson != null) {
        _customLightTheme = _deserializeTheme(customLightJson as String);
      }

      if (customDarkJson != null) {
        _customDarkTheme = _deserializeTheme(customDarkJson as String);
      }
    } catch (e) {
      debugPrint('Error loading theme from storage: $e');
      // Continue with defaults
    }
  }

  Future<void> _saveThemeToStorage() async {
    try {
      final prefs = await _getSharedPreferences();
      if (prefs != null) {
        await prefs!.setString(_themeModeKey, _themeMode.toString());
      }
    } catch (e) {
      debugPrint('Error saving theme to storage: $e');
    }
  }

  Future<void> _saveCustomThemesToStorage() async {
    try {
      final prefs = await _getSharedPreferences();
      if (prefs == null) return;

      if (_customLightTheme != null) {
        await prefs!.setString(
          _customLightThemeKey,
          _serializeTheme(_customLightTheme!),
        );
      } else {
        await prefs!.remove(_customLightThemeKey);
      }

      if (_customDarkTheme != null) {
        await prefs!.setString(
          _customDarkThemeKey,
          _serializeTheme(_customDarkTheme!),
        );
      } else {
        await prefs!.remove(_customDarkThemeKey);
      }
    } catch (e) {
      debugPrint('Error saving custom themes to storage: $e');
    }
  }

  // ============ SERIALIZATION ============

  String _serializeTheme(MPColorTheme theme) {
    return jsonEncode({
      'primary': theme.primary?.value,
      'primarySurface': theme.primarySurface?.value,
      'primaryFocus': theme.primaryFocus?.value,
      'primaryBorder': theme.primaryBorder?.value,
      'primaryHover': theme.primaryHover?.value,
      'primaryPressed': theme.primaryPressed?.value,
      'neutral10': theme.neutral10?.value,
      'neutral20': theme.neutral20?.value,
      'neutral30': theme.neutral30?.value,
      'neutral40': theme.neutral40?.value,
      'neutral50': theme.neutral50?.value,
      'neutral60': theme.neutral60?.value,
      'neutral70': theme.neutral70?.value,
      'neutral80': theme.neutral80?.value,
      'neutral90': theme.neutral90?.value,
      'neutral100': theme.neutral100?.value,
    });
  }

  MPColorTheme? _deserializeTheme(String json) {
    try {
      final dynamic data = jsonDecode(json);
      if (data is! Map<String, dynamic>) {
        debugPrint('Invalid theme data format');
        return null;
      }

      final Map<String, dynamic> map = data;
      return MPColorTheme(
        primary: _getColorValue(map['primary']),
        primarySurface: _getColorValue(map['primarySurface']),
        primaryFocus: _getColorValue(map['primaryFocus']),
        primaryBorder: _getColorValue(map['primaryBorder']),
        primaryHover: _getColorValue(map['primaryHover']),
        primaryPressed: _getColorValue(map['primaryPressed']),
        neutral10: _getColorValue(map['neutral10']),
        neutral20: _getColorValue(map['neutral20']),
        neutral30: _getColorValue(map['neutral30']),
        neutral40: _getColorValue(map['neutral40']),
        neutral50: _getColorValue(map['neutral50']),
        neutral60: _getColorValue(map['neutral60']),
        neutral70: _getColorValue(map['neutral70']),
        neutral80: _getColorValue(map['neutral80']),
        neutral90: _getColorValue(map['neutral90']),
        neutral100: _getColorValue(map['neutral100']),
      );
    } catch (e) {
      debugPrint('Error deserializing theme: $e');
      return null;
    }
  }

  Color? _getColorValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return Color(value);
    if (value is double) return Color(value.toInt());
    return null;
  }

  ThemeMode _parseThemeMode(String themeString) {
    switch (themeString) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  // ============ RESET FUNCTIONALITY ============

  /// Reset all settings to default
  Future<void> resetToDefaults() async {
    if (!_isInitialized) {
      throw StateError(
        'MPThemeManager is not initialized. Call initialize() first.',
      );
    }

    await _lock.acquire();
    try {
      _themeMode = ThemeMode.system;
      _customLightTheme = null;
      _customDarkTheme = null;

      // Clear from storage
      try {
        final prefs = await _getSharedPreferences();
        if (prefs != null) {
          await prefs!.remove(_themeModeKey);
          await prefs!.remove(_customLightThemeKey);
          await prefs!.remove(_customDarkThemeKey);
        }
      } catch (e) {
        debugPrint('Error clearing theme from storage: $e');
      }

      _notifyListeners();
    } finally {
      _lock.release();
    }
  }

  /// Reset only theme mode to system
  Future<void> resetThemeMode() async {
    await setThemeMode(ThemeMode.system);
  }

  /// Reset only custom themes
  Future<void> resetCustomThemes() async {
    await clearCustomThemes();
  }

  // ============ EXPORT/IMPORT ============

  /// Export current theme configuration
  Map<String, dynamic> exportThemeConfig() {
    if (!_isInitialized) {
      throw StateError(
        'MPThemeManager is not initialized. Call initialize() first.',
      );
    }

    return {
      'themeMode': _themeMode.toString(),
      'customLightTheme': _customLightTheme != null
          ? _serializeTheme(_customLightTheme!)
          : null,
      'customDarkTheme':
          _customDarkTheme != null ? _serializeTheme(_customDarkTheme!) : null,
    };
  }

  /// Import theme configuration
  Future<void> importThemeConfig(Map<String, dynamic> config) async {
    if (!_isInitialized) {
      throw StateError(
        'MPThemeManager is not initialized. Call initialize() first.',
      );
    }

    await _lock.acquire();
    try {
      // Import theme mode
      if (config.containsKey('themeMode') && config['themeMode'] is String) {
        _themeMode = _parseThemeMode(config['themeMode'] as String);
      }

      // Import custom themes
      if (config.containsKey('customLightTheme') &&
          config['customLightTheme'] is String) {
        _customLightTheme =
            _deserializeTheme(config['customLightTheme'] as String);
      }

      if (config.containsKey('customDarkTheme') &&
          config['customDarkTheme'] is String) {
        _customDarkTheme =
            _deserializeTheme(config['customDarkTheme'] as String);
      }

      // Save to storage
      await _saveThemeToStorage();
      await _saveCustomThemesToStorage();

      _notifyListeners();
    } finally {
      _lock.release();
    }
  }

  // ============ DISPOSE ============

  /// Dispose of theme manager and clean up resources
  Future<void> dispose() async {
    await _lock.acquire();
    try {
      unawaited(
        _listenerMutex.acquire().then((_) {
          try {
            _listeners.clear();
          } finally {
            _listenerMutex.release();
          }
        }),
      );

      // Clear caches on dispose
      _themeDataCache.clear();
      _colorThemeCache.clear();
    } finally {
      _lock.release();
    }
  }

  /// Clear theme caches (useful for testing or memory management)
  void clearCaches() {
    _themeDataCache.clear();
    _colorThemeCache.clear();
  }

  /// Get cache statistics
  Map<String, dynamic> getCacheStats() {
    return {
      'themeDataCacheSize': _themeDataCache.length,
      'colorThemeCacheSize': _colorThemeCache.length,
      'cacheKeys': _themeDataCache.keys.toList(),
    };
  }

  // ============ DEBUG ============

  /// Get debug information
  Map<String, dynamic> getDebugInfo() {
    return {
      'isInitialized': _isInitialized,
      'isInitializing': _isInitializing,
      'initializationError': _initializationError,
      'themeMode': _themeMode.toString(),
      'hasCustomThemes': hasCustomThemes,
      'listenerCount': _listeners.length,
    };
  }
}

// ============ SHARED PREFERENCES HELPER ============

/// Try to get SharedPreferences instance (optional dependency)
Future<SharedPreferences?> _getSharedPreferences() async {
  try {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  } catch (e) {
    debugPrint('SharedPreferences not available: $e');
    return null;
  }
}

// ============ MUTEX FOR THREAD SAFETY ============

/// Simple mutex implementation for thread safety
class _Mutex {
  Completer<void>? _completer;

  Future<void> acquire() async {
    while (_completer != null) {
      await _completer!.future;
    }
    _completer = Completer<void>();
  }

  void release() {
    final completer = _completer;
    _completer = null;
    completer?.complete();
  }
}
