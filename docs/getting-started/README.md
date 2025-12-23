# Getting Started with Micropack UI Kit

Welcome to Micropack UI Kit! This guide will help you integrate the UI kit into your Flutter application quickly and effectively.

## 📋 Prerequisites

Before you begin, ensure you have:

- Flutter SDK 3.0.1 or higher
- Dart SDK 3.0.1 or higher
- Basic knowledge of Flutter widgets and theming

## 🚀 Installation

### Step 1: Add Dependency

Add `micropack_ui_kit` to your `pubspec.yaml` file:

```yaml
dependencies:
  micropack_ui_kit: ^0.3.0
```

### Step 2: Install Package

Run the following command in your project root:

```bash
flutter pub get
```

Or use your IDE's package manager to install the dependency.

### Step 3: Import Package

Import the package in your Dart files:

```dart
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
```

## ⚙️ Initialization

### Basic Setup

Initialize the UI kit in your `main.dart` file:

```dart
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize UI Kit with brand colors
  MpUiKit.init(
    colorBrand: Color(0xFF4086EF),      // Your primary brand color
    colorBrand2: Color(0xFFFFFFFF),     // Your secondary brand color
    colorText: Color(0xFF2F2F2F),      // Text color for light theme
    fontName: 'Inter',                 // Optional: your custom font family
  );

  runApp(const MyApp());
}
```

### With Theme Support

Set up the UI kit with theme support:

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
        themeMode: ThemeMode.system, // Use system preference
        home: const HomePage(),
      ),
    );
  }
}
```

### With Custom Font

If you want to use a custom font:

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  MpUiKit.init(
    colorBrand: Color(0xFF4086EF),
    colorBrand2: Color(0xFFFFFFFF),
    colorText: Color(0xFF2F2F2F),
    fontName: 'YourCustomFont',
  );

  runApp(const MyApp());
}
```

Then declare your font in `pubspec.yaml`:

```yaml
flutter:
  fonts:
    - family: YourCustomFont
      fonts:
        - asset: fonts/YourCustomFont-Regular.ttf
        - asset: fonts/YourCustomFont-Medium.ttf
        - asset: fonts/YourCustomFont-Bold.ttf
```

## 🎨 Theme System

### Using Theme Colors

