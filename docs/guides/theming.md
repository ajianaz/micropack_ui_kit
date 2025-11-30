# Comprehensive Theming Guide

This guide covers everything you need to know about implementing and customizing themes in Micropack UI Kit, including dark/light mode support, theme switching, and best practices.

## 📚 Table of Contents

- [Theme System Architecture](#theme-system-architecture)
- [Basic Theme Setup](#basic-theme-setup)
- [Theme Switching Implementation](#theme-switching-implementation)
- [Theme Customization](#theme-customization)
- [Dark/Light Mode Best Practices](#darklight-mode-best-practices)
- [Advanced Theme Features](#advanced-theme-features)
- [Theme Migration](#theme-migration)
- [Troubleshooting](#troubleshooting)

## Theme System Architecture

Micropack UI Kit's theme system is built on top of Flutter's ThemeData with custom extensions:

```
MaterialApp
├── theme (Light theme)
│   ├── ThemeData
│   └── MPColorTheme (Extension)
├── darkTheme (Dark theme)
│   ├── ThemeData
│   └── MPColorTheme (Extension)
└── themeMode (Current selection)
```

### Core Components

1. **MPColorTheme**: Custom theme extension defining color schemes
2. **MPThemeHelper**: Utility class for theme-related operations
3. **MPContextExtension**: Extension on BuildContext for easy theme access

### Color System

The theme system uses a structured color palette:

- **Primary Colors**: Brand colors (primary, primarySurface, primaryFocus, etc.)
- **Neutral Colors**: 10-step neutral scale (neutral10 to neutral100)
- **Semantic Colors**: Purpose-specific colors (textColor, subtitleColor, etc.)
- **Status Colors**: State-specific colors (successColor, errorColor, etc.)

## Basic Theme Setup

### 1. Initialize Theme System

```dart
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MPTextStyle.defaultFontFamily = 'YourFont'; // Optional

  runApp(MyApp());
}
```

### 2. Configure MaterialApp

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MPComponentInit(
      builder: (_) => MaterialApp(
        title: 'My App',
        themeMode: ThemeMode.system, // Follow system preference
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

### 3. Access Theme in Components

```dart
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

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
}
```

## Theme Switching Implementation

### Basic Theme Toggle

```dart
class ThemeToggle extends StatefulWidget {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ThemeMode>(
      icon: Icon(_getThemeIcon(_themeMode)),
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
      onSelected: (mode) => setState(() => _themeMode = mode),
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

### State Management Integration (Provider)

```dart
// 1. Create theme provider
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

// 2. Integrate with MaterialApp
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

// 3. Use theme in components
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return PopupMenuButton<ThemeMode>(
          icon: Icon(_getThemeIcon(themeProvider.themeMode)),
          onSelected: (mode) => themeProvider.setTheme(mode),
          itemBuilder: (context) => [
            PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
            PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
            PopupMenuItem(value: ThemeMode.system, child: Text('System')),
          ],
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

```dart
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  static const String _themeKey = 'theme_mode';

  ThemeMode get themeMode => _themeMode;

  // Load saved theme preference
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);

    if (savedTheme != null) {
      _themeMode = _parseThemeMode(savedTheme);
      notifyListeners();
    }
  }

  // Save theme preference
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

// Initialize in main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    ChangeNotifierProvider.value(
      value: themeProvider,
      child: MyApp(),
    ),
  );
}
```

## Theme Customization

### Custom Color Scheme

```dart
MaterialApp(
  theme: MPTheme.main().copyWith(
    extensions: [
      MPColorTheme.light.copyWith(
        primary: Colors.deepPurple,
        primarySurface: Colors.deepPurple.shade50,
        primaryFocus: Colors.deepPurple.shade200,
        primaryBorder: Colors.deepPurple.shade300,
        primaryHover: Colors.deepPurple.shade400,
        primaryPressed: Colors.deepPurple.shade600,
        neutral10: Colors.grey.shade50,
        neutral20: Colors.grey.shade100,
        neutral30: Colors.grey.shade200,
        neutral40: Colors.grey.shade300,
        neutral50: Colors.grey.shade400,
        neutral60: Colors.grey.shade500,
        neutral70: Colors.grey.shade600,
        neutral80: Colors.grey.shade700,
        neutral90: Colors.grey.shade800,
        neutral100: Colors.grey.shade900,
      ),
    ],
  ),
  darkTheme: MPTheme.main().copyWith(
    extensions: [
      MPColorTheme.dark.copyWith(
        primary: Colors.deepPurple,
        primarySurface: Colors.deepPurple.shade900,
        primaryFocus: Colors.deepPurple.shade700,
        primaryBorder: Colors.deepPurple.shade600,
        primaryHover: Colors.deepPurple.shade500,
        primaryPressed: Colors.deepPurple.shade800,
        neutral10: Colors.grey.shade900,
        neutral20: Colors.grey.shade800,
        neutral30: Colors.grey.shade700,
        neutral40: Colors.grey.shade600,
        neutral50: Colors.grey.shade500,
        neutral60: Colors.grey.shade400,
        neutral70: Colors.grey.shade300,
        neutral80: Colors.grey.shade200,
        neutral90: Colors.grey.shade100,
        neutral100: Colors.grey.shade50,
      ),
    ],
  ),
  home: YourApp(),
)
```

### Custom Theme Extension

```dart
class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color? accentColor;
  final Color? surfaceColor;
  final Color? overlayColor;

  const CustomThemeExtension({
    this.accentColor,
    this.surfaceColor,
    this.overlayColor,
  });

  @override
  CustomThemeExtension copyWith({
    Color? accentColor,
    Color? surfaceColor,
    Color? overlayColor,
  }) {
    return CustomThemeExtension(
      accentColor: accentColor ?? this.accentColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      overlayColor: overlayColor ?? this.overlayColor,
    );
  }

  @override
  CustomThemeExtension lerp(
    ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) {
      return this;
    }

    return CustomThemeExtension(
      accentColor: Color.lerp(accentColor, other.accentColor, t),
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t),
      overlayColor: Color.lerp(overlayColor, other.overlayColor, t),
    );
  }
}

// Light theme
static final light = CustomThemeExtension(
  accentColor: Colors.orange,
  surfaceColor: Colors.white,
  overlayColor: Colors.black.withValues(alpha: 0.05),
);

// Dark theme
static final dark = CustomThemeExtension(
  accentColor: Colors.orange.shade300,
  surfaceColor: Colors.grey.shade900,
  overlayColor: Colors.white.withValues(alpha: 0.05),
);

// Usage in MaterialApp
MaterialApp(
  theme: MPTheme.main().copyWith(
    extensions: [
      MPColorTheme.light,
      CustomThemeExtension.light,
    ],
  ),
  darkTheme: MPTheme.main().copyWith(
    extensions: [
      MPColorTheme.dark,
      CustomThemeExtension.dark,
    ],
  ),
  home: YourApp(),
)

// Access in components
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomThemeExtension>();

    return Container(
      color: customTheme?.surfaceColor,
      child: Icon(
        Icons.star,
        color: customTheme?.accentColor,
      ),
    );
  }
}
```

### Theme Builder for Dynamic Customization

```dart
class ThemeBuilder extends StatefulWidget {
  const ThemeBuilder({
    super.key,
    required this.builder,
    this.lightTheme,
    this.darkTheme,
  });

  final Widget Function(BuildContext context, ThemeData lightTheme, ThemeData darkTheme) builder;
  final MPColorTheme? lightTheme;
  final MPColorTheme? darkTheme;

  @override
  State<ThemeBuilder> createState() => _ThemeBuilderState();
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  late MPColorTheme _lightTheme;
  late MPColorTheme _darkTheme;

  @override
  void initState() {
    super.initState();
    _lightTheme = widget.lightTheme ?? MPColorTheme.light;
    _darkTheme = widget.darkTheme ?? MPColorTheme.dark;
  }

  void updatePrimaryColor(Color color) {
    setState(() {
      _lightTheme = _lightTheme.copyWith(
        primary: color,
        primarySurface: color.withValues(alpha: 0.1),
        primaryFocus: color.withValues(alpha: 0.2),
        primaryBorder: color.withValues(alpha: 0.3),
        primaryHover: color.withValues(alpha: 0.4),
        primaryPressed: color.withValues(alpha: 0.6),
      );

      _darkTheme = _darkTheme.copyWith(
        primary: color,
        primarySurface: color.withValues(alpha: 0.2),
        primaryFocus: color.withValues(alpha: 0.3),
        primaryBorder: color.withValues(alpha: 0.4),
        primaryHover: color.withValues(alpha: 0.5),
        primaryPressed: color.withValues(alpha: 0.7),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      MPTheme.main().copyWith(extensions: [_lightTheme]),
      MPTheme.main().copyWith(extensions: [_darkTheme]),
    );
  }
}
```

## Dark/Light Mode Best Practices

### 1. Color Contrast

Ensure sufficient contrast ratios for accessibility:

```dart
// ✅ Good - Using semantic colors
Text(
  'Important text',
  style: TextStyle(color: context.mp.textColor),
)

// ✅ Also good - Manual contrast check
Container(
  color: context.mp.isDarkMode ? Colors.black : Colors.white,
  child: Text(
    'Contrast text',
    style: TextStyle(
      color: context.mp.isDarkMode ? Colors.white : Colors.black,
    ),
  ),
)

// ❌ Bad - Poor contrast
Container(
  color: Colors.grey.shade200,
  child: Text(
    'Low contrast text',
    style: TextStyle(color: Colors.grey.shade300),
  ),
)
```

### 2. Adaptive Shadows

Adjust shadows based on theme:

```dart
Container(
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: context.mp.adaptiveShadowColor,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  ),
)
```

### 3. Image Handling

Handle images appropriately for different themes:

```dart
class ThemeAwareImage extends StatelessWidget {
  const ThemeAwareImage({
    super.key,
    required this.lightAsset,
    required this.darkAsset,
  });

  final String lightAsset;
  final String darkAsset;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      context.mp.isDarkMode ? darkAsset : lightAsset,
    );
  }
}
```

### 4. Icon Adaptation

Ensure icons are visible in both themes:

```dart
Icon(
  Icons.info,
  color: context.mp.isDarkMode
    ? context.mp.neutral70
    : context.mp.neutral40,
)
```

### 5. Animation Considerations

Add smooth transitions when switching themes:

```dart
class AnimatedThemeSwitch extends StatelessWidget {
  const AnimatedThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: Theme.of(context),
      duration: Duration(milliseconds: 300),
      child: YourContent(),
    );
  }
}
```

## Advanced Theme Features

### Theme Preview

```dart
class ThemePreview extends StatelessWidget {
  const ThemePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Light theme preview
        Expanded(
          child: Theme(
            data: Theme.of(context).copyWith(
              brightness: Brightness.light,
              extensions: [MPColorTheme.light],
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  MPButton(
                    text: 'Light Button',
                    onPressed: () {},
                  ),
                  SizedBox(height: 8),
                  Text('Light theme text'),
                ],
              ),
            ),
          ),
        ),

        // Dark theme preview
        Expanded(
          child: Theme(
            data: Theme.of(context).copyWith(
              brightness: Brightness.dark,
              extensions: [MPColorTheme.dark],
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                border: Border.all(color: Colors.grey.shade700),
              ),
              child: Column(
                children: [
                  MPButton(
                    text: 'Dark Button',
                    onPressed: () {},
                  ),
                  SizedBox(height: 8),
                  Text('Dark theme text'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

### Theme Export/Import

```dart
class ThemeManager {
  static Map<String, dynamic> exportTheme(MPColorTheme theme) {
    return {
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
    };
  }

  static MPColorTheme importTheme(Map<String, dynamic> data) {
    return MPColorTheme(
      primary: data['primary'] != null ? Color(data['primary']) : null,
      primarySurface: data['primarySurface'] != null ? Color(data['primarySurface']) : null,
      primaryFocus: data['primaryFocus'] != null ? Color(data['primaryFocus']) : null,
      primaryBorder: data['primaryBorder'] != null ? Color(data['primaryBorder']) : null,
      primaryHover: data['primaryHover'] != null ? Color(data['primaryHover']) : null,
      primaryPressed: data['primaryPressed'] != null ? Color(data['primaryPressed']) : null,
      neutral10: data['neutral10'] != null ? Color(data['neutral10']) : null,
      neutral20: data['neutral20'] != null ? Color(data['neutral20']) : null,
      neutral30: data['neutral30'] != null ? Color(data['neutral30']) : null,
      neutral40: data['neutral40'] != null ? Color(data['neutral40']) : null,
      neutral50: data['neutral50'] != null ? Color(data['neutral50']) : null,
      neutral60: data['neutral60'] != null ? Color(data['neutral60']) : null,
      neutral70: data['neutral70'] != null ? Color(data['neutral70']) : null,
      neutral80: data['neutral80'] != null ? Color(data['neutral80']) : null,
      neutral90: data['neutral90'] != null ? Color(data['neutral90']) : null,
      neutral100: data['neutral100'] != null ? Color(data['neutral100']) : null,
    );
  }
}
```

## Theme Migration

### From Material Components

```dart
// Before - Material Components
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  ),
  darkTheme: ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  ),
)

// After - Micropack UI Kit
MaterialApp(
  theme: MPTheme.main().copyWith(
    extensions: [MPColorTheme.light],
  ),
  darkTheme: MPTheme.main().copyWith(
    extensions: [MPColorTheme.dark],
  ),
)
```

### From Other UI Libraries

```dart
// Before - Other UI library
Container(
  color: Colors.white,
  child: Text(
    'Hello',
    style: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
  ),
)

// After - Micropack UI Kit
Container(
  color: context.mp.adaptiveBackgroundColor,
  child: Text(
    'Hello',
    style: TextStyle(
      color: context.mp.textColor,
      fontSize: 16,
    ),
  ),
)
```

## Troubleshooting

### Common Issues

1. **Theme not applying**
   - Ensure `MPComponentInit` wraps your MaterialApp
   - Check that theme extensions are properly configured

2. **Colors not adapting**
   - Use `context.mp` utilities instead of hardcoded colors
   - Verify `isDarkMode` check is working correctly

3. **Theme persistence not working**
   - Ensure SharedPreferences is properly initialized
   - Check that theme is loaded before building UI

### Debug Theme Issues

```dart
class ThemeDebugger extends StatelessWidget {
  const ThemeDebugger({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Brightness: ${Theme.of(context).brightness}'),
        Text('Is Dark Mode: ${context.mp.isDarkMode}'),
        Text('Primary Color: ${context.mp.primary}'),
        Text('Background Color: ${context.mp.adaptiveBackgroundColor}'),
        Text('Text Color: ${context.mp.textColor}'),
      ],
    );
  }
}
```

### Performance Considerations

1. **Avoid rebuilding entire widget tree** when switching themes
2. **Use const constructors** where possible
3. **Cache theme calculations** in complex widgets

```dart
class OptimizedThemedWidget extends StatelessWidget {
  const OptimizedThemedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Cache theme values
    final bgColor = context.mp.adaptiveBackgroundColor;
    final textColor = context.mp.textColor;

    return Container(
      color: bgColor,
      child: Text(
        'Optimized',
        style: TextStyle(color: textColor),
      ),
    );
  }
}
```

## Conclusion

Micropack UI Kit's theme system provides a comprehensive solution for implementing dark/light mode support in your Flutter applications. By following the best practices and examples in this guide, you can create beautiful, accessible themes that adapt seamlessly to user preferences.

For more information, check out:
- [API Reference](../api/theme-utilities.md)
- [Component Documentation](../api/components.md)
- [Examples](../examples/README.md)