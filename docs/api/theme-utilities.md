# Theme Utilities API

Complete documentation for Micropack UI Kit theme utilities available via `context.mp`.

## 🎨 Accessing Theme Utilities

All theme utilities are available through the `mp` extension on BuildContext:

```dart
@override
Widget build(BuildContext context) {
  return Container(
    color: context.mp.adaptiveBackgroundColor,
    child: Text(
      'Hello World',
      style: TextStyle(color: context.mp.textColor),
    ),
  );
}
```

## 📋 Available Properties

### Basic Theme Information

#### `theme: ThemeData`
Returns the Flutter ThemeData for the current context.

```dart
final theme = context.mp.theme;
final scaffoldBg = theme.scaffoldBackgroundColor;
```

#### `colorTheme: MPColorTheme?`
Returns the MPColorTheme extension if available, otherwise null.

```dart
final mpTheme = context.mp.colorTheme;
final primary = mpTheme?.primary ?? Colors.blue;
```

#### `isDarkMode: bool`
Returns true if the current theme is dark mode.

```dart
if (context.mp.isDarkMode) {
  // Dark mode specific styling
} else {
  // Light mode specific styling
}
```

### Adaptive Colors

These colors automatically adapt to the current theme (light/dark mode).

#### `adaptiveBackgroundColor: Color`
Returns an appropriate background color for the current theme.

```dart
Container(
  color: context.mp.adaptiveBackgroundColor,
  child: content,
)
```

#### `adaptiveBorderColor: Color`
Returns an appropriate border color for the current theme.

```dart
Container(
  decoration: BoxDecoration(
    border: Border.all(color: context.mp.adaptiveBorderColor),
  ),
)
```

#### `adaptiveShadowColor: Color`
Returns an appropriate shadow color for the current theme.

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

#### `adaptiveTextColor(double opacity): Color`
Returns a text color with the specified opacity, adapted to the current theme.

```dart
Text(
  'Subtle text',
  style: TextStyle(
    color: context.mp.adaptiveTextColor(0.6),
  ),
)
```

### Primary Colors

Brand colors with fallback to MpUiKit defaults when MPColorTheme is not available.

