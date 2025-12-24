# Component Quick Reference Card

Quick reference card for all Micropack UI Kit components. Print this or keep it open for fast component lookup.

## 🔘 Basic Components

| Component | Quick Use | Import | Demo |
|-----------|-----------|---------|-------|
| **MPButton** | Buttons, CTA | `import 'package:micropack_ui_kit/micropack_ui_kit.dart';` | [Demo](../../example/lib/pages/button_page.dart) |
| **MPCard** | Content containers | Same | [Demo](../../example/lib/pages/mp_card_page.dart) |
| **MPText** | Typography | Same | [Demo](../../example/lib/pages/typography_page.dart) |
| **MPTextField** | Form inputs | Same | [Demo](../../example/lib/pages/textfield_page.dart) |

### MPButton - Quick Props
```dart
MPButton(
  text: 'Click Me',
  variant: MPButtonVariant.primary,  // primary, outlined, ghost, text, danger
  size: MPButtonSize.medium,          // small, regular, medium, large
  onPressed: () {},
)
```

### MPText - Quick Styles
```dart
MPText.head('Headline')      // H1, headings
MPText.subhead('Subhead')    // H2, subtitles
MPText.body('Body')          // Paragraph, main text
MPText.label('Label')        // Form labels, small text
MPText.small('Caption')      // Captions, hints
```

### MPTextField - Quick Usage
```dart
MPTextField(
  hintText: 'Enter text',
  controller: _controller,
  prefixIcon: Icons.search,       // Icon before input
  obscureText: false,           // Hide text (password)
  validator: (v) => null,     // Validation
)
```

---

## 📝 Form Components

| Component | Quick Use | Import | Demo |
|-----------|-----------|---------|-------|
| **MPCheckbox** | Checkboxes, toggles | Same | [Demo](../../example/lib/pages/checkbox_demo_page.dart) |
| **MPSwitch** | Toggle switches | Same | [Demo](../../example/lib/pages/switch_demo_page.dart) |
| **MPBadge** | Status indicators | Same | [Demo](../../example/lib/pages/badge_demo_page.dart) |
| **MPChip** | Tags, labels | Same | [Demo](../../example/lib/pages/chip_demo_page.dart) |
| **MPDropdown** | Select inputs | Same | [Demo](../../example/lib/pages/dropdown_demo_page.dart) |
| **MPTooltip** | Tooltips | Same | [Demo](../../example/lib/pages/tooltip_demo_page.dart) |
| **MPProgress** | Loading bars | Same | [Demo](../../example/lib/pages/progress_demo_page.dart) |
| **MPSnackbar** | Notifications | Same | [Demo](../../example/lib/pages/snackbar_demo_page.dart) |
| **MPSkeleton** | Loading placeholders | Same | [Demo](../../example/lib/pages/skeleton_demo_page.dart) |
| **MPStepper** | Multi-step forms | Same | [Demo](../../example/lib/pages/new_components_demo_page.dart) |

### MPCheckbox - Quick Props
```dart
MPCheckbox(
  value: _checked,
  onToggle: (v) => setState(() => _checked = v ?? false),
  size: MPCheckboxSize.medium,  // small, medium, large
  tristate: false,            // Enable null/indeterminate
)
```

### MPSwitch - Quick Props
```dart
MPSwitch(
  value: _isOn,
  onToggle: (v) => setState(() => _isOn = v),
  size: MPSwitchSize.medium,    // small, medium, large
  disabled: false,             // Disable switch
)
```

### MPBadge - Quick Props
```dart
MPBadge(
  label: 'New',
  variant: MPBadgeVariant.primary,  // standard, dot, notification
  size: MPBadgeSize.medium,       // small, medium, large
  leading: Icon(Icons.star),      // Icon before
)

// Variants
MPBadge.dot()                           // Just dot
MPBadge.notification(label: '5')      // Notification style
```

