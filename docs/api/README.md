# Component API Reference

Complete API documentation for all Micropack UI Kit components.

## 📚 Table of Contents

- [Basic Components](#basic-components)
- [Form Components](#form-components)
- [Feedback Components](#feedback-components)
- [Navigation Components](#navigation-components)
- [Display Components](#display-components)

---

## 🔘 Basic Components

### MPButton

Customizable button component with multiple variants and states.

#### Constructor

```dart
MPButton({
  Key? key,
  required String text,
  IconData? icon,
  MPButtonVariant variant = MPButtonVariant.primary,
  MPButtonSize size = MPButtonSize.medium,
  VoidCallback? onPressed,
  bool loading = false,
  bool disabled = false,
  double? width,
  double? height,
  Color? backgroundColor,
  Color? textColor,
  BorderRadius? borderRadius,
  EdgeInsets? padding,
})
```

#### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|--------|-----------|----------|-------------|
| `text` | `String` | ✅ Yes | Button label text |
| `icon` | `IconData?` | ❌ No | Optional leading icon |
| `variant` | `MPButtonVariant` | ❌ No | `primary` | Button visual style |
| `size` | `MPButtonSize` | ❌ No | `medium` | Button size |
| `onPressed` | `VoidCallback?` | ❌ No | Callback when pressed |
| `loading` | `bool` | ❌ No | `false` | Show loading state |
| `disabled` | `bool` | ❌ No | `false` | Disable button |
| `width` | `double?` | ❌ No | Custom width |
| `height` | `double?` | ❌ No | Custom height |
| `backgroundColor` | `Color?` | ❌ No | Custom background color |
| `textColor` | `Color?` | ❌ No | Custom text color |
| `borderRadius` | `BorderRadius?` | ❌ No | Custom border radius |
| `padding` | `EdgeInsets?` | ❌ No | Custom padding |

#### Variants

- `primary` - Primary action button
- `secondary` - Secondary action button
- `outlined` - Outlined button style
- `ghost` - Ghost button (no border/background)
- `text` - Text-only button
- `danger` - Destructive action button
- `success` - Success action button
- `warning` - Warning action button
- `info` - Info action button

#### Sizes

- `small` - 32px height
- `regular` - 40px height
- `medium` - 44px height
- `large` - 52px height

#### Example

```dart
MPButton(
  text: 'Get Started',
  variant: MPButtonVariant.primary,
  size: MPButtonSize.medium,
  onPressed: () => print('Button pressed'),
)

// With icon and loading
MPButton(
  text: 'Loading...',
  icon: Icons.download,
  loading: true,
  onPressed: null,
)
```

---

### MPCard

Content container component with styling and elevation.

#### Constructor

```dart
MPCard({
  Key? key,
  required Widget child,
  Color? backgroundColor,
  Color? borderColor,
  double? borderWidth,
  double? borderRadius,
  EdgeInsets? padding,
  EdgeInsets? margin,
  bool elevation = false,
  VoidCallback? onTap,
})
```

#### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|--------|-----------|----------|-------------|
| `child` | `Widget` | ✅ Yes | Card content |
| `backgroundColor` | `Color?` | ❌ No | Custom background color |
| `borderColor` | `Color?` | ❌ No | Custom border color |
| `borderWidth` | `double?` | ❌ No | Custom border width |
| `borderRadius` | `double?` | ❌ No | Custom border radius |
| `padding` | `EdgeInsets?` | ❌ No | Custom padding |
| `margin` | `EdgeInsets?` | ❌ No | Custom margin |
| `elevation` | `bool` | `false` | Enable elevation shadow |
| `onTap` | `VoidCallback?` | ❌ No | Make card clickable |

#### Example

```dart
MPCard(
  elevation: true,
  onTap: () => print('Card tapped'),
  child: Column(
    children: [
      MPText.head('Card Title'),
      MPText.body('Card content here'),
    ],
  ),
)
```

---

### MPText

Enhanced text component with built-in styles.

#### Static Methods

```dart
// Headline text
MPText.head(String text, {TextStyle? style, int? fontSize, FontWeight? fontWeight, Color? color, TextAlign? textAlign, int? maxLines})

// Subheading
MPText.subhead(String text, {TextStyle? style, int? fontSize, ...})

// Body text
MPText.body(String text, {TextStyle? style, int? fontSize, ...})

// Label text
MPText.label(String text, {TextStyle? style, int? fontSize, ...})

// Small/caption text
MPText.small(String text, {TextStyle? style, int? fontSize, ...})
```

#### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|--------|-----------|----------|-------------|
| `text` | `String` | ✅ Yes | Text content |
| `style` | `TextStyle?` | ❌ No | Custom text style |
| `fontSize` | `int?` | ❌ No | Font size |
| `fontWeight` | `FontWeight?` | ❌ No | Font weight |
| `color` | `Color?` | ❌ No | Text color |
| `textAlign` | `TextAlign?` | ❌ No | Text alignment |
| `maxLines` | `int?` | ❌ No | Maximum lines |

#### Example

```dart
Column(
  children: [
    MPText.head('Welcome', fontSize: 24),
    MPText.subhead('Sign in to continue'),
    MPText.body('Enter your credentials below'),
    MPText.label('Email Address'),
    MPText.small('By continuing, you agree to terms'),
  ],
)
```

---

### MPTextField

Input field component with validation and theming.

#### Constructor

```dart
MPTextField({
  Key? key,
  String hintText,
  TextEditingController? controller,
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? onSuffixTap,
  bool obscureText = false,
  bool enabled = true,
  int maxLines = 1,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
  Color? backgroundColor,
  Color? borderColor,
  Color? focusColor,
  double? borderRadius,
  EdgeInsets? padding,
})
```

#### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|--------|-----------|----------|-------------|
| `hintText` | `String` | ❌ No | Placeholder text |
| `controller` | `TextEditingController?` | ❌ No | Text editing controller |
| `prefixIcon` | `IconData?` | ❌ No | Icon before input |
| `suffixIcon` | `IconData?` | ❌ No | Icon after input |
| `onSuffixTap` | `VoidCallback?` | ❌ No | Callback when suffix tapped |
| `obscureText` | `bool` | `false` | Hide text (password) |
| `enabled` | `bool` | `true` | Enable/disable field |
| `maxLines` | `int` | `1` | Maximum text lines |
| `validator` | `String? Function(String?)?` | ❌ No | Validation function |
| `onChanged` | `void Function(String)?` | ❌ No | Callback when text changes |
| `onSubmitted` | `void Function(String)?` | ❌ No | Callback when submitted |
| `backgroundColor` | `Color?` | ❌ No | Custom background |
| `borderColor` | `Color?` | ❌ No | Custom border color |
| `focusColor` | `Color?` | ❌ No | Focus border color |
| `borderRadius` | `double?` | ❌ No | Custom border radius |
| `padding` | `EdgeInsets?` | ❌ No | Custom padding |

#### Example

```dart
MPTextField(
  hintText: 'Enter your email',
  controller: _emailController,
  prefixIcon: Icons.email,
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Email is required';
    if (!value!.contains('@')) return 'Invalid email';
    return null;
  },
  onChanged: (value) => print(value),
)

// Password field
MPTextField(
  hintText: 'Password',
  obscureText: true,
  prefixIcon: Icons.lock,
  suffixIcon: Icons.visibility,
  onSuffixTap: () => print('Toggle visibility'),
)
```

---

## 📝 Form Components

### MPCheckbox

Checkbox component with multiple sizes and states.

#### Constructor

```dart
MPCheckbox({
  Key? key,
  required bool value,
  required ValueChanged<bool?> onToggle,
  MPCheckboxSize size = MPCheckboxSize.medium,
  bool tristate = false,
  bool enabled = true,
  Color? activeColor,
  Color? inactiveColor,
})
```

#### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|--------|-----------|----------|-------------|
| `value` | `bool` | ✅ Yes | Checkbox state |
| `onToggle` | `ValueChanged<bool?>` | ✅ Yes | Callback when tapped |
| `size` | `MPCheckboxSize` | ❌ No | `medium` | Checkbox size |
| `tristate` | `bool` | `false` | Enable null state |
| `enabled` | `bool` | `true` | Enable/disable |
| `activeColor` | `Color?` | ❌ No | Custom active color |
| `inactiveColor` | `Color?` | ❌ No | Custom inactive color |

#### Sizes

- `small` - 18px check box
- `medium` - 22px check box (default)
- `large` - 26px check box

#### Example

```dart
// Basic checkbox
bool _isChecked = false;
MPCheckbox(
  value: _isChecked,
  onToggle: (value) => setState(() => _isChecked = value ?? false),
)

// With label
Row(
  children: [
    MPCheckbox(value: _agree, onToggle: (v) => _agree = v ?? false),
    SizedBox(width: 12),
    MPText('I agree to terms'),
  ],
)

// Indeterminate state
bool? _indeterminate = true;
MPCheckbox(
  value: _indeterminate,
  tristate: true,
  onToggle: (value) => setState(() => _indeterminate = value),
)
```

---

### MPSwitch

Toggle switch component with animations.

#### Constructor

```dart
MPSwitch({
  Key? key,
  required bool value,
  required ValueChanged<bool> onToggle,
  MPSwitchSize size = MPSwitchSize.medium,
  bool enabled = true,
  bool disabled = false,
  Duration animationDuration = const Duration(milliseconds: 300),
  Color? activeColor,
  Color? inactiveColor,
})
```

#### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|--------|-----------|----------|-------------|
| `value` | `bool` | ✅ Yes | Switch state |
| `onToggle` | `ValueChanged<bool>` | ✅ Yes | Callback when toggled |
| `size` | `MPSwitchSize` | ❌ No | `medium` | Switch size |
| `enabled` | `bool` | `true` | Enable/disable |
| `disabled` | `bool` | `false` | Disable switch (same as enabled) |
| `animationDuration` | `Duration` | `300ms` | Animation duration |
| `activeColor` | `Color?` | ❌ No | Custom active color |
| `inactiveColor` | `Color?` | ❌ No | Custom inactive color |

#### Sizes

- `small` - 32px toggle
- `medium` - 40px toggle (default)
- `large` - 48px toggle

#### Example

```dart
bool _isOn = false;
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
```

---

### MPBadge

Badge component for status indicators, counts, or labels.

#### Constructor

```dart
MPBadge({
  Key? key,
  required String label,
  MPBadgeVariant variant = MPBadgeVariant.primary,
  MPBadgeSize size = MPBadgeSize.medium,
  Widget? leading,
  Widget? trailing,
  bool enabled = true,
  Color? backgroundColor,
  Color? textColor,
  Color? borderColor,
  double? borderWidth,
  double? borderRadius,
  EdgeInsets? padding,
  String? semanticLabel,
})

// Dot variant
MPBadge.dot({Key? key, Color? color, double? size})

// Notification variant
MPBadge.notification({Key? key, String? label, bool showBadge = true})
```

#### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|--------|-----------|----------|-------------|
| `label` | `String` | ✅ Yes | Badge text |
| `variant` | `MPBadgeVariant` | ❌ No | `primary` | Badge style |
| `size` | `MPBadgeSize` | ❌ No | `medium` | Badge size |
| `leading` | `Widget?` | ❌ No | Widget before label |
| `trailing` | `Widget?` | ❌ No | Widget after label |
| `enabled` | `bool` | `true` | Enable/disable |
| `backgroundColor` | `Color?` | ❌ No | Custom background |
| `textColor` | `Color?` | ❌ No | Custom text color |
| `borderColor` | `Color?` | ❌ No | Custom border |
| `borderWidth` | `double?` | ❌ No | Custom border width |
| `borderRadius` | `double?` | ❌ No | Custom radius |
| `padding` | `EdgeInsets?` | ❌ No | Custom padding |
| `semanticLabel` | `String?` | ❌ No | Accessibility label |

#### Variants

- `standard` - Standard badge
- `dot` - Simple dot indicator
- `notification` - Notification badge style

#### Sizes

- `small` - Compact size
- `medium` - Default size
- `large` - Prominent size

#### Example

```dart
// Standard badge
MPBadge(label: 'New')

// Dot badge
MPBadge.dot()

// Notification badge
MPBadge(label: '5', variant: MPBadgeVariant.notification)

// With icon
MPBadge(
  label: 'Warning',
  icon: Icons.warning,
  variant: MPBadgeVariant.notification,
)
```

---

### MPChip

Tag and label chip component.

#### Constructor

```dart
MPChip({
  Key? key,
  required String label,
  MPChipVariant variant = MPChipVariant.default,
  bool selected = false,
  Widget? avatar,
  IconData? icon,
  VoidCallback? onTap,
  VoidCallback? onDeleted,
  Color? backgroundColor,
  Color? textColor,
  Color? borderColor,
  double? borderRadius,
})
```

#### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|--------|-----------|----------|-------------|
| `label` | `String` | ✅ Yes | Chip text |
| `variant` | `MPChipVariant` | ❌ No | `default` | Chip style |
| `selected` | `bool` | `false` | Selected state |
| `avatar` | `Widget?` | ❌ No | Avatar widget |
| `icon` | `IconData?` | ❌ No | Leading icon |
| `onTap` | `VoidCallback?` | ❌ No | Callback when tapped |
| `onDeleted` | `VoidCallback?` | ❌ No | Callback when deleted |
| `backgroundColor` | `Color?` | ❌ No | Custom background |
| `textColor` | `Color?` | ❌ No | Custom text color |
| `borderColor` | `Color?` | ❌ No | Custom border |
| `borderRadius` | `double?` | ❌ No | Custom radius |

#### Variants

- `default` - Standard chip
- `primary` - Primary colored chip
- `outlined` - Outlined chip
- `filter` - Filter style chip

#### Example

```dart
// Basic chip
MPChip(
  label: 'Flutter',
  onTap: () => print('Chip tapped'),
)

// With avatar
MPChip(
  label: 'John',
  avatar: CircleAvatar(child: Text('JD')),
)

// Closable chip
MPChip(
  label: 'Tag',
  onDeleted: () => print('Deleted'),
)

// Filter chip
MPChip(
  label: 'All',
  selected: _isSelected,
  variant: MPChipVariant.filter,
  onTap: () => setState(() => _isSelected = !_isSelected),
)
```

---

## 💬 Feedback Components

### MPToast

Quick notification toast component.

#### Static Method

```dart
MPToast.show(
  BuildContext context, {
  required String message,
  MPToastType type = MPToastType.info,
  Duration duration = const Duration(seconds: 2),
  VoidCallback? onTap,
})
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|--------|-----------|-------------|
| `context` | `BuildContext` | ✅ Yes | Build context |
| `message` | `String` | ✅ Yes | Toast message |
| `type` | `MPToastType` | ❌ No | Toast style |
| `duration` | `Duration` | ❌ No | Display duration |
| `onTap` | `VoidCallback?` | ❌ No | Tap callback |

#### Types

- `info` - Information toast
- `success` - Success toast
- `warning` - Warning toast
- `error` - Error toast

#### Example

```dart
// Basic toast
MPToast.show(
  context: context,
  message: 'Operation completed',
)

// Success toast
MPToast.show(
  context: context,
  message: 'Saved successfully!',
  type: MPToastType.success,
)
```

---

### MPSnackbar

Snackbar notification component with variants and actions.

#### Static Method

```dart
MPSnackbar.show(
  BuildContext context, {
  required String message,
  MPSnackbarVariant variant = MPSnackbarVariant.info,
  MPSnackbarPosition position = MPSnackbarPosition.bottom,
  Duration? duration,
  MPSnackbarAction? action,
})
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|--------|-----------|-------------|
| `context` | `BuildContext` | ✅ Yes | Build context |
| `message` | `String` | ✅ Yes | Snackbar message |
| `variant` | `MPSnackbarVariant` | ❌ No | Snackbar style |
| `position` | `MPSnackbarPosition` | ❌ No | Position |
| `duration` | `Duration?` | ❌ No | Display duration |
| `action` | `MPSnackbarAction?` | ❌ No | Action button |

#### Variants

- `success` - Success message
- `error` - Error message
- `info` - Info message
- `warning` - Warning message

#### Positions

- `top` - Top of screen
- `bottom` - Bottom of screen (default)

#### Example

```dart
// Basic snackbar
MPSnackbar.show(
  context: context,
  message: 'Item saved',
)

// With action
MPSnackbar.show(
  context: context,
  message: 'Item deleted',
  action: MPSnackbarAction(
    label: 'UNDO',
    onPressed: () => _undoDelete(),
  ),
)

// Custom duration
MPSnackbar.show(
  context: context,
  message: 'Long message',
  duration: Duration(seconds: 5),
)
```

---

## 🧭 Navigation Components

### MPDialog

Modal dialog component with variants.

#### Static Method

```dart
MPDialog.show({
  required BuildContext context,
  required String title,
  String? content,
  DialogType type = DialogType.info,
  String confirmText = 'OK',
  String? cancelText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  Widget? customContent,
})
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|--------|-----------|-------------|
| `context` | `BuildContext` | ✅ Yes | Build context |
| `title` | `String` | ✅ Yes | Dialog title |
| `content` | `String?` | ❌ No | Dialog content text |
| `type` | `DialogType` | ❌ No | Dialog style |
| `confirmText` | `String` | ❌ No | Confirm button text |
| `cancelText` | `String?` | ❌ No | Cancel button text |
| `onConfirm` | `VoidCallback?` | ❌ No | Confirm callback |
| `onCancel` | `VoidCallback?` | ❌ No | Cancel callback |
| `customContent` | `Widget?` | ❌ No | Custom content widget |

#### Types

- `info` - Information dialog
- `success` - Success dialog
- `warning` - Warning dialog
- `error` - Error dialog

#### Example

```dart
// Confirmation dialog
MPDialog.show(
  context: context,
  title: 'Delete Item',
  content: 'Are you sure you want to delete this item?',
  type: DialogType.warning,
  confirmText: 'Delete',
  cancelText: 'Cancel',
  onConfirm: () => _deleteItem(),
)

// Success dialog
MPDialog.show(
  context: context,
  title: 'Success!',
  content: 'Your changes have been saved.',
  type: DialogType.success,
)
```

---

## 📰 Display Components

### MPAvatar

User profile avatar component.

#### Constructor

```dart
MPAvatar({
  Key? key,
  ImageProvider? image,
  String? name,
  String? initials,
  double size = 48,
  Color? backgroundColor,
  Color? textColor,
  VoidCallback? onTap,
})
```

#### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|--------|-----------|----------|-------------|
| `image` | `ImageProvider?` | ❌ No | Avatar image |
| `name` | `String?` | ❌ No | User name (for initials) |
| `initials` | `String?` | ❌ No | Custom initials |
| `size` | `double` | ❌ No | `48` | Avatar size |
| `backgroundColor` | `Color?` | ❌ No | Custom background |
| `textColor` | `Color?` | ❌ No | Custom text color |
| `onTap` | `VoidCallback?` | ❌ No | Tap callback |

#### Example

```dart
// With image
MPAvatar(
  image: NetworkImage('https://example.com/avatar.jpg'),
  size: 64,
)

// With initials
MPAvatar(
  name: 'John Doe',
  size: 64,
)

// Custom initials
MPAvatar(
  initials: 'JD',
  backgroundColor: Colors.blue,
  size: 64,
)
```

---

### MPSkeleton

Loading skeleton component for placeholder content.

#### Constructor

```dart
MPSkeleton({
  Key? key,
  required MPSkeletonType type,
  double? width,
  double? height,
  double? size,
  Color? baseColor,
  Color? highlightColor,
})
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|--------|-----------|-------------|
| `type` | `MPSkeletonType` | ✅ Yes | Skeleton type |
| `width` | `double?` | ❌ No | Skeleton width |
| `height` | `double?` | ❌ No | Skeleton height |
| `size` | `double?` | ❌ No | Size (for circle) |
| `baseColor` | `Color?` | ❌ No | Base color |
| `highlightColor` | `Color?` | ❌ No | Highlight color |

#### Types

- `line` - Text line skeleton
- `circle` - Circular avatar skeleton
- `rect` - Rectangular skeleton

#### Example

```dart
// Text line
MPSkeleton(type: MPSkeletonType.line, width: 200)

// Avatar circle
MPSkeleton(type: MPSkeletonType.circle, size: 64)

// Image rect
MPSkeleton(
  type: MPSkeletonType.rect,
  width: 200,
  height: 150,
)
```

---

## 🔗 Related Documentation

- [Getting Started](../getting-started/README.md)
- [Theme System](../guides/theming.md)
- [Best Practices](../guides/best-practices.md)
- [Examples](../examples/README.md)

## 🆘 Getting Help

If you have questions about component APIs:

1. Check the [Getting Started Guide](../getting-started/README.md)
2. Review [Examples](../examples/README.md) for usage
3. Search [GitHub Issues](https://github.com/ajianaz/micropack-ui-kit/issues)
4. Ask in [GitHub Discussions](https://github.com/ajianaz/micropack-ui-kit/discussions)
