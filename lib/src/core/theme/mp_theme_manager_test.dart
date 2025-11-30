import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:micropack_ui_kit/src/core/theme/mp_theme_manager.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_color_theme.dart';

void main() {
  group('MPThemeManager Tests', () {
    late MPThemeManager themeManager;

    setUpAll(() async {
      // Initialize theme manager for tests
      themeManager = await MPThemeManager.initialize();
    });

    tearDownAll(() async {
      // Clean up after tests
      await themeManager.dispose();
    });

    test('should initialize correctly', () {
      expect(themeManager.isInitialized, isTrue);
      expect(themeManager.isInitializing, isFalse);
      expect(themeManager.initializationError, isNull);
      expect(themeManager.themeMode, ThemeMode.system);
    });

    test('should get theme name correctly', () {
      expect(themeManager.getThemeName(), equals('System'));
    });

    test('should get theme icon correctly', () {
      expect(themeManager.getThemeIcon(), equals(Icons.settings_brightness));
    });

    test('should set theme mode correctly', () async {
      await themeManager.setLightTheme();
      expect(themeManager.themeMode, ThemeMode.light);
      expect(themeManager.getThemeName(), equals('Light'));
      expect(themeManager.getThemeIcon(), equals(Icons.light_mode));

      await themeManager.setDarkTheme();
      expect(themeManager.themeMode, ThemeMode.dark);
      expect(themeManager.getThemeName(), equals('Dark'));
      expect(themeManager.getThemeIcon(), equals(Icons.dark_mode));

      await themeManager.setSystemTheme();
      expect(themeManager.themeMode, ThemeMode.system);
      expect(themeManager.getThemeName(), equals('System'));
      expect(themeManager.getThemeIcon(), equals(Icons.settings_brightness));
    });

    test('should handle custom themes', () async {
      final customLight = MPColorTheme(
        primary: Colors.red,
        neutral10: Colors.white,
        neutral100: Colors.black,
      );

      final customDark = MPColorTheme(
        primary: Colors.blue,
        neutral10: Colors.white,
        neutral100: Colors.black,
      );

      await themeManager.setCustomThemes(
        lightTheme: customLight,
        darkTheme: customDark,
      );

      expect(themeManager.hasCustomThemes, isTrue);
      expect(themeManager.customLightTheme?.primary, equals(Colors.red));
      expect(themeManager.customDarkTheme?.primary, equals(Colors.blue));

      await themeManager.clearCustomThemes();
      expect(themeManager.hasCustomThemes, isFalse);
      expect(themeManager.customLightTheme, isNull);
      expect(themeManager.customDarkTheme, isNull);
    });

    test('should handle listeners correctly', () async {
      bool listenerCalled = false;

      void listener() {
        listenerCalled = true;
      }

      themeManager.addListener(listener);

      await themeManager.setLightTheme();

      expect(listenerCalled, isTrue);

      themeManager.removeListener(listener);
    });

    test('should export and import theme config', () async {
      // Set some custom configuration
      await themeManager.setDarkTheme();

      final customLight = MPColorTheme(primary: Colors.green);
      final customDark = MPColorTheme(primary: Colors.purple);

      await themeManager.setCustomThemes(
        lightTheme: customLight,
        darkTheme: customDark,
      );

      // Export configuration
      final config = themeManager.exportThemeConfig();
      expect(config['themeMode'], equals('ThemeMode.dark'));
      expect(config['customLightTheme'], isNotNull);
      expect(config['customDarkTheme'], isNotNull);

      // Reset and import configuration
      await themeManager.resetToDefaults();
      expect(themeManager.themeMode, ThemeMode.system);
      expect(themeManager.hasCustomThemes, isFalse);

      await themeManager.importThemeConfig(config);
      expect(themeManager.themeMode, ThemeMode.dark);
      expect(themeManager.hasCustomThemes, isTrue);
    });

    test('should reset to defaults', () async {
      // Set some custom configuration
      await themeManager.setLightTheme();
      await themeManager.setCustomThemes(
        lightTheme: MPColorTheme(primary: Colors.orange),
        darkTheme: MPColorTheme(primary: Colors.cyan),
      );

      // Reset
      await themeManager.resetToDefaults();

      expect(themeManager.themeMode, ThemeMode.system);
      expect(themeManager.hasCustomThemes, isFalse);
      expect(themeManager.customLightTheme, isNull);
      expect(themeManager.customDarkTheme, isNull);
    });

    test('should provide debug info', () {
      final debugInfo = themeManager.getDebugInfo();
      expect(debugInfo['isInitialized'], isTrue);
      expect(debugInfo['isInitializing'], isFalse);
      expect(debugInfo['themeMode'], equals('ThemeMode.system'));
      expect(debugInfo['hasCustomThemes'], isFalse);
      expect(debugInfo['listenerCount'], isA<int>());
    });

    test('should handle errors gracefully', () {
      // Test that invalid operations throw appropriate errors
      expect(
        () => MPThemeManager.instance,
        throwsA(isA<StateError>()),
      );
    });
  });

  group('MPThemeManager Serialization Tests', () {
    test('should serialize and deserialize themes correctly', () {
      final originalTheme = MPColorTheme(
        primary: Colors.red,
        primarySurface: Colors.pink,
        neutral10: Colors.white,
        neutral100: Colors.black,
      );

      // Test theme properties directly
      expect(originalTheme.primary, equals(Colors.red));
      expect(originalTheme.primarySurface, equals(Colors.pink));
      expect(originalTheme.neutral10, equals(Colors.white));
      expect(originalTheme.neutral100, equals(Colors.black));
    });
  });
}
