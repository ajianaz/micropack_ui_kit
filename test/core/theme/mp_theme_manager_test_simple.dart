import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/test_helper.dart';

void main() {
  group('MPThemeManager Simple Tests', () {
    late SharedPreferences prefs;

    setUpAll(() async {
      // Initialize test environment
      await MPTestHelper.initialize();

      // Set up mock SharedPreferences for testing
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    setUp(() async {
      // Reset theme manager before each test
      try {
        await MPThemeManager.instance.dispose();
      } catch (e) {
        // Ignore disposal errors if not initialized
      }

      // Clear SharedPreferences
      await prefs.clear();

      // Re-initialize for clean state
      await MPThemeManager.initialize();
    });

    tearDown(() async {
      // Clean up after each test
      try {
        await MPThemeManager.instance.dispose();
      } catch (e) {
        // Ignore disposal errors
      }
    });

    // Initialization tests
    test('initializes correctly', () async {
      await MPThemeManager.initialize();

      expect(MPThemeManager.instance.isInitialized, isTrue);
      expect(MPThemeManager.instance.isInitializing, isFalse);
      expect(MPThemeManager.instance.initializationError, isNull);
      expect(MPThemeManager.instance.themeMode, ThemeMode.system);
    });

    test('throws error when accessing instance before initialization',
        () async {
      // Reset instance to null
      await MPThemeManager.instance.dispose();

      expect(
        () => MPThemeManager.instance,
        throwsA(isA<StateError>()),
      );
    });

    // Theme mode tests
    test('sets light theme mode', () async {
      await MPThemeManager.initialize();
      await MPThemeManager.instance.setLightTheme();

      expect(MPThemeManager.instance.themeMode, ThemeMode.light);
      expect(MPThemeManager.instance.getThemeName(), 'Light');
      expect(MPThemeManager.instance.getThemeIcon(), Icons.light_mode);
    });

    test('sets dark theme mode', () async {
      await MPThemeManager.initialize();
      await MPThemeManager.instance.setDarkTheme();

      expect(MPThemeManager.instance.themeMode, ThemeMode.dark);
      expect(MPThemeManager.instance.getThemeName(), 'Dark');
      expect(MPThemeManager.instance.getThemeIcon(), Icons.dark_mode);
    });

    test('sets system theme mode', () async {
      await MPThemeManager.initialize();
      await MPThemeManager.instance.setSystemTheme();

      expect(MPThemeManager.instance.themeMode, ThemeMode.system);
      expect(MPThemeManager.instance.getThemeName(), 'System');
      expect(MPThemeManager.instance.getThemeIcon(), Icons.settings_brightness);
    });

    test('throws error when setting theme before initialization', () async {
      await MPThemeManager.instance.dispose();

      expect(
        () => MPThemeManager.instance.setLightTheme(),
        throwsA(isA<StateError>()),
      );
    });

    // Custom theme tests
    test('sets custom themes', () async {
      await MPThemeManager.initialize();

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

      await MPThemeManager.instance.setCustomThemes(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      );

      expect(MPThemeManager.instance.hasCustomThemes, isTrue);
      expect(MPThemeManager.instance.customLightTheme?.primary, Colors.red);
      expect(MPThemeManager.instance.customDarkTheme?.primary, Colors.blue);
    });

    test('clears custom themes', () async {
      await MPThemeManager.initialize();

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

      await MPThemeManager.instance.setCustomThemes(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      );

      expect(MPThemeManager.instance.hasCustomThemes, isTrue);

      await MPThemeManager.instance.clearCustomThemes();

      expect(MPThemeManager.instance.hasCustomThemes, isFalse);
      expect(MPThemeManager.instance.customLightTheme, isNull);
      expect(MPThemeManager.instance.customDarkTheme, isNull);
    });

    // Listener tests
    test('adds and removes listeners', () async {
      await MPThemeManager.initialize();

      bool listenerCalled = false;
      VoidCallback listener = () {
        listenerCalled = true;
      };

      MPThemeManager.instance.addListener(listener);

      // Trigger a theme change
      await MPThemeManager.instance.setLightTheme();

      // Wait a bit for async listener to be called
      await Future.delayed(Duration(milliseconds: 10));

      expect(listenerCalled, isTrue);

      listenerCalled = false;
      MPThemeManager.instance.removeListener(listener);

      // Trigger another theme change
      await MPThemeManager.instance.setDarkTheme();

      // Wait a bit for async listener to be called
      await Future.delayed(Duration(milliseconds: 10));

      expect(listenerCalled, isFalse);
    });

    // Reset functionality tests
    test('resets to defaults', () async {
      await MPThemeManager.initialize();

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

      await MPThemeManager.instance.setCustomThemes(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      );
      await MPThemeManager.instance.setDarkTheme();

      expect(MPThemeManager.instance.hasCustomThemes, isTrue);
      expect(MPThemeManager.instance.themeMode, ThemeMode.dark);

      // Reset to defaults
      await MPThemeManager.instance.resetToDefaults();

      expect(MPThemeManager.instance.hasCustomThemes, isFalse);
      expect(MPThemeManager.instance.themeMode, ThemeMode.system);
    });

    // Export/Import tests
    test('exports theme configuration', () async {
      await MPThemeManager.initialize();

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

      await MPThemeManager.instance.setCustomThemes(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      );
      await MPThemeManager.instance.setDarkTheme();

      final config = MPThemeManager.instance.exportThemeConfig();

      expect(config['themeMode'], 'ThemeMode.dark');
      expect(config['customLightTheme'], isNotNull);
      expect(config['customDarkTheme'], isNotNull);
    });

    test('imports theme configuration', () async {
      await MPThemeManager.initialize();

      final config = {
        'themeMode': 'ThemeMode.light',
        'customLightTheme': jsonEncode({
          'primary': Colors.red.value,
        }),
        'customDarkTheme': jsonEncode({
          'primary': Colors.blue.value,
        }),
      };

      await MPThemeManager.instance.importThemeConfig(config);

      expect(MPThemeManager.instance.themeMode, ThemeMode.light);
      expect(MPThemeManager.instance.hasCustomThemes, isTrue);
      expect(MPThemeManager.instance.customLightTheme?.primary, Colors.red);
      expect(MPThemeManager.instance.customDarkTheme?.primary, Colors.blue);
    });

    // Cache tests
    test('gets cache statistics', () async {
      await MPThemeManager.initialize();

      final stats = MPThemeManager.instance.getCacheStats();

      expect(stats['themeDataCacheSize'], 0);
      expect(stats['colorThemeCacheSize'], 0);
      expect(stats['cacheKeys'], isNotNull);
    });

    test('clears caches', () async {
      await MPThemeManager.initialize();

      // Verify cache is empty
      var stats = MPThemeManager.instance.getCacheStats();
      expect(stats['themeDataCacheSize'], 0);
      expect(stats['colorThemeCacheSize'], 0);

      // Clear caches
      MPThemeManager.instance.clearCaches();

      // Verify cache is still empty
      stats = MPThemeManager.instance.getCacheStats();
      expect(stats['themeDataCacheSize'], 0);
      expect(stats['colorThemeCacheSize'], 0);
    });

    // Debug information tests
    test('gets debug information', () async {
      await MPThemeManager.initialize();

      final debugInfo = MPThemeManager.instance.getDebugInfo();

      expect(debugInfo['isInitialized'], isTrue);
      expect(debugInfo['isInitializing'], isFalse);
      expect(debugInfo['initializationError'], isNull);
      expect(debugInfo['themeMode'], isNotNull);
      expect(debugInfo['hasCustomThemes'], isA<bool>());
      expect(debugInfo['listenerCount'], isA<int>());
    });

    // Disposal tests
    test('disposes correctly', () async {
      await MPThemeManager.initialize();

      // Add a listener
      bool listenerCalled = false;
      VoidCallback listener = () {
        listenerCalled = true;
      };

      MPThemeManager.instance.addListener(listener);

      // Dispose
      await MPThemeManager.instance.dispose();

      // Try to use after disposal
      expect(
        () => MPThemeManager.instance.setLightTheme(),
        throwsA(isA<StateError>()),
      );

      // Verify caches are cleared
      final stats = MPThemeManager.instance.getCacheStats();
      expect(stats['themeDataCacheSize'], 0);
      expect(stats['colorThemeCacheSize'], 0);
    });

    // Error handling tests
    test('handles theme switching errors', () async {
      await MPThemeManager.initialize();

      // This should not throw even if there's an error
      await MPThemeManager.instance.setLightTheme();

      // Manager should still be functional
      expect(MPThemeManager.instance.isInitialized, isTrue);
      expect(MPThemeManager.instance.themeMode, ThemeMode.light);
    });
  });
}
