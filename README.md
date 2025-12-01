# Micropack UI Kit

[![Pub Version](https://img.shields.io/pub/v/micropack_ui_kit.svg)](https://pub.dev/packages/micropack_ui_kit)
[![Platform](https://img.shields.io/badge/platform-flutter-blue.svg)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter Analysis](https://img.shields.io/badge/analysis-passing-brightgreen)](https://pub.dev/packages/micropack_ui_kit)

A comprehensive, customizable, and theme-aware UI kit for Flutter applications. Micropack UI Kit provides a collection of beautifully designed components that automatically adapt to light and dark themes, ensuring a consistent user experience across your app.

## ✨ Features

- 🎨 **Theme-Aware Components**: All components automatically adapt to light and dark themes
- 🎯 **Consistent Design System**: Unified design language across all components
- 📱 **Responsive Design**: Built-in responsive utilities for different screen sizes
- 🎭 **Customizable**: Extensive customization options for colors, fonts, and styles
- 🌐 **Cross-Platform**: Works seamlessly across Android, iOS, Web, Desktop
- ♿ **Accessibility**: Built with accessibility best practices in mind
- 🔧 **Developer Friendly**: Clean API with comprehensive documentation

## 🚀 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  micropack_ui_kit: ^0.0.1
```

Then install the package:

```bash
flutter pub get
```

## 🎯 Quick Start

### 1. Import the package

```dart
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
```

### 2. Initialize the UI Kit

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the UI Kit with your brand colors
  MpUiKit.init(
    colorBrand: Color(0xFF4086EF),      // Primary brand color
    colorBrand2: Color(0xFFFFFFFF),     // Secondary brand color
    colorText: Color(0xFF2F2F2F),      // Text color
    fontName: 'Inter',                 // Optional: custom font
  );

  runApp(MyApp());
}
```

### 3. Set up the theme provider

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
        home: const HomePage(),
      ),
    );
  }
}
```

## 🎨 Theme System

Micropack UI Kit includes a powerful theme system that automatically adapts to light and dark modes:

### Accessing Theme Colors

```dart
@override
Widget build(BuildContext context) {
  return Container(
    color: context.mp.adaptiveBackgroundColor,
    child: MPText(
      'Themed Text',
      style: TextStyle(color: context.mp.textColor),
    ),
  );
}
```

### Available Theme Properties

- `context.mp.primary` - Primary brand color
- `context.mp.primaryBorder` - Primary border color
- `context.mp.textColor` - Adaptive text color
- `context.mp.subtitleColor` - Secondary text color
- `context.mp.captionColor` - Caption text color
- `context.mp.adaptiveBackgroundColor` - Background color that adapts to theme
- `context.mp.adaptiveBorderColor` - Border color that adapts to theme
- `context.mp.errorColor` - Error color
- `context.mp.successColor` - Success color
- `context.mp.warningColor` - Warning color
- `context.mp.infoColor` - Info color

## 🧩 Available Components

### 🔘 MPButton

Customizable button with multiple variants and states.

```dart
MPButton(
  text: 'Get Started',
  variant: MPButtonVariant.primary,
  size: MPButtonSize.medium,
  onPressed: () => print('Button pressed'),
)

// Button with icon
MPButton(
  text: 'Download',
  icon: Icons.download,
  variant: MPButtonVariant.outlined,
  onPressed: () => _downloadFile(),
)

// Loading state
MPButton(
  text: 'Processing...',
  loading: true,
  onPressed: null, // Disabled when loading
)
```

**Variants**: `primary`, `outlined`, `ghost`, `text`, `danger`, `success`, `warning`, `info`
**Sizes**: `small`, `regular`, `medium`, `large`

### 📰 MPArticleCard

Feature-rich article card with multiple variants and interactive elements.

```dart
MPArticleCard(
  title: 'Understanding Flutter Themes',
  description: 'Learn how to implement beautiful themes in your Flutter applications.',
  imageUrl: 'https://example.com/image.jpg',
  author: 'John Doe',
  date: 'March 15, 2024',
  readTime: '5 min read',
  category: 'Flutter',
  tags: ['UI', 'Themes', 'Development'],
  onTap: () => _openArticle(),
  onLike: () => _toggleLike(),
  onBookmark: () => _toggleBookmark(),
  onShare: () => _shareArticle(),
)
```

**Variants**: `standard`, `elevated`, `outlined`
**Sizes**: `small`, `medium`, `large`

### 📝 MPText

Enhanced text component with built-in styling options.

```dart
// Different text styles
MPText.head('Heading Text')
MPText.subhead('Subheading Text')
MPText.body('Body text content')
MPText.label('Label text')
MPText.small('Small caption text')

