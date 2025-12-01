# MPCard Implementation Guide

## Quick Start Examples

### Basic Usage

```dart
// Simple card with content
MPCard(
  child: MPText('Hello World'),
)

// Card with custom styling
MPCard(
  variant: MPCardVariant.elevated,
  size: MPCardSize.large,
  child: MPText('Styled Card'),
)
```

### Content Slots

```dart
// Header-Body-Footer pattern
MPCard(
  header: Row(
    children: [
      MPText.head('Card Title'),
      Spacer(),
      Icon(Icons.more_vert),
    ],
  ),
  body: MPText('This is the main content of the card.'),
  footer: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      MPButton(
        text: 'Cancel',
        variant: MPButtonVariant.ghost,
        onPressed: () {},
      ),
      MPButton(
        text: 'Save',
        onPressed: () {},
      ),
    ],
  ),
)
```

### Predefined Patterns

```dart
// Media card pattern
MPCard.media(
  image: NetworkImage('https://example.com/image.jpg'),
  title: 'Beautiful Landscape',
  subtitle: 'A stunning view of mountains and lakes',
  actions: [
    MPButton(
      text: 'Like',
      icon: Icons.favorite,
      onPressed: () {},
    ),
    MPButton(
      text: 'Share',
      icon: Icons.share,
      onPressed: () {},
    ),
  ],
)

// Content card pattern
MPCard.content(
  title: 'Article Title',
  description: 'This is a comprehensive description of the article content that provides detailed information about the topic.',
  metadata: Row(
    children: [
      Icon(Icons.person, size: 16),
      SizedBox(width: 4),
      MPText.small('John Doe'),
      SizedBox(width: 16),
      Icon(Icons.calendar_today, size: 16),
      SizedBox(width: 4),
      MPText.small('Dec 1, 2023'),
    ],
  ),
)
```

### Interactive Cards

```dart
// Clickable card
MPCard.interactive(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MPText.head('Interactive Card'),
      SizedBox(height: 8),
      MPText('Tap this card to trigger an action.'),
    ],
  ),
  onTap: () {
    print('Card tapped!');
  },
  onHover: (isHovered) {
    print('Card hovered: $isHovered');
  },
)
```

## Advanced Usage

### Builder Pattern

```dart
MPCard.builder()
  .header(
    Row(
      children: [
        CircleAvatar(
          backgroundColor: context.mp.primary,
          child: MPText('JD', color: Colors.white),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MPText.subhead('John Doe'),
              MPText.small('john.doe@example.com'),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    ),
  )
  .body(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText('This is a complex card built using the builder pattern.'),
        SizedBox(height: 12),
        Row(
          children: [
            _buildStat('Posts', '42'),
            SizedBox(width: 24),
            _buildStat('Followers', '1.2K'),
            SizedBox(width: 24),
            _buildStat('Following', '89'),
          ],
        ),
      ],
    ),
  )
  .footer(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.message, 'Message'),
        _buildActionButton(Icons.phone, 'Call'),
        _buildActionButton(Icons.video_call, 'Video'),
      ],
    ),
  )
  .variant(MPCardVariant.elevated)
  .size(MPCardSize.medium)
  .responsive(MPCardResponsiveConfig(
    mobileLayout: MPCardLayout.vertical,
    tabletLayout: MPCardLayout.horizontal,
    desktopLayout: MPCardLayout.horizontal,
  ))
  .onTap(() => print('Profile card tapped'))
  .build()

Widget _buildStat(String label, String value) {
  return Column(
    children: [
      MPText.head(value),
      MPText.small(label),
    ],
  );
}

Widget _buildActionButton(IconData icon, String label) {
  return Column(
    children: [
      Icon(icon, color: context.mp.primary),
      SizedBox(height: 4),
      MPText.small(label),
    ],
  );
}
```

### Responsive Cards

```dart
class ResponsiveCardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        childAspectRatio: _getAspectRatio(context),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return MPCard.content(
          title: 'Card $index',
          description: 'This card adapts its layout based on screen size.',
          variant: MPCardVariant.elevated,
          responsive: MPCardResponsiveConfig(
            mobileLayout: MPCardLayout.vertical,
            tabletLayout: MPCardLayout.horizontal,
            desktopLayout: MPCardLayout.horizontal,
          ),
        );
      },
      itemCount: 6,
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) return 1;
    if (screenWidth <= 1024) return 2;
    return 3;
  }

  double _getAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) return 1.0;
    if (screenWidth <= 1024) return 1.5;
    return 2.0;
  }
}
```

### Custom Theme Integration

