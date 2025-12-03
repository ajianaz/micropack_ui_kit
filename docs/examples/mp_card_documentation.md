# MPCard Component Documentation

## Table of Contents

1. [Overview](#overview)
2. [API Documentation](#api-documentation)
3. [Visual Examples](#visual-examples)
4. [Implementation Guide](#implementation-guide)
5. [Accessibility Guide](#accessibility-guide)
6. [Migration Guide](#migration-guide)
7. [Testing Guide](#testing-guide)
8. [Troubleshooting](#troubleshooting)

## Overview

MPCard is a comprehensive, flexible card component designed for dynamic use cases across the Micropack UI Kit. It combines the foundation approach of MPButton with the content flexibility of MPArticleCard, supporting multiple variants, responsive layouts, comprehensive theme integration, and elevation levels.

### Key Features

- **Unified API**: Single component for all card use cases
- **Flexibility**: Multiple content organization patterns
- **Responsive Design**: Built-in adaptation to different screen sizes
- **Theme Integration**: Full compatibility with existing theme system
- **Accessibility**: Comprehensive support for assistive technologies
- **Performance**: Optimized for efficient rendering and memory usage

### Variants

MPCard supports multiple visual and semantic variants:

#### Foundation Variants
- `primary`: Uses theme primary color
- `secondary`: Uses theme secondary colors
- `surface`: Uses theme surface colors

#### Structural Variants
- `elevated`: Has elevation and shadow
- `outlined`: Has border only
- `filled`: Has solid background

#### Specialized Variants
- `interactive`: Optimized for interaction
- `display`: Optimized for content display
- `glass`: Translucent with blur effect

#### Use Case-Specific Variants
- `media`: Optimized for media content (images, videos)
- `content`: Text-focused with minimal visual elements
- `product`: Product cards with pricing and features
- `profile`: User profile with avatar and stats
- `notification`: Alert cards with actions and timestamps
- `dashboard`: Metrics and data visualization cards

## API Documentation

### Core Constructor

```dart
MPCard({
  Key? key,
  Widget? header,
  MPCardHeaderData? headerData,
  Widget? body,
  Widget? footer,
  MPCardFooterData? footerData,
  Widget? child,
  MPCardLayout layout = MPCardLayout.vertical,
  MPCardVariant variant = MPCardVariant.surface,
  MPCardSize size = MPCardSize.medium,
  MPCardResponsiveConfig? responsive,
  Color? backgroundColor,
  Color? borderColor,
  double? borderWidth,
  double? borderRadius,
  double? elevation,
  MPCardElevation? elevationLevel,
  EdgeInsets? padding,
  EdgeInsets? margin,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  ValueChanged<bool>? onHover,
  bool enabled = true,
  bool selectable = false,
  bool selected = false,
  MPCardThemeData? themeData,
  String? semanticLabel,
  String? semanticHint,
  FocusNode? focusNode,
  bool autofocus = false,
  bool enableOverflowHandling = true,
  Clip clipBehavior = Clip.antiAlias,
  MPCardInteractiveConfig? interactiveConfig,
  MPCardInteractionConfig? interactionConfig,
  MPCardAccessibilityConfig? accessibilityConfig,
})
```

### Named Constructors

#### Basic Card with Header
```dart
MPCard.withHeader({
  required MPCardHeaderData headerData,
  Widget? body,
  Widget? footer,
  MPCardFooterData? footerData,
  // ... other common parameters
})
```

#### Basic Card with Footer
```dart
MPCard.withFooter({
  required MPCardFooterData footerData,
  Widget? header,
  MPCardHeaderData? headerData,
  Widget? body,
  // ... other common parameters
})
```

#### Basic Card with Sections
```dart
MPCard.withSections({
  required MPCardHeaderData headerData,
  Widget? body,
  required MPCardFooterData footerData,
  // ... other common parameters
})
```

#### Media Card
```dart
MPCard.media({
  required MPCardMediaData mediaData,
  MPCardSize size = MPCardSize.medium,
  // ... other common parameters
})
```

#### Content Card
```dart
MPCard.content({
  required MPCardContentData contentData,
  MPCardSize size = MPCardSize.medium,
  // ... other common parameters
})
```

#### Product Card
```dart
MPCard.product({
  required MPCardProductData productData,
  MPCardSize size = MPCardSize.medium,
  // ... other common parameters
})
```

#### Profile Card
```dart
MPCard.profile({
  required MPCardProfileData profileData,
  MPCardSize size = MPCardSize.medium,
  // ... other common parameters
})
```

#### Notification Card
```dart
MPCard.notification({
  required MPCardNotificationData notificationData,
  MPCardSize size = MPCardSize.medium,
  // ... other common parameters
})
```

#### Dashboard Card
```dart
MPCard.dashboard({
  required MPCardDashboardData dashboardData,
  MPCardSize size = MPCardSize.medium,
  // ... other common parameters
})
```

### Data Classes

#### MPCardHeaderData
```dart
MPCardHeaderData({
  String? title,
  String? subtitle,
  Widget? titleWidget,
  Widget? subtitleWidget,
  List<Widget>? actions,
  Widget? leading,
  EdgeInsets? padding,
  CrossAxisAlignment? crossAxisAlignment,
  MainAxisAlignment? mainAxisAlignment,
})
```

#### MPCardFooterData
```dart
MPCardFooterData({
  List<Widget>? actions,
  Widget? content,
  EdgeInsets? padding,
  CrossAxisAlignment? crossAxisAlignment,
  MainAxisAlignment? mainAxisAlignment,
})
```

#### MPCardMediaData
```dart
MPCardMediaData({
  Widget? image,
  String? imageUrl,
  String? title,
  String? subtitle,
  String? description,
  List<Widget>? actions,
  Widget? metadata,
  double? imageHeight,
  double? imageWidth,
  BoxFit? imageFit,
  bool showImageOverlay = false,
  Widget? overlayContent,
})
```

#### MPCardContentData
```dart
MPCardContentData({
  String? title,
  String? subtitle,
  String? description,
  Widget? content,
  List<Widget>? actions,
  Widget? metadata,
  Widget? icon,
  bool showDivider = false,
})
```

#### MPCardProductData
```dart
MPCardProductData({
  String? name,
  String? description,
  String? price,
  String? originalPrice,
  String? currency = '\$',
  Widget? image,
  String? imageUrl,
  List<String>? features,
  List<Widget>? actions,
  Widget? badge,
  double? rating,
  int? reviewCount,
  bool isAvailable = true,
})
```

#### MPCardProfileData
```dart
MPCardProfileData({
  String? name,
  String? username,
  String? bio,
  Widget? avatar,
  String? avatarUrl,
  List<Widget>? actions,
  Map<String, String>? stats,
  List<Widget>? socialLinks,
  bool showVerifiedBadge = false,
  bool isOnline = false,
})
```

#### MPCardNotificationData
```dart
MPCardNotificationData({
  String? title,
  String? message,
  String? timestamp,
  Widget? icon,
  IconData? iconData,
  Color? iconColor,
  List<Widget>? actions,
  bool isRead = false,
  bool showTimestamp = true,
  VoidCallback? onTap,
  VoidCallback? onDismiss,
})
```

#### MPCardDashboardData
```dart
MPCardDashboardData({
  String? title,
  String? value,
  String? subtitle,
  String? unit,
  Widget? chart,
  List<Widget>? actions,
  Widget? icon,
  Color? valueColor,
  Color? trendColor,
  String? trend,
  bool showTrend = false,
})
```

### Enums

#### MPCardVariant
- `primary`, `secondary`, `surface`
- `elevated`, `outlined`, `filled`
- `interactive`, `display`, `glass`
- `media`, `content`, `product`, `profile`, `notification`, `dashboard`

#### MPCardSize
- `small`: Compact cards for dense layouts
- `medium`: Standard card size (default)
- `large`: Large cards for emphasis
- `xlarge`: Extra large for hero content
- `fluid`: Responsive sizing based on container

#### MPCardLayout
- `vertical`: Header-Body-Footer stacked
- `horizontal`: Side-by-side layout
- `grid`: Grid-based layout
- `adaptive`: Automatically switches based on screen size

#### MPCardElevation
- `level0` to `level24`: Predefined elevation levels
- `level0`: No elevation (flat)
- `level24`: Maximum elevation

## Visual Examples

### Basic Cards

#### Simple Card
```dart
MPCard(
  child: MPText('Simple card content'),
)
```

#### Card with Header
```dart
MPCard.withHeader(
  headerData: MPCardHeaderData(
    title: 'Card Title',
    subtitle: 'Card subtitle',
    actions: [Icon(Icons.more_vert)],
  ),
  body: MPText('Body content goes here'),
)
```

#### Card with Footer
```dart
MPCard.withFooter(
  footerData: MPCardFooterData(
    actions: [
      TextButton(onPressed: () {}, child: MPText('Cancel')),
      ElevatedButton(onPressed: () {}, child: MPText('Save')),
    ],
  ),
  body: MPText('Body content with footer actions'),
)
```

### Variant Examples

#### Elevated Card
```dart
MPCard(
  variant: MPCardVariant.elevated,
  child: MPText('Elevated card with shadow'),
)
```

#### Outlined Card
```dart
MPCard(
  variant: MPCardVariant.outlined,
  child: MPText('Outlined card with border'),
)
```

#### Filled Card
```dart
MPCard(
  variant: MPCardVariant.filled,
  child: MPText('Filled card with background'),
)
```

#### Primary Card
```dart
MPCard(
  variant: MPCardVariant.primary,
  child: MPText('Primary themed card'),
)
```

### Specialized Cards

#### Media Card
```dart
MPCard.media(
  mediaData: MPCardMediaData(
    imageUrl: 'https://example.com/image.jpg',
    title: 'Media Title',
    subtitle: 'Media subtitle',
    description: 'Description of the media content',
    actions: [
      IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
      IconButton(icon: Icon(Icons.share), onPressed: () {}),
    ],
  ),
)
```

#### Product Card
```dart
MPCard.product(
  productData: MPCardProductData(
    name: 'Product Name',
    description: 'Product description goes here',
    price: '29.99',
    originalPrice: '39.99',
    rating: 4.5,
    reviewCount: 128,
    features: ['Feature 1', 'Feature 2', 'Feature 3'],
    actions: [
      ElevatedButton(
        onPressed: () {},
        child: MPText('Add to Cart'),
      ),
    ],
  ),
)
```

#### Profile Card
```dart
MPCard.profile(
  profileData: MPCardProfileData(
    name: 'John Doe',
    username: 'johndoe',
    bio: 'Flutter developer and UI/UX enthusiast',
    isOnline: true,
    showVerifiedBadge: true,
    stats: {
      'Followers': '1.2K',
      'Following': '234',
      'Posts': '56',
    },
    actions: [
      ElevatedButton(
        onPressed: () {},
        child: MPText('Follow'),
      ),
    ],
  ),
)
```

#### Notification Card
```dart
MPCard.notification(
  notificationData: MPCardNotificationData(
    title: 'New Message',
    message: 'You have received a new message from John Doe',
    timestamp: '2 minutes ago',
    iconData: Icons.message,
    iconColor: Colors.blue,
    actions: [
      TextButton(onPressed: () {}, child: MPText('View')),
    ],
  ),
)
```

#### Dashboard Card
```dart
MPCard.dashboard(
  dashboardData: MPCardDashboardData(
    title: 'Total Revenue',
    value: '\$12,345',
    subtitle: 'This month',
    unit: 'USD',
    trend: '+12.5%',
    trendColor: Colors.green,
    showTrend: true,
    chart: Container(
      height: 60,
      child: SimpleLineChart(data: chartData),
    ),
  ),
)
```

### Interactive Cards

#### Clickable Card
```dart
MPCard(
  variant: MPCardVariant.interactive,
  onTap: () => print('Card tapped'),
  child: MPText('Click me!'),
)
```

#### Card with Hover Effects
```dart
MPCard(
  interactionConfig: MPCardInteractiveConfig(
    enableQuickActions: true,
    quickActions: [
      IconButton(icon: Icon(Icons.edit), onPressed: () {}),
      IconButton(icon: Icon(Icons.delete), onPressed: () {}),
    ],
  ),
  child: MPText('Hover over me'),
)
```

#### Expandable Card
```dart
MPCard(
  interactiveConfig: MPCardInteractiveConfig(
    enableExpandable: true,
    initiallyExpanded: false,
    onExpand: () => print('Expanded'),
    onCollapse: () => print('Collapsed'),
  ),
  child: MPText('This card can be expanded and collapsed'),
)
```

### Responsive Cards

#### Adaptive Layout
```dart
MPCard(
  layout: MPCardLayout.adaptive,
  responsive: MPCardResponsiveConfig(
    mobileLayout: MPCardLayout.vertical,
    tabletLayout: MPCardLayout.horizontal,
    desktopLayout: MPCardLayout.horizontal,
    enableOrientationAdaptation: true,
  ),
  child: MPText('This card adapts to screen size'),
)
```

#### Responsive Sizing
```dart
MPCard(
  responsive: MPCardResponsiveConfig(
    mobileSize: MPCardSize.small,
    tabletSize: MPCardSize.medium,
    desktopSize: MPCardSize.large,
  ),
  child: MPText('Responsive sizing'),
)
```

## Implementation Guide

### Step-by-Step Implementation

#### 1. Basic Setup

First, ensure you have the Micropack UI Kit imported:

```dart
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
```

#### 2. Create a Simple Card

Start with a basic card:

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MPCard(
      child: MPText('Hello, MPCard!'),
    );
  }
}
```

#### 3. Add Structure

Add header and footer:

```dart
MPCard.withSections(
  headerData: MPCardHeaderData(
    title: 'My Card',
    subtitle: 'With header and footer',
  ),
  body: MPText('This is the main content'),
  footerData: MPCardFooterData(
    actions: [
      TextButton(onPressed: () {}, child: MPText('Cancel')),
      ElevatedButton(onPressed: () {}, child: MPText('Save')),
    ],
  ),
)
```

#### 4. Customize Appearance

Add custom styling:

```dart
MPCard(
  variant: MPCardVariant.elevated,
  size: MPCardSize.large,
  elevationLevel: MPCardElevation.level8,
  backgroundColor: Colors.blue.shade50,
  borderRadius: 16.0,
  child: MPText('Custom styled card'),
)
```

#### 5. Add Interactions

Make the card interactive:

```dart
MPCard(
  onTap: () => print('Card tapped'),
  onLongPress: () => print('Card long pressed'),
  onHover: (isHovered) => print('Hover: $isHovered'),
  interactionConfig: MPCardInteractionConfig(
    enableRipple: true,
    pressedScale: 0.95,
  ),
  child: MPText('Interactive card'),
)
```

#### 6. Add Accessibility

Ensure accessibility:

```dart
MPCard(
  semanticLabel: 'Product card with price and description',
  semanticHint: 'Tap to view details',
  accessibilityConfig: MPCardAccessibilityConfig(
    enableFocusManagement: true,
    enableKeyboardNavigation: true,
    screenReader: MPCardScreenReaderConfig(
      announceStateChanges: true,
      announceInteractionHints: true,
    ),
  ),
  child: MPText('Accessible card'),
)
```

### Common Use Cases

#### List Item Card
```dart
MPCard(
  variant: MPCardVariant.outlined,
  size: MPCardSize.medium,
  onTap: () => _navigateToDetail(item),
  child: Row(
    children: [
      CircleAvatar(
        backgroundImage: NetworkImage(item.imageUrl),
        radius: 24,
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText.subhead(item.title),
            MPText.small(item.subtitle),
          ],
        ),
      ),
      Icon(Icons.chevron_right),
    ],
  ),
)
```

#### Settings Card
```dart
MPCard.withSections(
  headerData: MPCardHeaderData(
    title: 'Settings',
    actions: [
      IconButton(
        icon: Icon(Icons.help_outline),
        onPressed: () => _showHelp(),
      ),
    ],
  ),
  body: Column(
    children: [
      _buildSettingItem('Notifications', true),
      _buildSettingItem('Dark Mode', false),
      _buildSettingItem('Auto-sync', true),
    ],
  ),
)
```

#### Statistics Card
```dart
MPCard.dashboard(
  dashboardData: MPCardDashboardData(
    title: 'Active Users',
    value: '1,234',
    subtitle: 'Currently online',
    trend: '+5.2%',
    trendColor: Colors.green,
    showTrend: true,
    icon: Icon(Icons.people, color: Colors.blue),
  ),
)
```

### Integration with Theme System

MPCard automatically integrates with your theme:

```dart
// Theme-aware card
MPCard(
  variant: MPCardVariant.primary, // Uses theme primary color
  child: MPText('Themed card'),
)

// Custom theme override
MPCard(
  themeData: MPCardThemeData(
    backgroundColor: Colors.purple.shade50,
    borderColor: Colors.purple.shade200,
    shadowColor: Colors.purple.shade300,
  ),
  child: MPText('Custom themed card'),
)
```

### Performance Optimization Tips

1. **Use Const Constructors**: When possible, use const constructors for data classes
2. **Optimize Images**: Use appropriate image sizes and caching
3. **Lazy Loading**: For large lists, consider lazy loading
4. **Avoid Unnecessary Rebuilds**: Use const widgets where possible

```dart
// Good: Const constructor
const headerData = MPCardHeaderData(
  title: 'Static Title',
);

// Good: Efficient image loading
MPCard.media(
  mediaData: MPCardMediaData(
    imageUrl: imageUrl,
    imageHeight: 200, // Specify dimensions
    imageFit: BoxFit.cover,
  ),
)

// Good: Lazy loading in ListView
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return MPCard(
      key: ValueKey(items[index].id), // Stable key
      child: ItemWidget(item: items[index]),
    );
  },
)
```

## Accessibility Guide

### WCAG Compliance Overview

MPCard is designed to meet WCAG 2.1 AA standards by default:

- **Perceivable**: High contrast ratios, clear visual hierarchy
- **Operable**: Keyboard navigation, clear focus indicators
- **Understandable**: Semantic labels, clear instructions
- **Robust**: Compatible with assistive technologies

### Screen Reader Support

#### Basic Screen Reader Usage
```dart
MPCard(
  semanticLabel: 'Product: Wireless Headphones, Price: \$99.99',
  semanticHint: 'Double tap to view product details',
  child: MPText('Wireless Headphones'),
)
```

#### Advanced Screen Reader Configuration
```dart
MPCard(
  accessibilityConfig: MPCardAccessibilityConfig(
    screenReader: MPCardScreenReaderConfig(
      announceStateChanges: true,
      announceInteractionHints: true,
      readingOrder: [MPCardReadingOrder.headerBodyFooter],
      customActions: [
        SemanticsAction.tap,
        SemanticsAction.longPress,
      ],
      onCustomAction: (action) {
        switch (action) {
          case SemanticsAction.tap:
            _handleTap();
            break;
          case SemanticsAction.longPress:
            _handleLongPress();
            break;
        }
      },
    ),
  ),
  child: MPText('Advanced accessibility'),
)
```

### Keyboard Navigation

#### Basic Keyboard Navigation
```dart
MPCard(
  focusNode: _focusNode,
  autofocus: true,
  onTap: () => _handleSelection(),
  child: MPText('Keyboard navigable card'),
)
```

#### Advanced Keyboard Configuration
```dart
MPCard(
  accessibilityConfig: MPCardAccessibilityConfig(
    enableKeyboardNavigation: true,
    keyboard: MPCardKeyboardConfig(
      enableArrowKeys: true,
      enableEscapeKey: true,
      enableEnterSpaceActivation: true,
      customKeyBindings: {
        SingleActivator(LogicalKeyboardKey.keyD): () => _delete(),
        SingleActivator(LogicalKeyboardKey.keyE): () => _edit(),
      },
    ),
  ),
  child: MPText('Advanced keyboard navigation'),
)
```

### High Contrast Support

#### High Contrast Detection
```dart
MPCard(
  accessibilityConfig: MPCardAccessibilityConfig(
    enableHighContrast: true,
    highContrast: MPCardHighContrastConfig(
      autoDetect: true,
      minimumTextContrastRatio: 4.5,
      minimumInteractiveContrastRatio: 3.0,
      enableHighContrastBorders: true,
      highContrastBorderWidth: 2.0,
    ),
  ),
  child: MPText('High contrast supported'),
)
```

#### Custom High Contrast Theme
```dart
MPCard(
  accessibilityConfig: MPCardAccessibilityConfig(
    highContrast: MPCardHighContrastConfig(
      highContrastTheme: MPCardThemeData(
        backgroundColor: Colors.black,
        borderColor: Colors.white,
        shadowColor: Colors.white,
      ),
    ),
  ),
  child: MPText('Custom high contrast'),
)
```

### Reduced Motion Support

#### Reduced Motion Configuration
```dart
MPCard(
  accessibilityConfig: MPCardAccessibilityConfig(
    respectReducedMotion: true,
    motion: MPCardMotionConfig(
      respectSystemReducedMotion: true,
      enableAnimations: true,
      reducedMotionDurationMultiplier: 0.1,
      disableHoverEffects: false,
      disableTransitions: false,
    ),
  ),
  child: MPText('Reduced motion aware'),
)
```

### Focus Management

#### Focus Navigation
```dart
MPCard(
  accessibilityConfig: MPCardAccessibilityConfig(
    enableFocusManagement: true,
    focusNavigation: MPCardFocusNavigationConfig(
      enableArrowKeyNavigation: true,
      enableTabNavigation: true,
      trapFocus: false,
      focusHighlightColor: Colors.blue,
      focusHighlightWidth: 2.0,
      focusHighlightRadius: 8.0,
      autofocus: false,
      onFocusChange: (hasFocus) {
        print('Focus changed: $hasFocus');
      },
    ),
  ),
  child: MPText('Focus managed card'),
)
```

## Migration Guide

### From MPArticleCard

#### Basic Migration

**Before (MPArticleCard):**
```dart
MPArticleCard(
  title: 'Article Title',
  description: 'Article description goes here...',
  author: 'John Doe',
  date: 'March 15, 2024',
  readTime: '5 min read',
  imageUrl: 'https://example.com/image.jpg',
  onTap: () => print('Card tapped'),
  variant: MPArticleCardVariant.elevated,
  size: MPArticleCardSize.medium,
)
```

**After (MPCard):**
```dart
MPCard.content(
  contentData: MPCardContentData(
    title: 'Article Title',
    description: 'Article description goes here...',
    metadata: Row(
      children: [
        MPText.small('John Doe'),
        SizedBox(width: 8),
        MPText.small('March 15, 2024'),
        SizedBox(width: 8),
        MPText.small('5 min read'),
      ],
    ),
  ),
  onTap: () => print('Card tapped'),
  variant: MPCardVariant.elevated,
  size: MPCardSize.medium,
)
```

#### Media Card Migration

**Before (MPArticleCard with image):**
```dart
MPArticleCard(
  title: 'Media Title',
  description: 'Media description',
  imageUrl: 'https://example.com/image.jpg',
  variant: MPArticleCardVariant.media,
)
```

**After (MPCard):**
```dart
MPCard.media(
  mediaData: MPCardMediaData(
    title: 'Media Title',
    description: 'Media description',
    imageUrl: 'https://example.com/image.jpg',
  ),
)
```

### From Container

**Before (Container):**
```dart
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: content,
)
```

**After (MPCard):**
```dart
MPCard(
  child: content,
  variant: MPCardVariant.elevated,
)
```

### Breaking Changes and Compatibility

#### Enum Changes
- `MPArticleCardVariant` → `MPCardVariant`
- `MPArticleCardSize` → `MPCardSize`

#### Parameter Changes
- `title` → `headerData.title` or `contentData.title`
- `description` → `contentData.description`
- `imageUrl` → `mediaData.imageUrl`
- `author`, `date`, `readTime` → `contentData.metadata`

#### Constructor Changes
- Direct parameters → Data classes for structured content
- Separate constructors for different card types

### Migration Checklist

- [ ] Update import statements
- [ ] Replace enum references
- [ ] Migrate constructor parameters
- [ ] Update data structure usage
- [ ] Test visual appearance
- [ ] Verify interaction behavior
- [ ] Check accessibility features
- [ ] Validate responsive behavior

## Testing Guide

### Unit Testing Strategies

#### Testing Basic Properties
```dart
test('MPCard creates with default properties', () {
  final card = MPCard(
    child: Text('Test'),
  );

  expect(card.variant, MPCardVariant.surface);
  expect(card.size, MPCardSize.medium);
  expect(card.layout, MPCardLayout.vertical);
  expect(card.enabled, true);
});
```

#### Testing Custom Properties
```dart
test('MPCard creates with custom properties', () {
  final card = MPCard(
    variant: MPCardVariant.elevated,
    size: MPCardSize.large,
    enabled: false,
    child: Text('Test'),
  );

  expect(card.variant, MPCardVariant.elevated);
  expect(card.size, MPCardSize.large);
  expect(card.enabled, false);
});
```

#### Testing Data Classes
```dart
test('MPCardHeaderData creates correctly', () {
  final headerData = MPCardHeaderData(
    title: 'Test Title',
    subtitle: 'Test Subtitle',
  );

  expect(headerData.title, 'Test Title');
  expect(headerData.subtitle, 'Test Subtitle');
});
```

### Widget Testing Approaches

#### Testing Basic Rendering
```dart
testWidgets('MPCard renders correctly', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: MPCard(
          child: Text('Test Card'),
        ),
      ),
    ),
  );

  expect(find.text('Test Card'), findsOneWidget);
  expect(find.byType(MPCard), findsOneWidget);
});
```

#### Testing Variants
```dart
testWidgets('MPCard renders different variants', (WidgetTester tester) async {
  for (final variant in MPCardVariant.values) {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MPCard(
            variant: variant,
            child: Text('Test'),
          ),
        ),
      ),
    );

    expect(find.byType(MPCard), findsOneWidget);
  }
});
```

#### Testing Interactions
```dart
testWidgets('MPCard handles tap correctly', (WidgetTester tester) async {
  bool wasTapped = false;

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: MPCard(
          onTap: () => wasTapped = true,
          child: Text('Test'),
        ),
      ),
    ),
  );

  await tester.tap(find.byType(MPCard));
  await tester.pump();

  expect(wasTapped, true);
});
```

#### Testing Accessibility
```dart
testWidgets('MPCard has correct semantics', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: MPCard(
          semanticLabel: 'Test Card',
          onTap: () {},
          child: Text('Test'),
        ),
      ),
    ),
  );

  expect(
    tester.getSemantics(find.byType(MPCard)).label,
    'Test Card',
  );

  expect(
    tester.getSemantics(find.byType(MPCard)).actions.contains(SemanticsAction.tap),
    true,
  );
});
```

### Integration Testing Guidelines

#### Testing Theme Integration
```dart
testWidgets('MPCard integrates with theme', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        body: MPCard(
          variant: MPCardVariant.primary,
          child: Text('Test'),
        ),
      ),
    ),
  );

  final card = tester.widget<MPCard>(find.byType(MPCard));
  expect(card.variant, MPCardVariant.primary);
});
```

#### Testing Responsive Behavior
```dart
testWidgets('MPCard adapts to screen size', (WidgetTester tester) async {
  // Test mobile size
  tester.binding.window.physicalSizeTestValue = Size(400, 800);
  tester.binding.window.devicePixelRatioTestValue = 1.0;

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: MPCard(
          responsive: MPCardResponsiveConfig(
            mobileSize: MPCardSize.small,
            desktopSize: MPCardSize.large,
          ),
          child: Text('Test'),
        ),
      ),
    ),
  );

  // Verify mobile behavior
  expect(find.byType(MPCard), findsOneWidget);

  // Test desktop size
  tester.binding.window.physicalSizeTestValue = Size(1200, 800);
  await tester.pump();

  // Verify desktop behavior
  expect(find.byType(MPCard), findsOneWidget);
});
```

### Golden Testing Setup

#### Setting Up Golden Tests
```dart
void main() {
  testWidgets('MPCard golden test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MPCard(
            variant: MPCardVariant.elevated,
            child: Text('Golden Test'),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(MPCard),
      matchesGoldenFile('goldens/mp_card_elevated.png'),
    );
  });
}
```

#### Testing All Variants
```dart
void main() {
  for (final variant in MPCardVariant.values) {
    testWidgets('MPCard golden test - $variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPCard(
              variant: variant,
              child: Text('Golden Test - $variant'),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MPCard),
        matchesGoldenFile('goldens/mp_card_${variant.name}.png'),
      );
    });
  }
}
```

### Performance Testing

#### Testing Render Performance
```dart
testWidgets('MPCard renders efficiently', (WidgetTester tester) async {
  final stopwatch = Stopwatch()..start();

  await tester.pumpWidget(
    MaterialApp(
      home: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return MPCard(
            key: ValueKey(index),
            child: Text('Card $index'),
          );
        },
      ),
    ),
  );

  stopwatch.stop();

  // Should render within reasonable time
  expect(stopwatch.elapsedMilliseconds, lessThan(1000));
});
```

## Troubleshooting

### Common Issues and Solutions

#### Card Not Rendering

**Problem**: Card doesn't appear on screen

**Solution**: Check that you're providing either `child`, `body`, or structured content:

```dart
// ❌ Missing content
MPCard()

