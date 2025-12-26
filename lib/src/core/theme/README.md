# MPThemeManager - Provider-Free Theme Management

A comprehensive, provider-free theme manager for Flutter applications with singleton pattern, custom theme support, and robust error handling.

## Features

- ✅ **Singleton Pattern**: Global access with thread-safe initialization
- ✅ **Provider-Free**: No dependency on Provider package
- ✅ **Listener System**: Basic listener pattern for state changes
- ✅ **Theme Persistence**: Optional SharedPreferences integration
- ✅ **Custom Themes**: Support for user-defined light/dark themes
- ✅ **Error Handling**: Robust error handling with fallbacks
- ✅ **Reset Functionality**: Reset to defaults or specific settings
- ✅ **Thread-Safe**: Mutex-based synchronization for async operations
- ✅ **Initialization State**: Proper initialization state management

## Quick Start

### 1. Initialize the Theme Manager

```dart
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() async {
  // Initialize theme manager before running the app
  await MPThemeManager.initialize();

  runApp(MyApp());
}
```

### 2. Use in MaterialApp

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: MPThemeManager.instance.getCurrentThemeData(context),
      darkTheme: MPThemeManager.instance.getCurrentThemeData(context),
      themeMode: MPThemeManager.instance.themeMode,
      home: MyHomePage(),
    );
  }
}
```

### 3. Listen to Theme Changes

```dart
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    // Add listener for theme changes
    MPThemeManager.instance.addListener(_onThemeChanged);
  }

  void _onThemeChanged() {
    setState(() {
      // Rebuild UI when theme changes
    });
  }

  @override
  void dispose() {
    // Remove listener
    MPThemeManager.instance.removeListener(_onThemeChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Theme: ${MPThemeManager.instance.getThemeName()}'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await MPThemeManager.instance.setDarkTheme();
          },
          child: Text('Switch to Dark'),
        ),
      ),
    );
  }
}
```

## API Reference

### Theme Mode Management

```dart
// Get current theme mode
ThemeMode mode = MPThemeManager.instance.themeMode;

// Set theme modes
await MPThemeManager.instance.setLightTheme();
await MPThemeManager.instance.setDarkTheme();
await MPThemeManager.instance.setSystemTheme();
await MPThemeManager.instance.setThemeMode(ThemeMode.dark);

// Get theme information
String name = MPThemeManager.instance.getThemeName(); // "Light", "Dark", or "System"
IconData icon = MPThemeManager.instance.getThemeIcon();
Brightness brightness = MPThemeManager.instance.getCurrentBrightness(context);
String brightnessName = MPThemeManager.instance.getCurrentBrightnessName(context);
```

### Custom Themes

```dart
// Create custom themes
final customLight = MPColorTheme(
  primary: Colors.blue,
  primarySurface: Colors.blue.shade50,
  neutral10: Colors.white,
  neutral100: Colors.black,
);

final customDark = MPColorTheme(
  primary: Colors.blue.shade300,
  primarySurface: Colors.blue.shade900,
  neutral10: Colors.white,
  neutral100: Colors.black,
);

// Set custom themes
await MPThemeManager.instance.setCustomThemes(
  lightTheme: customLight,
  darkTheme: customDark,
);

// Check if custom themes are available
bool hasCustom = MPThemeManager.instance.hasCustomThemes;

// Get current custom themes
MPColorTheme? lightTheme = MPThemeManager.instance.customLightTheme;
MPColorTheme? darkTheme = MPThemeManager.instance.customDarkTheme;

// Clear custom themes
await MPThemeManager.instance.clearCustomThemes();
```

### Theme Data Access

```dart
// Get current theme data for MaterialApp
ThemeData themeData = MPThemeManager.instance.getCurrentThemeData(context);

// Get current color theme
MPColorTheme? colorTheme = MPThemeManager.instance.getCurrentColorTheme(context);
```

### Reset Functionality

```dart
// Reset all settings to defaults
await MPThemeManager.instance.resetToDefaults();

// Reset only theme mode
await MPThemeManager.instance.resetThemeMode();

// Reset only custom themes
await MPThemeManager.instance.resetCustomThemes();
```

### Export/Import Configuration

```dart
// Export current configuration
Map<String, dynamic> config = MPThemeManager.instance.exportThemeConfig();

// Import configuration
await MPThemeManager.instance.importThemeConfig(config);
```

### Debug Information

```dart
// Get debug info
Map<String, dynamic> debugInfo = MPThemeManager.instance.getDebugInfo();

// Check initialization state
bool isInitialized = MPThemeManager.instance.isInitialized;
bool isInitializing = MPThemeManager.instance.isInitializing;
String? error = MPThemeManager.instance.initializationError;
```

## Error Handling

The theme manager includes robust error handling:

- **Initialization Errors**: Graceful fallback to defaults if initialization fails
- **Storage Errors**: Continues operation if storage is unavailable
- **Listener Errors**: Isolates listener errors to prevent crashes
- **Type Safety**: Proper type checking and casting

## Thread Safety

All async operations are protected by a mutex implementation:

```dart
class _Mutex {
  Completer<void>? _completer;

  Future<void> acquire() async { /* ... */ }
  void release() { /* ... */ }
}
```

## Persistence

Theme persistence is handled through SharedPreferences (optional):

- **Theme Mode**: Saved as string (`'ThemeMode.light'`, `'ThemeMode.dark'`, `'ThemeMode.system'`)
- **Custom Themes**: Serialized as JSON and stored separately
- **Fallback**: Works without SharedPreferences (in-memory only)

## Migration from ThemeProvider

To migrate from the old ThemeProvider:

1. **Replace Provider initialization**:
   ```dart
   // Old
   final themeProvider = Provider.of<ThemeProvider>(context);

   // New
   await MPThemeManager.initialize();
   final themeManager = MPThemeManager.instance;
   ```

2. **Update theme switching**:
   ```dart
   // Old
   themeProvider.setTheme(ThemeMode.dark);

   // New
   await MPThemeManager.instance.setDarkTheme();
   ```

3. **Replace listeners**:
   ```dart
   // Old
   Provider.of<ThemeProvider>(context, listen: false);

   // New
   MPThemeManager.instance.addListener(callback);
   ```

## Best Practices

1. **Initialize Early**: Call `MPThemeManager.initialize()` in `main()` before `runApp()`
2. **Manage Listeners**: Always remove listeners in `dispose()`
3. **Handle Initialization**: Check `isInitialized` before using
4. **Async Operations**: All theme operations are async - use `await`
5. **Error Handling**: Wrap operations in try-catch for robustness

## Dependencies

- **Required**: Flutter SDK
- **Optional**: SharedPreferences (for persistence)
- **No Provider dependency**: Completely provider-free

## Example

See [`mp_theme_manager_example.dart`](mp_theme_manager_example.dart) for a complete working example.