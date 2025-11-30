# Components API Reference

Complete documentation for all Micropack UI Kit components.

## 📚 Table of Contents

- [MPArticleCard](#mparticlecard)
- [MPButton](#mpbutton)
- [MPText](#mptext)
- [MPTextField](#mptextfield)
- [MPDialog](#mpdialog)

---

## 📰 MPArticleCard

Feature-rich article card component with multiple variants and sizes.

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

Customizable button component with multiple variants and states.

### Basic Usage

```dart
MPButton(
  text: 'Get Started',
  onPressed: () => print('Button pressed'),
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

Enhanced text component with built-in styling options.

### Basic Usage

```dart
MPText(
  'Hello World',
  style: MPTextStyle.headline1(),
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

Input field component with validation and theming support.

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

Modal dialog component with multiple display options.

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

## 🔗 Related Links

- [Theme Utilities](./theme-utilities.md) - Using context.mp
- [Getting Started](../getting-started/README.md) - Setup guide
- [Examples](../examples/README.md) - Complete code examples

## 🤝 Contributing

Found an issue or want to improve documentation? Please see our [contributing guide](../../CONTRIBUTING.md).
