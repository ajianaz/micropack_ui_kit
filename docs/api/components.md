# Components API Reference

Complete documentation for all Micropack UI Kit components.

## 📚 Table of Contents

- [MPArticleCard](#mparticlecard)
- [MPButton](#mpbutton)
- [MPText](#mptext)
- [MPTextField](#mptextfield)
- [MPDialog](#mpdialog)
- [MPTabRounded](#mptabrounded)
- [MPSnackbar](#mpsnackbar)

---

## 📰 MPArticleCard

Feature-rich article card component with multiple variants and sizes. Fully theme-aware with automatic dark/light mode adaptation.

### Theme-Aware Properties

MPArticleCard automatically adapts to the current theme:

- **Background**: Uses `context.mp.adaptiveBackgroundColor` by default
- **Text Colors**: Uses semantic colors (`textColor`, `subtitleColor`, `captionColor`)
- **Borders**: Adapts using `context.mp.adaptiveBorderColor`
- **Shadows**: Adjusts based on theme with `context.mp.adaptiveShadowColor`

### Basic Usage

```dart
MPArticleCard(
  title: 'Article Title',
  description: 'Article description goes here...',
  author: 'John Doe',
  date: 'March 15, 2024',
  readTime: '5 min read',
  imageUrl: 'https://example.com/image.jpg',
  onTap: () => print('Card tapped'),
)
```

### Theme Customization

```dart
MPArticleCard(
  title: 'Article Title',
  description: 'Article description goes here...',
  backgroundColor: context.mp.neutral100, // Light mode white, dark mode dark
  borderColor: context.mp.primaryBorder,
  titleStyle: TextStyle(color: context.mp.textColor),
  subtitleStyle: TextStyle(color: context.mp.subtitleColor),
  onTap: () => print('Card tapped'),
)
```

### Light/Dark Theme Examples

#### Light Theme
```dart
Theme(
  data: ThemeData.light(),
  child: MPArticleCard(
    title: 'Light Theme Article',
    description: 'This card uses light theme colors',
    variant: MPArticleCardVariant.elevated,
  ),
)
```

#### Dark Theme
```dart
Theme(
  data: ThemeData.dark(),
  child: MPArticleCard(
    title: 'Dark Theme Article',
    description: 'This card uses dark theme colors',
    variant: MPArticleCardVariant.elevated,
  ),
)
```

### Constructor

```dart
MPArticleCard({
  Key? key,
  required this.title,
  this.description,
  this.imageUrl,
  this.imageWidget,
  this.author,
  this.date,
  this.readTime,
  this.onTap,
  this.onLike,
  this.onBookmark,
  this.onShare,
  this.category,
  this.tags,
  this.variant = MPArticleCardVariant.standard,
  this.size = MPArticleCardSize.medium,
  this.isLiked = false,
  this.isBookmarked = false,
  this.likeCount = 0,
  this.padding,
  this.margin,
  this.borderRadius,
  this.backgroundColor,
  this.elevation,
  this.actionButtons,
})
```

### Properties

| Property | Type | Default | Description |
|-----------|--------|----------|-------------|
| `title` | `String` | - | **Required**. Main article title |
| `description` | `String?` | `null` | Article description text |
| `imageUrl` | `String?` | `null` | URL for article image |
| `imageWidget` | `Widget?` | `null` | Custom image widget |
| `author` | `String?` | `null` | Article author name |
| `date` | `String?` | `null` | Publication date |
| `readTime` | `String?` | `null` | Estimated reading time |
| `onTap` | `VoidCallback?` | `null` | Card tap callback |
| `onLike` | `VoidCallback?` | `null` | Like button callback |
| `onBookmark` | `VoidCallback?` | `null` | Bookmark button callback |
| `onShare` | `VoidCallback?` | `null` | Share button callback |
| `category` | `String?` | `null` | Article category label |
| `tags` | `List<String>?` | `null` | Article tags |
| `variant` | `MPArticleCardVariant` | `standard` | Visual style variant |
| `size` | `MPArticleCardSize` | `medium` | Card size variant |
| `isLiked` | `bool` | `false` | Like button state |
| `isBookmarked` | `bool` | `false` | Bookmark button state |
| `likeCount` | `int` | `0` | Number of likes |
| `padding` | `EdgeInsets?` | `null` | Internal padding |
| `margin` | `EdgeInsets?` | `null` | External margin |
| `borderRadius` | `double?` | `null` | Border radius |
| `backgroundColor` | `Color?` | `null` | Background color |
| `elevation` | `double?` | `null` | Shadow elevation |
| `actionButtons` | `List<Widget>?` | `null` | Custom action buttons |

### Enums

#### MPArticleCardVariant

```dart
enum MPArticleCardVariant {
  standard,   // Clean, minimal design
  elevated,   // Card with elevation shadow
  outlined,    // Card with border
}
```

#### MPArticleCardSize

```dart
enum MPArticleCardSize {
  small,   // Compact layout
  medium,   // Standard layout
  large,    // Expanded layout
}
```

### Examples

#### Elevated Card with Image

```dart
MPArticleCard(
  title: 'Advanced Flutter Development',
  description: 'Master advanced Flutter techniques and best practices.',
  imageUrl: 'https://picsum.photos/400/200',
  author: 'Jane Smith',
  date: 'March 15, 2024',
  readTime: '8 min read',
  variant: MPArticleCardVariant.elevated,
  size: MPArticleCardSize.large,
  onTap: () => _openArticle(),
)
```

#### Minimal Outlined Card

```dart
MPArticleCard(
  title: 'Quick Tip',
  description: 'A simple but effective Flutter optimization.',
  variant: MPArticleCardVariant.outlined,
  size: MPArticleCardSize.small,
  onTap: () => _showDetails(),
)
```

---

## 🔘 MPButton

Customizable button component with multiple variants and states. Fully theme-aware with automatic dark/light mode adaptation.

### Theme-Aware Properties

MPButton automatically adapts to the current theme:

- **Primary Variant**: Uses `context.mp.primary` for background
- **Text Color**: Automatically adjusts for contrast
- **Border Colors**: Uses `context.mp.primaryBorder` for outline variant
- **Hover/Pressed States**: Uses `context.mp.primaryHover` and `context.mp.primaryPressed`
- **Disabled State**: Uses `context.mp.disabledColor`

### Basic Usage

```dart
MPButton(
  text: 'Get Started',
  onPressed: () => print('Button pressed'),
)
```

### Theme Customization

```dart
MPButton(
  text: 'Custom Button',
  backgroundColor: context.mp.primary,
  textColor: context.mp.isDarkMode ? Colors.white : Colors.black,
  borderColor: context.mp.primaryBorder,
  onPressed: () => print('Button pressed'),
)
```

### Light/Dark Theme Examples

#### Light Theme Buttons
```dart
Column(
  children: [
    MPButton(
      text: 'Primary Button',
      variant: MPButtonVariant.primary,
      onPressed: () {},
    ),
    MPButton(
      text: 'Secondary Button',
      variant: MPButtonVariant.secondary,
      onPressed: () {},
    ),
    MPButton(
      text: 'Outline Button',
      variant: MPButtonVariant.outline,
      onPressed: () {},
    ),
  ],
)
```

#### Dark Theme Buttons
```dart
Theme(
  data: ThemeData.dark(),
  child: Column(
    children: [
      MPButton(
        text: 'Primary Button',
        variant: MPButtonVariant.primary,
        onPressed: () {},
      ),
      MPButton(
        text: 'Secondary Button',
        variant: MPButtonVariant.secondary,
        onPressed: () {},
      ),
      MPButton(
        text: 'Outline Button',
        variant: MPButtonVariant.outline,
        onPressed: () {},
      ),
    ],
  ),
)
```

### Constructor

```dart
MPButton({
  Key? key,
  required this.text,
  this.onPressed,
  this.onLongPress,
  this.variant = MPButtonVariant.primary,
  this.size = MPButtonSize.medium,
  this.fullWidth = false,
  this.isLoading = false,
  this.disabled = false,
  this.icon,
  this.backgroundColor,
  this.textColor,
  this.borderRadius,
  this.padding,
  this.margin,
})
```

### Properties

| Property | Type | Default | Description |
|-----------|--------|----------|-------------|
| `text` | `String` | - | **Required**. Button text |
| `onPressed` | `VoidCallback?` | `null` | Press callback |
| `onLongPress` | `VoidCallback?` | `null` | Long press callback |
| `variant` | `MPButtonVariant` | `primary` | Button style variant |
| `size` | `MPButtonSize` | `medium` | Button size |
| `fullWidth` | `bool` | `false` | Fill available width |
| `isLoading` | `bool` | `false` | Show loading state |
| `disabled` | `bool` | `false` | Disable button |
| `icon` | `IconData?` | `null` | Button icon |
| `backgroundColor` | `Color?` | `null` | Custom background |
| `textColor` | `Color?` | `null` | Custom text color |
| `borderRadius` | `double?` | `null` | Custom border radius |
| `padding` | `EdgeInsets?` | `null` | Custom padding |
| `margin` | `EdgeInsets?` | `null` | Custom margin |

### Enums

#### MPButtonVariant

```dart
enum MPButtonVariant {
  primary,    // Main action button
  secondary,  // Secondary action
  outline,    // Outlined button
  ghost,      // Transparent background
  link,       // Text-only button
  danger,     // Destructive action
  success,     // Success action
}
```

#### MPButtonSize

```dart
enum MPButtonSize {
  small,   // Compact button
  medium,   // Standard button
  large,    // Prominent button
  xlarge,   // Extra large button
}
```

### Examples

#### Primary Button with Icon

```dart
MPButton(
  text: 'Download',
  icon: Icons.download,
  variant: MPButtonVariant.primary,
  size: MPButtonSize.large,
  fullWidth: true,
  onPressed: () => _downloadFile(),
)
```

#### Loading State Button

```dart
MPButton(
  text: 'Processing...',
  variant: MPButtonVariant.primary,
  isLoading: true,
  disabled: true,
)
```

---

## 📝 MPText

Enhanced text component with built-in styling options. Fully theme-aware with automatic dark/light mode adaptation.

### Theme-Aware Properties

MPText automatically adapts to the current theme:

- **Default Color**: Uses `context.mp.textColor` for optimal contrast
- **Subtitle Color**: Uses `context.mp.subtitleColor` for secondary text
- **Caption Color**: Uses `context.mp.captionColor` for subtle text
- **Adaptive Opacity**: Adjusts text opacity based on theme brightness

### Basic Usage

```dart
MPText(
  'Hello World',
  style: MPTextStyle.headline1(),
)
```

### Theme Customization

```dart
MPText(
  'Themed Text',
  style: MPTextStyle.headline2(
    color: context.mp.textColor,
  ),
)

MPText(
  'Subtitle Text',
  style: MPTextStyle.body1(
    color: context.mp.subtitleColor,
  ),
)

MPText(
  'Caption Text',
  style: MPTextStyle.caption(
    color: context.mp.captionColor,
  ),
)
```

### Light/Dark Theme Examples

#### Light Theme Text
```dart
Theme(
  data: ThemeData.light(),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MPText(
        'Light Theme Title',
        style: MPTextStyle.headline3(),
      ),
      MPText(
        'Light theme subtitle with proper contrast',
        style: MPTextStyle.body1(),
      ),
      MPText(
        'Light theme caption',
        style: MPTextStyle.caption(),
      ),
    ],
  ),
)
```

#### Dark Theme Text
```dart
Theme(
  data: ThemeData.dark(),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MPText(
        'Dark Theme Title',
        style: MPTextStyle.headline3(),
      ),
      MPText(
        'Dark theme subtitle with proper contrast',
        style: MPTextStyle.body1(),
      ),
      MPText(
        'Dark theme caption',
        style: MPTextStyle.caption(),
      ),
    ],
  ),
)
```

### Constructor

```dart
MPText(
  this.text, {
  Key? key,
  this.style,
  this.textAlign,
  this.maxLines,
  this.overflow,
  this.semanticsLabel,
})
```

### Properties

| Property | Type | Default | Description |
|-----------|--------|----------|-------------|
| `text` | `String` | - | **Required**. Text to display |
| `style` | `TextStyle?` | `null` | Text styling |
| `textAlign` | `TextAlign?` | `null` | Text alignment |
| `maxLines` | `int?` | `null` | Maximum lines |
| `overflow` | `TextOverflow?` | `null` | Overflow handling |
| `semanticsLabel` | `String?` | `null` | Accessibility label |

### Examples

#### Styled Text

```dart
MPText(
  'Featured Article',
  style: MPTextStyle.headline4(
    color: context.mp.primary,
    fontWeight: FontWeight.bold,
  ),
)
```

#### Multiline Text

```dart
MPText(
  'This is a long text that will wrap to multiple lines when it exceeds the available width.',
  maxLines: 3,
  overflow: TextOverflow.ellipsis,
)
```

---

## 📝 MPTextField

Input field component with validation and theming support. Fully theme-aware with automatic dark/light mode adaptation.

### Theme-Aware Properties

MPTextField automatically adapts to the current theme:

- **Background**: Uses `context.mp.adaptiveBackgroundColor`
- **Border Color**: Uses `context.mp.adaptiveBorderColor` by default
- **Focus Border**: Uses `context.mp.primaryFocus` when focused
- **Text Color**: Uses `context.mp.textColor` for input text
- **Hint Text**: Uses `context.mp.subtitleColor` for placeholder
- **Error Text**: Uses `context.mp.errorColor` for validation errors

### Basic Usage

```dart
MPTextField(
  hintText: 'Enter your email',
  controller: _emailController,
  validator: (value) {
    if (value?.isEmpty ?? true) {
      return 'Email is required';
    }
    if (!value!.contains('@')) {
      return 'Invalid email format';
    }
    return null;
  },
)
```

### Theme Customization

```dart
MPTextField(
  hintText: 'Custom themed field',
  controller: _controller,
  fillColor: context.mp.neutral100,
  borderColor: context.mp.primaryBorder,
  focusBorderColor: context.mp.primaryFocus,
  textStyle: TextStyle(color: context.mp.textColor),
  hintStyle: TextStyle(color: context.mp.subtitleColor),
  errorStyle: TextStyle(color: context.mp.errorColor),
)
```

### Light/Dark Theme Examples

#### Light Theme TextField
```dart
Theme(
  data: ThemeData.light(),
  child: MPTextField(
    hintText: 'Light theme input',
    controller: _controller,
    prefixIcon: Icons.email,
  ),
)
```

#### Dark Theme TextField
```dart
Theme(
  data: ThemeData.dark(),
  child: MPTextField(
    hintText: 'Dark theme input',
    controller: _controller,
    prefixIcon: Icons.email,
  ),
)
```

### Constructor

```dart
MPTextField({
  Key? key,
  this.controller,
  this.hintText,
  this.labelText,
  this.obscureText = false,
  this.keyboardType,
  this.validator,
  this.onChanged,
  this.onSubmitted,
  this.isEnabled = true,
  this.errorText,
  this.prefixIcon,
  this.suffixIcon,
  this.fillColor,
  this.borderColor,
  this.borderWidth,
  this.borderRadius,
})
```

### Properties

| Property | Type | Default | Description |
|-----------|--------|----------|-------------|
| `controller` | `TextEditingController?` | `null` | Text controller |
| `hintText` | `String?` | `null` | Placeholder text |
| `labelText` | `String?` | `null` | Field label |
| `obscureText` | `bool` | `false` | Hide text (password) |
| `keyboardType` | `TextInputType?` | `null` | Keyboard type |
| `validator` | `String? Function(String?)` | `null` | Validation function |
| `onChanged` | `ValueChanged<String>?` | `null` | Change callback |
| `onSubmitted` | `ValueChanged<String>?` | `null` | Submit callback |
| `isEnabled` | `bool` | `true` | Enable/disable field |
| `errorText` | `String?` | `null` | Error message |
| `prefixIcon` | `IconData?` | `null` | Leading icon |
| `suffixIcon` | `IconData?` | `null` | Trailing icon |

### Examples

#### Email Field with Validation

```dart
MPTextField(
  controller: _emailController,
  hintText: 'Email address',
  prefixIcon: Icons.email,
  keyboardType: TextInputType.emailAddress,
  validator: _validateEmail,
  onChanged: (value) => _updateEmail(value),
)
```

#### Password Field

```dart
MPTextField(
  controller: _passwordController,
  hintText: 'Password',
  obscureText: true,
  prefixIcon: Icons.lock,
  suffixIcon: Icons.visibility,
  validator: _validatePassword,
)
```

---

## 💬 MPDialog

Modal dialog component with multiple display options. Fully theme-aware with automatic dark/light mode adaptation.

### Theme-Aware Properties

MPDialog automatically adapts to the current theme:

- **Background**: Uses `context.mp.adaptiveBackgroundColor`
- **Surface Color**: Uses `context.mp.primarySurface` for elevated surfaces
- **Title Color**: Uses `context.mp.textColor` for titles
- **Content Color**: Uses `context.mp.textColor` for content
- **Border**: Uses `context.mp.adaptiveBorderColor`
- **Shadow**: Uses `context.mp.adaptiveShadowColor`

### Basic Usage

```dart
MPDialog.show(
  context: context,
  title: 'Confirm Deletion',
  content: 'Are you sure you want to delete this item?',
  confirmText: 'Delete',
  cancelText: 'Cancel',
  onConfirm: () => _deleteItem(),
)
```

### Theme Customization

```dart
MPDialog.show(
  context: context,
  title: 'Custom Dialog',
  content: Container(
    color: context.mp.primarySurface,
    child: Text(
      'Custom themed dialog content',
      style: TextStyle(color: context.mp.textColor),
    ),
  ),
  backgroundColor: context.mp.adaptiveBackgroundColor,
  borderColor: context.mp.primaryBorder,
  titleStyle: TextStyle(color: context.mp.textColor),
  contentStyle: TextStyle(color: context.mp.textColor),
  onConfirm: () => Navigator.of(context).pop(),
)
```

### Light/Dark Theme Examples

#### Light Theme Dialog
```dart
Theme(
  data: ThemeData.light(),
  child: Builder(
    builder: (context) => ElevatedButton(
      onPressed: () => MPDialog.show(
        context: context,
        title: 'Light Theme Dialog',
        content: Text('This dialog uses light theme colors'),
        onConfirm: () => Navigator.of(context).pop(),
      ),
      child: Text('Show Light Dialog'),
    ),
  ),
)
```

#### Dark Theme Dialog
```dart
Theme(
  data: ThemeData.dark(),
  child: Builder(
    builder: (context) => ElevatedButton(
      onPressed: () => MPDialog.show(
        context: context,
        title: 'Dark Theme Dialog',
        content: Text('This dialog uses dark theme colors'),
        onConfirm: () => Navigator.of(context).pop(),
      ),
      child: Text('Show Dark Dialog'),
    ),
  ),
)
```

### Static Methods

#### Show Dialog

```dart
MPDialog.show({
  required BuildContext context,
  String? title,
  required Widget content,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool barrierDismissible = true,
  DialogType type = DialogType.info,
})
```

### Properties

| Parameter | Type | Default | Description |
|-----------|--------|----------|-------------|
| `context` | `BuildContext` | - | **Required**. Build context |
| `title` | `String?` | `null` | Dialog title |
| `content` | `Widget` | - | **Required**. Dialog content |
| `confirmText` | `String?` | `'OK'` | Confirm button text |
| `cancelText` | `String?` | `'Cancel'` | Cancel button text |
| `onConfirm` | `VoidCallback?` | `null` | Confirm callback |
| `onCancel` | `VoidCallback?` | `null` | Cancel callback |
| `barrierDismissible` | `bool` | `true` | Tap outside to close |
| `type` | `DialogType` | `info` | Dialog style type |

### Examples

#### Confirmation Dialog

```dart
MPDialog.show(
  context: context,
  title: 'Delete Item',
  content: Text('This action cannot be undone. Continue?'),
  confirmText: 'Delete',
  cancelText: 'Cancel',
  type: DialogType.warning,
  onConfirm: () => _confirmDelete(),
)
```

#### Success Dialog

```dart
MPDialog.show(
  context: context,
  title: 'Success!',
  content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.check_circle, color: Colors.green, size: 48),
      SizedBox(height: 16),
      Text('Item saved successfully'),
    ],
  ),
  type: DialogType.success,
)
```

---

## 📑 MPTabRounded

Tab component with rounded corners. Fully theme-aware with automatic dark/light mode adaptation.

### Theme-Aware Properties

MPTabRounded automatically adapts to current theme:

- **Background**: Uses `context.mp.adaptiveBackgroundColor`
- **Selected Color**: Uses `context.mp.primary` for selected tab
- **Text Color**: Uses `context.mp.textColor` for labels
- **Border**: Uses `context.mp.adaptiveBorderColor`

### Basic Usage

```dart
MPTabRounded(
  tabs: [
    MPTabItem(title: 'Home', icon: Icons.home),
    MPTabItem(title: 'Profile', icon: Icons.person),
    MPTabItem(title: 'Settings', icon: Icons.settings),
  ],
  selectedIndex: _currentIndex,
  onTap: (index) => setState(() => _currentIndex = index),
)
```

### Constructor

```dart
MPTabRounded({
  Key? key,
  required this.tabs,
  required this.selectedIndex,
  this.onTap,
  this.backgroundColor,
  this.selectedColor,
  this.textColor,
  this.selectedTextColor,
  this.borderRadius,
  this.padding,
})
```

### Properties

| Property | Type | Default | Description |
|-----------|--------|----------|-------------|
| `tabs` | `List<MPTabItem>` | - | **Required**. List of tabs |
| `selectedIndex` | `int` | - | **Required**. Currently selected tab index |
| `onTap` | `Function(int)?` | `null` | Tab selection callback |
| `backgroundColor` | `Color?` | `null` | Custom background color |
| `selectedColor` | `Color?` | `null` | Custom selected color |
| `textColor` | `Color?` | `null` | Custom text color |
| `selectedTextColor` | `Color?` | `null` | Custom selected text color |
| `borderRadius` | `double?` | `null` | Custom border radius |
| `padding` | `EdgeInsets?` | `null` | Custom padding |

---

## 🔔 MPSnackbar

Notification snackbar component with multiple variants. Fully theme-aware with automatic dark/light mode adaptation.

### Theme-Aware Properties

MPSnackbar automatically adapts to current theme:

- **Background**: Uses `context.mp.adaptiveBackgroundColor`
- **Success**: Uses `context.mp.successBackgroundColor` and `context.mp.successColor`
- **Error**: Uses `context.mp.errorBackgroundColor` and `context.mp.errorColor`
- **Warning**: Uses `context.mp.warningBackgroundColor` and `context.mp.warningColor`
- **Info**: Uses `context.mp.infoBackgroundColor` and `context.mp.infoColor`

### Basic Usage

```dart
MPSnackbar.show(
  context: context,
  message: 'Operation completed successfully',
  type: MPSnackbarType.success,
)

MPSnackbar.show(
  context: context,
  message: 'An error occurred',
  type: MPSnackbarType.error,
)
```

### Static Methods

#### Show Snackbar

```dart
MPSnackbar.show({
  required BuildContext context,
  required String message,
  MPSnackbarType type = MPSnackbarType.info,
  Duration duration = const Duration(seconds: 3),
  VoidCallback? onAction,
  String? actionText,
})
```

### Properties

| Parameter | Type | Default | Description |
|-----------|--------|----------|-------------|
| `context` | `BuildContext` | - | **Required**. Build context |
| `message` | `String` | - | **Required**. Message to display |
| `type` | `MPSnackbarType` | `info` | Snackbar type |
| `duration` | `Duration` | `3 seconds` | Display duration |
| `onAction` | `VoidCallback?` | `null` | Action button callback |
| `actionText` | `String?` | `null` | Action button text |

### Enums

#### MPSnackbarType

```dart
enum MPSnackbarType {
  success,  // Success notification
  error,    // Error notification
  warning,  // Warning notification
  info,     // Info notification
}
```

---

## 🌓 Theme-Specific Behaviors

### Component Theme Adaptation

All Micropack UI Kit components automatically adapt to theme changes:

1. **Real-time Updates**: Components update immediately when theme changes
2. **Smooth Transitions**: Theme changes animate smoothly when using `AnimatedTheme`
3. **Persistent State**: Component states maintain during theme switches
4. **Accessibility**: Contrast ratios maintained in both themes

### Testing Theme Behavior

```dart
// Test component in both themes
class ThemeTestWidget extends StatelessWidget {
  const ThemeTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Light Theme', style: Theme.of(context).textTheme.headline6),
        Theme(
          data: ThemeData.light(),
          child: MPButton(
            text: 'Light Button',
            onPressed: () {},
          ),
        ),
        SizedBox(height: 20),
        Text('Dark Theme', style: Theme.of(context).textTheme.headline6),
        Theme(
          data: ThemeData.dark(),
          child: MPButton(
            text: 'Dark Button',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
```

## 🔗 Related Links

- [Theme Utilities](./theme-utilities.md) - Using context.mp
- [Theming Guide](../guides/theming.md) - Comprehensive theme documentation
- [Getting Started](../getting-started/README.md) - Setup guide
- [Examples](../examples/README.md) - Complete code examples

## 🤝 Contributing

Found an issue or want to improve documentation? Please see our [contributing guide](../../CONTRIBUTING.md).
