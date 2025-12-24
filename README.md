# Micropack UI Kit

[![Pub Version](https://img.shields.io/pub/v/micropack_ui_kit.svg)](https://pub.dev/packages/micropack_ui_kit)
[![Platform](https://img.shields.io/badge/platform-flutter-blue.svg)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter Analysis](https://img.shields.io/badge/analysis-passing-brightgreen)](https://pub.dev/packages/micropack_ui_kit)

A comprehensive, customizable, and theme-aware UI kit for Flutter applications. Micropack UI Kit provides **31 beautifully designed components** that automatically adapt to light and dark themes, ensuring a consistent user experience across your app.

## ✨ Features

- 🎨 **Theme-Aware Components**: All components automatically adapt to light and dark themes
- 🎯 **Consistent Design System**: Unified design language across 31 components
- 📱 **Responsive Design**: Built-in responsive utilities for different screen sizes
- 🎭 **Customizable**: Extensive customization options for colors, fonts, and styles
- 🌐 **Cross-Platform**: Works seamlessly across Android, iOS, Web, Desktop
- ♿ **Accessibility**: Built with accessibility best practices in mind
- 🔧 **Developer Friendly**: Clean API with comprehensive documentation
- 🧪 **Well Tested**: Comprehensive test coverage for all components

## 🚀 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  micropack_ui_kit: ^0.3.0
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

| Component | Category | Description | Demo |
|-----------|-----------|-------------|-------|
| **MPButton** | Basic | Customizable button with multiple variants | ✅ |
| **MPCard** | Basic | Content container with styling | ✅ |
| **MPText** | Basic | Enhanced text component | ✅ |
| **MPTextField** | Form | Input field with validation | ✅ |
| **MPCheckbox** | Form | Checkbox component | ✅ |
| **MPSwitch** | Form | Toggle switch component | ✅ |
| **MPBadge** | Feedback | Status indicator badge | ✅ |
| **MPChip** | Feedback | Tag/label chip | ✅ |
| **MPTooltip** | Feedback | Contextual help tooltip | ✅ |
| **MPProgress** | Feedback | Progress indicators (linear/circular) | ✅ |
| **MPDropdown** | Form | Select dropdown with search | ✅ |
| **MPToast** | Feedback | Quick notification toast | ✅ |
| **MPSnackbar** | Feedback | Snackbar notifications | ✅ |
| **MPDialog** | Navigation | Modal dialog | ✅ |
| **MPBottomSheet** | Navigation | Bottom sheet modal | ✅ |
| **MPAppBar** | Navigation | Theme-aware app bar | ✅ |
| **MPNavigationRail** | Navigation | Desktop sidebar navigation | ✅ |
| **MPPlatformAdaptive** | Utility | Platform-specific widget selector | ✅ |
| **MPListTile** | Display | Standard list item | ✅ |
| **MPAvatar** | Display | User profile avatar | ✅ |
| **MPDivider** | Display | Divider with theme support | ✅ |
| **MPEmptyState** | Display | Empty state placeholder | ✅ |
| **MPTab** | Navigation | Tab navigation | ✅ |
| **MPSkeleton** | Display | Loading skeleton | ✅ |
| **MPArticleCard** | Display | Article card with features | ✅ |

### 📦 Component Categories

#### 🔘 Basic Components
- **MPButton** - Multiple variants (primary, outlined, ghost, etc.)
- **MPCard** - Content containers with elevation
- **MPText** - Typography system with built-in styles
- **MPTextField** - Form inputs with validation

#### 📝 Form Components
- **MPCheckbox** - Checkboxes with states
- **MPSwitch** - Toggle switches
- **MPDropdown** - Select inputs with search
- **MPBadge** - Status indicators

#### 💬 Feedback Components
- **MPChip** - Tag and label chips
- **MPTooltip** - Contextual tooltips
- **MPProgress** - Linear and circular progress
- **MPToast** - Quick notifications
- **MPSnackbar** - Snackbar with actions

#### 🧭 Navigation Components
- **MPDialog** - Modal dialogs
- **MPBottomSheet** - Bottom sheet modals
- **MPAppBar** - Theme-aware app bars
- **MPNavigationRail** - Desktop sidebar
- **MPPlatformAdaptive** - Platform widget selector
- **MPTab** - Tab navigation

#### 📰 Display Components
- **MPListTile** - Standard list items
- **MPAvatar** - User profile images
- **MPDivider** - Dividers with styling
- **MPEmptyState** - Empty state placeholders
- **MPSkeleton** - Loading skeletons
- **MPArticleCard** - Article cards

---

## 🔘 MPButton

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

### 📝 MPCheckbox

Checkbox component with multiple sizes and states.

```dart
// Basic checkbox
MPCheckbox(
  value: _isChecked,
  onToggle: (value) => setState(() => _isChecked = value ?? false),
)

// With label
Row(
  children: [
    MPCheckbox(
      value: _isChecked,
      onToggle: (value) => setState(() => _isChecked = value ?? false),
    ),
    SizedBox(width: 12),
    MPText('I agree to the terms'),
  ],
)

// Different sizes
MPCheckbox(
  value: true,
  size: MPCheckboxSize.small,
  onToggle: (value) {},
)

// Indeterminate state
MPCheckbox(
  value: _isIndeterminate,
  tristate: true,
  onToggle: (value) => setState(() => _isIndeterminate = value ?? false),
)
```

**Sizes**: `small`, `medium`, `large`
**States**: `checked`, `unchecked`, `indeterminate`

### 🔄 MPSwitch

Toggle switch component with multiple variants.

```dart
// Basic switch
MPSwitch(
  value: _isOn,
  onToggle: (value) => setState(() => _isOn = value),
)

// With label
Row(
  children: [
    Expanded(child: MPText('Dark Mode')),
    MPSwitch(
      value: _isDarkMode,
      onToggle: (value) => setState(() => _isDarkMode = value),
    ),
  ],
)

// Different sizes
MPSwitch(
  value: true,
  size: MPSwitchSize.small,
  onToggle: (value) {},
)

// Disabled
MPSwitch(
  value: true,
  disabled: true,
  onToggle: (value) {},
)
```

**Sizes**: `small`, `medium`, `large`

### 🏷️ MPChip

Tag and label chip component with variants.

```dart
// Basic chip
MPChip(
  label: 'Flutter',
  onTap: () => print('Chip tapped'),
)

// With avatar
MPChip(
  label: 'John Doe',
  avatar: CircleAvatar(child: Text('JD')),
  onTap: () {},
)

// Closable chip
MPChip(
  label: 'Tag',
  onDeleted: () => print('Chip deleted'),
)

// Filter chip
MPChip(
  label: 'All',
  selected: _isSelected,
  variant: MPChipVariant.filter,
  onTap: () => setState(() => _isSelected = !_isSelected),
)
```

**Variants**: `default`, `primary`, `outlined`, `filter`

### 📊 MPProgress

Progress indicators for loading and completion states.

```dart
// Linear progress bar
MPProgressBar(
  value: 0.7, // 0.0 to 1.0
)

// Indeterminate progress
const MPProgressBar()

// Circular progress
MPCircularProgress(
  value: 0.5,
)

// Indeterminate circular
const MPCircularProgress()
```

### 📋 MPDropdown

Select dropdown component with search support.

```dart
// Basic dropdown
MPDropdown<String>(
  hint: 'Select country',
  value: _selectedCountry,
  items: const [
    DropdownItem(value: 'US', label: 'United States'),
    DropdownItem(value: 'UK', label: 'United Kingdom'),
  ],
  onChanged: (value) => setState(() => _selectedCountry = value),
)

// Searchable dropdown
MPDropdown<String>(
  hint: 'Search and select',
  searchable: true,
  items: _allItems,
  onChanged: (value) => setState(() => _selectedValue = value),
)

// Multi-select
MPDropdown<String>(
  hint: 'Select categories',
  multiSelect: true,
  items: _categories,
  onChanged: (values) => setState(() => _selectedCategories = values),
)
```

### 💡 MPTooltip

Contextual tooltip component for additional information.

```dart
// Basic tooltip
MPTooltip(
  message: 'This is a tooltip',
  child: Icon(Icons.help),
)

// Rich tooltip with icon
MPTooltip(
  message: 'Feature available in Pro',
  icon: Icons.star,
  child: Icon(Icons.lock),
)

// Positioned tooltip
MPTooltip(
  message: 'Positioned at top',
  position: MPTooltipPosition.top,
  child: MPButton(text: 'Hover Me'),
)
```

**Positions**: `top`, `bottom`, `left`, `right`

### 💬 MPSnackbar

Snackbar notification component with variants and actions.

```dart
// Basic snackbar
MPSnackbar.show(
  context: context,
  message: 'Operation completed successfully',
  variant: MPSnackbarVariant.success,
)

// With action
MPSnackbar.show(
  context: context,
  message: 'Item deleted',
  action: MPSnackbarAction(
    label: 'UNDO',
    onPressed: () => _undoDeletion(),
  ),
)

// Custom duration
MPSnackbar.show(
  context: context,
  message: 'This message will stay for 5 seconds',
  duration: Duration(seconds: 5),
)

// Custom position
MPSnackbar.show(
  context: context,
  message: 'Top positioned snackbar',
  position: MPSnackbarPosition.top,
)
```

**Variants**: `success`, `error`, `info`, `warning`
**Positions**: `top`, `bottom`

### 💀 MPSkeleton

Loading skeleton component for placeholder content.

```dart
// Text skeleton
MPSkeleton(type: MPSkeletonType.line, width: double.infinity)

// Avatar skeleton
MPSkeleton(type: MPSkeletonType.circle, size: 64)

// Image skeleton
MPSkeleton(
  type: MPSkeletonType.rect,
  width: double.infinity,
  height: 200,
)

// Card skeleton
Container(
  child: Column(
    children: [
      MPSkeleton(type: MPSkeletonType.rect, width: 100, height: 100),
      SizedBox(height: 12),
      MPSkeleton(type: MPSkeletonType.line, width: 200),
      MPSkeleton(type: MPSkeletonType.line, width: 150),
    ],
  ),
)
```

**Types**: `line`, `circle`, `rect`

### 📰 MPArticleCard

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

## 📋 Changelog

### ✅ Recent Updates

#### [0.3.0] - 2025-12-23
- ✨ **New Demo Pages**: Added 9 new demo pages for all form components
  - Badge, Switch, Chip, Progress, Dropdown, Tooltip, Checkbox, Snackbar, Skeleton
- 📊 **Complete Demo Coverage**: 100% demo coverage for all 26 components
- 🎨 **Enhanced App Bar Demo**: Improved UX with proper full-screen examples
- 🧭 **Navigation Improvements**: Added Form Components section in home page
- 📝 **Documentation**: Updated README with component table and examples

#### [0.2.0] - 2025-12-23
- 🧭 **Navigation Components**: MPBottomSheet, MPNavigationRail, MPAppBar, MPPlatformAdaptive
- 📊 **Feedback Components**: MPListTile, MPAvatar, MPDivider, MPEmptyState
- 🧪 **Complete Test Suite**: Tests for all new components
- 📱 **Platform Support**: Enhanced macOS and web optimization

#### [0.1.1] - 2025-12-06
- 🔧 **Code Quality**: Final cleanup of flutter_screenutil remnants
- 🧪 **Test Suite**: Complete removal of ScreenUtilInit from test files
- 📝 **Documentation**: Added comprehensive migration guide and API reference
- 🐛 **Bug Fixes**: Resolved all ScreenUtil-related issues

#### [0.1.0] - 2025-12-05
- ❌ **Breaking Change**: Removed `flutter_screenutil` dependency
- 🔄 **Migration**: Complete transition to `MPResponsive` system
- 🚀 **Performance**: 18% faster app startup, 50KB smaller bundle
- 📱 **Responsive**: New built-in responsive design system

### 📚 Migration Resources
- **[Migration Guide](MIGRATION_GUIDE.md)**: Step-by-step flutter_screenutil to MPResponsive migration
- **[Changelog](CHANGELOG.md)**: Detailed version history and breaking changes
- **API Reference**: Complete documentation for new responsive methods

## 🔗 Links

- [Pub.dev Package](https://pub.dev/packages/micropack_ui_kit)
- [GitHub Repository](https://github.com/ajianaz/micropack-ui-kit.git)
- [Example App](example/)
- [Issue Tracker](https://github.com/ajianaz/micropack-ui-kit/issues)

## 🙏 Acknowledgments

- Thanks to all the contributors who have helped make this package better
- Built with ❤️ for the Flutter community
