import 'package:flutter/material.dart';

import 'package:micropack_ui_kit/src/core/theme/mp_theme_manager.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_color_theme.dart';

/// Example usage of MPThemeManager
///
/// This file demonstrates how to use the provider-free theme manager
/// in a Flutter application.
class ThemeManagerExample extends StatefulWidget {
  const ThemeManagerExample({super.key});

  @override
  State<ThemeManagerExample> createState() => _ThemeManagerExampleState();
}

class _ThemeManagerExampleState extends State<ThemeManagerExample> {
  late MPThemeManager _themeManager;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeThemeManager();
  }

  Future<void> _initializeThemeManager() async {
    try {
      // Initialize the theme manager
      _themeManager = await MPThemeManager.initialize();

      // Add listener for theme changes
      _themeManager.addListener(_onThemeChanged);

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      debugPrint('Failed to initialize theme manager: $e');
    }
  }

  void _onThemeChanged() {
    // Rebuild UI when theme changes
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // Remove listener and dispose theme manager
    if (_isInitialized) {
      _themeManager.removeListener(_onThemeChanged);
      _themeManager.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Manager Example'),
        backgroundColor:
            _themeManager.getCurrentThemeData(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current theme info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Theme: ${_themeManager.getThemeName()}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Brightness: ${_themeManager.getCurrentBrightnessName(context)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(_themeManager.getThemeIcon()),
                        const SizedBox(width: 8),
                        Text('Theme Mode'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Theme switching buttons
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme Switching',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await _themeManager.setLightTheme();
                            },
                            child: const Text('Light'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await _themeManager.setDarkTheme();
                            },
                            child: const Text('Dark'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await _themeManager.setSystemTheme();
                            },
                            child: const Text('System'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Custom theme controls
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Custom Themes',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await _setCustomRedTheme();
                            },
                            child: const Text('Red Theme'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await _themeManager.clearCustomThemes();
                            },
                            child: const Text('Clear Custom'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Has Custom Themes: ${_themeManager.hasCustomThemes}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Reset controls
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reset Options',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await _themeManager.resetThemeMode();
                            },
                            child: const Text('Reset Theme'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await _themeManager.resetCustomThemes();
                            },
                            child: const Text('Reset Custom'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await _themeManager.resetToDefaults();
                            },
                            child: const Text('Reset All'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Debug info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Debug Information',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Initialized: ${_themeManager.isInitialized}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Listeners: ${_themeManager.getDebugInfo()['listenerCount']}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setCustomRedTheme() async {
    final customLight = MPColorTheme(
      primary: Colors.red,
      primarySurface: Colors.red.shade50,
      primaryFocus: Colors.red.shade200,
      primaryBorder: Colors.red.shade300,
      primaryHover: Colors.red.shade400,
      primaryPressed: Colors.red.shade600,
      neutral10: Colors.white,
      neutral20: Colors.grey.shade50,
      neutral30: Colors.grey.shade100,
      neutral40: Colors.grey.shade200,
      neutral50: Colors.grey.shade300,
      neutral60: Colors.grey.shade400,
      neutral70: Colors.grey.shade500,
      neutral80: Colors.grey.shade600,
      neutral90: Colors.grey.shade700,
      neutral100: Colors.grey.shade900,
    );

    final customDark = MPColorTheme(
      primary: Colors.red.shade400,
      primarySurface: Colors.red.shade900,
      primaryFocus: Colors.red.shade300,
      primaryBorder: Colors.red.shade500,
      primaryHover: Colors.red.shade200,
      primaryPressed: Colors.red.shade700,
      neutral10: Colors.white,
      neutral20: Colors.grey.shade100,
      neutral30: Colors.grey.shade200,
      neutral40: Colors.grey.shade300,
      neutral50: Colors.grey.shade400,
      neutral60: Colors.grey.shade500,
      neutral70: Colors.grey.shade600,
      neutral80: Colors.grey.shade700,
      neutral90: Colors.grey.shade800,
      neutral100: Colors.grey.shade900,
    );

    await _themeManager.setCustomThemes(
      lightTheme: customLight,
      darkTheme: customDark,
    );
  }
}

/// Widget to demonstrate theme manager integration with MaterialApp
class ThemeManagerApp extends StatelessWidget {
  const ThemeManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MPThemeManager>(
      future: MPThemeManager.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child:
                    Text('Error initializing theme manager: ${snapshot.error}'),
              ),
            ),
          );
        }

        final themeManager = snapshot.data!;

        return MaterialApp(
          title: 'Theme Manager Example',
          theme: themeManager.getCurrentThemeData(context),
          darkTheme: themeManager.getCurrentThemeData(context),
          themeMode: themeManager.themeMode,
          home: const ThemeManagerExample(),
        );
      },
    );
  }
}
