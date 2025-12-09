# 🎨 Micropack UI Kit - Theme Color Quick Reference

## ⚡ Quick Start

### **Always Use Adaptive Colors**
```dart
// ✅ CORRECT - Adaptive colors
Text('Hello', style: TextStyle(color: context.mp.textColor))
Container(color: context.mp.cardColor)
Icon(Icons.star, color: context.mp.subtitleColor)

// ❌ WRONG - Fixed colors
Text('Hello', style: TextStyle(color: context.mp.neutral90))
Container(color: context.mp.neutral20)
Icon(Icons.star, color: context.mp.neutral70)
```

---

## 📋 Color Cheat Sheet

### **Text Colors**
```dart
// Primary text (headings, important content)
context.mp.textColor          // Black in light, White in dark

// Secondary text (descriptions, labels)
context.mp.subtitleColor      // Gray in light, Light gray in dark

// Tertiary text (hints, captions)
context.mp.captionColor       // Light gray in light, Medium gray in dark

// Disabled text
context.mp.disabledColor      // Very light gray in both modes
```

### **Background Colors**
```dart
// Page background
context.mp.backgroundColor           // White in light, Black in dark
context.mp.adaptiveBackgroundColor   // Same as above

// Card/Surface background
context.mp.cardColor                 // White in light, Dark gray in dark

// Primary surface (highlighted areas)
context.mp.primarySurface            // Light indigo in both modes
```

### **Border & Divider Colors**
```dart
// Borders
context.mp.borderColor               // Light gray in light, Medium gray in dark
context.mp.adaptiveBorderColor       // Same as above

// Dividers
context.mp.dividerColor              // Very light gray in light, Dark gray in dark
```

### **Semantic Colors**
```dart
// Success (always green)
context.mp.successColor              // #10B981
context.mp.successBackgroundColor    // #D1FAE5

// Warning (always amber)
context.mp.warningColor              // #F59E0B
context.mp.warningBackgroundColor    // #FEF3C7

// Error (always red)
context.mp.errorColor                // #EF4444
context.mp.errorBackgroundColor      // #FEE2E2

// Info (always blue)
context.mp.infoColor                 // #3B82F6
context.mp.infoBackgroundColor       // #DBEAFE
```

### **Primary Colors**
```dart
// Primary brand color
context.mp.primary                   // #6366F1 (Indigo)
context.mp.primaryHover              // #4F46E5 (Darker on hover)
context.mp.primaryPressed            // #4338CA (Darkest when pressed)
context.mp.primaryFocus              // #818CF8 (Lighter for focus)
context.mp.primaryBorder             // #A5B4FC (Light for borders)
```

---

## 🎯 Common Use Cases

### **Card Component**
```dart
MPCard(
  variant: MPCardVariant.filled,  // ✅ Uses cardColor automatically
  body: Column(
    children: [
      MPText(
        'Title',
        style: TextStyle(
          color: context.mp.textColor,      // ✅ Adaptive
          fontWeight: FontWeight.bold,
        ),
      ),
      MPText(
        'Description',
        style: TextStyle(
          color: context.mp.subtitleColor,  // ✅ Adaptive
        ),
      ),
    ],
  ),
)
```

### **Custom Container**
```dart
Container(
  decoration: BoxDecoration(
    color: context.mp.cardColor,           // ✅ Adaptive background
    border: Border.all(
      color: context.mp.borderColor,       // ✅ Adaptive border
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text(
    'Content',
    style: TextStyle(
      color: context.mp.textColor,         // ✅ Adaptive text
    ),
  ),
)
```

### **AppBar**
```dart
AppBar(
  title: Text(
    'My App',
    style: TextStyle(color: context.mp.textColor),  // ✅ Adaptive
  ),
  backgroundColor: context.mp.backgroundColor,      // ✅ Adaptive
  iconTheme: IconThemeData(
    color: context.mp.textColor,                    // ✅ Adaptive
  ),
)
```

### **PopupMenu**
```dart
PopupMenuButton(
  icon: Icon(Icons.more_vert, color: context.mp.textColor),
  surfaceTintColor: Colors.transparent,  // ✅ Remove Material 3 tint
  color: context.mp.cardColor,           // ✅ Adaptive background
  itemBuilder: (context) => [
    PopupMenuItem(
      child: Text(
        'Option',
        style: TextStyle(color: context.mp.textColor),  // ✅ Adaptive
      ),
    ),
  ],
)
```

### **Button with Icon**
```dart
MPButton(
  text: 'Click Me',
  icon: Icons.star,
  variant: MPButtonVariant.primary,  // ✅ Uses primary color
  // Text color is automatically white for good contrast
)
```

---

## 🚫 Common Mistakes

### **❌ Mistake #1: Using Fixed Neutral Colors**
```dart
// ❌ WRONG
Text('Hello', style: TextStyle(color: context.mp.neutral90))

// ✅ CORRECT
Text('Hello', style: TextStyle(color: context.mp.textColor))
```

**Why?** `neutral90` is always dark gray, even in dark mode where it becomes invisible.

### **❌ Mistake #2: Hardcoding Colors**
```dart
// ❌ WRONG
Container(color: Color(0xFFFFFFFF))

// ✅ CORRECT
Container(color: context.mp.backgroundColor)
```

