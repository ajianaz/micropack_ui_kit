import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPCardBuilder', () {
    testWidgets('should create basic card with default values',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Test Card')
          .content(const Text('Card content'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Test Card'), findsOneWidget);
      expect(find.text('Card content'), findsOneWidget);
    });

    testWidgets('should create card from existing card configuration',
        (WidgetTester tester) async {
      final originalCard = MPCard(
        variant: MPCardVariant.primary,
        size: MPCardSize.large,
        headerData: MPCardHeaderData(title: 'Original Card'),
        body: const Text('Original content'),
      );

      final builder = MPCardBuilder.fromCard(originalCard);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Original Card'), findsOneWidget);
      expect(find.text('Original content'), findsOneWidget);
    });

    testWidgets('should apply variant correctly', (WidgetTester tester) async {
      for (final variant in MPCardVariant.values) {
        final builder = MPCardBuilder()
            .variant(variant)
            .title('Test Card')
            .content(const Text('Content'));

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: builder.build(),
            ),
          ),
        );

        expect(find.text('Test Card'), findsOneWidget);
        expect(find.text('Content'), findsOneWidget);

        await tester.pumpWidget(Container()); // Clean up
      }
    });

    testWidgets('should apply size correctly', (WidgetTester tester) async {
      for (final size in MPCardSize.values) {
        final builder = MPCardBuilder()
            .size(size)
            .title('Test Card')
            .content(const Text('Content'));

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: builder.build(),
            ),
          ),
        );

        expect(find.text('Test Card'), findsOneWidget);
        expect(find.text('Content'), findsOneWidget);

        await tester.pumpWidget(Container()); // Clean up
      }
    });

    testWidgets('should apply layout correctly', (WidgetTester tester) async {
      for (final layout in MPCardLayout.values) {
        final builder = MPCardBuilder()
            .layout(layout)
            .title('Test Card')
            .content(const Text('Content'));

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: builder.build(),
            ),
          ),
        );

        expect(find.text('Test Card'), findsOneWidget);
        expect(find.text('Content'), findsOneWidget);

        await tester.pumpWidget(Container()); // Clean up
      }
    });

    testWidgets('should apply custom colors and styling',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .backgroundColor(Colors.red)
          .borderColor(Colors.blue)
          .borderWidth(2.0)
          .borderRadius(12.0)
          .elevation(8.0)
          .title('Styled Card')
          .content(const Text('Styled content'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Styled Card'), findsOneWidget);
      expect(find.text('Styled content'), findsOneWidget);
    });

    testWidgets('should apply padding and margin correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .padding(const EdgeInsets.all(16.0))
          .margin(const EdgeInsets.all(8.0))
          .title('Padded Card')
          .content(const Text('Padded content'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Padded Card'), findsOneWidget);
      expect(find.text('Padded content'), findsOneWidget);
    });

    testWidgets('should handle interactions correctly',
        (WidgetTester tester) async {
      bool wasTapped = false;
      bool wasLongPressed = false;

      final builder = MPCardBuilder()
          .title('Interactive Card')
          .content(const Text('Interactive content'))
          .onTap(() => wasTapped = true)
          .onLongPress(() => wasLongPressed = true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Interactive Card'), findsOneWidget);
      expect(find.text('Interactive content'), findsOneWidget);

      await tester.tap(find.byType(Card));
      expect(wasTapped, isTrue);

      await tester.longPress(find.byType(Card));
      expect(wasLongPressed, isTrue);
    });

    testWidgets('should handle hover correctly', (WidgetTester tester) async {
      bool isHovered = false;

      final builder = MPCardBuilder()
          .title('Hover Card')
          .content(const Text('Hover content'))
          .onHover((hovering) => isHovered = hovering);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Hover Card'), findsOneWidget);
      expect(find.text('Hover content'), findsOneWidget);

      await tester.pumpWidget(Container()); // Clean up
    });

    testWidgets('should handle selection correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Selectable Card')
          .content(const Text('Selectable content'))
          .selectable(true)
          .selected(true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Selectable Card'), findsOneWidget);
      expect(find.text('Selectable content'), findsOneWidget);
    });

    testWidgets('should handle overflow handling', (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Overflow Card')
          .content(const Text('Overflow content'))
          .overflowHandling(false);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Overflow Card'), findsOneWidget);
      expect(find.text('Overflow content'), findsOneWidget);
    });

    testWidgets('should apply clip behavior correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Clip Card')
          .content(const Text('Clip content'))
          .clipBehavior(Clip.hardEdge);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Clip Card'), findsOneWidget);
      expect(find.text('Clip content'), findsOneWidget);
    });

    testWidgets('should use convenience methods correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .primary()
          .large()
          .vertical()
          .title('Convenience Card')
          .content(const Text('Convenience content'))
          .spacing(16.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Convenience Card'), findsOneWidget);
      expect(find.text('Convenience content'), findsOneWidget);
    });

    testWidgets('should handle conditional rendering correctly',
        (WidgetTester tester) async {
      final condition = true;
      final builder = MPCardBuilder().title('Conditional Card').when(
          condition,
          () => MPCardBuilder()
              .title('Conditional Card')
              .content(const Text('Conditional content')));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Conditional Card'), findsOneWidget);
      expect(find.text('Conditional content'), findsOneWidget);
    });

    testWidgets('should handle whenNotNull correctly',
        (WidgetTester tester) async {
      final value = 'Not Null Value';
      final builder = MPCardBuilder().title('WhenNotNull Card').whenNotNull(
          value,
          (val) => MPCardBuilder()
              .title('WhenNotNull Card')
              .content(Text('Value: $val')));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('WhenNotNull Card'), findsOneWidget);
      expect(find.text('Value: Not Null Value'), findsOneWidget);
    });

    testWidgets('should handle whenNotEmpty correctly',
        (WidgetTester tester) async {
      final value = 'Not Empty Value';
      final builder = MPCardBuilder().title('WhenNotEmpty Card').whenNotEmpty(
          value,
          (val) => MPCardBuilder()
              .title('WhenNotEmpty Card')
              .content(Text('Value: $val')));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('WhenNotEmpty Card'), findsOneWidget);
      expect(find.text('Value: Not Empty Value'), findsOneWidget);
    });

    testWidgets('should handle whenListNotEmpty correctly',
        (WidgetTester tester) async {
      final list = ['Item 1', 'Item 2'];
      final builder = MPCardBuilder()
          .title('WhenListNotEmpty Card')
          .whenListNotEmpty(
              list,
              (val) => MPCardBuilder()
                  .title('WhenListNotEmpty Card')
                  .content(Text('Items: ${val.length}')));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('WhenListNotEmpty Card'), findsOneWidget);
      expect(find.text('Items: 2'), findsOneWidget);
    });

    testWidgets('should handle lazy rendering', (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .lazyRendering(true)
          .title('Lazy Card')
          .content(const Text('Lazy content'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Lazy Card'), findsOneWidget);
      expect(find.text('Lazy content'), findsOneWidget);
    });

    testWidgets('should handle conditional rendering',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .conditionalRendering(true)
          .title('Conditional Rendering Card')
          .content(const Text('Conditional rendering content'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Conditional Rendering Card'), findsOneWidget);
      expect(find.text('Conditional rendering content'), findsOneWidget);
    });

    testWidgets('should handle empty content correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('should build simple content correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Simple Card')
          .content(const Text('Simple content'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Simple Card'), findsOneWidget);
      expect(find.text('Simple content'), findsOneWidget);
    });

    testWidgets('should build complex content correctly',
        (WidgetTester tester) async {
      final responsiveConfig = MPCardResponsiveConfig(
        mobileSize: MPCardSize.small,
        tabletSize: MPCardSize.medium,
        desktopSize: MPCardSize.large,
      );

      final builder = MPCardBuilder()
          .title('Complex Card')
          .content(const Text('Complex content'))
          .responsive(responsiveConfig);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Complex Card'), findsOneWidget);
      expect(find.text('Complex content'), findsOneWidget);
    });

    testWidgets('should handle actions correctly', (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Actions Card')
          .content(const Text('Actions content'))
          .actions([
        TextButton(onPressed: () {}, child: const Text('Action 1')),
        TextButton(onPressed: () {}, child: const Text('Action 2')),
      ]);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Actions Card'), findsOneWidget);
      expect(find.text('Actions content'), findsOneWidget);
      expect(find.text('Action 1'), findsOneWidget);
      expect(find.text('Action 2'), findsOneWidget);
    });

    testWidgets('should handle single action correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Single Action Card')
          .content(const Text('Single action content'))
          .action(
              TextButton(onPressed: () {}, child: const Text('Single Action')));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Single Action Card'), findsOneWidget);
      expect(find.text('Single action content'), findsOneWidget);
      expect(find.text('Single Action'), findsOneWidget);
    });

    testWidgets('should handle spacing methods correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Spacing Card')
          .content(const Text('Spacing content'))
          .spacingSymmetric(horizontal: 16.0, vertical: 12.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Spacing Card'), findsOneWidget);
      expect(find.text('Spacing content'), findsOneWidget);
    });

    testWidgets('should handle spacingOnly correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('SpacingOnly Card')
          .content(const Text('SpacingOnly content'))
          .spacingOnly(left: 8.0, top: 12.0, right: 8.0, bottom: 16.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('SpacingOnly Card'), findsOneWidget);
      expect(find.text('SpacingOnly content'), findsOneWidget);
    });

    testWidgets('should handle subtitle correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Title Card')
          .subtitle('Subtitle text')
          .content(const Text('Card content'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Title Card'), findsOneWidget);
      expect(find.text('Subtitle text'), findsOneWidget);
      expect(find.text('Card content'), findsOneWidget);
    });

    testWidgets('should handle header and footer widgets correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .header(const Text('Custom Header'))
          .body(const Text('Body content'))
          .footer(const Text('Custom Footer'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Custom Header'), findsOneWidget);
      expect(find.text('Body content'), findsOneWidget);
      expect(find.text('Custom Footer'), findsOneWidget);
    });

    testWidgets('should handle disabled state correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Disabled Card')
          .content(const Text('Disabled content'))
          .enabled(false);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Disabled Card'), findsOneWidget);
      expect(find.text('Disabled content'), findsOneWidget);
    });

    testWidgets('should convert to MPCard correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Convert Card')
          .content(const Text('Convert content'));

      final card = builder.toCard();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: card,
          ),
        ),
      );

      expect(find.text('Convert Card'), findsOneWidget);
      expect(find.text('Convert content'), findsOneWidget);
    });

    testWidgets('should handle elevation level correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Elevation Card')
          .content(const Text('Elevation content'))
          .elevationLevel(MPCardElevation.level8);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Elevation Card'), findsOneWidget);
      expect(find.text('Elevation content'), findsOneWidget);
    });

    testWidgets('should handle responsive config correctly',
        (WidgetTester tester) async {
      final responsiveConfig = MPCardResponsiveConfig(
        mobileSize: MPCardSize.small,
        tabletSize: MPCardSize.medium,
        desktopSize: MPCardSize.large,
      );

      final builder = MPCardBuilder()
          .title('Responsive Card')
          .content(const Text('Responsive content'))
          .responsive(responsiveConfig);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Responsive Card'), findsOneWidget);
      expect(find.text('Responsive content'), findsOneWidget);
    });

    testWidgets('should handle interactive config correctly',
        (WidgetTester tester) async {
      final interactiveConfig = MPCardInteractiveConfig(
        enableQuickActions: true,
        enableExpandable: true,
      );

      final builder = MPCardBuilder()
          .title('Interactive Config Card')
          .content(const Text('Interactive config content'))
          .interactiveConfig(interactiveConfig);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Interactive Config Card'), findsOneWidget);
      expect(find.text('Interactive config content'), findsOneWidget);
    });

    testWidgets('should handle accessibility config correctly',
        (WidgetTester tester) async {
      final accessibilityConfig = MPCardAccessibilityConfig(
        enabled: true,
        enableFocusManagement: true,
      );

      final builder = MPCardBuilder()
          .title('Accessibility Card')
          .content(const Text('Accessibility content'))
          .accessibilityConfig(accessibilityConfig);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Accessibility Card'), findsOneWidget);
      expect(find.text('Accessibility content'), findsOneWidget);
    });

    testWidgets('should handle interaction config correctly',
        (WidgetTester tester) async {
      final interactionConfig = MPCardInteractionConfig(
        enableRipple: true,
        hoverDuration: Duration(milliseconds: 200),
      );

      final builder = MPCardBuilder()
          .title('Interaction Config Card')
          .content(const Text('Interaction config content'))
          .interactionConfig(interactionConfig);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: builder.build(),
          ),
        ),
      );

      expect(find.text('Interaction Config Card'), findsOneWidget);
      expect(find.text('Interaction config content'), findsOneWidget);
    });
  });

  group('MPCardBuilderExtensions', () {
    testWidgets('should convert builder to MPCard correctly',
        (WidgetTester tester) async {
      final builder = MPCardBuilder()
          .title('Extension Card')
          .content(const Text('Extension content'));

      final card = builder.toCard();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: card,
          ),
        ),
      );

      expect(find.text('Extension Card'), findsOneWidget);
      expect(find.text('Extension content'), findsOneWidget);
    });
  });
}