All Micropack UI Kit components automatically adapt to your theme. Access theme colors using the `mp` extension:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: context.mp.adaptiveBackgroundColor,
    appBar: AppBar(
      title: Text(
        'My App',
        style: TextStyle(color: context.mp.textColor),
      ),
    ),
    body: Container(
      color: context.mp.cardColor,
      padding: EdgeInsets.all(16),
      child: MPText(
        'Hello World!',
        style: TextStyle(color: context.mp.subtitleColor),
      ),
    ),
  );
}
```

### Available Theme Properties

| Property | Description | Usage |
|-----------|-------------|---------|
| `context.mp.primary` | Primary brand color | Buttons, active states |
| `context.mp.primaryBorder` | Primary border color | Input borders |
| `context.mp.textColor` | Adaptive text color | Text, labels |
| `context.mp.subtitleColor` | Secondary text color | Captions, subtitles |
| `context.mp.captionColor` | Caption text color | Small text |
| `context.mp.adaptiveBackgroundColor` | Background color that adapts | Container, Scaffold backgrounds |
| `context.mp.adaptiveBorderColor` | Border color that adapts | Borders, dividers |
| `context.mp.cardColor` | Card background color | Cards, elevated containers |
| `context.mp.borderColor` | Border color | Borders, outlines |
| `context.mp.dividerColor` | Divider color | Dividers, separators |
| `context.mp.errorColor` | Error color | Error messages, validation |
| `context.mp.successColor` | Success color | Success messages, confirmations |
| `context.mp.warningColor` | Warning color | Warnings, alerts |
| `context.mp.infoColor` | Info color | Information messages |

## 🧩 Using Your First Component

### Example 1: Basic Button

```dart
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: Center(
        child: MPButton(
          text: 'Get Started',
          variant: MPButtonVariant.primary,
          size: MPButtonSize.medium,
          onPressed: () {
            print('Button pressed!');
          },
        ),
      ),
    );
  }
}
```

### Example 2: Card with Content

```dart
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.mp.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          MPAvatar(
            size: 64,
            image: NetworkImage('https://example.com/avatar.jpg'),
          ),
          const SizedBox(height: 12),
          MPText.head(
            'John Doe',
            fontSize: 18,
          ),
          const SizedBox(height: 4),
          MPText.label(
            'Software Engineer',
            style: TextStyle(
              color: context.mp.subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
```

### Example 3: Form with Validation

```dart
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MPTextField(
                hintText: 'Enter your email',
                controller: _emailController,
                prefixIcon: Icons.email,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Email is required';
                  }
                  if (!value!.contains('@')) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              MPTextField(
                hintText: 'Enter your password',
                controller: _passwordController,
                obscureText: true,
                prefixIcon: Icons.lock,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Password is required';
                  }
                  if (value!.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              MPButton(
                text: 'Login',
                variant: MPButtonVariant.primary,
                width: double.infinity,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle login
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
```

## 🔧 Configuration Options

### Brand Colors

Customize the UI kit with your brand colors:

```dart
MpUiKit.init(
  colorBrand: Color(0xFF4086EF),      // Primary brand color
  colorBrand2: Color(0xFFFFFFFF),     // Secondary brand color
  colorStroke: Color(0xFF4086EF),     // Stroke/border color
  colorText: Color(0xFF2F2F2F),      // Text color
  colorError: Color(0xFFFF0000),       // Error color
  colorDisable: Color(0xFFA9A9A9),     // Disabled color
);
```

### Font Configuration

Configure the default font family:

```dart
MpUiKit.init(
  fontName: 'Inter',  // Your font family name
);

// Or set globally
MPTextStyle.defaultFontFamily = 'Inter';
```

### Responsive Font Sizing

Enable responsive font sizing for different screen sizes:

```dart
MpUiKit.init(
  useScreenUtil: true,  // Enable responsive font sizing
);
```

## 🎯 Next Steps

1. **Explore Components**: Browse the [Component API Reference](../api/README.md) to see all available components
2. **Check Examples**: Visit the [Examples](../examples/README.md) section for code samples
3. **Read Guides**: Learn advanced patterns from the [Guides](../guides/README.md) section
4. **Run Demo App**: Explore the example app to see components in action

## ❓ Common Questions

### Do I need to use `MPComponentInit`?

Yes, `MPComponentInit` is required to initialize the theme system and ensure all components work correctly.

### Can I use custom fonts?

Yes! You can specify your custom font family during initialization using the `fontName` parameter.

### How do I switch between light and dark themes?

You can use the `themeMode` parameter in `MaterialApp` or `CupertinoApp`:

```dart
MaterialApp(
  themeMode: ThemeMode.system,  // or ThemeMode.light/dark
  theme: MPTheme.main().copyWith(extensions: [MPColorTheme.light]),
  darkTheme: MPTheme.main().copyWith(extensions: [MPColorTheme.dark]),
  // ...
)
```

### Are components responsive?

Yes, most components are responsive by default. Enable additional responsive features with `useScreenUtil: true`.

## 🆘 Getting Help

If you encounter any issues:

1. Check the [Troubleshooting Guide](../guides/troubleshooting.md)
2. Review the [Component API Reference](../api/README.md)
3. Search [GitHub Issues](https://github.com/ajianaz/micropack-ui-kit/issues)
4. Ask a question in [GitHub Discussions](https://github.com/ajianaz/micropack-ui-kit/discussions)

## 🔗 Related Documentation

- [Theme System Guide](../guides/theming.md)
- [Component API Reference](../api/README.md)
- [Best Practices Guide](../guides/best-practices.md)
- [Migration Guide](../migration/README.md)