```dart
class CustomThemedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MPCard(
      variant: MPCardVariant.primary,
      themeData: MPCardThemeData(
        backgroundColor: context.mp.primary.withValues(alpha: 0.1),
        borderColor: context.mp.primary,
        shadowColor: context.mp.primary.withValues(alpha: 0.2),
        hoverColor: context.mp.primary.withValues(alpha: 0.2),
        pressedColor: context.mp.primary.withValues(alpha: 0.3),
      ),
      child: MPText(
        'Custom Themed Card',
        color: context.mp.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
```

## Theme Integration Examples

### Light/Dark Mode Adaptation

```dart
class ThemedCardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Uses theme-aware colors automatically
        MPCard(
          variant: MPCardVariant.elevated,
          child: MPText('Adapts to theme automatically'),
        ),

        // Manual theme-aware styling
        MPCard(
          backgroundColor: context.mp.adaptiveBackgroundColor,
          borderColor: context.mp.adaptiveBorderColor,
          child: MPText(
            'Manual theme integration',
            color: context.mp.textColor,
          ),
        ),

        // Dark mode specific styling
        MPCard(
          backgroundColor: context.mp.isDarkMode
              ? context.mp.neutral20
              : context.mp.neutral100,
          child: MPText(
            'Dark mode specific',
            color: context.mp.isDarkMode
                ? context.mp.neutral100
                : context.mp.neutral20,
          ),
        ),
      ],
    );
  }
}
```

### Variant Styling

```dart
class VariantShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        // Primary variant
        MPCard(
          variant: MPCardVariant.primary,
          child: MPText('Primary'),
        ),

        // Secondary variant
        MPCard(
          variant: MPCardVariant.secondary,
          child: MPText('Secondary'),
        ),

        // Elevated variant
        MPCard(
          variant: MPCardVariant.elevated,
          child: MPText('Elevated'),
        ),

        // Outlined variant
        MPCard(
          variant: MPCardVariant.outlined,
          child: MPText('Outlined'),
        ),

        // Glass variant
        MPCard(
          variant: MPCardVariant.glass,
          child: MPText('Glass'),
        ),
      ],
    );
  }
}
```

## Interactive Examples

### State Management

```dart
class InteractiveCardExample extends StatefulWidget {
  @override
  _InteractiveCardExampleState createState() => _InteractiveCardExampleState();
}

class _InteractiveCardExampleState extends State<InteractiveCardExample> {
  bool _isSelected = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MPCard(
      variant: MPCardVariant.interactive,
      selected: _isSelected,
      enabled: !_isLoading,
      onTap: _isLoading ? null : _handleTap,
      child: Column(
        children: [
          Row(
            children: [
              MPText.head('Interactive Card'),
              Spacer(),
              if (_isLoading)
                CircularProgressIndicator(
                  color: context.mp.primary,
                  strokeWidth: 2,
                )
              else
                Icon(
                  _isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: _isSelected ? context.mp.successColor : context.mp.subtitleColor,
                ),
            ],
          ),
          SizedBox(height: 12),
          MPText(
            _isSelected
                ? 'Card is selected and ready for action.'
                : 'Tap to select this card for processing.',
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MPButton(
                text: 'Reset',
                variant: MPButtonVariant.ghost,
                onPressed: _resetCard,
              ),
              MPButton(
                text: _isLoading ? 'Processing...' : 'Process',
                onPressed: _isLoading ? null : _processCard,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  void _resetCard() {
    setState(() {
      _isSelected = false;
      _isLoading = false;
    });
  }

  void _processCard() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate processing
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MPText('Card processed successfully!'),
        backgroundColor: context.mp.successColor,
      ),
    );
  }
}
```

## Accessibility Examples

### Semantic Labels

```dart
class AccessibleCardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MPCard(
      semanticLabel: 'Product card for wireless headphones with price $199.99',
      semanticHint: 'Tap to view product details',
      onTap: () => _showProductDetails(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image with alt text
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: context.mp.neutral20,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.headphones,
              size: 64,
              color: context.mp.neutral60,
            ),
          ),
          SizedBox(height: 16),

          // Product information
          MPText.head('Wireless Headphones'),
          SizedBox(height: 8),
          MPText(
            'Premium noise-cancelling wireless headphones with 30-hour battery life.',
            color: context.mp.subtitleColor,
          ),
          SizedBox(height: 16),

          // Price and rating
          Row(
            children: [
              MPText.head(
                '\$199.99',
                color: context.mp.primary,
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  MPText('4.5'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showProductDetails() {
    // Navigate to product details
  }
}
```

### Keyboard Navigation

```dart
class KeyboardNavigableCard extends StatefulWidget {
  @override
  _KeyboardNavigableCardState createState() => _KeyboardNavigableCardState();
}

class _KeyboardNavigableCardState extends State<KeyboardNavigableCard> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MPCard(
      focusNode: _focusNode,
      autofocus: true,
      semanticLabel: 'Keyboard navigable card, press Enter or Space to activate',
      onTap: _handleAction,
      child: MPText('Focus this card and press Enter or Space'),
    );
  }

  void _handleAction() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: MPText('Card action activated!')),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
```