### MPChip - Quick Props
```dart
MPChip(
  label: 'Flutter',
  variant: MPChipVariant.default,  // default, primary, outlined, filter
  selected: false,                 // Selected state
  avatar: CircleAvatar(...),       // Avatar
  onDeleted: () {},               // Closable
)

// Filter chip (with selected state)
MPChip(
  label: 'All',
  variant: MPChipVariant.filter,
  selected: _isSelected,
  onTap: () => setState(() => _isSelected = !_isSelected),
)
```

### MPProgress - Quick Usage
```dart
// Linear progress
MPProgressBar(
  value: 0.7,        // 0.0 to 1.0
)

// Indeterminate
const MPProgressBar()

// Circular
MPCircularProgress(
  value: 0.5,
)

// Indeterminate circular
const MPCircularProgress()
```

### MPDropdown - Quick Props
```dart
MPDropdown<String>(
  hint: 'Select',
  value: _selected,
  items: const [
    DropdownItem(value: 'us', label: 'United States'),
    DropdownItem(value: 'uk', label: 'United Kingdom'),
  ],
  searchable: true,          // Enable search
  multiSelect: false,        // Enable multiple selection
  onChanged: (v) => setState(() => _selected = v),
)
```

### MPTooltip - Quick Props
```dart
MPTooltip(
  message: 'Help text',
  position: MPTooltipPosition.top,  // top, bottom, left, right
  icon: Icons.info,               // Icon in tooltip
  child: Icon(Icons.help),
)
```

### MPSnackbar - Quick Props
```dart
MPSnackbar.show(
  context: context,
  message: 'Saved!',
  variant: MPSnackbarVariant.success,  // success, error, info, warning
  position: MPSnackbarPosition.bottom,   // top, bottom
  duration: Duration(seconds: 3),       // Duration
  action: MPSnackbarAction(           // Action button
    label: 'UNDO',
    onPressed: () => _undo(),
  ),
)
```

### MPSkeleton - Quick Types
```dart
// Text line
MPSkeleton(type: MPSkeletonType.line, width: 200)

// Avatar circle
MPSkeleton(type: MPSkeletonType.circle, size: 64)

// Image rect
MPSkeleton(type: MPSkeletonType.rect, width: 200, height: 150)
```

### MPStepper - Quick Props
```dart
MPStepper(
  steps: [
    MPStep(
      title: Text('Step 1'),
      subtitle: Text('Description'),
      content: _step1Content,
    ),
    MPStep(
      title: Text('Step 2'),
      content: _step2Content,
    ),
  ],
  currentStep: _currentStep,
  type: StepperType.vertical,  // vertical, horizontal
  onContinue: () => setState(() => _currentStep++),
  onCancel: () => setState(() => _currentStep--),
)
```

---

## 💬 Feedback Components

| Component | Quick Use | Import | Demo |
|-----------|-----------|---------|-------|
| **MPToast** | Quick notifications | Same | [Demo](../../example/lib/pages/toast_page.dart) |
| **MPSnackbar** | Snackbar notifications | Same | [Demo](../../example/lib/pages/snackbar_demo_page.dart) |

### MPToast - Quick Usage
```dart
MPToast.show(
  context: context,
  message: 'Hello World',
  type: MPToastType.info,      // info, success, warning, error
  duration: Duration(seconds: 2), // Display duration
)
```

---

## 🧭 Navigation Components

| Component | Quick Use | Import | Demo |
|-----------|-----------|---------|-------|
| **MPDialog** | Modal dialogs | Same | [Demo](../../example/lib/pages/dialog_page.dart) |
| **MPBottomSheet** | Bottom modals | Same | [Demo](../../example/lib/pages/bottom_sheet_demo_page.dart) |
| **MPAppBar** | App bars | Same | [Demo](../../example/lib/pages/app_bar_demo_page.dart) |
| **MPNavigationRail** | Desktop sidebar | Same | [Demo](../../example/lib/pages/navigation_rail_demo_page.dart) |
| **MPTab** | Tabs | Same | [Demo](../../example/lib/pages/tab_page.dart) |
| **MPPlatformAdaptive** | Platform-specific | Same | [Demo](../../example/lib/pages/platform_adaptive_demo_page.dart) |

