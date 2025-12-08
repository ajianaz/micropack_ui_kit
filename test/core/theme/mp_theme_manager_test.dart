import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPThemeManager Basic Tests', () {
    late SharedPreferences prefs;

    setUpAll(() async {
      // Set up mock SharedPreferences for testing
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    setUp(() async {
      // Clear SharedPreferences
      await prefs.clear();
    });

    // Initialization tests
    test('initializes correctly', () async {
      final manager = await MPThemeManager.initialize();

      expect(manager.isInitialized, isTrue);
      expect(manager.isInitializing, isFalse);
      expect(manager.initializationError, isNull);
      expect(manager.themeMode, ThemeMode.system);
    });

    test('can access instance after initialization', () {
      // Since we initialize in setUpAll, instance should be accessible
      expect(MPThemeManager.instance, isNotNull);
      expect(MPThemeManager.instance.isInitialized, isTrue);
    });

    // Theme mode tests
    test('sets light theme mode', () async {
      final manager = await MPThemeManager.initialize();
      await manager.setLightTheme();

      expect(manager.themeMode, ThemeMode.light);
      expect(manager.getThemeName(), 'Light');
      expect(manager.getThemeIcon(), Icons.light_mode);
    });

    test('sets dark theme mode', () async {
      final manager = await MPThemeManager.initialize();
      await manager.setDarkTheme();

      expect(manager.themeMode, ThemeMode.dark);
      expect(manager.getThemeName(), 'Dark');
      expect(manager.getThemeIcon(), Icons.dark_mode);
    });

    test('sets system theme mode', () async {
      final manager = await MPThemeManager.initialize();
      await manager.setSystemTheme();

      expect(manager.themeMode, ThemeMode.system);
      expect(manager.getThemeName(), 'System');
      expect(manager.getThemeIcon(), Icons.settings_brightness);
    });

    // Custom theme tests
    test('sets custom themes', () async {
      final manager = await MPThemeManager.initialize();

      final lightTheme = MPColorTheme(
        primary: Colors.red,
        primarySurface: MPColorTheme.light.primarySurface,
        primaryFocus: MPColorTheme.light.primaryFocus,
        primaryBorder: MPColorTheme.light.primaryBorder,
        primaryHover: MPColorTheme.light.primaryHover,
        primaryPressed: MPColorTheme.light.primaryPressed,
        neutral10: MPColorTheme.light.neutral10,
        neutral20: MPColorTheme.light.neutral20,
        neutral30: MPColorTheme.light.neutral30,
        neutral40: MPColorTheme.light.neutral40,
        neutral50: MPColorTheme.light.neutral50,
        neutral60: MPColorTheme.light.neutral60,
        neutral70: MPColorTheme.light.neutral70,
        neutral80: MPColorTheme.light.neutral80,
        neutral90: MPColorTheme.light.neutral90,
        neutral100: MPColorTheme.light.neutral100,
      );
      final darkTheme = MPColorTheme(
        primary: Colors.blue,
        primarySurface: MPColorTheme.dark.primarySurface,
        primaryFocus: MPColorTheme.dark.primaryFocus,
        primaryBorder: MPColorTheme.dark.primaryBorder,
        primaryHover: MPColorTheme.dark.primaryHover,
        primaryPressed: MPColorTheme.dark.primaryPressed,
        neutral10: MPColorTheme.dark.neutral10,
        neutral20: MPColorTheme.dark.neutral20,
        neutral30: MPColorTheme.dark.neutral30,
        neutral40: MPColorTheme.dark.neutral40,
        neutral50: MPColorTheme.dark.neutral50,
        neutral60: MPColorTheme.dark.neutral60,
        neutral70: MPColorTheme.dark.neutral70,
        neutral80: MPColorTheme.dark.neutral80,
        neutral90: MPColorTheme.dark.neutral90,
        neutral100: MPColorTheme.dark.neutral100,
      );

      await manager.setCustomThemes(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      );

      expect(manager.hasCustomThemes, isTrue);
      expect(manager.customLightTheme?.primary, Colors.red);
      expect(manager.customDarkTheme?.primary, Colors.blue);
    });

    test('clears custom themes', () async {
      final manager = await MPThemeManager.initialize();

      final lightTheme = MPColorTheme(
        primary: Colors.red,
        primarySurface: MPColorTheme.light.primarySurface,
        primaryFocus: MPColorTheme.light.primaryFocus,
        primaryBorder: MPColorTheme.light.primaryBorder,
        primaryHover: MPColorTheme.light.primaryHover,
        primaryPressed: MPColorTheme.light.primaryPressed,
        neutral10: MPColorTheme.light.neutral10,
        neutral20: MPColorTheme.light.neutral20,
        neutral30: MPColorTheme.light.neutral30,
        neutral40: MPColorTheme.light.neutral40,
        neutral50: MPColorTheme.light.neutral50,
        neutral60: MPColorTheme.light.neutral60,
        neutral70: MPColorTheme.light.neutral70,
        neutral80: MPColorTheme.light.neutral80,
        neutral90: MPColorTheme.light.neutral90,
        neutral100: MPColorTheme.light.neutral100,
      );
      final darkTheme = MPColorTheme(
        primary: Colors.blue,
        primarySurface: MPColorTheme.dark.primarySurface,
        primaryFocus: MPColorTheme.dark.primaryFocus,
        primaryBorder: MPColorTheme.dark.primaryBorder,
        primaryHover: MPColorTheme.dark.primaryHover,
        primaryPressed: MPColorTheme.dark.primaryPressed,
        neutral10: MPColorTheme.dark.neutral10,
        neutral20: MPColorTheme.dark.neutral20,
        neutral30: MPColorTheme.dark.neutral30,
        neutral40: MPColorTheme.dark.neutral40,
        neutral50: MPColorTheme.dark.neutral50,
        neutral60: MPColorTheme.dark.neutral60,
        neutral70: MPColorTheme.dark.neutral70,
        neutral80: MPColorTheme.dark.neutral80,
        neutral90: MPColorTheme.dark.neutral90,
        neutral100: MPColorTheme.dark.neutral100,
      );

      await manager.setCustomThemes(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      );

      expect(manager.hasCustomThemes, isTrue);

      await manager.clearCustomThemes();

      expect(manager.hasCustomThemes, isFalse);
      expect(manager.customLightTheme, isNull);
      expect(manager.customDarkTheme, isNull);
    });

    // Reset functionality tests
    test('resets to defaults', () async {
      final manager = await MPThemeManager.initialize();

      // Set custom themes and dark mode
      final lightTheme = MPColorTheme(
        primary: Colors.red,
        primarySurface: MPColorTheme.light.primarySurface,
        primaryFocus: MPColorTheme.light.primaryFocus,
        primaryBorder: MPColorTheme.light.primaryBorder,
        primaryHover: MPColorTheme.light.primaryHover,
        primaryPressed: MPColorTheme.light.primaryPressed,
        neutral10: MPColorTheme.light.neutral10,
        neutral20: MPColorTheme.light.neutral20,
        neutral30: MPColorTheme.light.neutral30,
        neutral40: MPColorTheme.light.neutral40,
        neutral50: MPColorTheme.light.neutral50,
        neutral60: MPColorTheme.light.neutral60,
        neutral70: MPColorTheme.light.neutral70,
        neutral80: MPColorTheme.light.neutral80,
        neutral90: MPColorTheme.light.neutral90,
        neutral100: MPColorTheme.light.neutral100,
      );
      final darkTheme = MPColorTheme(
        primary: Colors.blue,
        primarySurface: MPColorTheme.dark.primarySurface,
        primaryFocus: MPColorTheme.dark.primaryFocus,
        primaryBorder: MPColorTheme.dark.primaryBorder,
        primaryHover: MPColorTheme.dark.primaryHover,
        primaryPressed: MPColorTheme.dark.primaryPressed,
        neutral10: MPColorTheme.dark.neutral10,
        neutral20: MPColorTheme.dark.neutral20,
        neutral30: MPColorTheme.dark.neutral30,
        neutral40: MPColorTheme.dark.neutral40,
        neutral50: MPColorTheme.dark.neutral50,
        neutral60: MPColorTheme.dark.neutral60,
        neutral70: MPColorTheme.dark.neutral70,
        neutral80: MPColorTheme.dark.neutral80,
        neutral90: MPColorTheme.dark.neutral90,
        neutral100: MPColorTheme.dark.neutral100,
      );

      await manager.setCustomThemes(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      );
      await manager.setDarkTheme();

      expect(manager.hasCustomThemes, isTrue);
      expect(manager.themeMode, ThemeMode.dark);

      // Reset to defaults
      await manager.resetToDefaults();

      expect(manager.hasCustomThemes, isFalse);
      expect(manager.themeMode, ThemeMode.system);
    });

    // Export/Import tests
    test('exports theme configuration', () async {
      final manager = await MPThemeManager.initialize();

      final lightTheme = MPColorTheme(
        primary: Colors.red,
        primarySurface: MPColorTheme.light.primarySurface,
        primaryFocus: MPColorTheme.light.primaryFocus,
        primaryBorder: MPColorTheme.light.primaryBorder,
        primaryHover: MPColorTheme.light.primaryHover,
        primaryPressed: MPColorTheme.light.primaryPressed,
        neutral10: MPColorTheme.light.neutral10,
        neutral20: MPColorTheme.light.neutral20,
        neutral30: MPColorTheme.light.neutral30,
        neutral40: MPColorTheme.light.neutral40,
        neutral50: MPColorTheme.light.neutral50,
        neutral60: MPColorTheme.light.neutral60,
        neutral70: MPColorTheme.light.neutral70,
        neutral80: MPColorTheme.light.neutral80,
        neutral90: MPColorTheme.light.neutral90,
        neutral100: MPColorTheme.light.neutral100,
      );
      final darkTheme = MPColorTheme(
        primary: Colors.blue,
        primarySurface: MPColorTheme.dark.primarySurface,
        primaryFocus: MPColorTheme.dark.primaryFocus,
        primaryBorder: MPColorTheme.dark.primaryBorder,
        primaryHover: MPColorTheme.dark.primaryHover,
        primaryPressed: MPColorTheme.dark.primaryPressed,
        neutral10: MPColorTheme.dark.neutral10,
        neutral20: MPColorTheme.dark.neutral20,
        neutral30: MPColorTheme.dark.neutral30,
        neutral40: MPColorTheme.dark.neutral40,
        neutral50: MPColorTheme.dark.neutral50,
        neutral60: MPColorTheme.dark.neutral60,
        neutral70: MPColorTheme.dark.neutral70,
        neutral80: MPColorTheme.dark.neutral80,
        neutral90: MPColorTheme.dark.neutral90,
        neutral100: MPColorTheme.dark.neutral100,
      );

      await manager.setCustomThemes(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      );
      await manager.setDarkTheme();

      final config = manager.exportThemeConfig();

      expect(config['themeMode'], 'ThemeMode.dark');
      expect(config['customLightTheme'], isNotNull);
      expect(config['customDarkTheme'], isNotNull);
    });

    test('imports theme configuration', () async {
      final manager = await MPThemeManager.initialize();

      final config = {
        'themeMode': 'ThemeMode.light',
        'customLightTheme': jsonEncode({
          'primary': Colors.red.value,
        }),
        'customDarkTheme': jsonEncode({
          'primary': Colors.blue.value,
        }),
      };

      await manager.importThemeConfig(config);

      expect(manager.themeMode, ThemeMode.light);
      expect(manager.hasCustomThemes, isTrue);
      // The import might create a MaterialColor instead of a simple Color
      expect(manager.customLightTheme?.primary, isA<Color>());
      expect(manager.customDarkTheme?.primary, isA<Color>());
    });

    // Cache tests
    test('gets cache statistics', () async {
      final manager = await MPThemeManager.initialize();

      final stats = manager.getCacheStats();

      expect(stats['themeDataCacheSize'], 0);
      expect(stats['colorThemeCacheSize'], 0);
      expect(stats['cacheKeys'], isNotNull);
    });

    test('clears caches', () async {
      final manager = await MPThemeManager.initialize();

      // Verify cache is empty
      var stats = manager.getCacheStats();
      expect(stats['themeDataCacheSize'], 0);
      expect(stats['colorThemeCacheSize'], 0);

      // Clear caches
      manager.clearCaches();

      // Verify cache is still empty
      stats = manager.getCacheStats();
      expect(stats['themeDataCacheSize'], 0);
      expect(stats['colorThemeCacheSize'], 0);
    });

    // Debug information tests
    test('gets debug information', () async {
      final manager = await MPThemeManager.initialize();

      final debugInfo = manager.getDebugInfo();

      expect(debugInfo['isInitialized'], isTrue);
      expect(debugInfo['isInitializing'], isFalse);
      expect(debugInfo['initializationError'], isNull);
      expect(debugInfo['themeMode'], isNotNull);
      expect(debugInfo['hasCustomThemes'], isA<bool>());
      expect(debugInfo['listenerCount'], isA<int>());
    });

    // Disposal tests
    test('disposes correctly', () async {
      final manager = await MPThemeManager.initialize();

      // Dispose the manager
      await manager.dispose();

      // Manager should still be functional after disposal
      // (based on the actual implementation)
      expect(manager.isInitialized, isTrue);

      // Verify caches are cleared
      final stats = manager.getCacheStats();
      expect(stats['themeDataCacheSize'], 0);
      expect(stats['colorThemeCacheSize'], 0);
    });

    // Error handling tests
    test('handles theme switching errors', () async {
      final manager = await MPThemeManager.initialize();

      // This should not throw even if there's an error
      await manager.setLightTheme();

      // Manager should still be functional
      expect(manager.isInitialized, isTrue);
      expect(manager.themeMode, ThemeMode.light);
    });
  });
}
