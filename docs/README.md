# Micropack UI Kit Documentation

Welcome to Micropack UI Kit documentation! This comprehensive UI library provides consistent, theme-aware components for Flutter applications.

## 📚 Table of Contents

- [Getting Started](./getting-started/README.md)
- [API Reference](./api/README.md)
- [Examples](./examples/README.md)
- [Guides](./guides/README.md)

## 🚀 Quick Start

```dart
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MPTextStyle.defaultFontFamily = 'YourFont';

  runApp(
    MPComponentInit(
      builder: (_) => MaterialApp(
        theme: MPTheme.main().copyWith(
          extensions: [MPColorTheme.light],
        ),
        darkTheme: MPTheme.main().copyWith(
          extensions: [MPColorTheme.dark],
        ),
        home: YourApp(),
      ),
    ),
  );
}
```

## 🎨 Theme Management

Micropack UI Kit provides powerful theme utilities with branding `mp`:

```dart
@override
Widget build(BuildContext context) {
  return Container(
    color: context.mp.adaptiveBackgroundColor,
    child: Text(
      'Hello World',
      style: TextStyle(
        color: context.mp.textColor,
      ),
    ),
  );
}
```

### Available Theme Utilities

- **Adaptive Colors**: Automatically adapt to dark/light mode
- **Semantic Colors**: Pre-defined colors for common use cases
- **Primary Colors**: Brand colors with fallback support
- **Neutral Colors**: Complete neutral color palette

## 🧩 Core Components

- **MPArticleCard**: Feature-rich article cards
- **MPButton**: Customizable buttons
- **MPText**: Enhanced text components
- **MPTextField**: Input fields with validation
- **MPDialog**: Modal dialogs
- **MPTabRounded**: Tab component with rounded corners
- **MPSnackbar**: Notification snackbar component

## 🌓 Dark Mode Support

All components are built with dark mode in mind. The theme system automatically:

- Adapts colors for better contrast
- Adjusts shadows and borders
- Maintains accessibility standards
- Uses system preferences by default

### Theme Setup

To enable dark/light theme support in your application:

```dart
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MPComponentInit(
      builder: (_) => MaterialApp(
        title: 'My App',
        themeMode: ThemeMode.system, // Use system preference by default
        theme: MPTheme.main().copyWith(
          extensions: [MPColorTheme.light],
        ),
        darkTheme: MPTheme.main().copyWith(
          extensions: [MPColorTheme.dark],
        ),
        home: HomePage(),
      ),
    );
  }
}
```

### Theme Switching Implementation

Implement a theme toggle in your app:

```dart
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MPComponentInit(
            builder: (_) => MaterialApp(
              themeMode: themeProvider.themeMode,
              theme: MPTheme.main().copyWith(
                extensions: [MPColorTheme.light],
              ),
              darkTheme: MPTheme.main().copyWith(
                extensions: [MPColorTheme.dark],
              ),
              home: HomePage(),
            ),
          );
        },
      ),
    );
  }
}

// Theme toggle widget
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return PopupMenuButton<ThemeMode>(
          icon: Icon(_getThemeIcon(themeProvider.themeMode)),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: ThemeMode.light,
              child: Row(
                children: [
                  Icon(Icons.light_mode),
                  SizedBox(width: 8),
                  Text('Light'),
                ],
              ),
            ),
            PopupMenuItem(
              value: ThemeMode.dark,
              child: Row(
                children: [
                  Icon(Icons.dark_mode),
                  SizedBox(width: 8),
                  Text('Dark'),
                ],
              ),
            ),
            PopupMenuItem(
              value: ThemeMode.system,
              child: Row(
                children: [
                  Icon(Icons.settings_brightness),
                  SizedBox(width: 8),
                  Text('System'),
                ],
              ),
            ),
          ],
          onSelected: (mode) => themeProvider.setTheme(mode),
        );
      },
    );
  }

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings_brightness;
    }
  }
}
```

### Theme Persistence

To persist the user's theme preference across app restarts:

```dart
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  static const String _themeKey = 'theme_mode';

  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);

    if (savedTheme != null) {
      _themeMode = _parseThemeMode(savedTheme);
      notifyListeners();
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.toString());
    notifyListeners();
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
}
```

### Theme Management Best Practices

1. **Always use theme utilities**: Access colors through `context.mp` instead of hardcoding values
2. **Test both themes**: Ensure your UI looks good in both light and dark modes
3. **Respect system preferences**: Use `ThemeMode.system` as the default
4. **Provide smooth transitions**: Add animation when switching themes
5. **Consider accessibility**: Ensure sufficient contrast ratios in both themes
6. **Test with different content**: Verify text readability with various content types

## 🎯 Key Features

- **Type Safe**: All APIs are compile-time checked
- **Theme Aware**: Components respond to theme changes
- **Customizable**: Extensive configuration options
- **Accessible**: Built with accessibility in mind
- **Performant**: Optimized for Flutter rendering

## 📖 Documentation Structure

```
docs/
├── api/           # API reference documentation
├── getting-started/ # Setup and basic usage
├── examples/       # Code examples and demos
├── guides/         # Advanced guides and patterns
└── assets/         # Images and resources
```

## 🔗 Links

- [Installation Guide](./getting-started/installation.md)
- [Component API](./api/components.md)
- [Theme System](./guides/theming.md)
- [Testing Summary](./testing-summary.md)
- [Examples Repository](https://github.com/your-repo/micropack_ui_kit_example)

## 🤝 Contributing

We welcome contributions! Please see our [contributing guide](../CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.