### MPDialog - Quick Usage
```dart
MPDialog.show(
  context: context,
  title: 'Confirm',
  content: 'Are you sure?',
  type: DialogType.warning,      // info, success, warning, error
  confirmText: 'OK',
  cancelText: 'Cancel',
  onConfirm: () => _confirm(),
)
```

---

## 📰 Display Components

| Component | Quick Use | Import | Demo |
|-----------|-----------|---------|-------|
| **MPListTile** | List items | Same | [Demo](../../example/lib/pages/list_tile_demo_page.dart) |
| **MPAvatar** | User avatars | Same | [Demo](../../example/lib/pages/avatar_demo_page.dart) |
| **MPDivider** | Dividers | Same | [Demo](../../example/lib/pages/divider_demo_page.dart) |
| **MPEmptyState** | Empty states | Same | [Demo](../../example/lib/pages/empty_state_demo_page.dart) |
| **MPSkeleton** | Loading placeholders | Same | [Demo](../../example/lib/pages/skeleton_demo_page.dart) |
| **MPArticleCard** | Article cards | Same | [Demo](../../example/lib/pages/article_card_page.dart) |
| **MPCarousel** | Image/content slider | Same | [Demo](../../example/lib/pages/new_components_demo_page.dart) |
| **MPSlidable** | Swipeable list items | Same | [Demo](../../example/lib/pages/new_components_demo_page.dart) |
| **MPExpansionTile** | Expandable cards | Same | [Demo](../../example/lib/pages/new_components_demo_page.dart) |
| **MPDataTable** | Data tables | Same | [Demo](../../example/lib/pages/new_components_demo_page.dart) |

### MPCarousel - Quick Props
```dart
MPCarousel(
  items: _items,
  variant: MPCarouselVariant.standard,  // standard, fullWidth, compact, hero
  autoPlay: true,                       // Auto-scroll
  infiniteScroll: true,                 // Infinite loop
  onPageChanged: (index, reason) {},    // Page change callback
)
```

### MPSlidable - Quick Props
```dart
MPSlidable(
  child: _listItemWidget,
  startActions: [
    MPSlidableAction(
      icon: Icons.archive,
      label: 'Archive',
      isDestructive: false,
      onPressed: (context) {},
    ),
  ],
  endActions: [
    MPSlidableAction(
      icon: Icons.delete,
      label: 'Delete',
      isDestructive: true,
      onPressed: (context) {},
    ),
  ],
)
```

### MPExpansionTile - Quick Props
```dart
MPExpansionTile(
  title: Text('Title'),
  subtitle: Text('Subtitle'),
  leading: Icon(Icons.info),
  initiallyExpanded: false,
  children: [
    Padding(
      padding: EdgeInsets.all(16),
      child: Text('Expanded content'),
    ),
  ],
)
```

### MPDataTable - Quick Props
```dart
MPDataTable(
  columns: [
    MPDataColumn(label: 'Name'),
    MPDataColumn(label: 'Age', numeric: true),
  ],
  rows: [
    ['John', '30'],
    ['Jane', '25'],
  ],
)
```

### MPAvatar - Quick Props
```dart
MPAvatar(
  image: NetworkImage('url'),    // Image
  name: 'John Doe',              // Name for initials
  initials: 'JD',               // Custom initials
  size: 64,                      // Size
  onTap: () {},                  // Clickable
)
```

### MPSkeleton - Types
```dart
MPSkeleton(type: MPSkeletonType.line)   // Text line
MPSkeleton(type: MPSkeletonType.circle) // Avatar
MPSkeleton(type: MPSkeletonType.rect)   // Image/card
```

