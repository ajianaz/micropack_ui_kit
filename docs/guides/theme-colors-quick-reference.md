# Theme Colors Quick Reference

Quick reference guide for all Micropack UI Kit theme colors with usage examples.

## 📋 Table of Contents

- [Color Categories](#color-categories)
- [Brand Colors](#brand-colors)
- [Adaptive Colors](#adaptive-colors)
- [Semantic Colors](#semantic-colors)
- [Color Usage Examples](#color-usage-examples)
- [When to Use Which Color](#when-to-use-which-color)

---

## 🎨 Color Categories

Micropack UI Kit provides 4 main color categories:

| Category | Colors | Purpose |
|----------|---------|---------|
| **Brand Colors** | 2 colors | Primary brand identity |
| **Adaptive Colors** | 7 colors | Automatically adapt to light/dark themes |
| **Semantic Colors** | 4 colors | Specific meanings (error, success, warning, info) |
| **Neutral Colors** | 10 colors | For reference only (DO NOT USE IN APP) |

> **⚠️ CRITICAL**: Always use **adaptive colors** (`context.mp.textColor`, `context.mp.cardColor`) instead of **fixed colors** (`context.mp.neutral90`). Fixed colors don't adapt to theme changes and will cause visibility issues.

---

## 💎 Brand Colors

Primary colors for your brand identity.

### MPPrimary

```dart
context.mp.primary
```

**Light Theme**: Your configured brand color (default: `#4086EF`)
**Dark Theme**: Your configured brand color (slightly darker: `#3B7CE6`)

**Usage**:
- Primary buttons
- Active states
- Brand accents
- Highlights
- Focused elements

**Examples**:
```dart
// Primary button
MPButton(
  text: 'Submit',
  variant: MPButtonVariant.primary,
  onPressed: _submit,
)

// Brand accent container
Container(
  color: context.mp.primary,
  padding: EdgeInsets.all(16),
  child: Text('Brand Accent', style: TextStyle(color: Colors.white)),
)

// Active tab
MPChip(
  label: 'Active',
  variant: MPChipVariant.primary,
  selected: true,
)
```

---

### MPPrimaryBorder

```dart
context.mp.primaryBorder
```

**Light Theme**: Slightly darker than primary (default: `#3B7CE6`)
**Dark Theme**: Even darker than primary (default: `#3573D9`)

**Usage**:
- Input borders (focused)
- Button borders (outlined)
- Active borders
- Highlighted dividers

**Examples**:
```dart
// Focused input
MPTextField(
  hintText: 'Email',
  focusColor: context.mp.primaryBorder,
)

// Outlined button
MPButton(
  text: 'Cancel',
  variant: MPButtonVariant.outlined,
  onPressed: _cancel,
)
```

---

## 🌗 Adaptive Colors

Colors that automatically adapt to light and dark themes. **ALWAYS USE THESE** for backgrounds, text, borders, and dividers.

### MPAdaptiveBackgroundColor

```dart
context.mp.adaptiveBackgroundColor
```

**Light Theme**: `#FAFAFA` (very light gray)
**Dark Theme**: `#121212` (very dark gray)

**Usage**:
- Scaffold backgrounds
- Page backgrounds
- Modal backgrounds
- Bottom sheet backgrounds
- Drawer backgrounds

**Examples**:
```dart
Scaffold(
  backgroundColor: context.mp.adaptiveBackgroundColor,
  body: HomePage(),
)

// Modal background
MPDialog.show(
  context: context,
  title: 'Dialog',
  // Dialog automatically uses adaptive background
)
```

---

### MPCardColor

```dart
context.mp.cardColor
```

**Light Theme**: `#FFFFFF` (white)
**Dark Theme**: `#1E1E1E` (dark gray)

**Usage**:
- Card backgrounds
- Elevation backgrounds
- Panel backgrounds
- Menu backgrounds
- Dropdown backgrounds

**Examples**:
```dart
MPCard(
  child: Column(
    children: [
      MPText.head('Card Title'),
      MPText.body('Card content'),
    ],
  ),
)

// Menu background
PopupMenuButton(
  color: context.mp.cardColor,
  itemBuilder: (context) => [
    PopupMenuItem(child: Text('Option 1')),
    PopupMenuItem(child: Text('Option 2')),
  ],
)
```

---

### MPTextColor

```dart
context.mp.textColor
```

**Light Theme**: `#1F2937` (dark gray - highly readable on light)
**Dark Theme**: `#F3F4F6` (light gray - highly readable on dark)

**Usage**:
- Primary text (headings, body)
- Important labels
- Button text
- Form labels
- **ALL TEXT** (except captions)

**Examples**:
```dart
// Headings
MPText.head('Main Heading')

// Body text
MPText.body('This is body text')

// Custom text
Text(
  'Custom styled text',
  style: TextStyle(color: context.mp.textColor),
)
```

---

### MPSubtitleColor

```dart
context.mp.subtitleColor
```

**Light Theme**: `#6B7280` (medium gray)
**Dark Theme**: `#9CA3AF` (light medium gray)

**Usage**:
- Subheadings
- Secondary text
- Descriptions
- Hints
- Placeholder text

**Examples**:
```dart
// Subheadings
MPText.subhead('This is a subheading')

// Secondary text
Text(
  'Secondary information',
  style: TextStyle(color: context.mp.subtitleColor),
)

// Hint text
MPTextField(
  hintText: 'Enter your email',  // Uses subtitle color
)
```

---

### MPCaptionColor

```dart
context.mp.captionColor
```

**Light Theme**: `#9CA3AF` (light gray)
**Dark Theme**: `#6B7280` (dark medium gray)

**Usage**:
- Captions
- Small labels
- Footer text
- Helper text
- Timestamps
- **SMALL TEXT ONLY**

**Examples**:
```dart
// Captions
MPText.small('This is a caption')

// Timestamps
Text(
  '2 hours ago',
  style: TextStyle(color: context.mp.captionColor, fontSize: 12),
)

// Helper text
Text(
  'Required field',
  style: TextStyle(color: context.mp.captionColor, fontSize: 10),
)
```

---

### MPBorderColor

```dart
context.mp.borderColor
```

**Light Theme**: `#E5E7EB` (light gray)
**Dark Theme**: `#374151` (dark gray)

**Usage**:
- Card borders
- Input borders (unfocused)
- Divider lines
- Separator lines
- Menu borders

**Examples**:
```dart
// Card border
Container(
  decoration: BoxDecoration(
    border: Border.all(color: context.mp.borderColor),
    borderRadius: BorderRadius.circular(12),
  ),
  child: MPText.body('Bordered content'),
)

// Divider
Divider(color: context.mp.borderColor)
```

---

### MPDividerColor

```dart
context.mp.dividerColor
```

**Light Theme**: `#E5E7EB` (same as border)
**Dark Theme**: `#374151` (same as border)

**Usage**:
- Horizontal dividers
- Vertical dividers
- Section separators
- List separators

**Examples**:
```dart
// Horizontal divider
Divider(color: context.mp.dividerColor)

// Vertical divider
VerticalDivider(color: context.mp.dividerColor)

// Between list items
ListView.separated(
  separatorBuilder: (context, index) => Divider(color: context.mp.dividerColor),
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(title: Text(items[index])),
)
```

---

## 🎯 Semantic Colors

Pre-defined colors for specific meanings and states.

### MPErrorColor

```dart
context.mp.errorColor
```

**Light Theme**: `#EF4444` (red)
**Dark Theme**: `#F87171` (light red)

**Usage**:
- Error messages
- Validation errors
- Failed states
- Delete actions
- Danger zones

**Examples**:
```dart
// Error message
Text(
  'Something went wrong',
  style: TextStyle(color: context.mp.errorColor),
)

// Error snackbar
MPSnackbar.show(
  context: context,
  message: 'Error: Invalid email',
  variant: MPSnackbarVariant.error,
)

// Delete button
MPButton(
  text: 'Delete',
  variant: MPButtonVariant.danger,
  onPressed: _delete,
)

// Error icon
Icon(Icons.error, color: context.mp.errorColor)
```

---

### MPSuccessColor

```dart
context.mp.successColor
```

**Light Theme**: `#10B981` (green)
**Dark Theme**: `#34D399` (light green)

**Usage**:
- Success messages
- Completed states
- Valid inputs
- Positive actions
- Confirmed states

**Examples**:
```dart
// Success message
Text(
  'Completed successfully!',
  style: TextStyle(color: context.mp.successColor),
)

// Success toast
MPToast.show(
  context: context,
  message: 'Saved!',
  type: MPToastType.success,
)

// Success badge
MPBadge(
  label: 'Verified',
  backgroundColor: context.mp.successColor,
)

// Success icon
Icon(Icons.check_circle, color: context.mp.successColor)
```

---

### MPWarningColor

```dart
context.mp.warningColor
```

**Light Theme**: `#F59E0B` (orange)
**Dark Theme**: `#FBBF24` (light orange)

**Usage**:
- Warning messages
- Pending states
- Attention required
- Caution zones
- Action needed

**Examples**:
```dart
// Warning message
Text(
  'Please review before proceeding',
  style: TextStyle(color: context.mp.warningColor),
)

// Warning toast
MPToast.show(
  context: context,
  message: 'Unsaved changes',
  type: MPToastType.warning,
)

// Warning icon
Icon(Icons.warning, color: context.mp.warningColor)

// Warning badge
MPBadge(
  label: 'Warning',
  backgroundColor: context.mp.warningColor,
)
```

---

### MPInfoColor

```dart
context.mp.infoColor
```

**Light Theme**: `#3B82F6` (blue)
**Dark Theme**: `#60A5FA` (light blue)

**Usage**:
- Information messages
- Help text
- Notes
- Tips
- Information icons

**Examples**:
```dart
// Info message
Text(
  'Tip: You can save your changes anytime',
  style: TextStyle(color: context.mp.infoColor),
)

// Info toast
MPToast.show(
  context: context,
  message: 'Feature available in Pro',
  type: MPToastType.info,
)

// Info icon
Icon(Icons.info, color: context.mp.infoColor)

// Info badge
MPBadge(
  label: 'Info',
  backgroundColor: context.mp.infoColor,
)
```

---

## 🎨 Color Usage Examples

### Example 1: Complete Card with All Colors

```dart
MPCard(
  elevation: true,
  child: Column(
    children: [
      // Heading with primary color
      Row(
        children: [
          Icon(Icons.star, color: context.mp.primary),
          SizedBox(width: 8),
          MPText.head('Card Title'),
        ],
      ),
      SizedBox(height: 12),
      // Body text
      MPText.body('This is the card body text.'),
      // Caption
      MPText.small('Last updated 2 hours ago'),
      SizedBox(height: 16),
      // Divider
      Divider(color: context.mp.dividerColor),
      SizedBox(height: 16),
      // Success message
      Row(
        children: [
          Icon(Icons.check_circle, color: context.mp.successColor, size: 16),
          SizedBox(width: 8),
          MPText.label('Status: Verified', style: TextStyle(color: context.mp.successColor)),
        ],
      ),
    ],
  ),
)
```

### Example 2: Form with All Colors

```dart
Form(
  child: Column(
    children: [
      // Form label
      MPText.label('Email Address'),
      SizedBox(height: 8),
      // Input (uses subtitle color for hint)
      MPTextField(
        hintText: 'Enter your email',
        prefixIcon: Icons.email,
      ),
      SizedBox(height: 16),
      // Form label
      MPText.label('Password'),
      SizedBox(height: 8),
      // Input
      MPTextField(
        hintText: 'Enter your password',
        obscureText: true,
        prefixIcon: Icons.lock,
      ),
      SizedBox(height: 24),
      // Error message
      Text(
        'Password must be at least 8 characters',
        style: TextStyle(color: context.mp.errorColor, fontSize: 12),
      ),
      SizedBox(height: 16),
      // Primary button
      MPButton(
        text: 'Sign In',
        variant: MPButtonVariant.primary,
        width: double.infinity,
        onPressed: _signIn,
      ),
      SizedBox(height: 8),
      // Info message
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info, color: context.mp.infoColor, size: 16),
          SizedBox(width: 8),
          MPText.label('We\'ll never share your password'),
        ],
      ),
    ],
  ),
)
```

### Example 3: Status Badges with All Semantic Colors

```dart
Row(
  children: [
    // Success badge
    Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: context.mp.successColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mp.successColor),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: context.mp.successColor, size: 14),
          SizedBox(width: 6),
          MPText.label('Success', style: TextStyle(color: context.mp.successColor)),
        ],
      ),
    ),
    SizedBox(width: 12),
    // Warning badge
    Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: context.mp.warningColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mp.warningColor),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: context.mp.warningColor, size: 14),
          SizedBox(width: 6),
          MPText.label('Warning', style: TextStyle(color: context.mp.warningColor)),
        ],
      ),
    ),
    SizedBox(width: 12),
    // Error badge
    Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: context.mp.errorColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mp.errorColor),
      ),
      child: Row(
        children: [
          Icon(Icons.error, color: context.mp.errorColor, size: 14),
          SizedBox(width: 6),
          MPText.label('Error', style: TextStyle(color: context.mp.errorColor)),
        ],
      ),
    ),
    SizedBox(width: 12),
    // Info badge
    Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: context.mp.infoColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mp.infoColor),
      ),
      child: Row(
        children: [
          Icon(Icons.info, color: context.mp.infoColor, size: 14),
          SizedBox(width: 6),
          MPText.label('Info', style: TextStyle(color: context.mp.infoColor)),
        ],
      ),
    ),
  ],
)
```

---

## 📖 When to Use Which Color

### Decision Tree

```
Need a color?
│
├─ For background?
│  ├─ Scaffold/Page?
│  │  └─ context.mp.adaptiveBackgroundColor
│  ├─ Card/Panel/Menu?
│  │  └─ context.mp.cardColor
│  └─ Other background?
│     └─ context.mp.cardColor (or lighter variant)
│
├─ For text?
│  ├─ Heading/Body/Primary?
│  │  └─ context.mp.textColor
│  ├─ Subheading/Secondary?
│  │  └─ context.mp.subtitleColor
│  └─ Caption/Small/Helper?
│     └─ context.mp.captionColor
│
├─ For border/divider?
│  ├─ Border/Outline?
│  │  └─ context.mp.borderColor
│  └─ Divider/Separator?
│     └─ context.mp.dividerColor
│
├─ For specific meaning?
│  ├─ Error/Failed/Danger?
│  │  └─ context.mp.errorColor
│  ├─ Success/Completed/Confirmed?
│  │  └─ context.mp.successColor
│  ├─ Warning/Pending/Attention?
│  │  └─ context.mp.warningColor
│  └─ Info/Help/Tip?
│     └─ context.mp.infoColor
│
└─ For brand accent?
   ├─ Primary/Brand color?
   │  └─ context.mp.primary
   └─ Border/Outline for brand?
      └─ context.mp.primaryBorder
```

### Quick Reference Table

| Use Case | Color | Example |
|-----------|--------|----------|
| **App Background** | `context.mp.adaptiveBackgroundColor` | Scaffold background |
| **Card Background** | `context.mp.cardColor` | Card, Panel, Menu |
| **Primary Text** | `context.mp.textColor` | Headings, Body text |
| **Secondary Text** | `context.mp.subtitleColor` | Subheadings, Hints |
| **Caption Text** | `context.mp.captionColor` | Small labels, Footer |
| **Borders** | `context.mp.borderColor` | Card borders, Input borders |
| **Dividers** | `context.mp.dividerColor` | Horizontal/Vertical dividers |
| **Error** | `context.mp.errorColor` | Error messages, Danger |
| **Success** | `context.mp.successColor` | Success messages, Checkmarks |
| **Warning** | `context.mp.warningColor` | Warnings, Pending states |
| **Info** | `context.mp.infoColor` | Info messages, Help |
| **Brand** | `context.mp.primary` | Primary buttons, Accents |
| **Brand Border** | `context.mp.primaryBorder` | Focused inputs, Outlined buttons |

---

## 🔗 Related Documentation

- [Theme System Guide](./theming.md)
- [Getting Started](../getting-started/README.md)
- [Best Practices](./best-practices.md)
- [Component API Reference](../api/README.md)

## 🆘 Need Help?

- Check [Theme System Guide](./theming.md) for complete theming information
- Review [Best Practices](./best-practices.md) for color usage patterns
- Search [GitHub Issues](https://github.com/ajianaz/micropack-ui-kit/issues)
