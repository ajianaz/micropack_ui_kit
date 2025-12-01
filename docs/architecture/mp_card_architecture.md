# MPCard Component Architecture Design

## Overview

MPCard is a flexible, theme-aware card component designed for dynamic use cases across the Micropack UI Kit. It combines the foundation approach of MPButton with the content flexibility of MPArticleCard, supporting multiple variants, responsive layouts, and comprehensive theme integration.

## Design Philosophy

1. **Flexibility First**: Support both generic foundation usage and specialized content patterns
2. **Theme-Aware**: Full integration with `context.mp` utilities for consistent theming
3. **Responsive by Default**: Adaptive layouts for different screen sizes and orientations
4. **Accessibility Built-In**: Semantic labels, focus management, and keyboard navigation
5. **Performance Optimized**: Efficient rendering with minimal rebuilds

## Component Structure

### Core Architecture

```dart
class MPCard extends StatefulWidget {
  // Content slots
  final Widget? header;
  final Widget? body;
  final Widget? footer;
  final Widget? child; // Alternative to body for simple cases

  // Layout configuration
  final MPCardLayout layout;
  final MPCardVariant variant;
  final MPCardSize size;
  final MPCardResponsiveConfig? responsive;

  // Visual styling
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? elevation;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  // Interactive behavior
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final bool enabled;
  final bool selectable;
  final bool selected;

  // Theme integration
  final MPCardThemeData? themeData;

  // Accessibility
  final String? semanticLabel;
  final String? semanticHint;
  final FocusNode? focusNode;
  final bool autofocus;
}
```

### Content Slot System

MPCard supports multiple content organization patterns:

#### 1. Slot-Based Approach
```dart
MPCard(
  header: _buildHeader(),
  body: _buildBody(),
  footer: _buildFooter(),
)
```

#### 2. Single Child Approach
```dart
MPCard(
  child: _buildCustomContent(),
)
```

#### 3. Predefined Content Patterns
```dart
// Media card pattern
MPCard.media(
  image: NetworkImage('url'),
  title: 'Card Title',
  subtitle: 'Card subtitle',
  actions: [_buildActions()],
)

// Content card pattern
MPCard.content(
  title: 'Title',
  description: 'Description',
  metadata: _buildMetadata(),
)
```

## Variant System

### Visual Variants

```dart
enum MPCardVariant {
  // Foundation variants (like MPButton)
  primary,      // Uses theme primary color
  secondary,    // Uses theme secondary colors
  surface,      // Uses theme surface colors

  // Structural variants (like MPArticleCard)
  elevated,     // Has elevation and shadow
  outlined,     // Has border only
  filled,       // Has solid background

  // Specialized variants
  interactive,  // Optimized for interaction
  display,      // Optimized for content display
  glass,        // Translucent with blur effect
}
```

### Size System

```dart
enum MPCardSize {
  small,    // Compact cards for dense layouts
  medium,   // Standard card size (default)
  large,     // Large cards for emphasis
  xlarge,    // Extra large for hero content
  fluid,     // Responsive sizing based on container
}
```

## Responsive Behavior System

### Layout Adaptation

```dart
enum MPCardLayout {
  vertical,    // Header-Body-Footer stacked
  horizontal,  // Side-by-side layout
  grid,        // Grid-based layout
  adaptive,    // Automatically switches based on screen size
}

class MPCardResponsiveConfig {
  final MPCardLayout? mobileLayout;
  final MPCardLayout? tabletLayout;
  final MPCardLayout? desktopLayout;
  final double? mobileMaxWidth;
  final double? tabletMaxWidth;
  final bool enableOrientationAdaptation;
  final Duration? layoutTransitionDuration;
}
```

### Responsive Breakpoints

```dart
class MPCardBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
}
```

### Adaptive Layout Logic

```dart
MPCardLayout _getAdaptiveLayout(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final config = widget.responsive;

  if (config != null) {
    if (screenWidth <= config.mobileMaxWidth ?? MPCardBreakpoints.mobile) {
      return config.mobileLayout ?? MPCardLayout.vertical;
    } else if (screenWidth <= config.tabletMaxWidth ?? MPCardBreakpoints.tablet) {
      return config.tabletLayout ?? MPCardLayout.horizontal;
    } else {
      return config.desktopLayout ?? MPCardLayout.horizontal;
    }
  }

  return widget.layout;
}
```

## Theme Integration Strategy

### Theme-Aware Color System

