# Installation Guide

This guide covers different ways to install Micropack UI Kit in your Flutter project.

## 📦 Pub.dev Installation

### Add to pubspec.yaml

```yaml
dependencies:
  micropack_ui_kit: ^1.0.0
```

### Install Dependencies

```bash
flutter pub get
```

## 🌙 Flutter CLI

### Add via Flutter CLI

```bash
flutter pub add micropack_ui_kit
```

## 📋 Requirements

- **Flutter SDK**: >=3.0.0
- **Dart SDK**: >=3.0.0
- **Platform Support**: Android, iOS, Web, Windows, macOS, Linux

## 🔄 Version Compatibility

| Micropack UI Kit | Flutter SDK | Status |
|-------------------|---------------|--------|
| 1.0.0             | >=3.0.0       | ✅ Latest |
| 0.x.x              | <3.0.0        | ⚠️ Legacy |

## 🧩 Integration Steps

### 1. Import the Package

```dart
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
```

### 2. Initialize the Library

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Optional: Configure global settings
  MPTextStyle.defaultFontFamily = 'Inter';
  MpUiKit.init(
    colorBrand: Colors.blue,
    colorText: Colors.black87,
  );
  
  runApp(MyApp());
}
```

### 3. Set Up Theme Provider

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MPComponentInit(
      builder: (_) => MaterialApp(
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

## 🔧 Optional Configuration

### Custom Colors

```dart
MpUiKit.init(
  colorBrand: Colors.blue,
  colorBrand2: Colors.white,
  colorStroke: Colors.blue.shade300,
  colorText: Colors.black87,
  colorError: Colors.red,
  colorDisable: Colors.grey,
);
```

### Custom Fonts

```dart
// Set default font family
MPTextStyle.defaultFontFamily = 'Roboto';

// Or per component
MPText(
  'Custom Font Text',
  style: MPTextStyle.body1(fontFamily: 'Poppins'),
)
```

## ✅ Verification

### Check Installation

Run your app and verify:

```dart
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

// This should work without errors
final card = MPArticleCard(
  title: 'Test Card',
  description: 'Installation successful!',
);
```

### Theme Test

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Container(
        color: context.mp.adaptiveBackgroundColor,
        child: MPText(
          'Theme Working!',
          style: TextStyle(color: context.mp.textColor),
        ),
      ),
    ),
  );
}
```

## 🐛 Troubleshooting

### Common Issues

#### Import Errors
```bash
# Clean and reinstall
flutter clean
flutter pub get
```

#### Theme Not Working
```dart
// Ensure MPComponentInit is used
return MPComponentInit(
  builder: (_) => MaterialApp(/*...*/),
);
```

#### Font Issues
```dart
// Make sure fonts are declared in pubspec.yaml
flutter:
  fonts:
    - family: Inter
      fonts:
        - asset: fonts/Inter-Regular.ttf
```

## 📚 Next Steps

- [Basic Setup](README.md) - Configure your first app
- [Theme System](../guides/theming.md) - Advanced theming
- [Component Examples](../examples/README.md) - See components in action

## 🔗 Links

- [Pub.dev Package](https://pub.dev/packages/micropack_ui_kit)
- [GitHub Repository](https://github.com/your-repo/micropack_ui_kit)
- [Example App](https://github.com/your-repo/micropack_ui_kit_example)