---

## 🎨 Theme Quick Reference

### Accessing Theme Colors
```dart
context.mp.primary                    // Primary brand color
context.mp.primaryBorder             // Primary border color
context.mp.textColor                 // Adaptive text color
context.mp.subtitleColor            // Secondary text
context.mp.captionColor             // Caption text
context.mp.adaptiveBackgroundColor // Background color
context.mp.adaptiveBorderColor      // Border color
context.mp.cardColor               // Card background
context.mp.borderColor             // Border color
context.mp.dividerColor            // Divider color
context.mp.errorColor              // Error color
context.mp.successColor            // Success color
context.mp.warningColor            // Warning color
context.mp.infoColor               // Info color
```

### Common Use Cases
```dart
// Container background
Container(color: context.mp.adaptiveBackgroundColor)

// Card
MPCard(child: ...)

// Text color
Text('Hello', style: TextStyle(color: context.mp.textColor))

// Border
BorderBorder(color: context.mp.borderColor)

// Error message
Text('Error!', style: TextStyle(color: context.mp.errorColor))
```

---

## 🔧 Text Style Quick Reference

### MPTextStyle Static Methods
```dart
MPTextStyle.heading1({color, fontWeight})    // 32px, bold
MPTextStyle.heading2({color, fontWeight})    // 28px, bold
MPTextStyle.heading3({color, fontWeight})    // 24px, bold
MPTextStyle.heading4({color, fontWeight})    // 20px, semibold
MPTextStyle.heading5({color, fontWeight})    // 18px, medium
MPTextStyle.heading6({color, fontWeight})    // 16px, medium
MPTextStyle.body({color})                    // 14px, regular
MPTextStyle.label({color})                  // 12px, medium
MPTextStyle.caption({color})               // 10px, regular
```

### MPText Components
```dart
MPText.head('Headline')          // Uses heading4 (20px, semibold)
MPText.subhead('Subhead')      // Uses heading5 (18px, medium)
MPText.body('Body text')         // Uses body (14px, regular)
MPText.label('Label text')       // Uses label (12px, medium)
MPText.small('Caption')         // Uses caption (10px, regular)
```

---

## 📐 Size Quick Reference

### Button Sizes
- `small` - 32px height
- `regular` - 40px height
- `medium` - 44px height (default)
- `large` - 52px height

### Badge Sizes
- `small` - Compact
- `medium` - Default
- `large` - Prominent

### Checkbox Sizes
- `small` - 18px check box
- `medium` - 22px check box (default)
- `large` - 26px check box

### Switch Sizes
- `small` - 32px toggle
- `medium` - 40px toggle (default)
- `large` - 48px toggle

---

## 🚀 Quick Common Patterns

### Form with Validation
```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      MPTextField(
        hintText: 'Email',
        controller: _email,
        validator: (v) => v?.isEmpty ? 'Required' : null,
      ),
      MPButton(
        text: 'Submit',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Submit
          }
        },
      ),
    ],
  ),
)
```

### Card with Content
```dart
MPCard(
  elevation: true,
  child: Column(
    children: [
      MPText.head('Title'),
      MPText.body('Description'),
    ],
  ),
)
```

### Button with Loading
```dart
MPButton(
  text: _loading ? 'Saving...' : 'Save',
  loading: _loading,
  onPressed: _loading ? null : _save,
)
```

### Snackbar with Action
```dart
MPSnackbar.show(
  context: context,
  message: 'Deleted',
  action: MPSnackbarAction(
    label: 'UNDO',
    onPressed: _undo,
  ),
)
```

---

## 🆘 Need Help?

- [Getting Started](../getting-started/README.md)
- [Component API](../api/README.md)
- [Best Practices](../guides/best-practices.md)
- [GitHub Issues](https://github.com/ajianaz/micropack-ui-kit/issues)