```dart
class MPCardThemeData {
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final Color? hoverColor;
  final Color? pressedColor;
  final Color? focusColor;
  final Color? selectedColor;
}

// Theme integration methods
Color _getBackgroundColor(BuildContext context) {
  // Priority: custom > theme > adaptive
  if (widget.backgroundColor != null) return widget.backgroundColor!;
  if (widget.themeData?.backgroundColor != null) return widget.themeData!.backgroundColor!;

  switch (widget.variant) {
    case MPCardVariant.primary:
      return context.mp.primary.withValues(alpha: 0.1);
    case MPCardVariant.secondary:
      return context.mp.neutral20;
    case MPCardVariant.surface:
      return context.mp.adaptiveBackgroundColor;
    case MPCardVariant.elevated:
      return context.mp.adaptiveBackgroundColor;
    case MPCardVariant.outlined:
      return context.mp.adaptiveBackgroundColor;
    case MPCardVariant.filled:
      return context.mp.neutral20;
    case MPCardVariant.interactive:
      return context.mp.primarySurface;
    case MPCardVariant.display:
      return context.mp.adaptiveBackgroundColor;
    case MPCardVariant.glass:
      return context.mp.neutral100.withValues(alpha: 0.1);
  }
}
```

### Dark Mode Adaptation

All colors automatically adapt using `context.mp` utilities:

- **Backgrounds**: Use `context.mp.adaptiveBackgroundColor`
- **Borders**: Use `context.mp.adaptiveBorderColor`
- **Text**: Use `context.mp.textColor` and variants
- **Shadows**: Use `context.mp.adaptiveShadowColor`
- **States**: Use theme-aware hover/pressed colors

## Interactive States System

### State Management

```dart
class _MPCardState extends State<MPCard> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  Color _getInteractionColor(BuildContext context) {
    if (!widget.enabled) return context.mp.disabledColor;
    if (widget.selected) return _getSelectedColor(context);
    if (_isPressed) return _getPressedColor(context);
    if (_isHovered) return _getHoverColor(context);
    if (_isFocused) return _getFocusColor(context);
    return _getBackgroundColor(context);
  }
}
```

### Smooth Transitions

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 200),
  curve: Curves.easeInOut,
  decoration: BoxDecoration(
    color: _getInteractionColor(context),
    borderRadius: BorderRadius.circular(widget.borderRadius ?? _getDefaultRadius()),
    border: _getBorder(),
    boxShadow: _getBoxShadow(),
  ),
  child: _buildContent(),
)
```

## Accessibility Implementation

### Semantic Labels

```dart
Widget _buildWithAccessibility(BuildContext context) {
  return Semantics(
    label: widget.semanticLabel ?? _buildSemanticLabel(),
    hint: widget.semanticHint,
    button: widget.onTap != null,
    selected: widget.selected,
    enabled: widget.enabled,
    child: _buildCard(context),
  );
}

String _buildSemanticLabel() {
  final parts = <String>[];
  if (widget.header != null) parts.add('Card with header');
  if (widget.body != null || widget.child != null) parts.add('and content');
  if (widget.footer != null) parts.add('and footer');
  if (widget.onTap != null) parts.add('Interactive card');
  return parts.join(', ');
}
```

### Focus Management

```dart
Focus(
  focusNode: widget.focusNode,
  autofocus: widget.autofocus,
  onFocusChange: (hasFocus) {
    setState(() => _isFocused = hasFocus);
  },
  child: _buildCardContent(),
)
```

### Keyboard Navigation

```dart
@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: widget.enabled ? widget.onTap : null,
    onLongPress: widget.enabled ? widget.onLongPress : null,
    child: KeyboardListener(
      focusNode: _keyboardFocusNode,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.enter ||
              event.logicalKey == LogicalKeyboardKey.space) {
            if (widget.enabled && widget.onTap != null) {
              widget.onTap!();
            }
          }
        }
      },
      child: _buildCard(context),
    ),
  );
}
```

## Component API Design

### Named Constructors

```dart
// Foundation constructor
MPCard({
  // All parameters
});

// Convenience constructors
MPCard.media({
  required Widget image,
  String? title,
  String? subtitle,
  List<Widget>? actions,
  // ... common parameters
});

MPCard.content({
  String? title,
  String? description,
  Widget? metadata,
  List<Widget>? actions,
  // ... common parameters
});

MPCard.interactive({
  required Widget child,
  VoidCallback? onTap,
  // ... interaction parameters
});
```

### Builder Pattern Support

```dart
MPCard.builder()
  .header(_buildHeader())
  .body(_buildBody())
  .footer(_buildFooter())
  .variant(MPCardVariant.elevated)
  .size(MPCardSize.medium)
  .responsive(MPCardResponsiveConfig(
    mobileLayout: MPCardLayout.vertical,
    tabletLayout: MPCardLayout.horizontal,
  ))
  .onTap(_handleTap)
  .build();
```

## Performance Optimization

### Efficient Rebuilds

```dart
class _MPCardState extends State<MPCard> {
  late final ValueNotifier<bool> _hoverNotifier;
  late final ValueNotifier<bool> _pressedNotifier;

