# API Reference

Complete API documentation for Micropack UI Kit components and utilities.

## 📚 Table of Contents

- [Theme Utilities](./theme-utilities.md)
- [Components](./components.md)
- [Text Styles](./text-styles.md)
- [Extensions](./extensions.md)

## 🎨 Theme API

### MPThemeUtilities

All theme utilities are available via `context.mp`:

```dart
@override
Widget build(BuildContext context) {
  return Container(
    color: context.mp.adaptiveBackgroundColor,
    child: Text(
      'Hello',
      style: TextStyle(color: context.mp.textColor),
    ),
  );
}
```

### Available Properties

#### Basic Theme
- `theme: ThemeData` - Flutter theme data
- `colorTheme: MPColorTheme?` - MP color theme extension
- `isDarkMode: bool` - Dark mode status

#### Adaptive Colors
- `adaptiveBackgroundColor: Color` - Adapts to theme
- `adaptiveBorderColor: Color` - Border colors
- `adaptiveShadowColor: Color` - Shadow colors
- `adaptiveTextColor(double opacity): Color` - Text with opacity

#### Primary Colors
- `primary: Color` - Primary brand color
- `primarySurface: Color` - Primary surface
- `primaryFocus: Color` - Primary focus
- `primaryBorder: Color` - Primary border
- `primaryHover: Color` - Primary hover
- `primaryPressed: Color` - Primary pressed

#### Neutral Colors
- `neutral10-100: Color` - Complete neutral palette

#### Semantic Colors
- `textColor: Color` - Primary text
- `subtitleColor: Color` - Secondary text
- `captionColor: Color` - Caption text
- `disabledColor: Color` - Disabled elements
- `successColor: Color` - Success state
- `warningColor: Color` - Warning state
- `errorColor: Color` - Error state
- `infoColor: Color` - Info state

## 🧩 Components

### Core Components

- [MPArticleCard](./components.md#mparticlecard) - Article display cards
- [MPButton](./components.md#mpbutton) - Interactive buttons
- [MPText](./components.md#mptext) - Enhanced text widgets
- [MPTextField](./components.md#mptextfield) - Input fields
- [MPDialog](./components.md#mpdialog) - Modal dialogs

### Layout Components

- [MPContainer](./components.md#mpcontainer) - Enhanced containers
- [MPCard](./components.md#mpcard) - Card layouts
- [MPChip](./components.md#mpchip) - Compact elements

### Feedback Components

- [MPLoading](./components.md#mploading) - Loading indicators
- [MPToast](./components.md#mptoast) - Notification messages
- [MPBadge](./components.md#mpbadge) - Status indicators

## 🔧 Utilities

### MPComponentInit

Required wrapper for Micropack UI Kit:

```dart
MPComponentInit(
  builder: (_) => MaterialApp(
    theme: MPTheme.main(),
    home: YourApp(),
  ),
)
```

### MPTheme Extension

Access theme utilities:

```dart
extension MPContextExtension on BuildContext {
  MPThemeUtilities get mp => MPThemeUtilities(this);
}
```

## 📖 Documentation Structure

```
api/
├── theme-utilities.md    # Theme system API
├── components.md        # Component reference
├── text-styles.md      # Typography system
└── extensions.md        # Extension methods
```

## 🔗 Related Links

- [Getting Started](../getting-started/README.md)
- [Component Examples](../examples/README.md)
- [Theme Guide](../guides/theming.md)
