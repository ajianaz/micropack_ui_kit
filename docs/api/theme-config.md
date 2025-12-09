# MPThemeConfig - Single Source of Truth for Theme Configuration

`MPThemeConfig` is the single source of truth for all color definitions and theme configuration in MicroPack UI Kit. This file replaces the problematic `MPColors` and provides a more robust and consistent system.

## Key Features

### 🎨 Correct Color Definitions
- **Primary Colors**: Consistent between light and dark mode
- **Neutral Colors**: Correct scale from 10 (light) to 100 (dark)
- **Semantic Colors**: Success, warning, error, and info colors
- **Dark Mode Fix**: Fixed neutral scale for dark mode

### 🛠️ Helper Methods with Error Handling
- Safe color access with fallback
- Validation for invalid input
- Context-aware color selection
- Contrast ratio calculation and validation

### ♿ Accessibility Features
- WCAG AA/AAA compliance checking
- Automatic contrast ratio calculation
- Best text color selection
- Theme validation with detailed reporting

## Basic Usage

> **⚠️ IMPORTANT:** For UI components, always use adaptive color methods (`getPrimaryTextColor`, `getBackgroundColor`, etc.) or use `context.mp.textColor`, `context.mp.cardColor` instead of direct neutral colors. Direct neutral colors like `getNeutral(90)` are the same in both light and dark modes and will cause visibility issues.
>
> **📖 See [Theme Colors Quick Reference](../guides/theme-colors-quick-reference.md) for best practices**

### Getting Primary Colors

```dart
// Get primary color (same for light and dark mode)
final primaryColor = MPThemeConfig.getPrimary();

// Get variant primary colors
final hoverColor = MPThemeConfig.getPrimaryHover();
final pressedColor = MPThemeConfig.getPrimaryPressed();
final focusColor = MPThemeConfig.getPrimaryFocus();
final borderColor = MPThemeConfig.getPrimaryBorder();
final surfaceColor = MPThemeConfig.getPrimarySurface();
```

### Getting Neutral Colors

> **⚠️ WARNING:** Only use direct neutral colors for internal theme configuration. For UI components, use adaptive colors instead!

```dart
// ❌ DON'T USE IN UI COMPONENTS
final neutral10 = MPThemeConfig.getNeutral(10); // Always white
final neutral90 = MPThemeConfig.getNeutral(90); // Always dark gray

// ✅ USE ADAPTIVE COLORS INSTEAD
final textColor = MPThemeConfig.getPrimaryTextColor(isDarkMode: isDarkMode);
final bgColor = MPThemeConfig.getBackgroundColor(isDarkMode: isDarkMode);
```

### Context-Aware Colors

```dart
// Background colors
final lightBg = MPThemeConfig.getBackgroundColor(isDarkMode: false); // White
final darkBg = MPThemeConfig.getBackgroundColor(isDarkMode: true); // Dark gray

// Text colors
final lightText = MPThemeConfig.getPrimaryTextColor(isDarkMode: false); // Dark text
final darkText = MPThemeConfig.getPrimaryTextColor(isDarkMode: true); // Light text

// Border colors
final lightBorder = MPThemeConfig.getBorderColor(isDarkMode: false); // Light gray
final darkBorder = MPThemeConfig.getBorderColor(isDarkMode: true); // Medium gray
```

### Semantic Colors

```dart
// Success colors
final successColor = MPThemeConfig.getSuccessColor();
final successBg = MPThemeConfig.getSuccessBackgroundColor();

// Warning colors
final warningColor = MPThemeConfig.getWarningColor();
final warningBg = MPThemeConfig.getWarningBackgroundColor();

// Error colors
final errorColor = MPThemeConfig.getErrorColor();
final errorBg = MPThemeConfig.getErrorBackgroundColor();

// Info colors
final infoColor = MPThemeConfig.getInfoColor();
final infoBg = MPThemeConfig.getInfoBackgroundColor();
```

## Accessibility Features

### Contrast Ratio Calculation

```dart
// Calculate contrast ratio between two colors
final ratio = MPThemeConfig.getContrastRatio(
  Colors.white, // foreground
  Colors.black, // background
);
print(ratio); // 21.0 (maximum contrast)

// Check if contrast is good enough
final isGood = MPThemeConfig.hasGoodContrast(
  Colors.black,
  Colors.white,
  minimumRatio: 4.5, // WCAG AA standard
);
```

### Best Text Color Selection

```dart
// Automatically select best text color for background
final bestTextColor = MPThemeConfig.getBestTextColor(
  Colors.grey[800]!, // background
); // Will return white or black depending on contrast
```

### Theme Validation

```dart
// Validate theme to ensure all contrast ratios are good
final validation = MPThemeConfig.validateThemeContrast(isDarkMode: false);

// Check validation results
if (validation['primary_text_on_background'] == false) {
  print('Primary text on background has poor contrast');
}

// Generate validation summary
final summary = MPThemeConfig.getThemeValidationSummary(isDarkMode: false);
print(summary);
// Output:
// === Light Mode Theme Validation ===
// primary_text_on_background: ✅ PASS
// secondary_text_on_background: ✅ PASS
// primary_text_on_surface: ✅ PASS
// secondary_text_on_surface: ✅ PASS
// primary_button_contrast: ✅ PASS
//
// Overall: ✅ ALL TESTS PASSED
```

## Utility Methods

### Available Neutral Shades

