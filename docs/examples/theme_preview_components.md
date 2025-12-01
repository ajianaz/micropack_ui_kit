# Theme Preview Components

This file contains comprehensive, reusable theme preview components for the Micropack UI Kit. These components make it easy to showcase and test themes across different light and dark modes, providing a single reference for all theme preview needs.

## 📚 Table of Contents

- [ThemePreview Widget](#theme-preview-widget)
- [ColorPalettePreview Widget](#color-palette-preview-widget)
- [ComponentShowcase Widget](#component-showcase-widget)
- [ThemeSwitchingDemo Widget](#theme-switching-demo-widget)
- [Usage Examples](#usage-examples)
- [Integration with MPThemeManager](#integration-with-mpthememanager)
- [Best Practices](#best-practices)

## 🎨 ThemePreview Widget

A comprehensive widget that displays components in both light and dark themes side by side, making it easy to compare and test theme appearances.

### Complete Implementation

```dart
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ThemePreview extends StatelessWidget {
  const ThemePreview({
    super.key,
    required this.child,
    this.lightTheme,
    this.darkTheme,
    this.showLabels = true,
    this.spacing = 16.0,
    this.aspectRatio = 1.0,
  });

  final Widget child;
  final MPColorTheme? lightTheme;
  final MPColorTheme? darkTheme;
  final bool showLabels;
  final double spacing;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Light theme preview
        Expanded(
          child: _ThemePreviewContainer(
            theme: lightTheme ?? MPColorTheme.light,
            isDark: false,
            showLabel: showLabels,
            label: 'Light Theme',
            child: child,
          ),
        ),

        SizedBox(width: spacing),

        // Dark theme preview
        Expanded(
          child: _ThemePreviewContainer(
            theme: darkTheme ?? MPColorTheme.dark,
            isDark: true,
            showLabel: showLabels,
            label: 'Dark Theme',
            child: child,
          ),
        ),
      ],
    );
  }
}

class _ThemePreviewContainer extends StatelessWidget {
  const _ThemePreviewContainer({
    required this.theme,
    required this.isDark,
    required this.child,
    required this.showLabel,
    required this.label,
  });

  final MPColorTheme theme;
  final bool isDark;
  final Widget child;
  final bool showLabel;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: MPTheme.main().copyWith(
        brightness: isDark ? Brightness.dark : Brightness.light,
        extensions: [theme],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLabel) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey.shade200 : Colors.grey.shade700,
                ),
              ),
            ),
          ],
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade900 : Colors.white,
              border: Border.all(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
              ),
              borderRadius: showLabel
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    )
                  : BorderRadius.circular(8),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
```

### Usage Examples

```dart
// Basic usage with default themes
ThemePreview(
  child: MPButton(
    text: 'Sample Button',
    onPressed: () {},
  ),
)

// With custom themes
ThemePreview(
  lightTheme: MPColorTheme.light.copyWith(
    primary: Colors.deepPurple,
  ),
  darkTheme: MPColorTheme.dark.copyWith(
    primary: Colors.deepPurple,
  ),
  child: Column(
    children: [
      MPButton(
        text: 'Primary Button',
        onPressed: () {},
      ),
      SizedBox(height: 8),
      MPTextField(
        hintText: 'Enter text here...',
      ),
    ],
  ),
)

// Without labels for compact display
ThemePreview(
  showLabels: false,
  spacing: 8.0,
  child: Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: context.mp.adaptiveBackgroundColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text('Sample Text'),
  ),
)
```

## 🎨 ColorPalettePreview Widget

A widget that showcases all theme colors with their names and hex values, making it easy to visualize and document color schemes.

### Complete Implementation

```dart
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ColorPalettePreview extends StatelessWidget {
  const ColorPalettePreview({
    super.key,
    this.lightTheme,
    this.darkTheme,
    this.showHexValues = true,
    this.showColorNames = true,
    this.swatchHeight = 60.0,
    this.swatchSpacing = 4.0,
  });

  final MPColorTheme? lightTheme;
  final MPColorTheme? darkTheme;
  final bool showHexValues;
  final bool showColorNames;
  final double swatchHeight;
  final double swatchSpacing;

  @override
  Widget build(BuildContext context) {
    return ThemePreview(
      lightTheme: lightTheme,
      darkTheme: darkTheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColorSection('Primary Colors', _buildPrimaryColors()),
          SizedBox(height: 16),
          _buildColorSection('Neutral Colors', _buildNeutralColors()),
          SizedBox(height: 16),
          _buildColorSection('Semantic Colors', _buildSemanticColors()),
        ],
      ),
    );
  }

  Widget _buildColorSection(String title, List<ColorSwatch> swatches) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        ...swatches.map((swatch) => Padding(
          padding: EdgeInsets.only(bottom: swatchSpacing),
          child: swatch,
        )),
      ],
    );
  }

  List<ColorSwatch> _buildPrimaryColors() {
    return [
      ColorSwatch(
        name: 'primary',
        colorGetter: (theme) => theme.primary,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
      ColorSwatch(
        name: 'primarySurface',
        colorGetter: (theme) => theme.primarySurface,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
      ColorSwatch(
        name: 'primaryFocus',
        colorGetter: (theme) => theme.primaryFocus,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
      ColorSwatch(
        name: 'primaryBorder',
        colorGetter: (theme) => theme.primaryBorder,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
      ColorSwatch(
        name: 'primaryHover',
        colorGetter: (theme) => theme.primaryHover,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
      ColorSwatch(
        name: 'primaryPressed',
        colorGetter: (theme) => theme.primaryPressed,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
    ];
  }

  List<ColorSwatch> _buildNeutralColors() {
    return [
      for (int i = 10; i <= 100; i += 10)
        ColorSwatch(
          name: 'neutral$i',
          colorGetter: (theme) => _getNeutralColor(theme, i),
          showName: showColorNames,
          showHex: showHexValues,
          height: swatchHeight,
        ),
    ];
  }

  List<ColorSwatch> _buildSemanticColors() {
    return [
      ColorSwatch(
        name: 'textColor',
        colorGetter: (theme) => theme.textColor,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
      ColorSwatch(
        name: 'subtitleColor',
        colorGetter: (theme) => theme.subtitleColor,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
      ColorSwatch(
        name: 'captionColor',
        colorGetter: (theme) => theme.captionColor,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
      ColorSwatch(
        name: 'disabledColor',
        colorGetter: (theme) => theme.disabledColor,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
      ColorSwatch(
        name: 'successColor',
        colorGetter: (theme) => theme.successColor,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
      ColorSwatch(
        name: 'warningColor',
        colorGetter: (theme) => theme.warningColor,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
      ColorSwatch(
        name: 'errorColor',
        colorGetter: (theme) => theme.errorColor,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
      ColorSwatch(
        name: 'infoColor',
        colorGetter: (theme) => theme.infoColor,
        showName: showColorNames,
        showHex: showHexValues,
        height: swatchHeight,
      ),
    ];
  }

  Color? _getNeutralColor(MPColorTheme theme, int shade) {
    switch (shade) {
      case 10: return theme.neutral10;
      case 20: return theme.neutral20;
      case 30: return theme.neutral30;
      case 40: return theme.neutral40;
      case 50: return theme.neutral50;
      case 60: return theme.neutral60;
      case 70: return theme.neutral70;
      case 80: return theme.neutral80;
      case 90: return theme.neutral90;
      case 100: return theme.neutral100;
      default: return null;
    }
  }
}

class ColorSwatch extends StatelessWidget {
  const ColorSwatch({
    super.key,
    required this.name,
    required this.colorGetter,
    this.showName = true,
    this.showHex = true,
    this.height = 60.0,
  });

  final String name;
  final Color? Function(MPColorTheme) colorGetter;
  final bool showName;
  final bool showHex;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<MPColorTheme>();
    final color = colorGetter(colorTheme ?? MPColorTheme.light);

    if (color == null) return SizedBox.shrink();

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            if (showName) ...[
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: _getContrastColor(color),
                ),
              ),
              SizedBox(width: 12),
            ],
            if (showHex) ...[
              Expanded(
                child: Text(
                  '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: _getContrastColor(color),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getContrastColor(Color backgroundColor) {
    // Calculate luminance to determine if we should use black or white text
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
```

### Usage Examples

```dart
// Basic color palette preview
ColorPalettePreview()

// With custom themes
ColorPalettePreview(
  lightTheme: MPColorTheme.light.copyWith(
    primary: Colors.deepPurple,
  ),
  darkTheme: MPColorTheme.dark.copyWith(
    primary: Colors.deepPurple,
  ),
)

// Compact version without hex values
ColorPalettePreview(
  showHexValues: false,
  swatchHeight: 40.0,
)

// Minimal version with just color swatches
ColorPalettePreview(
  showColorNames: false,
  showHexValues: false,
  swatchHeight: 30.0,
  swatchSpacing: 2.0,
)
```

## 🎨 ComponentShowcase Widget

A widget that demonstrates how various components look in different themes, providing a comprehensive overview of theme-aware component behavior.

### Complete Implementation

```dart
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ComponentShowcase extends StatelessWidget {
  const ComponentShowcase({
    super.key,
    this.lightTheme,
    this.darkTheme,
    this.showSections = true,
  });

  final MPColorTheme? lightTheme;
  final MPColorTheme? darkTheme;
  final bool showSections;

  @override
  Widget build(BuildContext context) {
    return ThemePreview(
      lightTheme: lightTheme,
      darkTheme: darkTheme,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showSections) ...[
              _buildSectionTitle('Typography'),
              _buildTypographyShowcase(),
              SizedBox(height: 24),
              _buildSectionTitle('Buttons'),
              _buildButtonShowcase(),
              SizedBox(height: 24),
              _buildSectionTitle('Form Elements'),
              _buildFormShowcase(),
              SizedBox(height: 24),
              _buildSectionTitle('Cards & Containers'),
              _buildContainerShowcase(),
              SizedBox(height: 24),
              _buildSectionTitle('Status Indicators'),
              _buildStatusShowcase(),
            ] else ...[
              _buildTypographyShowcase(),
              SizedBox(height: 16),
              _buildButtonShowcase(),
              SizedBox(height: 16),
              _buildFormShowcase(),
              SizedBox(height: 16),
              _buildContainerShowcase(),
              SizedBox(height: 16),
              _buildStatusShowcase(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade700,
      ),
    );
  }

  Widget _buildTypographyShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Heading 1',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: context.mp.textColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Heading 2',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: context.mp.textColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Body text example with regular weight',
          style: TextStyle(
            fontSize: 16,
            color: context.mp.textColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Subtitle text with medium emphasis',
          style: TextStyle(
            fontSize: 14,
            color: context.mp.subtitleColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Caption text with low emphasis',
          style: TextStyle(
            fontSize: 12,
            color: context.mp.captionColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Disabled text example',
          style: TextStyle(
            fontSize: 14,
            color: context.mp.disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            MPButton(
              text: 'Primary',
              onPressed: () {},
            ),
            MPButton(
              text: 'Secondary',
              variant: MPButtonVariant.secondary,
              onPressed: () {},
            ),
            MPButton(
              text: 'Outline',
              variant: MPButtonVariant.outline,
              onPressed: () {},
            ),
            MPButton(
              text: 'Ghost',
              variant: MPButtonVariant.ghost,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            MPButton(
              text: 'Success',
              variant: MPButtonVariant.success,
              onPressed: () {},
            ),
            MPButton(
              text: 'Warning',
              variant: MPButtonVariant.warning,
              onPressed: () {},
            ),
            MPButton(
              text: 'Danger',
              variant: MPButtonVariant.danger,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: 12),
        MPButton(
          text: 'Loading',
          isLoading: true,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildFormShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPTextField(
          hintText: 'Text field placeholder',
          prefixIcon: Icons.search,
        ),
        SizedBox(height: 12),
        MPTextField(
          hintText: 'Disabled text field',
          enabled: false,
          prefixIcon: Icons.lock,
        ),
        SizedBox(height: 12),
        MPTextField(
          hintText: 'Text field with error',
          errorText: 'This field has an error',
          prefixIcon: Icons.error,
        ),
      ],
    );
  }

  Widget _buildContainerShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.mp.adaptiveBackgroundColor,
            border: Border.all(color: context.mp.adaptiveBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Standard container with adaptive background',
            style: TextStyle(color: context.mp.textColor),
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.mp.primarySurface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: context.mp.adaptiveShadowColor,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'Elevated container with shadow',
            style: TextStyle(color: context.mp.textColor),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusShowicate() {
    return Row(
      children: [
        _buildStatusItem('Success', Icons.check_circle, context.mp.successColor),
        SizedBox(width: 16),
        _buildStatusItem('Warning', Icons.warning, context.mp.warningColor),
        SizedBox(width: 16),
        _buildStatusItem('Error', Icons.error, context.mp.errorColor),
        SizedBox(width: 16),
        _buildStatusItem('Info', Icons.info, context.mp.infoColor),
      ],
    );
  }

  Widget _buildStatusItem(String label, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: context.mp.subtitleColor,
          ),
        ),
      ],
    );
  }
}
```

### Usage Examples

```dart
// Basic component showcase
ComponentShowcase()

// With custom themes
ComponentShowcase(
  lightTheme: MPColorTheme.light.copyWith(
    primary: Colors.teal,
  ),
  darkTheme: MPColorTheme.dark.copyWith(
    primary: Colors.teal,
  ),
)

// Compact version without section titles
ComponentShowcase(showSections: false)
```

## 🎨 ThemeSwitchingDemo Widget

An interactive widget that demonstrates theme switching with animations and real-world usage patterns.

### Complete Implementation

```dart
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ThemeSwitchingDemo extends StatefulWidget {
  const ThemeSwitchingDemo({
    super.key,
    this.initialTheme = ThemeMode.system,
    this.enableAnimation = true,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  final ThemeMode initialTheme;
  final bool enableAnimation;
  final Duration animationDuration;

  @override
  State<ThemeSwitchingDemo> createState() => _ThemeSwitchingDemoState();
}

class _ThemeSwitchingDemoState extends State<ThemeSwitchingDemo>
    with SingleTickerProviderStateMixin {
  late ThemeMode _currentTheme;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _currentTheme = widget.initialTheme;

    if (widget.enableAnimation) {
      _animationController = AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      );
      _fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    if (widget.enableAnimation) {
      _animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.mp.adaptiveBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mp.adaptiveBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildThemeSelector(),
          SizedBox(height: 24),
          _buildThemePreview(),
          SizedBox(height: 24),
          _buildThemeInfo(),
        ],
      ),
    );
  }

  Widget _buildThemeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme Selector',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.mp.textColor,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            _buildThemeOption(
              label: 'Light',
              icon: Icons.light_mode,
              themeMode: ThemeMode.light,
            ),
            SizedBox(width: 12),
            _buildThemeOption(
              label: 'Dark',
              icon: Icons.dark_mode,
              themeMode: ThemeMode.dark,
            ),
            SizedBox(width: 12),
            _buildThemeOption(
              label: 'System',
              icon: Icons.settings_brightness,
              themeMode: ThemeMode.system,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeOption({
    required String label,
    required IconData icon,
    required ThemeMode themeMode,
  }) {
    final isSelected = _currentTheme == themeMode;

    return GestureDetector(
      onTap: () => _switchTheme(themeMode),
      child: AnimatedContainer(
        duration: widget.animationDuration,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? context.mp.primary
              : context.mp.adaptiveBackgroundColor,
          border: Border.all(
            color: isSelected
                ? context.mp.primary
                : context.mp.adaptiveBorderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? Colors.white
                  : context.mp.subtitleColor,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : context.mp.textColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemePreview() {
    if (widget.enableAnimation) {
      return AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: _buildPreviewContent(),
          );
        },
      );
    } else {
      return _buildPreviewContent();
    }
  }

  Widget _buildPreviewContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.mp.textColor,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: MPButton(
                text: 'Primary Button',
                onPressed: () {},
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: MPTextField(
                hintText: 'Text input',
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.mp.primarySurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sample Card',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: context.mp.textColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'This is how content looks in the selected theme.',
                style: TextStyle(
                  color: context.mp.subtitleColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThemeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.mp.textColor,
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.mp.neutral20,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Current Theme', _getThemeModeText()),
              _buildInfoRow('Is Dark Mode', context.mp.isDarkMode.toString()),
              _buildInfoRow('Primary Color', _colorToString(context.mp.primary)),
              _buildInfoRow('Background', _colorToString(context.mp.adaptiveBackgroundColor)),
              _buildInfoRow('Text Color', _colorToString(context.mp.textColor)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: context.mp.subtitleColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: context.mp.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _switchTheme(ThemeMode themeMode) {
    if (widget.enableAnimation) {
      _animationController.reverse().then((_) {
        setState(() {
          _currentTheme = themeMode;
        });
        _animationController.forward();
      });
    } else {
      setState(() {
        _currentTheme = themeMode;
      });
    }
  }

  String _getThemeModeText() {
    switch (_currentTheme) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System (${context.mp.isDarkMode ? 'Dark' : 'Light'})';
    }
  }

  String _colorToString(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
}
```

### Usage Examples

```dart
// Basic theme switching demo
ThemeSwitchingDemo()

// With custom initial theme and animation
ThemeSwitchingDemo(
  initialTheme: ThemeMode.dark,
  enableAnimation: true,
  animationDuration: Duration(milliseconds: 500),
)

// Without animation for instant switching
ThemeSwitchingDemo(enableAnimation: false)
```

## 🔧 Usage Examples

### Complete Theme Preview Page

```dart
class ThemePreviewPage extends StatelessWidget {
  const ThemePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Preview'),
        backgroundColor: context.mp.primary,
      ),
      backgroundColor: context.mp.adaptiveBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Interactive theme switching
            ThemeSwitchingDemo(),
            SizedBox(height: 32),

            // Component showcase
            Text(
              'Component Showcase',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.mp.textColor,
              ),
            ),
            SizedBox(height: 16),
            ComponentShowcase(),
            SizedBox(height: 32),

            // Color palette
            Text(
              'Color Palette',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.mp.textColor,
              ),
            ),
            SizedBox(height: 16),
            ColorPalettePreview(),
          ],
        ),
      ),
    );
  }
}
```

### Custom Theme Builder

```dart
class CustomThemeBuilder extends StatefulWidget {
  const CustomThemeBuilder({super.key});

  @override
  State<CustomThemeBuilder> createState() => _CustomThemeBuilderState();
}

class _CustomThemeBuilderState extends State<CustomThemeBuilder> {
  Color _primaryColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Color picker
        Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Primary Color'),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  Colors.blue,
                  Colors.green,
                  Colors.red,
                  Colors.purple,
                  Colors.orange,
                  Colors.teal,
                ].map((color) {
                  return GestureDetector(
                    onTap: () => setState(() => _primaryColor = color),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: _primaryColor == color
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Preview with custom theme
        ThemePreview(
          lightTheme: MPColorTheme.light.copyWith(
            primary: _primaryColor,
            primarySurface: _primaryColor.withValues(alpha: 0.1),
          ),
          darkTheme: MPColorTheme.dark.copyWith(
            primary: _primaryColor,
            primarySurface: _primaryColor.withValues(alpha: 0.2),
          ),
          child: ComponentShowcase(showSections: false),
        ),
      ],
    );
  }
}
```

## 🔗 Integration with MPThemeManager

### Theme Manager Integration

```dart
class MPThemeManager {
  static MPThemeManager? _instance;
  static MPThemeManager get instance => _instance ??= MPThemeManager._();

  MPThemeManager._();

  ThemeMode _currentTheme = ThemeMode.system;
  final StreamController<ThemeMode> _themeController = StreamController<ThemeMode>.broadcast();

  Stream<ThemeMode> get themeStream => _themeController.stream;
  ThemeMode get currentTheme => _currentTheme;

  void setTheme(ThemeMode theme) {
    _currentTheme = theme;
    _themeController.add(theme);
  }

  MPColorTheme getLightTheme(Color? primaryColor) {
    return MPColorTheme.light.copyWith(
      primary: primaryColor,
    );
  }

  MPColorTheme getDarkTheme(Color? primaryColor) {
    return MPColorTheme.dark.copyWith(
      primary: primaryColor,
    );
  }

  void dispose() {
    _themeController.close();
  }
}

class ThemeManagerIntegration extends StatefulWidget {
  const ThemeManagerIntegration({super.key});

  @override
  State<ThemeManagerIntegration> createState() => _ThemeManagerIntegrationState();
}

class _ThemeManagerIntegrationState extends State<ThemeManagerIntegration> {
  final MPThemeManager _themeManager = MPThemeManager.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeMode>(
      stream: _themeManager.themeStream,
      initialData: _themeManager.currentTheme,
      builder: (context, snapshot) {
        final themeMode = snapshot.data ?? ThemeMode.system;

        return ThemePreview(
          lightTheme: _themeManager.getLightTheme(Colors.indigo),
          darkTheme: _themeManager.getDarkTheme(Colors.indigo),
          child: Column(
            children: [
              Text(
                'Current Theme: ${themeMode.toString()}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.mp.textColor,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: MPButton(
                      text: 'Light',
                      onPressed: () => _themeManager.setTheme(ThemeMode.light),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: MPButton(
                      text: 'Dark',
                      onPressed: () => _themeManager.setTheme(ThemeMode.dark),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: MPButton(
                      text: 'System',
                      onPressed: () => _themeManager.setTheme(ThemeMode.system),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
```

## 📋 Best Practices

### 1. Performance Considerations

```dart
// ✅ Good - Use const constructors where possible
const ThemePreview(
  child: MPButton(text: 'Button'),
)

// ✅ Good - Cache theme values in build method
class OptimizedPreview extends StatelessWidget {
  const OptimizedPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = context.mp.adaptiveBackgroundColor;
    final textColor = context.mp.textColor;

    return Container(
      color: bgColor,
      child: Text('Optimized', style: TextStyle(color: textColor)),
    );
  }
}

// ❌ Avoid - Rebuilding entire widget tree unnecessarily
class BadPreview extends StatelessWidget {
  const BadPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemePreview(
      child: Container(
        color: context.mp.adaptiveBackgroundColor, // Called multiple times
        child: Text('Text', style: TextStyle(color: context.mp.textColor)),
      ),
    );
  }
}
```

### 2. Accessibility Considerations

```dart
// ✅ Good - Ensure sufficient contrast
AccessibleColorSwatch({
  required this.color,
  required this.name,
}) : assert(color.computeLuminance() > 0.5 || color.computeLuminance() < 0.5);

// ✅ Good - Use semantic colors
Text('Important', style: TextStyle(color: context.mp.textColor))

// ❌ Avoid - Poor contrast combinations
Container(
  color: Colors.grey.shade200,
  child: Text('Low contrast', style: TextStyle(color: Colors.grey.shade300)),
)
```

### 3. Animation Best Practices

```dart
// ✅ Good - Smooth theme transitions
AnimatedThemeSwitcher(
  duration: Duration(milliseconds: 300),
  child: ThemePreview(child: content),
)

// ✅ Good - Use appropriate curves
CurvedAnimation(
  parent: controller,
  curve: Curves.easeInOut, // Smooth transition
)

// ❌ Avoid - Abrupt changes
setState(() {
  _themeMode = newTheme; // Instant change without animation
});
```

### 4. Testing Considerations

```dart
// ✅ Good - Testable theme preview
class TestableThemePreview extends StatelessWidget {
  const TestableThemePreview({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ThemePreview(
      key: Key('theme_preview'), // Testable key
      child: child,
    );
  }
}

// Test example
testWidgets('Theme preview displays correctly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: MPTheme.main().copyWith(extensions: [MPColorTheme.light]),
      home: TestableThemePreview(
        child: Text('Test'),
      ),
    ),
  );

  expect(find.byKey(Key('theme_preview')), findsOneWidget);
  expect(find.text('Test'), findsOneWidget);
});
```

## 🎯 Conclusion

These theme preview components provide a comprehensive solution for showcasing and testing themes in Micropack UI Kit applications. They offer:

1. **Reusability**: Components can be easily integrated into any part of your application
2. **Consistency**: Standardized way to display theme previews
3. **Flexibility**: Customizable options for different use cases
4. **Performance**: Optimized implementations with best practices
5. **Accessibility**: Built-in contrast and usability considerations

By using these components, developers can easily create beautiful, theme-aware interfaces that work seamlessly across light and dark modes.

For more information, check out:
- [Theme Utilities API](../api/theme-utilities.md)
- [Comprehensive Theming Guide](../guides/theming.md)
- [Component Examples](./README.md)