#### `primary: Color`
Primary brand color.

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: context.mp.primary,
  ),
  child: Text('Primary Action'),
)
```

#### `primarySurface: Color`
Primary surface color for elevated elements.

#### `primaryFocus: Color`
Primary color for focused elements.

#### `primaryBorder: Color`
Primary color for borders and dividers.

#### `primaryHover: Color`
Primary color for hover states.

#### `primaryPressed: Color`
Primary color for pressed states.

### Neutral Colors

Complete neutral color palette (10-100) with fallback to Material Design grays.

```dart
Container(
  color: context.mp.neutral100, // Light theme white
  child: Container(
    color: context.mp.neutral20,  // Light theme light gray
  ),
)
```

#### Available Neutral Colors

| Property | Light Mode | Dark Mode | Use Case |
|----------|-------------|-------------|-----------|
| `neutral10` | `Colors.grey.shade50` | Fallback | Surface backgrounds |
| `neutral20` | `Colors.grey.shade100` | `Colors.grey.shade800` | Card backgrounds |
| `neutral30` | `Colors.grey.shade200` | Fallback | Hover states |
| `neutral40` | `Colors.grey.shade300` | Fallback | Dividers/borders |
| `neutral50` | `Colors.grey.shade400` | Fallback | Disabled text |
| `neutral60` | `Colors.grey.shade500` | Fallback | Placeholder text |
| `neutral70` | `Colors.grey.shade600` | Fallback | Secondary text |
| `neutral80` | `Colors.grey.shade700` | Fallback | Primary text |
| `neutral90` | `Colors.grey.shade800` | Fallback | Header text |
| `neutral100` | `Colors.grey.shade900` | Fallback | Overlay backgrounds |

### Semantic Colors

Pre-defined colors for common UI states and use cases.

#### Text Colors

##### `textColor: Color`
Primary text color, optimized for readability.

```dart
Text(
  'Important Title',
  style: TextStyle(
    color: context.mp.textColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)
```

##### `subtitleColor: Color`
Secondary text color, less prominent than primary text.

```dart
Text(
  'Subtitle or description',
  style: TextStyle(
    color: context.mp.subtitleColor,
    fontSize: 16,
  ),
)
```

##### `captionColor: Color`
Caption text color, least prominent text element.

```dart
Text(
  'Caption or metadata',
  style: TextStyle(
    color: context.mp.captionColor,
    fontSize: 12,
  ),
)
```

##### `disabledColor: Color`
Color for disabled elements and text.

```dart
ElevatedButton(
  onPressed: null, // Disabled
  style: ElevatedButton.styleFrom(
    backgroundColor: context.mp.disabledColor,
  ),
  child: Text(
    'Disabled Button',
    style: TextStyle(color: context.mp.disabledColor),
  ),
)
```

#### Status Colors

##### `successColor: Color`
Color for success states and positive feedback.

```dart
Icon(
  Icons.check_circle,
  color: context.mp.successColor,
)
```

##### `warningColor: Color`
Color for warning states and caution.

```dart
Icon(
  Icons.warning,
  color: context.mp.warningColor,
)
```

##### `errorColor: Color`
Color for error states and negative feedback.

```dart
Icon(
  Icons.error,
  color: context.mp.errorColor,
)
```

##### `infoColor: Color`
Color for information states and neutral feedback.

```dart
Icon(
  Icons.info,
  color: context.mp.infoColor,
)
```

### Helper Methods

#### `themeColor(Color? Function(MPColorTheme) colorGetter): Color?`
Generic method to access any color from MPColorTheme with fallback support.

```dart
final customColor = context.mp.themeColor(
  (theme) => theme.neutral40,
) ?? Colors.grey.shade300;
```

## 🔧 Best Practices

### 1. Always Use Theme Utilities

```dart
// ✅ Good - Uses theme utilities
Container(color: context.mp.adaptiveBackgroundColor)

// ❌ Bad - Hardcoded colors
Container(color: Colors.white)
```

### 2. Semantic Color Usage

```dart
// ✅ Good - Semantic color
Text('Title', style: TextStyle(color: context.mp.textColor))

// ❌ Less ideal - Direct neutral color
Text('Title', style: TextStyle(color: context.mp.neutral80))
```

### 3. Dark Mode Awareness

```dart
// ✅ Good - Adaptive by default
Container(color: context.mp.adaptiveBackgroundColor)

// ✅ Also good - Manual dark mode check
Container(
  color: context.mp.isDarkMode 
    ? context.mp.neutral20 
    : context.mp.neutral100,
)
```

## 🎨 Custom Theme Example

```dart
MaterialApp(
  theme: MPTheme.main().copyWith(
    extensions: [
      MPColorTheme.light.copyWith(
        primary: Colors.deepPurple,
        neutral100: Colors.grey.shade50,
        neutral20: Colors.grey.shade100,
        textColor: Colors.grey.shade900,
        subtitleColor: Colors.grey.shade700,
      ),
    ],
  ),
  home: YourApp(),
)
```

## 🔗 Related Links

- [Getting Started](../getting-started/README.md) - Theme setup
- [Components](./components.md) - Component usage
- [Component Examples](../../examples/README.md) - Complete examples

## 🤝 Migration

Coming from `Theme.of(context).extension<MPColorTheme>()`? Here's how to migrate:

### Before
```dart
final theme = Theme.of(context);
final colorTheme = theme.extension<MPColorTheme>();
final bgColor = colorTheme?.neutral100 ?? Colors.white;
```

### After
```dart
final bgColor = context.mp.adaptiveBackgroundColor;
```

The new approach is:
- **More concise**: `context.mp` vs multiple lines
- **Type safe**: All properties available directly
- **Self-documenting**: Clear property names
- **Fallback-ready**: Automatic fallbacks to sensible defaults
