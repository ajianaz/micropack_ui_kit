# Getting Started with Micropack UI Kit

Welcome to Micropack UI Kit! This guide will help you set up and start using the UI library in your Flutter applications.

## 📦 Installation

Add Micropack UI Kit to your `pubspec.yaml`:

```yaml
dependencies:
  micropack_ui_kit: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Basic Setup

### 1. Initialize the Library

```dart
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Optional: Set custom font family
  MPTextStyle.defaultFontFamily = 'YourFontFamily';
  
  runApp(const MyApp());
}
```

### 2. Configure Theme System

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MPComponentInit(
      builder: (_) => MaterialApp(
        title: 'My App',
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

## 🎨 Theming

Micropack UI Kit provides a powerful theming system with `context.mp` utilities:

### Basic Theme Usage

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: context.mp.adaptiveBackgroundColor,
    appBar: AppBar(
      backgroundColor: context.mp.primary,
      title: Text(
        'Welcome',
        style: TextStyle(color: context.mp.textColor),
      ),
    ),
    body: Container(
      padding: EdgeInsets.all(16),
      color: context.mp.neutral100,
      child: Column(
        children: [
          Text(
            'Primary Text',
            style: TextStyle(
              fontSize: 24,
              color: context.mp.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Subtitle text',
            style: TextStyle(
              fontSize: 16,
              color: context.mp.subtitleColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Caption text',
            style: TextStyle(
              fontSize: 14,
              color: context.mp.captionColor,
            ),
          ),
        ],
      ),
    ),
  );
}
```

### Available Theme Properties

```dart
context.mp.adaptiveBackgroundColor  // Adaptive background
context.mp.adaptiveBorderColor      // Adaptive borders
context.mp.textColor               // Primary text color
context.mp.subtitleColor           // Secondary text
context.mp.captionColor            // Caption text
context.mp.disabledColor          // Disabled elements
context.mp.primary                // Primary brand color
context.mp.neutral10-100        // Neutral color palette
context.mp.successColor           // Success state
context.mp.warningColor           // Warning state
context.mp.errorColor             // Error state
context.mp.infoColor             // Info state
```

## 🧩 Using Components

### Article Card Example

```dart
MPArticleCard(
  title: 'Getting Started with Flutter',
  description: 'Learn the basics of Flutter development with this comprehensive guide.',
  author: 'John Doe',
  date: 'March 15, 2024',
  readTime: '5 min read',
  imageUrl: 'https://example.com/image.jpg',
  onTap: () {
    // Handle card tap
  },
  variant: MPArticleCardVariant.elevated,
  size: MPArticleCardSize.medium,
)
```

### Button Example

```dart
MPButton(
  text: 'Get Started',
  onPressed: () {
    // Handle button press
  },
  variant: MPButtonVariant.primary,
  size: MPButtonSize.large,
  fullWidth: true,
)
```

## 🔧 Configuration Options

### Custom Brand Colors

```dart
void main() {
  MpUiKit.init(
    colorBrand: Colors.blue,
    colorBrand2: Colors.white,
    colorStroke: Colors.blue.shade300,
    colorText: Colors.black87,
    colorError: Colors.red,
    colorDisable: Colors.grey,
  );
  
  runApp(MyApp());
}
```

### Theme Customization

```dart
MaterialApp(
  theme: MPTheme.main().copyWith(
    extensions: [
      MPColorTheme.light.copyWith(
        primary: Colors.customBlue,
        neutral100: Colors.customWhite,
      ),
    ],
  ),
  // ...
)
```

## 🌓 Dark Mode

The theme system automatically supports dark mode:

- **System Default**: Follows device settings
- **Manual Toggle**: Users can switch between light/dark
- **Adaptive Colors**: Colors automatically adjust for contrast
- **Smooth Transitions**: Theme changes are animated

### Theme Toggle Implementation

```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: Icon(_getThemeIcon()),
            itemBuilder: (context) => [
              PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
              PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              PopupMenuItem(value: ThemeMode.system, child: Text('System')),
            ],
            onSelected: (mode) => setState(() => _themeMode = mode),
          ),
        ],
      ),
      body: YourContent(),
    );
  }

  IconData _getThemeIcon() {
    switch (_themeMode) {
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

## 📚 Next Steps

- [API Reference](../api/README.md) - Explore all available components
- [Examples](../examples/README.md) - See complete examples
- [Theme Guide](../guides/theming.md) - Advanced theming patterns
- [Migration Guide](migration.md) - Coming from other UI libraries

## 🆘 Need Help?

- Check our [Examples](../examples/README.md)
- Review [API Documentation](../api/README.md)
- Open an [Issue](https://github.com/your-repo/micropack_ui_kit/issues)

Happy coding with Micropack UI Kit! 🚀