// ✅ With content
MPCard(child: Text('Content'))

// ✅ With structured content
MPCard.withHeader(
  headerData: MPCardHeaderData(title: 'Title'),
  body: Text('Body'),
)
```

#### Theme Not Applied

**Problem**: Card doesn't use theme colors

**Solution**: Ensure you're using theme-aware variants:

```dart
// ❌ Won't use theme
MPCard(
  backgroundColor: Colors.blue,
  child: Text('Content'),
)

// ✅ Will use theme
MPCard(
  variant: MPCardVariant.primary,
  child: Text('Content'),
)
```

#### Responsive Layout Not Working

**Problem**: Card doesn't adapt to screen size

**Solution**: Configure responsive settings correctly:

```dart
MPCard(
  layout: MPCardLayout.adaptive,
  responsive: MPCardResponsiveConfig(
    mobileLayout: MPCardLayout.vertical,
    tabletLayout: MPCardLayout.horizontal,
    desktopLayout: MPCardLayout.horizontal,
    enableOrientationAdaptation: true,
  ),
  child: Text('Responsive content'),
)
```

#### Accessibility Issues

**Problem**: Screen reader doesn't announce content

**Solution**: Provide semantic labels:

```dart
MPCard(
  semanticLabel: 'Product card with price \$29.99',
  semanticHint: 'Tap to view details',
  child: Text('Product'),
)
```

#### Performance Issues

**Problem**: Cards are slow to render in lists

**Solution**: Optimize for performance:

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return MPCard(
      key: ValueKey(items[index].id), // Stable key
      child: Text(items[index].title),
    );
  },
)
```

