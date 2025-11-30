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
- **And more...**: Explore all components

## 🌓 Dark Mode Support

All components are built with dark mode in mind. The theme system automatically:

- Adapts colors for better contrast
- Adjusts shadows and borders
- Maintains accessibility standards
- Uses system preferences by default

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
- [Examples Repository](https://github.com/your-repo/micropack_ui_kit_example)

## 🤝 Contributing

We welcome contributions! Please see our [contributing guide](../CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.