```dart
// Get all available shades
final shades = MPThemeConfig.availableNeutralShades;
print(shades); // [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

// Validate shade
final isValid = MPThemeConfig.isValidNeutralShade(25); // false
final isValid = MPThemeConfig.isValidNeutralShade(50); // true
```

### Shadow Colors

```dart
// Get shadow color appropriate for theme
final lightShadow = MPThemeConfig.getShadowColor(isDarkMode: false);
final darkShadow = MPThemeConfig.getShadowColor(isDarkMode: true);

// Custom opacity
final customShadow = MPThemeConfig.getShadowColor(
  isDarkMode: false,
  opacity: 0.2,
);
```

## Migration from MPColors

### Before (Problematic MPColors):

```dart
// ❌ Problematic approach
final color = MPColors.getNeutral(90, isDarkMode: true); // Inconsistent
final primary = MPColors.getPrimary(isDarkMode: false); // Different from dark mode
```

### After (MPThemeConfig):

```dart
// ✅ Correct approach
final color = MPThemeConfig.getNeutral(90); // Consistent
final primary = MPThemeConfig.getPrimary(); // Same for all modes
final contextColor = MPThemeConfig.getPrimaryTextColor(isDarkMode: isDarkMode);
```

## Best Practices

### 1. Use Context-Aware Methods
```dart
// ✅ Good
final textColor = MPThemeConfig.getPrimaryTextColor(isDarkMode: isDarkMode);
final bgColor = MPThemeConfig.getBackgroundColor(isDarkMode: isDarkMode);

// ❌ Avoid hardcoding
final textColor = isDarkMode ? Colors.white : Colors.black;
```

### 2. Validate Contrast Ratio
```dart
// ✅ Validate important combinations
final hasGoodContrast = MPThemeConfig.hasGoodContrast(
  textColor,
  backgroundColor,
);

if (!hasGoodContrast) {
  // Adjust colors or use different combination
}
```

### 3. Use Safe Methods for Dynamic Input
```dart
// ✅ Safe for dynamic input
final shade = userSelectedShade ?? 50;
final color = MPThemeConfig.getNeutralSafe(shade, fallback: 50);

// ❌ Risky for dynamic input
final color = MPThemeConfig.getNeutral(userSelectedShade); // Might throw
```

### 4. Leverage Theme Validation
```dart
// ✅ Validate theme in development
void validateTheme() {
  final validation = MPThemeConfig.validateThemeContrast(isDarkMode: isDarkMode);
  final failedTests = validation.entries.where((e) => !e.value);

  if (failedTests.isNotEmpty) {
    debugPrint('Theme validation failed for: ${failedTests.map((e) => e.key).join(', ')}');
  }
}
```

## Color Reference

### Primary Colors
- **Primary**: `#6366F1` (Indigo-500)
- **Hover**: `#4F46E5` (Indigo-600)
- **Pressed**: `#4338CA` (Indigo-700)
- **Focus**: `#818CF8` (Indigo-400)
- **Border**: `#A5B4FC` (Indigo-300)
- **Surface**: `#EEF2FF` (Indigo-50)

### Neutral Scale
| Shade | Hex | Usage |
|-------|------|-------|
| 10 | `#FFFFFF` | Light backgrounds, dark text |
| 20 | `#F9FAFB` | Light surfaces |
| 30 | `#F3F4F6` | Light borders |
| 40 | `#E5E7EB` | Light dividers |
| 50 | `#D1D5DB` | Disabled elements |
| 60 | `#9CA3AF` | Medium text |
| 70 | `#6B7280` | Secondary text |
| 80 | `#4B5563` | Dark secondary text |
| 90 | `#374151` | Dark surfaces |
| 100 | `#111827` | Dark backgrounds |

### Semantic Colors
- **Success**: `#10B981` (Emerald-500) / `#D1FAE5` (Emerald-100)
- **Warning**: `#F59E0B` (Amber-500) / `#FEF3C7` (Amber-100)
- **Error**: `#EF4444` (Red-500) / `#FEE2E2` (Red-100)
- **Info**: `#3B82F6` (Blue-500) / `#DBEAFE` (Blue-100)

## Troubleshooting

### Common Issues

1. **Invalid Neutral Shade**
   ```dart
   // Error: ArgumentError
   MPThemeConfig.getNeutral(15);

   // Solution: Use valid shade or getNeutralSafe
   MPThemeConfig.getNeutralSafe(15, fallback: 20);
   ```

2. **Poor Contrast Ratio**
   ```dart
   // Check contrast
   final ratio = MPThemeConfig.getContrastRatio(foreground, background);
   if (ratio < 4.5) {
     // Use different colors or adjust opacity
   }
   ```

3. **Theme Validation Failed**
   ```dart
   // Get detailed validation report
   final validation = MPThemeConfig.validateThemeContrast();
   final summary = MPThemeConfig.getThemeValidationSummary();

   // Fix failing combinations
   ```

### Performance Tips

1. **Cache Color Values**: Untuk warna yang sering digunakan, cache hasilnya
2. **Use Constants**: Untuk warna statis, gunakan constants
3. **Avoid Repeated Validation**: Validasi theme sekali di development, tidak di production

## Integration dengan Theme System

`MPThemeConfig` sudah terintegrasi dengan:
- `MPColorTheme` untuk theme extensions
- `MPTheme` untuk ThemeData construction
- `MPThemeHelper` untuk context utilities
- `MPContextExtension` untuk easy access

Gunakan `MPThemeConfig` sebagai single source of truth untuk semua kebutuhan warna dalam aplikasi Anda.