### Debugging Tips

#### 1. Enable Debug Flags
```dart
MPCard(
  debugLabel: 'MyCard', // For debugging
  child: Text('Debug card'),
)
```

#### 2. Check Responsive State
```dart
// In your widget
@override
Widget build(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  print('Screen size: ${screenSize.width}x${screenSize.height}');

  return MPCard(
    child: Text('Debug info'),
  );
}
```

#### 3. Inspect Theme Colors
```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  print('Primary color: ${theme.primaryColor}');

  return MPCard(
    variant: MPCardVariant.primary,
    child: Text('Theme debug'),
  );
}
```

### Performance Optimization Tips

#### 1. Use Const Constructors
```dart
// Good
const headerData = MPCardHeaderData(
  title: 'Static Title',
);

// Bad (rebuilds every time)
final headerData = MPCardHeaderData(
  title: 'Dynamic Title',
);
```

#### 2. Optimize Image Loading
```dart
// Good: Specify dimensions
MPCard.media(
  mediaData: MPCardMediaData(
    imageUrl: url,
    imageHeight: 200,
    imageWidth: 300,
    imageFit: BoxFit.cover,
  ),
)

// Bad: No dimensions
MPCard.media(
  mediaData: MPCardMediaData(
    imageUrl: url,
  ),
)
```