  @override
  void initState() {
    super.initState();
    _hoverNotifier = ValueNotifier(false);
    _pressedNotifier = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _hoverNotifier,
      builder: (context, isHovered, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: _pressedNotifier,
          builder: (context, isPressed, child) {
            return _buildCard(context, isHovered, isPressed);
          },
          child: child,
        );
      },
      child: _buildStaticContent(),
    );
  }
}
```

### Lazy Content Loading

```dart
class _LazyContent extends StatelessWidget {
  final Widget? content;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();
    return content ?? const SizedBox.shrink();
  }
}
```

## Testing Strategy

### Unit Tests

```dart
testWidgets('MPCard renders with basic properties', (tester) async {
  await tester.pumpWidget(
    MPCard(
      child: Text('Test Card'),
    ),
  );

  expect(find.text('Test Card'), findsOneWidget);
  expect(find.byType(MPCard), findsOneWidget);
});

testWidgets('MPCard adapts to theme changes', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MPCard(child: Text('Test')),
    ),
  );

  // Test light theme
  var card = tester.widget<MPCard>(find.byType(MPCard));
  expect(card.backgroundColor, isNull);

  // Switch to dark theme and rebuild
  // ... theme switching logic
});
```

### Widget Tests

```dart
testWidgets('MPCard handles tap interactions', (tester) async {
  bool wasTapped = false;

  await tester.pumpWidget(
    MPCard(
      onTap: () => wasTapped = true,
      child: Text('Tap Me'),
    ),
  );

  await tester.tap(find.byType(MPCard));
  await tester.pump();

  expect(wasTapped, isTrue);
});

testWidgets('MPCard adapts layout on screen size change', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MPCard(
        responsive: MPCardResponsiveConfig(
          mobileLayout: MPCardLayout.vertical,
          desktopLayout: MPCardLayout.horizontal,
        ),
        child: Text('Responsive Card'),
      ),
    ),
  );

  // Test mobile layout
  await tester.binding.setSurfaceSize(const Size(400, 800));
  await tester.pump();

  // Test desktop layout
  await tester.binding.setSurfaceSize(const Size(1200, 800));
  await tester.pump();

  // Verify layout changes
});
```

### Accessibility Tests

```dart
testWidgets('MPCard has proper semantic labels', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MPCard(
        semanticLabel: 'Important card',
        child: Text('Content'),
      ),
    ),
  );

  expect(
    tester.semantics(find.byType(MPCard)),
    matchesSemantics(label: 'Important card'),
  );
});
```

## Implementation Guidelines

### File Structure

```
lib/src/components/card/
├── mp_card.dart                 // Main component
├── enums/
│   ├── mp_card_variant.dart      // Variant enums
│   ├── mp_card_size.dart        // Size enums
│   └── mp_card_layout.dart      // Layout enums
├── theme/
│   ├── mp_card_theme.dart       // Theme data
│   └── mp_card_theme_data.dart // Theme data class
├── responsive/
│   ├── mp_card_responsive.dart  // Responsive config
│   └── mp_card_breakpoints.dart // Breakpoint definitions
└── builders/
    ├── mp_card_builder.dart     // Builder pattern
    └── mp_card_media.dart      // Media card builder
```

### Integration with Existing Components

```dart
// Use existing components within MPCard
Widget _buildHeader() {
  return Row(
    children: [
      MPText.head(
        'Card Title',
        color: context.mp.textColor,
      ),
      const Spacer(),
      MPButton(
        text: 'Action',
        variant: MPButtonVariant.ghost,
        onPressed: _handleAction,
      ),
    ],
  );
}

// Consistent spacing with existing system
EdgeInsets _getDefaultPadding() {
  switch (widget.size) {
    case MPCardSize.small:
      return EdgeInsets.all(12.r);
    case MPCardSize.medium:
      return EdgeInsets.all(16.r);
    case MPCardSize.large:
      return EdgeInsets.all(20.r);
    case MPCardSize.xlarge:
      return EdgeInsets.all(24.r);
    case MPCardSize.fluid:
      return EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      );
  }
}
```

## Migration Path

### From MPArticleCard

```dart
// Before
MPArticleCard(
  title: 'Title',
  description: 'Description',
  variant: MPArticleCardVariant.elevated,
)

// After
MPCard.content(
  title: 'Title',
  description: 'Description',
  variant: MPCardVariant.elevated,
)
```

### From Container

```dart
// Before
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [BoxShadow(...)],
  ),
  child: content,
)

// After
MPCard(
  child: content,
  variant: MPCardVariant.elevated,
)
```

## Conclusion

MPCard provides a comprehensive, flexible foundation for card-based UI components in the Micropack UI Kit. It combines the best practices from existing components while adding new capabilities for responsive design and content organization. The architecture ensures consistency with the theme system while providing maximum flexibility for different use cases.

The component is designed to evolve with the needs of the application while maintaining backward compatibility and performance optimization.