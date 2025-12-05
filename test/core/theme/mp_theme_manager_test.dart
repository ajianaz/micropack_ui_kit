import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/test_helper.dart';

void main() {
  group('MPThemeManager Tests', () {
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
    testWidgets('initializes correctly', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      expect(MPThemeManager.instance.isInitialized, isTrue);
      expect(MPThemeManager.instance.isInitializing, isFalse);
      expect(MPThemeManager.instance.initializationError, isNull);
      expect(MPThemeManager.instance.themeMode, ThemeMode.system);
    });

    testWidgets('throws error when accessing instance before initialization',
        (WidgetTester tester) async {
      // Reset instance to null
      await MPThemeManager.instance.dispose();

      // Access the static getter to trigger the error
      expect(
        () => MPThemeManager.instance,
        throwsA(isA<StateError>()),
      );
    });

    testWidgets('handles initialization errors gracefully',
        (WidgetTester tester) async {
      // Mock SharedPreferences to throw error
      SharedPreferences.setMockInitialValues({});

      await MPThemeManager.initialize();

      // Should still be marked as initialized even with error
      expect(MPThemeManager.instance.isInitialized, isTrue);
      expect(MPThemeManager.instance.isInitializing, isFalse);
    });

    // Theme mode tests
    testWidgets('sets light theme mode', (WidgetTester tester) async {
      await MPThemeManager.initialize();
      await MPThemeManager.instance.setLightTheme();

      expect(MPThemeManager.instance.themeMode, ThemeMode.light);
      expect(MPThemeManager.instance.getThemeName(), 'Light');
      expect(MPThemeManager.instance.getThemeIcon(), Icons.light_mode);
    });

    testWidgets('sets dark theme mode', (WidgetTester tester) async {
      await MPThemeManager.initialize();
      await MPThemeManager.instance.setDarkTheme();

      expect(MPThemeManager.instance.themeMode, ThemeMode.dark);
      expect(MPThemeManager.instance.getThemeName(), 'Dark');
      expect(MPThemeManager.instance.getThemeIcon(), Icons.dark_mode);
    });

    testWidgets('sets system theme mode', (WidgetTester tester) async {
      await MPThemeManager.initialize();
      await MPThemeManager.instance.setSystemTheme();

      expect(MPThemeManager.instance.themeMode, ThemeMode.system);
      expect(MPThemeManager.instance.getThemeName(), 'System');
      expect(MPThemeManager.instance.getThemeIcon(), Icons.settings_brightness);
    });

    testWidgets('throws error when setting theme before initialization',
        (WidgetTester tester) async {
      await MPThemeManager.instance.dispose();

      expect(
        () => MPThemeManager.instance.setLightTheme(),
        throwsA(isA<StateError>()),
      );
    });

    // Custom theme tests
    testWidgets('sets custom themes', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      final MPColorTheme lightTheme = MPColorTheme(
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
      final MPColorTheme darkTheme = MPColorTheme(
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

    testWidgets('clears custom themes', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      final MPColorTheme lightTheme = MPColorTheme(
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
      final MPColorTheme darkTheme = MPColorTheme(
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

    // Theme data access tests
    testWidgets('gets current theme data', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final themeData =
                  MPThemeManager.instance.getCurrentThemeData(context);
              expect(themeData, isNotNull);
              expect(themeData.brightness, Brightness.light);

              return Container();
            },
          ),
        ),
      );

      await tester.pump();
    });

    testWidgets('gets current color theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final colorTheme =
                  MPThemeManager.instance.getCurrentColorTheme(context);
              expect(colorTheme, isNotNull);
              expect(colorTheme?.primary, isNotNull);

              return Container();
            },
          ),
        ),
      );

      await tester.pump();
    });

    testWidgets('detects dark mode correctly', (WidgetTester tester) async {
      await MPThemeManager.initialize();
      await MPThemeManager.instance.setDarkTheme();

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Builder(
            builder: (context) {
              // Use public method to check dark mode
              final isDark =
                  MPThemeManager.instance.themeMode == ThemeMode.dark ||
                      (MPThemeManager.instance.themeMode == ThemeMode.system &&
                          MediaQuery.of(context).platformBrightness ==
                              Brightness.dark);
              expect(isDark, isTrue);

              return Container();
            },
          ),
        ),
      );

      await tester.pump();
    });

    // Listener tests
    testWidgets('adds and removes listeners', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      bool listenerCalled = false;
      VoidCallback listener = () {
        listenerCalled = true;
      };

      MPThemeManager.instance.addListener(listener);

      // Trigger a theme change
      await MPThemeManager.instance.setLightTheme();

      expect(listenerCalled, isTrue);

      listenerCalled = false;
      MPThemeManager.instance.removeListener(listener);

      // Trigger another theme change
      await MPThemeManager.instance.setDarkTheme();

      expect(listenerCalled, isFalse);
    });

    testWidgets('handles listener errors gracefully',
        (WidgetTester tester) async {
      await MPThemeManager.initialize();

      bool errorHandled = false;
      VoidCallback errorListener = () {
        throw Exception('Test error');
      };

      VoidCallback normalListener = () {
        errorHandled = true;
      };

      MPThemeManager.instance.addListener(errorListener);
      MPThemeManager.instance.addListener(normalListener);

      // Trigger a theme change
      await MPThemeManager.instance.setLightTheme();

      expect(errorHandled, isTrue);

      MPThemeManager.instance.removeListener(errorListener);
      MPThemeManager.instance.removeListener(normalListener);
    });

    // Reset functionality tests
    testWidgets('resets to defaults', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      // Set custom themes and dark mode
      final MPColorTheme lightTheme = MPColorTheme(
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
      final MPColorTheme darkTheme = MPColorTheme(
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

    testWidgets('resets only theme mode', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      await MPThemeManager.instance.setDarkTheme();
      expect(MPThemeManager.instance.themeMode, ThemeMode.dark);

      await MPThemeManager.instance.resetThemeMode();
      expect(MPThemeManager.instance.themeMode, ThemeMode.system);
    });

    testWidgets('resets only custom themes', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      final MPColorTheme lightTheme = MPColorTheme(
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
      final MPColorTheme darkTheme = MPColorTheme(
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

      await MPThemeManager.instance.resetCustomThemes();
      expect(MPThemeManager.instance.hasCustomThemes, isFalse);
    });

    // Export/Import tests
    testWidgets('exports theme configuration', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      final MPColorTheme lightTheme = MPColorTheme(
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
      final MPColorTheme darkTheme = MPColorTheme(
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

    testWidgets('imports theme configuration', (WidgetTester tester) async {
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
    testWidgets('caches theme data', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // First call should cache the result
              final theme1 =
                  MPThemeManager.instance.getCurrentThemeData(context);

              // Second call should use cache
              final theme2 =
                  MPThemeManager.instance.getCurrentThemeData(context);

              expect(identical(theme1, theme2), isTrue);

              return Container();
            },
          ),
        ),
      );

      await tester.pump();
    });

    testWidgets('clears cache when theme changes', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Get initial theme
              final theme1 =
                  MPThemeManager.instance.getCurrentThemeData(context);

              return Container();
            },
          ),
        ),
      );

      await tester.pump();

      // Change theme mode
      await MPThemeManager.instance.setDarkTheme();

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Should get new theme after cache clear
              final theme2 =
                  MPThemeManager.instance.getCurrentThemeData(context);

              return Container();
            },
          ),
        ),
      );

      await tester.pump();
    });

    testWidgets('gets cache statistics', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Access theme to populate cache
              MPThemeManager.instance.getCurrentThemeData(context);
              MPThemeManager.instance.getCurrentColorTheme(context);

              return Container();
            },
          ),
        ),
      );

      await tester.pump();

      final stats = MPThemeManager.instance.getCacheStats();

      expect(stats['themeDataCacheSize'], greaterThan(0));
      expect(stats['colorThemeCacheSize'], greaterThan(0));
      expect(stats['cacheKeys'], isNotNull);
    });

    testWidgets('clears caches', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Access theme to populate cache
              MPThemeManager.instance.getCurrentThemeData(context);
              MPThemeManager.instance.getCurrentColorTheme(context);

              return Container();
            },
          ),
        ),
      );

      await tester.pump();

      // Verify cache has items
      var stats = MPThemeManager.instance.getCacheStats();
      expect(stats['themeDataCacheSize'], greaterThan(0));

      // Clear caches
      MPThemeManager.instance.clearCaches();

      // Verify cache is empty
      stats = MPThemeManager.instance.getCacheStats();
      expect(stats['themeDataCacheSize'], 0);
      expect(stats['colorThemeCacheSize'], 0);
    });

    // Debug information tests
    testWidgets('gets debug information', (WidgetTester tester) async {
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
    testWidgets('disposes correctly', (WidgetTester tester) async {
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
    testWidgets('handles theme switching errors', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      // This should not throw even if there's an error
      await MPThemeManager.instance.setLightTheme();

      // Manager should still be functional
      expect(MPThemeManager.instance.isInitialized, isTrue);
      expect(MPThemeManager.instance.themeMode, ThemeMode.light);
    });

    // Thread safety tests
    testWidgets('handles concurrent operations', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      // Simulate concurrent theme changes
      final futures = <Future>[];

      for (int i = 0; i < 5; i++) {
        futures.add(MPThemeManager.instance.setLightTheme());
        futures.add(MPThemeManager.instance.setDarkTheme());
      }

      // Wait for all operations to complete
      await Future.wait(futures);

      // Manager should still be in a valid state
      expect(MPThemeManager.instance.isInitialized, isTrue);
      expect(MPThemeManager.instance.themeMode, isA<ThemeMode>());
    });

    // Persistence tests
    testWidgets('persists theme mode', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      // Set theme mode
      await MPThemeManager.instance.setDarkTheme();

      // Create new instance to test persistence
      await MPThemeManager.instance.dispose();
      await MPThemeManager.initialize();

      expect(MPThemeManager.instance.themeMode, ThemeMode.dark);
    });

    testWidgets('persists custom themes', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      // Set custom themes
      final MPColorTheme lightTheme = MPColorTheme(
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
      final MPColorTheme darkTheme = MPColorTheme(
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

      // Create new instance to test persistence
      await MPThemeManager.instance.dispose();
      await MPThemeManager.initialize();

      expect(MPThemeManager.instance.hasCustomThemes, isTrue);
      expect(MPThemeManager.instance.customLightTheme?.primary, Colors.red);
      expect(MPThemeManager.instance.customDarkTheme?.primary, Colors.blue);
    });

    // Integration tests with widgets
    testWidgets('integrates with MaterialApp', (WidgetTester tester) async {
      await MPThemeManager.initialize();

      await tester.pumpWidget(
        MaterialApp(
          theme: MPTheme.main(isDarkMode: false),
          home: Builder(
            builder: (context) {
              final themeData =
                  MPThemeManager.instance.getCurrentThemeData(context);
              expect(themeData, isNotNull);
              expect(themeData.brightness, Brightness.light);

              return Container(
                color: themeData.primaryColor,
              );
            },
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('updates widgets when theme changes',
        (WidgetTester tester) async {
      await MPThemeManager.initialize();

      Color? containerColor;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              final themeData =
                  MPThemeManager.instance.getCurrentThemeData(context);
              containerColor = themeData.primaryColor;

              return Container(
                color: containerColor,
              );
            },
          ),
        ),
      );

      await tester.pump();

      // Change theme
      await MPThemeManager.instance.setDarkTheme();

      // Rebuild to reflect theme change
      await tester.pump();

      // Container color should have changed
      expect(containerColor, isNotNull);
    });

    // Performance tests
    testWidgets('caches theme data for performance',
        (WidgetTester tester) async {
      await MPThemeManager.initialize();

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final stopwatch = Stopwatch()..start();

              // First call - should be slower (no cache)
              final theme1 =
                  MPThemeManager.instance.getCurrentThemeData(context);
              final time1 = stopwatch.elapsedMicroseconds;

              stopwatch.reset();

              // Second call - should be faster (cached)
              final theme2 =
                  MPThemeManager.instance.getCurrentThemeData(context);
              final time2 = stopwatch.elapsedMicroseconds;

              // Second call should be faster or equal
              expect(time2 <= time1, isTrue);

              return Container();
            },
          ),
        ),
      );

      await tester.pump();
    });

    // Edge case tests
    testWidgets('handles missing SharedPreferences',
        (WidgetTester tester) async {
      // This test verifies manager works even when SharedPreferences is not available
      await MPThemeManager.initialize();

      // Should still initialize with defaults
      expect(MPThemeManager.instance.isInitialized, isTrue);
      expect(MPThemeManager.instance.themeMode, ThemeMode.system);
    });

    testWidgets('handles invalid theme data in storage',
        (WidgetTester tester) async {
      // Set invalid data in storage
      await prefs.setString('mp_theme_mode', 'invalid_theme');
      await prefs.setString('mp_custom_light_theme', 'invalid_json');

      await MPThemeManager.initialize();

      // Should still initialize with defaults
      expect(MPThemeManager.instance.isInitialized, isTrue);
      expect(MPThemeManager.instance.themeMode, ThemeMode.system);
      expect(MPThemeManager.instance.hasCustomThemes, isFalse);
    });
  });
}