#### 3. Use Efficient Widgets
```dart
// Good: Efficient text widget
MPText.body('Content')

// Bad: Less efficient
Text(
  'Content',
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
)
```

### Theme Integration Troubleshooting

#### Custom Theme Not Applied

**Problem**: Custom theme colors not showing

**Solution**: Ensure theme is properly configured:

```dart
MaterialApp(
  theme: ThemeData(
    // Make sure your theme extends the correct theme
    extensions: [MPThemeData(...)],
  ),
  home: MPCard(
    variant: MPCardVariant.primary,
    child: Text('Themed'),
  ),
)
```

#### Dark Mode Issues

**Problem**: Cards don't adapt to dark mode

**Solution**: Use adaptive colors:

```dart
// Good: Uses adaptive colors
MPCard(
  variant: MPCardVariant.surface,
  child: Text('Adaptive'),
)

// Bad: Static colors
MPCard(
  backgroundColor: Colors.white,
  child: Text('Static'),
)
```

### Getting Help

If you're still having issues:

1. Check the [GitHub Issues](https://github.com/your-repo/issues) for known problems
2. Create a minimal reproduction case
3. Include your MPCard configuration
4. Mention the Flutter version and platform
5. Provide screenshots if it's a visual issue

### Contributing

Found a bug or want to improve MPCard?

1. Fork the repository
2. Create a feature branch
3. Add tests for your changes
4. Update documentation
5. Submit a pull request

---

*This documentation covers MPCard version 1.0.0. For the latest updates, check the official repository.*