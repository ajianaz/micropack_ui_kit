# Micropack UI Kit Documentation

Welcome to Micropack UI Kit documentation! This comprehensive UI library provides consistent, theme-aware components for Flutter applications.

## 📚 Table of Contents

- [Documentation Overview](./overview.md) - **START HERE**
- [Getting Started](./getting-started/README.md)
- [Component API Reference](./api/README.md)
- [Component Quick Reference](./component-quick-reference.md)
- [Examples](./examples/README.md)
- [Guides](./guides/README.md)

---

## 🚀 New to Micropack UI Kit?

Start with the [Documentation Overview](./overview.md) to understand the structure and find what you need!

### Recommended Learning Path

1. **[Getting Started Guide](./getting-started/README.md)** (15 min)
   - Installation
   - Basic setup
   - Your first component
   - Theme initialization

2. **[Common Use Cases](./examples/common-use-cases.md)** (30 min)
   - Authentication forms
   - User profiles
   - Settings pages
   - Real-world examples

3. **[Component Quick Reference](./component-quick-reference.md)** (Keep open!)
   - Fast component lookup
   - Quick props reference
   - Common patterns

---

## 📖 Available Documentation

### 📖 Core Documentation

| Document | Description | Reading Time |
|-----------|-------------|---------------|
| **[Overview](./overview.md)** | Documentation structure and learning paths | 5 min |
| **[Getting Started](./getting-started/README.md)** | Installation and basic setup | 15 min |
| **[Component API](./api/README.md)** | Complete API documentation for all 26 components | 30 min |
| **[Quick Reference](./component-quick-reference.md)** | Fast lookup card | 5 min |

### 🎨 Examples & Guides

| Document | Description | Reading Time |
|-----------|-------------|---------------|
| **[Common Use Cases](./examples/common-use-cases.md)** | Real-world usage examples | 20 min |
| **[Best Practices](./guides/best-practices.md)** | Best practices and patterns | 15 min |
| **[Theme Rules & Guidelines](./guides/theme-rules.md)** | **CRITICAL: Theme rules and best practices** | 15 min |
| **[Theme System Guide](./guides/theming.md)** | Complete theme system guide | 20 min |
| **[Theme Colors Quick Reference](./guides/theme-colors-quick-reference.md)** | All theme colors reference | 10 min |
| **[Troubleshooting Guide](./guides/troubleshooting.md)** | Common issues and solutions | 15 min |

---

## 🔗 Quick Links

### Quick Start

- [Installation](./getting-started/README.md#-installation)
- [Initialize UI Kit](./getting-started/README.md#-initialization)
- [Your First Component](./getting-started/README.md#-using-your-first-component)
- [Theme Setup](./getting-started/README.md#-theme-system)

### Components

- [Basic Components](./api/README.md#basic-components) - Button, Card, Text, TextField
- [Form Components](./api/README.md#form-components) - Checkbox, Switch, Badge, Chip, Progress, Dropdown, Tooltip
- [Feedback Components](./api/README.md#feedback-components) - Toast, Snackbar
- [Navigation Components](./api/README.md#navigation-components) - Dialog, BottomSheet, AppBar, NavigationRail, Tab, PlatformAdaptive
- [Display Components](./api/README.md#display-components) - ListTile, Avatar, Divider, EmptyState, Skeleton, ArticleCard

### References

- [Component Quick Reference](./component-quick-reference.md) - Fast lookup
- [Theme Properties](./api/README.md#available-theme-properties) - All theme colors
- [Component Variants](./component-quick-reference.md#component-variants) - All variants
- [Component Sizes](./component-quick-reference.md#component-sizes) - All sizes

---

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

> **⚠️ CRITICAL:** Always use adaptive colors (`context.mp.textColor`, `context.mp.cardColor`, etc.) instead of fixed neutral colors (`context.mp.neutral90`, `context.mp.neutral20`). Fixed colors don't adapt to theme changes and will cause visibility issues.
>
> **📖 See [Theme Colors Quick Reference](./guides/theme-colors-quick-reference.md) for complete guide**

1. **Always use adaptive color utilities**: Access colors through `context.mp.textColor`, `context.mp.cardColor`, etc.
   ```dart
   // ✅ CORRECT
   Text('Hello', style: TextStyle(color: context.mp.textColor))
   Container(color: context.mp.cardColor)

   // ❌ WRONG
   Text('Hello', style: TextStyle(color: context.mp.neutral90))
   Container(color: context.mp.neutral20)
   ```

2. **Test both themes**: Ensure your UI looks good in both light and dark modes
3. **Respect system preferences**: Use `ThemeMode.system` as the default
4. **Provide smooth transitions**: Add animation when switching themes
5. **Consider accessibility**: Ensure sufficient contrast ratios in both themes (WCAG AA: 4.5:1)
6. **Test with different content**: Verify text readability with various content types
7. **Use PopupMenu properly**: Always set `surfaceTintColor: Colors.transparent` and `color: context.mp.cardColor`

## 🎯 Key Features

- **Type Safe**: All APIs are compile-time checked
- **Theme Aware**: Components respond to theme changes
- **Customizable**: Extensive configuration options
- **Accessible**: Built with accessibility in mind
- **Performant**: Optimized for Flutter rendering

## 📖 Documentation Structure

```
docs/
├── README.md                          # This file
├── overview.md                        # Documentation overview and navigation
├── getting-started/
│   └── README.md                      # Installation and setup
├── api/
│   └── README.md                      # Complete component API reference
├── guides/
│   └── best-practices.md             # Best practices and patterns
├── examples/
│   └── common-use-cases.md         # Real-world usage examples
├── component-quick-reference.md      # Quick reference card
└── assets/                         # Images and resources
```

## 🔗 Quick Links

### 📚 Core Documentation
- [Documentation Overview](./overview.md) - **START HERE**
- [Getting Started Guide](./getting-started/README.md) - Installation and setup
- [Component API Reference](./api/README.md) - Complete API documentation
- [Component Quick Reference](./component-quick-reference.md) - Fast lookup

### 🎨 Examples & Guides
- [Common Use Cases](./examples/common-use-cases.md) - Real-world examples
- [Best Practices Guide](./guides/best-practices.md) - Best practices

### 🔗 External Links
- [Package README](../README.md) - Main package documentation
- [CHANGELOG](../CHANGELOG.md) - Version history and changes
- [Example App](../example/) - Full working example
- [GitHub Repository](https://github.com/ajianaz/micropack-ui-kit.git)

## 🤝 Contributing

We welcome contributions! Please see our [contributing guide](../CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.