## Performance Examples

### Efficient List Rendering

```dart
class EfficientCardList extends StatelessWidget {
  final List<CardData> cards;

  const EfficientCardList({required this.cards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];

        // Use const constructors where possible
        return MPCard.content(
          key: ValueKey(card.id), // Important for list performance
          title: card.title,
          description: card.description,
          variant: MPCardVariant.elevated,
          // Use ValueListenableBuilder for state changes
          onTap: () => _handleCardTap(card),
        );
      },
    );
  }

  void _handleCardTap(CardData card) {
    // Handle card tap
  }
}
```

### Lazy Content Loading

```dart
class LazyLoadCard extends StatefulWidget {
  @override
  _LazyLoadCardState createState() => _LazyLoadCardState();
}

class _LazyLoadCardState extends State<LazyLoadCard> {
  bool _isContentVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MPCard(
      onTap: _toggleContent,
      child: Column(
        children: [
          MPText.head('Lazy Load Card'),
          SizedBox(height: 8),
          MPText('Tap to load additional content'),

          // Only render content when needed
          if (_isContentVisible) ...[
            if (_isLoading)
              Container(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(
                    color: context.mp.primary,
                  ),
                ),
              )
            else
              _buildLazyContent(),
          ],
        ],
      ),
    );
  }

  Widget _buildLazyContent() {
    return Column(
      children: [
        SizedBox(height: 16),
        MPText('This content was loaded on demand!'),
        SizedBox(height: 8),
        MPText(
          'Lazy loading improves initial render performance.',
          color: context.mp.subtitleColor,
        ),
      ],
    );
  }

  Future<void> _toggleContent() async {
    if (_isContentVisible) {
      setState(() {
        _isContentVisible = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _isContentVisible = true;
    });

    // Simulate content loading
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }
}
```

## Testing Examples

### Widget Test

```dart
void main() {
  testWidgets('MPCard renders correctly with basic props', (tester) async {
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

  testWidgets('MPCard handles tap interactions', (tester) async {
    bool wasTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MPCard(
            onTap: () => wasTapped = true,
            child: Text('Tap Me'),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(MPCard));
    await tester.pump();

    expect(wasTapped, isTrue);
  });

  testWidgets('MPCard adapts to theme changes', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        home: Scaffold(
          body: MPCard(
            variant: MPCardVariant.primary,
            child: Text('Theme Test'),
          ),
        ),
      ),
    );

    // Get initial card
    var card = tester.widget<MPCard>(find.byType(MPCard));

    // Switch to dark theme
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home: Scaffold(
          body: MPCard(
            variant: MPCardVariant.primary,
            child: Text('Theme Test'),
          ),
        ),
      ),
    );

    await tester.pump();

    // Verify theme adaptation
    expect(find.byType(MPCard), findsOneWidget);
  });
}
```

### Golden Test

```dart
void main() {
  testWidgets('MPCard golden test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: MPCard(
              variant: MPCardVariant.elevated,
              size: MPCardSize.medium,
              child: Text('Golden Test'),
            ),
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

## Best Practices

### 1. Use Theme-Aware Colors

```dart
// ✅ Good - Uses theme utilities
MPCard(
  variant: MPCardVariant.elevated,
  child: MPText('Themed content'),
)

// ❌ Avoid - Hardcoded colors
MPCard(
  backgroundColor: Colors.white,
  child: MPText('Hardcoded colors'),
)
```

### 2. Leverage Responsive Features

```dart
// ✅ Good - Responsive configuration
MPCard(
  responsive: MPCardResponsiveConfig(
    mobileLayout: MPCardLayout.vertical,
    tabletLayout: MPCardLayout.horizontal,
  ),
  child: content,
)

// ❌ Less ideal - Static layout
MPCard(
  child: content,
)
```

### 3. Implement Accessibility

```dart
// ✅ Good - With semantic labels
MPCard(
  semanticLabel: 'Product card with price and description',
  child: productContent,
)

// ❌ Missing accessibility
MPCard(
  child: productContent,
)
```

### 4. Optimize Performance

```dart
// ✅ Good - Efficient list rendering
ListView.builder(
  itemBuilder: (context, index) {
    return MPCard(
      key: ValueKey(items[index].id),
      child: Text(items[index].title),
    );
  },
)

// ❌ Less efficient - No keys
ListView(
  children: items.map((item) {
    return MPCard(
      child: Text(item.title),
    );
  }).toList(),
)
```

This implementation guide provides practical examples for using MPCard in various scenarios while following best practices for performance, accessibility, and theme integration.