// Custom styling
MPText(
  'Custom styled text',
  style: MPTextStyle.heading3(
    color: context.mp.primary,
    fontWeight: FontWeight.bold,
  ),
)
```

### 📝 MPTextField

Input field component with validation and theming support.

```dart
MPTextField(
  hintText: 'Enter your email',
  controller: _emailController,
  prefixIcon: Icons.email,
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Email is required';
    if (!value!.contains('@')) return 'Invalid email format';
    return null;
  },
  onChanged: (value) => _updateEmail(value),
)

// Password field
MPTextField(
  hintText: 'Password',
  controller: _passwordController,
  obscureText: true,
  prefixIcon: Icons.lock,
  suffixIcon: Icons.visibility,
)
```

### 💬 MPDialog

Modal dialog component with multiple display options.

```dart
// Confirmation dialog
MPDialog.show(
  context: context,
  title: 'Confirm Deletion',
  content: 'Are you sure you want to delete this item?',
  confirmText: 'Delete',
  cancelText: 'Cancel',
  type: DialogType.warning,
  onConfirm: () => _deleteItem(),
)

// Success dialog
MPDialog.show(
  context: context,
  title: 'Success!',
  content: 'Your changes have been saved successfully.',
  type: DialogType.success,
  onConfirm: () => Navigator.of(context).pop(),
)
```

### 📑 MPTab

Customizable tab component for navigation.

```dart
MPTab(
  tabs: const ['Home', 'Profile', 'Settings'],
  selectedIndex: _selectedIndex,
  onTabChanged: (index) => setState(() => _selectedIndex = index),
  variant: MPTabVariant.rounded,
)
```

### 🔔 MPSnackbar

Notification component for displaying brief messages.

```dart
MPSnackbar.show(
  context: context,
  message: 'Operation completed successfully',
  type: MPSnackbarType.success,
  duration: Duration(seconds: 3),
  action: SnackBarAction(
    label: 'UNDO',
    onPressed: () => _undoAction(),
  ),
)
```

## 🎯 Advanced Usage

### Custom Theme Configuration

```dart
// Initialize with custom configuration
MpUiKit.init(
  colorBrand: Color(0xFF4086EF),
  colorBrand2: Color(0xFFFFFFFF),
  colorStroke: Color(0xFF4086EF),
  colorText: Color(0xFF2F2F2F),
  colorError: Color(0xFFFF0000),
  colorDisable: Color(0xFFA9A9A9),
  fontName: 'Inter',
  buttonBorderRadius: 12.0,
  useScreenUtil: true, // Enable responsive font sizing
);

// Custom text style
MPTextStyle.defaultFontFamily = 'Roboto';
```

### Responsive Design

The UI Kit includes built-in responsive utilities:

```dart
// Responsive breakpoints
MpUiKit.limitSmallMediumScreen = 600;   // Small < 600px < Medium
MpUiKit.limitMediumLargeScreen = 1024;   // Medium < 1024px < Large

// Responsive font helper
double responsiveSize = ResponsiveFontHelper.getResponsiveFontSize(
  16.0, // Base font size
  context,
);
```

## 📚 Documentation

For detailed documentation and examples:

- [Getting Started Guide](docs/getting-started/README.md)
- [Component API Reference](docs/api/components.md)
- [Theme Configuration](docs/guides/theming.md)
- [Examples](docs/examples/README.md)

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Setup

1. Clone the repository
2. Run `flutter pub get` in the root directory
3. Run `flutter pub get` in the example directory
4. Run the example app: `cd example && flutter run`

### Code Style

This project follows the [Very Good Analysis](https://pub.dev/packages/very_good_analysis) linting rules.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- [Pub.dev Package](https://pub.dev/packages/micropack_ui_kit)
- [GitHub Repository](https://github.com/ajianaz/micropack-ui-kit.git)
- [Example App](example/)
- [Issue Tracker](https://github.com/ajianaz/micropack-ui-kit/issues)

## 🙏 Acknowledgments

- Thanks to all the contributors who have helped make this package better
- Built with ❤️ for the Flutter community
