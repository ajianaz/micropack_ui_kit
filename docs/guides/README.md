# Development Guides

Advanced guides and best practices for developing with Micropack UI Kit.

## 📚 Table of Contents

- [Theme System](./theming.md) - Complete theming guide
- [Theme Colors Quick Reference](./theme-colors-quick-reference.md) - Quick color guide for developers
- [Theme Color Fix Report](./theme-color-fix-report.md) - Recent theme color improvements
- [Component Theme Audit](./component-theme-audit.md) - Component color audit & recommendations
- [Component Development](./component-development.md) - Building custom components
- [Migration Guide](./migration.md) - Moving from other UI libraries
- [Best Practices](./best-practices.md) - Development patterns
- [Performance Optimization](./performance.md) - Optimization techniques
- [Accessibility](./accessibility.md) - A11y compliance

## 🎨 Theming

Learn how to create beautiful, consistent themes:

- [Complete Theme Guide](./theming.md)
- Custom color schemes
- Dark mode implementation
- Theme transitions

## 🧩 Component Development

Build your own components that integrate seamlessly:

- [Component Development Guide](./component-development.md)
- Using theme utilities
- Extending existing components
- Publishing guidelines

## 📦 Migration

Coming from other UI libraries? We've got you covered:

- [Migration Guide](./migration.md)
- Flutter Material Design migration
- Popular UI library comparisons
- Step-by-step migration

## 🎯 Best Practices

Write better, more maintainable code:

- [Best Practices Guide](./best-practices.md)
- Architecture patterns
- Code organization
- Testing strategies

## ⚡ Performance

Create fast, smooth user experiences:

- [Performance Optimization](./performance.md)
- Rendering optimization
- Memory management
- Build optimizations

## ♿ Accessibility

Build inclusive applications for all users:

- [Accessibility Guide](./accessibility.md)
- Screen reader support
- Color contrast
- Navigation patterns

## 🔧 Advanced Topics

### Custom Theme Extensions

```dart
class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color? accentColor;

  const CustomThemeExtension({
    this.accentColor,
  });

  @override
  CustomThemeExtension copyWith({
    Color? accentColor,
  }) {
    return CustomThemeExtension(
      accentColor: accentColor ?? this.accentColor,
    );
  }

  @override
  CustomThemeExtension lerp(
    ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) {
      return this;
    }

    final CustomThemeExtension typedOther = other as CustomThemeExtension;

    return CustomThemeExtension(
      accentColor: Color.lerp(
        accentColor,
        typedOther.accentColor,
        t,
      ),
    );
  }
}

// Usage
MaterialApp(
  theme: MPTheme.main().copyWith(
    extensions: [
      MPColorTheme.light,
      CustomThemeExtension(accentColor: Colors.orange),
    ],
  ),
  home: YourApp(),
)
```

### Responsive Design Patterns

```dart
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktop;
        } else if (constraints.maxWidth >= 800) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
```

### State Management Integration

```dart
// With Provider
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

// Usage
Consumer<ThemeProvider>(
  builder: (context, themeProvider, child) {
    return MaterialApp(
      themeMode: themeProvider.themeMode,
      theme: MPTheme.main().copyWith(
        extensions: [MPColorTheme.light],
      ),
      home: child,
    );
  },
)
```

## 🔗 Related Resources

- [Getting Started](../getting-started/README.md) - Basic setup
- [API Reference](../api/README.md) - Complete documentation
- [Examples](../examples/README.md) - Code examples

## 🤝 Contributing

Have a guide idea? Please contribute!

1. Check existing guides for overlap
2. Follow our documentation style
3. Include practical examples
4. Test your code thoroughly
5. Submit a pull request

We value community contributions to our documentation! 📝