**Why?** Hardcoded colors don't adapt to theme changes.

### **❌ Mistake #3: Using Wrong Background for Cards**
```dart
// ❌ WRONG
MPCard(backgroundColor: context.mp.neutral20)

// ✅ CORRECT
MPCard(variant: MPCardVariant.filled)  // Uses cardColor automatically
// OR
MPCard(backgroundColor: context.mp.cardColor)
```

**Why?** `neutral20` doesn't adapt to dark mode.

### **❌ Mistake #4: Forgetting PopupMenu Colors**
```dart
// ❌ WRONG
PopupMenuButton(
  itemBuilder: (context) => [...],
)

// ✅ CORRECT
PopupMenuButton(
  surfaceTintColor: Colors.transparent,
  color: context.mp.cardColor,
  itemBuilder: (context) => [...],
)
```

**Why?** Material 3 adds a tint by default that may not match your theme.

---

## 🎨 Neutral Color Scale (For Reference Only)

**⚠️ Use adaptive colors instead of these directly!**

| Shade | Hex | Light Mode Use | Dark Mode Use |
|-------|-----|----------------|---------------|
| `neutral10` | `#FFFFFF` | Background, Cards | Text |
| `neutral20` | `#F9FAFB` | Subtle backgrounds | - |
| `neutral30` | `#F3F4F6` | Dividers | Subtitle text |
| `neutral40` | `#E5E7EB` | Borders | - |
| `neutral50` | `#D1D5DB` | Disabled text | - |
| `neutral60` | `#9CA3AF` | - | Caption text |
| `neutral70` | `#6B7280` | Subtitle text | Borders |
| `neutral80` | `#4B5563` | - | Cards |
| `neutral90` | `#374151` | - | Surfaces |
| `neutral100` | `#111827` | Text | Background |

---

## 📱 Testing Your Colors

### **Visual Test Checklist**
```dart
// Test in both light and dark modes:
1. Switch to light mode
   - Can you read all text? ✅
   - Are borders visible? ✅
   - Do cards stand out? ✅

2. Switch to dark mode
   - Can you read all text? ✅
   - Are borders visible? ✅
   - Do cards stand out? ✅

3. Test theme toggle
   - Does everything update? ✅
   - No flickering? ✅
   - Smooth transition? ✅
```

### **Code Test**
```dart
// Add this to your widget to test
@override
Widget build(BuildContext context) {
  // Print current theme for debugging
  debugPrint('Is Dark Mode: ${Theme.of(context).brightness == Brightness.dark}');
  debugPrint('Text Color: ${context.mp.textColor}');
  debugPrint('Background: ${context.mp.backgroundColor}');

  return YourWidget();
}
```

---

## 🔍 Debugging Theme Issues

### **Problem: Text not visible**
```dart
// Check:
1. Are you using adaptive colors?
   ✅ context.mp.textColor
   ❌ context.mp.neutral90

2. Is background adaptive?
   ✅ context.mp.cardColor
   ❌ context.mp.neutral20

3. Test contrast:
   final contrast = MPThemeConfig.getContrastRatio(
     context.mp.textColor,
     context.mp.backgroundColor,
   );
   print('Contrast: $contrast'); // Should be > 4.5
```

### **Problem: Colors not updating on theme change**
```dart
// Solution: Ensure you're using context.mp, not cached values
// ❌ WRONG
final textColor = context.mp.textColor;  // Cached!
return Text('Hello', style: TextStyle(color: textColor));

// ✅ CORRECT
return Text('Hello', style: TextStyle(color: context.mp.textColor));
```

---

## 💡 Pro Tips

### **Tip #1: Use MPText for Typography**
```dart
// ✅ BEST - Automatic styling
MPText.head('Title')
MPText.body('Description')
MPText.caption('Hint')

// ✅ GOOD - Manual styling with adaptive colors
MPText(
  'Custom',
  style: MPTextStyle.heading1(color: context.mp.textColor),
)
```

### **Tip #2: Use MPCard Variants**
```dart
// ✅ Let the component handle colors
MPCard(variant: MPCardVariant.filled)      // Adaptive card color
MPCard(variant: MPCardVariant.elevated)    // Adaptive with shadow
MPCard(variant: MPCardVariant.outlined)    // Adaptive with border
```

### **Tip #3: Check Contrast Programmatically**
```dart
// Validate your colors
final isGoodContrast = MPThemeConfig.hasGoodContrast(
  context.mp.textColor,
  context.mp.backgroundColor,
  minimumRatio: 4.5,  // WCAG AA standard
);

if (!isGoodContrast) {
  debugPrint('⚠️ Poor contrast detected!');
}
```

---

## 📚 Additional Resources

- **Full Theme Documentation:** `lib/src/core/theme/mp_theme_config.dart`
- **Color Utilities:** `lib/src/core/theme/mp_theme_helper.dart`
- **Example Usage:** `example/lib/pages/theme_toggle_demo_page.dart`
- **Theme Fix Report:** `tasks/THEME_COLOR_FIX.md`

---

**Remember:** When in doubt, use adaptive colors! 🎨✨
