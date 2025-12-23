# Theme System Guide

Complete guide to the Micropack UI Kit theme system, including color utilities, theming patterns, and best practices.

## 📋 Table of Contents

- [Theme System Overview](#theme-system-overview)
- [Core Concepts](#core-concepts)
- [Color Utilities](#color-utilities)
- [Theme Initialization](#theme-initialization)
- [Custom Theming](#custom-theming)
- [Dark/Light Mode](#darklight-mode)
- [Theme Best Practices](#theme-best-practices)

---

## 🎨 Theme System Overview

Micropack UI Kit includes a powerful theme system built on Flutter's ThemeData with custom extensions. The theme system provides:

- ✅ **Adaptive Colors** - Colors that automatically adapt to light and dark themes
- ✅ **Semantic Colors** - Pre-defined colors for common use cases (error, success, warning, info)
- ✅ **Brand Colors** - Easy brand customization
- ✅ **Extension-based** - Uses Flutter's theme extension system
- ✅ **Type Safe** - All theme properties are compile-time checked

### Key Benefits

```dart
// Before: Hard-coded colors - doesn't adapt
Container(color: Color(0xFF000000))

// After: Adaptive colors - responds to theme
Container(color: context.mp.adaptiveBackgroundColor)
```

---

## 🔑 Core Concepts

### 1. Theme Extension

The theme system uses Flutter's `ThemeExtension` pattern:

```dart
// Light theme
MaterialApp(
  theme: MPTheme.main().copyWith(
    extensions: [MPColorTheme.light],
  ),
)

// Dark theme
MaterialApp(
  darkTheme: MPTheme.main().copyWith(
    extensions: [MPColorTheme.dark],
  ),
)
```

### 2. MP Extension

Access theme properties through the `mp` extension on `BuildContext`:

```dart
@override
Widget build(BuildContext context) {
  return Container(
    color: context.mp.primary,  // Access theme via context.mp
  );
}
```

### 3. Adaptive vs Fixed Colors

> **⚠️ CRITICAL**: Always use adaptive colors (`context.mp.textColor`) instead of fixed neutral colors (`context.mp.neutral90`). Fixed colors don't adapt to theme changes and will cause visibility issues.

```dart
// ✅ CORRECT: Adaptive colors
Container(
  color: context.mp.adaptiveBackgroundColor,
  child: Text(
    'Hello',
    style: TextStyle(color: context.mp.textColor),
  ),
)

// ❌ WRONG: Fixed colors - don't adapt
Container(
  color: context.mp.neutral90,
  child: Text(
    'Hello',
    style: TextStyle(color: context.mp.neutral20),
  ),
)
```

---

## 🎨 Color Utilities

### Brand Colors

Primary colors for your brand identity:

```dart
context.mp.primary              // Primary brand color
context.mp.primaryBorder        // Primary border color
```

**Usage**: Primary buttons, active states, brand accents

```dart
MPButton(
  text: 'Primary Action',
  variant: MPButtonVariant.primary,
  onPressed: _onTap,
)

Container(
  color: context.mp.primary,
  padding: EdgeInsets.all(16),
  child: Text('Brand Accent'),
)
```

---

### Adaptive Colors

Colors that automatically adapt to theme:

```dart
context.mp.adaptiveBackgroundColor  // Background color (light/dark)
context.mp.cardColor               // Card background color
context.mp.borderColor             // Border color
context.mp.dividerColor            // Divider color
context.mp.textColor               // Text color
context.mp.subtitleColor          // Subtitle text color
context.mp.captionColor           // Caption text color
```

**Usage**: All backgrounds, text, borders, dividers

```dart
Scaffold(
  backgroundColor: context.mp.adaptiveBackgroundColor,
  body: Padding(
    padding: EdgeInsets.all(16),
    child: MPCard(
      child: Column(
        children: [
          MPText.head('Main Heading'),
          MPText.subhead('Subheading'),
          MPText.body('Body text'),
          MPText.label('Label text'),
          MPText.small('Caption text'),
          Divider(color: context.mp.dividerColor),
        ],
      ),
    ),
  ),
)
```

---

### Semantic Colors

Pre-defined colors for specific meanings:

```dart
context.mp.errorColor     // Error (red)
context.mp.successColor   // Success (green)
context.mp.warningColor   // Warning (orange/yellow)
context.mp.infoColor      // Info (blue)
```

**Usage**: Feedback messages, validation, status indicators

```dart
// Error message
Text(
  'Something went wrong',
  style: TextStyle(color: context.mp.errorColor),
)

// Success message
MPToast.show(
  context: context,
  message: 'Saved successfully!',
  type: MPToastType.success,
)

// Warning badge
MPBadge(
  label: 'Warning',
  variant: MPBadgeVariant.notification,
  backgroundColor: context.mp.warningColor,
)

// Info icon
Icon(Icons.info, color: context.mp.infoColor)
```

---

### Neutral Colors (For Reference Only)

> **⚠️ WARNING**: These colors are for reference only. Use adaptive colors in your app.

```dart
context.mp.neutral90   // Very light gray
context.mp.neutral80
context.mp.neutral70
context.mp.neutral60
context.mp.neutral50
context.mp.neutral40
context.mp.neutral30
context.mp.neutral20
context.mp.neutral10   // Very dark gray
```

**DO NOT USE**: These colors in your app code. They're provided for debugging and reference only.

---

## ⚙️ Theme Initialization

### Basic Setup

```dart
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize UI Kit
  MpUiKit.init(
    colorBrand: Color(0xFF4086EF),      // Primary brand color
    colorBrand2: Color(0xFFFFFFFF),     // Secondary brand color
    colorText: Color(0xFF2F2F2F),      // Text color for light theme
    fontName: 'Inter',                 // Optional: custom font
  );

  runApp(const MyApp());
}
```

### With Light and Dark Themes

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MPComponentInit(
      builder: (_) => MaterialApp(
        title: 'My App',
        themeMode: ThemeMode.system,  // Use system preference

        // Light theme
        theme: MPTheme.main().copyWith(
          extensions: [MPColorTheme.light],
        ),

        // Dark theme
        darkTheme: MPTheme.main().copyWith(
          extensions: [MPColorTheme.dark],
        ),

        home: const HomePage(),
      ),
    );
  }
}
```

---

## 🎭 Custom Theming

### 1. Customize Brand Colors

```dart
MpUiKit.init(
  colorBrand: Color(0xFF6366F1),      // Your primary color
  colorBrand2: Color(0xFFF472B6),     // Your secondary color
  colorText: Color(0xFF1F2937),       // Your text color
  colorError: Color(0xFFEF4444),       // Your error color
  colorSuccess: Color(0xFF10B981),     // Your success color
  colorWarning: Color(0xFFF59E0B),     // Your warning color
  colorInfo: Color(0xFF3B82F6),        // Your info color
)
```

### 2. Customize Font

```dart
// During initialization
MpUiKit.init(
  fontName: 'YourCustomFont',
  useScreenUtil: true,  // Enable responsive font sizing
)

// Or globally
MPTextStyle.defaultFontFamily = 'YourCustomFont';
```

### 3. Customize Button Border Radius

```dart
MpUiKit.init(
  buttonBorderRadius: 12.0,  // Rounded corners
)
```

### 4. Customize Theme Colors

```dart
MaterialApp(
  theme: MPTheme.main().copyWith(
    extensions: [MPColorTheme.light].map((theme) {
      return theme.copyWith(
        primary: Color(0xFF6366F1),  // Override primary
        cardColor: Color(0xFFFAFAFA), // Override card color
      );
    }).first,
  ),
  home: const HomePage(),
)
```

---

## 🌓 Dark/Light Mode

### 1. System Theme

Follow user's system preference:

```dart
MaterialApp(
  themeMode: ThemeMode.system,  // ✅ Uses system preference
  theme: MPTheme.main().copyWith(extensions: [MPColorTheme.light]),
  darkTheme: MPTheme.main().copyWith(extensions: [MPColorTheme.dark]),
  home: const HomePage(),
)
```

### 2. Manual Theme Toggle

Let users manually select theme:

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
              theme: MPTheme.main().copyWith(extensions: [MPColorTheme.light]),
              darkTheme: MPTheme.main().copyWith(extensions: [MPColorTheme.dark]),
              home: const HomePage(),
            ),
          );
        },
      ),
    );
  }
}

// Theme toggle button
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
}
```

### 3. Persist Theme Preference

Save user's theme choice:

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

// Load theme on app start
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    ChangeNotifierProvider.value(
      value: themeProvider,
      child: const MyApp(),
    ),
  );
}
```

---

## ✅ Theme Best Practices

### 1. Always Use Adaptive Colors

> **⚠️ CRITICAL**: Never use fixed colors for backgrounds, text, or borders.

```dart
// ✅ CORRECT
Container(
  color: context.mp.adaptiveBackgroundColor,
  child: Text(
    'Hello',
    style: TextStyle(color: context.mp.textColor),
  ),
)

// ❌ WRONG
Container(
  color: context.mp.neutral90,  // Won't adapt
  child: Text(
    'Hello',
    style: TextStyle(color: context.mp.neutral20),  // Won't adapt
  ),
)
```

### 2. Use Semantic Colors Appropriately

```dart
// Error state
Text('Invalid email', style: TextStyle(color: context.mp.errorColor))

// Success state
Text('Success!', style: TextStyle(color: context.mp.successColor))

// Warning state
Text('Warning!', style: TextStyle(color: context.mp.warningColor))

// Info state
Text('Note:', style: TextStyle(color: context.mp.infoColor))
```

### 3. Test Both Themes

Always verify your UI looks good in both light and dark themes:

```dart
// Use ThemeMode.system during development
MaterialApp(
  themeMode: ThemeMode.system,  // Test both by changing system theme
  theme: MPTheme.main().copyWith(extensions: [MPColorTheme.light]),
  darkTheme: MPTheme.main().copyWith(extensions: [MPColorTheme.dark]),
  home: const HomePage(),
)

// Provide theme toggle for easy testing
PopupMenuButton<ThemeMode>(
  icon: Icon(Icons.brightness_6),
  onSelected: (mode) => setState(() => _themeMode = mode),
  itemBuilder: (context) => [
    PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
    PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
  ],
)
```

### 4. Ensure Color Contrast

Follow WCAG AA contrast ratio (4.5:1 for normal text):

```dart
// Good contrast
Text(
  'Important Message',
  style: TextStyle(
    color: context.mp.textColor,  // Adapts for good contrast
    fontSize: 16,  // Minimum 16px for readability
  ),
)

// Poor contrast - avoid
Text(
  'Important Message',
  style: TextStyle(
    color: context.mp.textColor.withValues(alpha: 0.3),  // Too faint
  ),
)
```

### 5. Respect System Preferences

Use `ThemeMode.system` as the default:

```dart
MaterialApp(
  themeMode: ThemeMode.system,  // ✅ Respects user's system preference
  // ...
)

// ❌ Don't force theme unless necessary
MaterialApp(
  themeMode: ThemeMode.light,  // Ignores user preference
  // ...
)
```

### 6. Use PopupMenu Properly

Always set proper colors forPopupMenuButton:

```dart
PopupMenuButton<ThemeMode>(
  surfaceTintColor: Colors.transparent,  // ✅ Remove default tint
  color: context.mp.cardColor,          // ✅ Use card color
  itemBuilder: (context) => [
    PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
    PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
  ],
)
```

---

## 📊 Complete Color Reference

| Color | Light | Dark | Usage |
|--------|--------|--------|--------|
| **Primary** | Brand color | Brand color (darker) | Primary actions, brand accents |
| **Primary Border** | Brand border | Brand border (darker) | Input borders, button borders |
| **Background** | `#FAFAFA` | `#121212` | App background |
| **Card** | `#FFFFFF` | `#1E1E1E` | Card background |
| **Text** | `#1F2937` | `#F3F4F6` | Primary text |
| **Subtitle** | `#6B7280` | `#9CA3AF` | Secondary text |
| **Caption** | `#9CA3AF` | `#6B7280` | Caption, hints |
| **Border** | `#E5E7EB` | `#374151` | Borders, dividers |
| **Divider** | `#E5E7EB` | `#374151` | Dividers, separators |
| **Error** | `#EF4444` | `#F87171` | Error messages |
| **Success** | `#10B981` | `#34D399` | Success messages |
| **Warning** | `#F59E0B` | `#FBBF24` | Warnings |
| **Info** | `#3B82F6` | `#60A5FA` | Information |

---

## 🔗 Related Documentation

- [Getting Started](../getting-started/README.md)
- [Component API Reference](../api/README.md)
- [Best Practices Guide](./best-practices.md)
- [Theme Colors Quick Reference](./theme-colors-quick-reference.md)

## 🆘 Need Help?

- Check [Best Practices Guide](./best-practices.md) for theme usage patterns
- Review [Component API Reference](../api/README.md) for component theming
- Search [GitHub Issues](https://github.com/ajianaz/micropack-ui-kit/issues)
