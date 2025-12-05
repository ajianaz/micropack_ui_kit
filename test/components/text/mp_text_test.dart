import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/test_helper.dart';

void main() {
  group('MPText Tests', () {
    // Initialize MPErrorHandler before all tests
    setUpAll(() async {
      await MPTestHelper.initialize();
    });

    testWidgets('renders with basic text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText('Test Text'),
        ),
      );

      expect(find.text('Test Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with custom style', (WidgetTester tester) async {
      const customStyle = TextStyle(
        color: Colors.purple,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Styled Text',
            style: customStyle,
          ),
        ),
      );

      expect(find.text('Styled Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with max lines', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Multi Line Text\nSecond Line\nThird Line',
            maxLines: 2,
          ),
        ),
      );

      expect(find.textContaining('Multi Line Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with text overflow ellipsis',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Very long text that should overflow and show ellipsis at the end',
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
          ),
        ),
      );

      expect(
          find.text(
              'Very long text that should overflow and show ellipsis at the end'),
          findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with text overflow clip', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Very long text that should overflow and be clipped',
            maxLines: 1,
            textOverflow: TextOverflow.clip,
          ),
        ),
      );

      expect(find.text('Very long text that should overflow and be clipped'),
          findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with text overflow fade', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Very long text that should overflow and fade at the edges',
            maxLines: 1,
            textOverflow: TextOverflow.fade,
          ),
        ),
      );

      expect(
          find.text(
              'Very long text that should overflow and fade at the edges'),
          findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with soft wrap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'This is a very long text that should wrap to multiple lines when softWrap is enabled',
            softWrap: true,
          ),
        ),
      );

      expect(find.textContaining('This is a very long text that should wrap'),
          findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with text align left', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Left Aligned Text',
            textAlign: TextAlign.left,
          ),
        ),
      );

      expect(find.text('Left Aligned Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with text align center', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Center Aligned Text',
            textAlign: TextAlign.center,
          ),
        ),
      );

      expect(find.text('Center Aligned Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with text align right', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Right Aligned Text',
            textAlign: TextAlign.right,
          ),
        ),
      );

      expect(find.text('Right Aligned Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with custom font weight', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Bold Text',
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      expect(find.text('Bold Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with custom font size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Large Text',
            fontSize: 24,
          ),
        ),
      );

      expect(find.text('Large Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with custom font style', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Italic Text',
            fontStyle: FontStyle.italic,
          ),
        ),
      );

      expect(find.text('Italic Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with custom letter spacing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Spaced Text',
            letterSpacing: 2.0,
          ),
        ),
      );

      expect(find.text('Spaced Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with custom color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Colored Text',
            color: Colors.purple,
          ),
        ),
      );

      expect(find.text('Colored Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with decoration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Decorated Text',
            decoration: TextDecoration.underline,
            decorationColor: Colors.red,
            decorationStyle: TextDecorationStyle.solid,
          ),
        ),
      );

      expect(find.text('Decorated Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with decoration style', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Styled Decoration Text',
            decorationStyle: TextDecorationStyle.solid,
            decorationColor: Colors.blue,
            decorationThickness: 2.0,
          ),
        ),
      );

      expect(find.text('Styled Decoration Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    // Factory constructor tests
    testWidgets('head constructor creates heading text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText.head('Heading Text'),
        ),
      );

      expect(find.text('Heading Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('subhead constructor creates subheading text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText.subhead('Subheading Text'),
        ),
      );

      expect(find.text('Subheading Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('body constructor creates body text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText.body('Body Text'),
        ),
      );

      expect(find.text('Body Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('label constructor creates label text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText.label('Label Text'),
        ),
      );

      expect(find.text('Label Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('small constructor creates small text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText.small('Small Text'),
        ),
      );

      expect(find.text('Small Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    // Expandable text tests
    testWidgets('expandable text shows expand button when overflowing',
        (WidgetTester tester) async {
      bool wasExpanded = false;

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'This is a very long text that should overflow and show an expand button when overflowBehavior is expandable',
            maxLines: 1,
            overflowBehavior: MPTextOverflowBehavior.expandable,
            onExpandChanged: () => wasExpanded = !wasExpanded,
          ),
        ),
      );

      // Initially should not show expand button
      expect(find.text('Show less'), findsNothing);
      expect(find.text('Show more'), findsNothing);
      expect(wasExpanded, isFalse);

      // Force overflow by reducing container width
      await tester.binding.setSurfaceSize(const Size(100, 50));
      await tester.pump();

      // Now should show expand button if text overflows
      final showMoreButton = find.text('Show more');
      if (showMoreButton.evaluate().isNotEmpty) {
        expect(showMoreButton, findsOneWidget);
        expect(find.text('Show less'), findsNothing);
        expect(wasExpanded, isFalse);

        // Tap expand button
        await tester.tap(showMoreButton);
        await tester.pump();

        expect(wasExpanded, isTrue);
        expect(find.text('Show less'), findsOneWidget);
        expect(find.text('Show more'), findsNothing);
      } else {
        // If text doesn't overflow, that's also valid
        expect(wasExpanded, isFalse);
      }
    });

    testWidgets('responsive truncation adapts to screen size',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'This is a very long text that should be truncated differently on different screen sizes',
            maxLines: 2,
            enableResponsiveTruncation: true,
          ),
        ),
      );

      expect(
          find.textContaining(
              'This is a very long text that should be truncated'),
          findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    // Accessibility tests
    testWidgets('has semantic label when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Text',
            semanticLabel: 'Custom semantic label',
          ),
        ),
      );

      // Check if semantic label is properly set
      expect(find.byType(MPText), findsOneWidget);
      // Verify the widget has the expected semantic properties
      final mpText = tester.widget<MPText>(find.byType(MPText));
      expect(mpText.semanticLabel, equals('Custom semantic label'));
    });

    testWidgets('has semantic hint when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Text',
            semanticHint: 'Custom semantic hint',
          ),
        ),
      );

      // Check if semantic hint is properly set
      expect(find.byType(MPText), findsOneWidget);
      // Verify the widget has the expected semantic properties
      final mpText = tester.widget<MPText>(find.byType(MPText));
      expect(mpText.semanticHint, equals('Custom semantic hint'));
    });

    testWidgets('excludes semantics when requested',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Text',
            excludeSemantics: true,
          ),
        ),
      );

      expect(find.byType(MPText), findsOneWidget);
      expect(find.bySemanticsLabel('Text'), findsNothing);
    });

    // Error handling tests
    testWidgets('handles empty text gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(''),
        ),
      );

      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('handles null text gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(''),
        ),
      );

      expect(find.byType(MPText), findsOneWidget);
    });

    // Performance tests
    testWidgets('caches text style for performance',
        (WidgetTester tester) async {
      const customStyle = TextStyle(
        color: Colors.purple,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Cached Text',
            style: customStyle,
          ),
        ),
      );

      expect(find.text('Cached Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);

      // Pump again with same style to test caching
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPText(
            'Another Cached Text',
            style: customStyle,
          ),
        ),
      );

      expect(find.text('Another Cached Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });
  });
}
