# Theme Rules & Guidelines

> **⚠️ CRITICAL**: Follow these rules to ensure your components work correctly in both light and dark themes.

## Table of Contents
- [Golden Rules](#golden-rules)
- [Color Usage](#color-usage)
- [Component Theming](#component-theming)
- [Common Mistakes](#common-mistakes)
- [Testing Checklist](#testing-checklist)

---

## 🎯 Golden Rules

### Rule #1: Always Use Adaptive Colors

**NEVER use fixed neutral colors for backgrounds, text, or borders.**

```dart
// ✅ CORRECT
Container(
  color: context.mp.adaptiveBackgroundColor,
  child: Text('Hello', style: TextStyle(color: context.mp.textColor)),
)

// ❌ WRONG - Fixed colors don't adapt!
Container(
  color: context.mp.neutral90,
  child: Text('Hello', style: TextStyle(color: context.mp.neutral20)),
)
```

**Why?** Fixed colors like `neutral90` are ALWAYS the same color regardless of theme mode. This causes:
- Text invisible in dark mode (dark gray on dark gray)
- Low contrast in light mode
- Poor accessibility

---

### Rule #2: Use Semantic Color Names

Use semantic names that describe the purpose, not the color value.

```dart
// ✅ CORRECT - Clear purpose
color: context.mp.textColor        // Primary text
color: context.mp.subtitleColor   // Secondary text
color: context.mp.captionColor    // Caption text
color: context.mp.cardColor        // Card background

// ❌ WRONG - Unclear purpose
color: context.mp.neutral90        // What is this for?
color: context.mp.neutral70        // When to use this?
color: context.mp.neutral20        // Ambiguous
```

---

### Rule #3: Never Hardcode Colors

**ALWAYS use `context.mp.*` for colors. Never use `Colors.white`, `Colors.black`, or hex values directly.**

```dart
// ✅ CORRECT
Icon(Icons.home, color: context.mp.subtitleColor)
BoxShadow(color: context.mp.adaptiveShadowColor.withValues(alpha: 0.1))

// ❌ WRONG - Hardcoded colors
Icon(Icons.home, color: Color(0xFF6B7280))
BoxShadow(color: Colors.black.withValues(alpha: 0.1))
```

**Exception:** White text on colored backgrounds (primary buttons, badges, chips) is OK because it provides necessary contrast.

---

### Rule #4: Use Adaptive Shadow Colors

Shadows must adapt to theme for proper visibility.

```dart
// ✅ CORRECT
BoxShadow(
  color: context.mp.adaptiveShadowColor.withValues(alpha: 0.1),
  blurRadius: 8,
  offset: Offset(0, 2),
)

// ❌ WRONG - Black shadow invisible in dark mode
BoxShadow(
  color: Colors.black.withValues(alpha: 0.1),
  blurRadius: 8,
  offset: Offset(0, 2),
)
```

---

## 🎨 Color Usage

### Background Colors

| Use Case | Property | Light | Dark |
|----------|----------|-------|------|
| Page background | `context.mp.adaptiveBackgroundColor` | White | Black |
| Card background | `context.mp.cardColor` | White | Dark Gray |
| Input background | `context.mp.inputBackgroundColor` | Light Gray | Dark Gray |
| Surface | `context.mp.surfaceColor` | Light Gray | Dark Gray |

### Text Colors

| Use Case | Property | Light | Dark |
|----------|----------|-------|------|
| Headings | `context.mp.textColor` | Black | White |
| Body text | `context.mp.textColor` | Black | White |
| Secondary text | `context.mp.subtitleColor` | Medium Gray | Light Gray |
| Captions | `context.mp.captionColor` | Light Gray | Medium Gray |
| Disabled | `context.mp.disabledColor` | Very Light | Medium Gray |

### Border & Divider Colors

| Use Case | Property |
|----------|----------|
| Borders | `context.mp.borderColor` |
| Dividers | `context.mp.dividerColor` |
| Focus rings | `context.mp.primary` |
| Error borders | `context.mp.errorColor` |

### Semantic Colors

| Use Case | Property |
|----------|----------|
| Error | `context.mp.errorColor` |
| Success | `context.mp.successColor` |
| Warning | `context.mp.warningColor` |
| Info | `context.mp.infoColor` |

---

## 🧩 Component Theming

### Container/Card Pattern

```dart
Container(
  decoration: BoxDecoration(
    color: context.mp.cardColor,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: context.mp.borderColor,
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: context.mp.adaptiveShadowColor.withValues(alpha: 0.05),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: Text(
    'Content',
    style: TextStyle(color: context.mp.textColor),
  ),
)
```

### Scaffold Pattern

```dart
Scaffold(
  backgroundColor: context.mp.adaptiveBackgroundColor,
  appBar: AppBar(
    title: Text('Title', style: TextStyle(color: context.mp.textColor)),
    backgroundColor: context.mp.adaptiveBackgroundColor,
  ),
  body: YourContent(),
)
```

### Icon Pattern

```dart
// ✅ CORRECT - Icon with semantic color
Icon(Icons.home, color: context.mp.subtitleColor)
Icon(Icons.settings, color: context.mp.primary)

// ❌ WRONG - Icon without color (may be invisible)
Icon(Icons.home)
Icon(Icons.settings)
```

### PopupMenu Pattern

```dart
PopupMenuButton<ThemeMode>(
  icon: Icon(Icons.more_vert, color: context.mp.textColor),
  surfaceTintColor: Colors.transparent,  // Critical: Remove Material 3 tint
  color: context.mp.cardColor,
  itemBuilder: (context) => [
    PopupMenuItem(value: 1, child: Text('Option 1')),
    PopupMenuItem(value: 2, child: Text('Option 2')),
  ],
)
```

---

## ❌ Common Mistakes

### Mistake #1: Using Fixed Neutral Colors

```dart
// ❌ WRONG
Text('Title', style: TextStyle(color: context.mp.neutral90))
Container(color: context.mp.neutral20)

// ✅ CORRECT
Text('Title', style: TextStyle(color: context.mp.textColor))
Container(color: context.mp.cardColor)
```

### Mistake #2: Hardcoded Colors

```dart
// ❌ WRONG
Icon(Icons.home, color: Color(0xFF6B7280))
BoxShadow(color: Colors.black.withValues(alpha: 0.1))

// ✅ CORRECT
Icon(Icons.home, color: context.mp.subtitleColor)
BoxShadow(color: context.mp.adaptiveShadowColor.withValues(alpha: 0.1))
```

### Mistake #3: Wrong Shadow Colors

```dart
// ❌ WRONG - Uses Colors.black
BoxShadow(
  color: Colors.black.withValues(alpha: 0.1),
  blurRadius: 8,
)

// ✅ CORRECT - Uses adaptive shadow
BoxShadow(
  color: context.mp.adaptiveShadowColor.withValues(alpha: 0.1),
  blurRadius: 8,
)
```

### Mistake #4: Using TextField Without Theme

```dart
// ❌ WRONG - TextField doesn't use theme
TextField(
  style: TextStyle(color: Colors.black),
  decoration: InputDecoration(
    fillColor: Colors.grey[100],
  ),
)

// ✅ CORRECT - Use MPTextField
MPTextField(
  // Automatically uses theme colors
)
```

### Mistake #5: Forgetting PopupMenu Colors

```dart
// ❌ WRONG - No colors (bad in dark mode)
PopupMenuButton(
  icon: Icon(Icons.more_vert),
  itemBuilder: (context) => [...],
)

// ✅ CORRECT - Proper themed
PopupMenuButton(
  icon: Icon(Icons.more_vert, color: context.mp.textColor),
  surfaceTintColor: Colors.transparent,
  color: context.mp.cardColor,
  itemBuilder: (context) => [...],
)
```

---

## ✅ Testing Checklist

Before committing any UI code, verify:

### Visual Testing
- [ ] All text is visible in light mode
- [ ] All text is visible in dark mode
- [ ] Icons are visible in both modes
- [ ] Cards have proper contrast
- [ ] Borders are visible but not harsh
- [ ] Shadows are subtle in both modes

### Functional Testing
- [ ] Theme toggle works smoothly
- [ ] No flickering when switching themes
- [ ] All components update their colors
- [ ] PopupMenus display correctly in both modes
- [ ] TextFields maintain readability

### Accessibility Testing
- [ ] Contrast ratios meet WCAG AA (4.5:1)
- [ ] Screen reader works correctly
- [ ] Semantic labels are present
- [ ] Focus indicators are visible

### Code Review Checklist
- [ ] No `Colors.white` or `Colors.black` (except for contrast)
- [ ] No hardcoded hex colors like `Color(0xFF6B7280)`
- [ ] No fixed neutral colors (`neutral90`, `neutral70`, etc.)
- [ ] All shadows use `context.mp.adaptiveShadowColor`
- [ ] All backgrounds use adaptive colors
- [ ] All text uses semantic color names

---

## 📚 Quick Reference Card

```dart
// Copy-paste these into your component

// Backgrounds
context.mp.adaptiveBackgroundColor  // Page background
context.mp.cardColor               // Card background
context.mp.surfaceColor             // Surface background

// Text
context.mp.textColor               // Primary text
context.mp.subtitleColor          // Secondary text
context.mp.captionColor           // Captions & hints
context.mp.disabledColor          // Disabled text

// Borders
context.mp.borderColor             // Borders & dividers
context.mp.primary                 // Focus/active states

// Semantic
context.mp.errorColor             // Errors
context.mp.successColor           // Success
context.mp.warningColor           // Warnings
context.mp.infoColor                // Information

// Special
context.mp.adaptiveShadowColor    // Shadows (add alpha)
context.mp.primary                 // Brand color
```

---

## 🚨 Critical Warnings

### ⚠️ NEVER Use These

```dart
// ❌ Fixed neutral colors - DON'T USE
context.mp.neutral10   through   context.mp.neutral100

// ❌ Hardcoded colors - DON'T USE
Colors.white
Colors.black
Color(0xFF123456)

// ❌ Default Icons - DON'T USE
Icon(Icons.home)              // Missing color
Icon(Icons.settings)         // Missing color
```

### ✅ Always Use These Instead

```dart
// ✅ Adaptive colors - USE THESE
context.mp.adaptiveBackgroundColor
context.mp.cardColor
context.mp.textColor
context.mp.subtitleColor

// ✅ Proper icons - USE THESE
Icon(Icons.home, color: context.mp.subtitleColor)
Icon(Icons.settings, color: context.mp.primary)

// ✅ Theme-aware shadows - USE THESE
context.mp.adaptiveShadowColor.withValues(alpha: 0.1)
```

---

## 🔗 Related Documentation

- [Theme System Guide](./theming.md) - Complete theming guide
- [Theme Colors Quick Reference](./theme-colors-quick-reference.md)
- [Best Practices Guide](./best-practices.md)
- [Troubleshooting Guide](./troubleshooting.md)

---

**Last Updated:** 2025-12-24
**Version:** 1.0.0
