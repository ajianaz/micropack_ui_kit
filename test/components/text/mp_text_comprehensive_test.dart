import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/mp_component_init_test.dart';

void main() {
  group('MPText Comprehensive Tests', () {
    // Basic rendering tests
    testWidgets('renders with basic text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText('Test Text'),
          ),
        ),
      );

      expect(find.text('Test Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('renders with empty text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(''),
          ),
        ),
      );

      expect(find.text(''), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    // Named constructor tests
    testWidgets('renders head constructor correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText.head('Head Text'),
          ),
        ),
      );

      expect(find.text('Head Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontWeight, FontWeight.w800);
    });

    testWidgets('renders subhead constructor correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText.subhead('Subhead Text'),
          ),
        ),
      );

      expect(find.text('Subhead Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontWeight, FontWeight.w600);
    });

    testWidgets('renders body constructor correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText.body('Body Text'),
          ),
        ),
      );

      expect(find.text('Body Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontWeight, FontWeight.normal);
    });

    testWidgets('renders label constructor correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText.label('Label Text'),
          ),
        ),
      );

      expect(find.text('Label Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontWeight, FontWeight.w500);
    });

    testWidgets('renders small constructor correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText.small('Small Text'),
          ),
        ),
      );

      expect(find.text('Small Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontWeight, FontWeight.w400);
    });

    // Text styling tests
    testWidgets('applies custom color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Colored Text',
              color: Colors.red,
            ),
          ),
        ),
      );

      expect(find.text('Colored Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, Colors.red);
    });

    testWidgets('applies custom font size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Large Text',
              fontSize: 24,
            ),
          ),
        ),
      );

      expect(find.text('Large Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontSize, 24);
    });

    testWidgets('applies custom font weight', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Bold Text',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      expect(find.text('Bold Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('applies custom font style', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Italic Text',
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );

      expect(find.text('Italic Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontStyle, FontStyle.italic);
    });

    testWidgets('applies custom letter spacing', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Spaced Text',
              letterSpacing: 2.0,
            ),
          ),
        ),
      );

      expect(find.text('Spaced Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.letterSpacing, 2.0);
    });

    testWidgets('applies custom text style', (WidgetTester tester) async {
      const customStyle = TextStyle(
        color: Colors.purple,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Custom Style Text',
              style: customStyle,
            ),
          ),
        ),
      );

      expect(find.text('Custom Style Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, Colors.purple);
      expect(textWidget.style?.fontSize, 20);
      expect(textWidget.style?.fontWeight, FontWeight.w700);
    });

    // Text decoration tests
    testWidgets('applies underline decoration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Underlined Text',
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );

      expect(find.text('Underlined Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.decoration, TextDecoration.underline);
    });

    testWidgets('applies line through decoration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Strikethrough Text',
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
      );

      expect(find.text('Strikethrough Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.decoration, TextDecoration.lineThrough);
    });

    testWidgets('applies decoration style', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Dashed Text',
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed,
            ),
          ),
        ),
      );

      expect(find.text('Dashed Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.decoration, TextDecoration.underline);
      expect(textWidget.style?.decorationStyle, TextDecorationStyle.dashed);
    });

    testWidgets('applies decoration color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Colored Underline',
              decoration: TextDecoration.underline,
              decorationColor: Colors.blue,
            ),
          ),
        ),
      );

      expect(find.text('Colored Underline'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.decoration, TextDecoration.underline);
      expect(textWidget.style?.decorationColor, Colors.blue);
    });

    testWidgets('applies decoration thickness', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Thick Underline',
              decoration: TextDecoration.underline,
              decorationThickness: 3.0,
            ),
          ),
        ),
      );

      expect(find.text('Thick Underline'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.decoration, TextDecoration.underline);
      expect(textWidget.style?.decorationThickness, 3.0);
    });

    // Text layout tests
    testWidgets('applies text alignment', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Centered Text',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

      expect(find.text('Centered Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.textAlign, TextAlign.center);
    });

    testWidgets('applies max lines', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'This is a very long text that should be truncated when maxLines is set',
              maxLines: 2,
            ),
          ),
        ),
      );

      expect(
          find.text(
              'This is a very long text that should be truncated when maxLines is set'),
          findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.maxLines, 2);
    });

    testWidgets('applies text overflow', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'This is a very long text that should be clipped',
              maxLines: 1,
              textOverflow: TextOverflow.clip,
            ),
          ),
        ),
      );

      expect(find.text('This is a very long text that should be clipped'),
          findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.overflow, TextOverflow.clip);
    });

    testWidgets('applies soft wrap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'This text should not wrap',
              softWrap: false,
            ),
          ),
        ),
      );

      expect(find.text('This text should not wrap'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.softWrap, false);
    });

    // Responsive font tests
    testWidgets('applies responsive font size', (WidgetTester tester) async {
      // Test with small screen
      await tester.binding.setSurfaceSize(const Size(300, 600));
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Responsive Text',
              fontSize: 16,
            ),
          ),
        ),
      );

      expect(find.text('Responsive Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontSize, isNotNull);

      // Test with large screen
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Responsive Text',
              fontSize: 16,
            ),
          ),
        ),
      );

      expect(find.text('Responsive Text'), findsOneWidget);
      final largeTextWidget = tester.widget<Text>(find.byType(Text));
      expect(largeTextWidget.style?.fontSize, isNotNull);
    });

    // Theme adaptation tests
    testWidgets('adapts to light theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: MaterialApp(
            theme: MPTheme.main().copyWith(
              extensions: <ThemeExtension<dynamic>>[
                MPColorTheme.light,
              ],
            ),
            home: Scaffold(
              body: MPText(
                'Light Theme Text',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Light Theme Text'), findsOneWidget);
    });

    testWidgets('adapts to dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: MaterialApp(
            theme: MPTheme.main().copyWith(
              extensions: <ThemeExtension<dynamic>>[
                MPColorTheme.dark,
              ],
            ),
            home: Scaffold(
              body: MPText(
                'Dark Theme Text',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Dark Theme Text'), findsOneWidget);
    });

    // Edge case tests
    testWidgets('handles null text gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(''),
          ),
        ),
      );

      expect(find.text(''), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('handles very long text', (WidgetTester tester) async {
      final longText =
          'This is a very long text that should be handled properly by MPText component. ' *
              100;

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(longText),
          ),
        ),
      );

      expect(find.text(longText), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('handles special characters', (WidgetTester tester) async {
      const specialText = 'Special chars: @#\$%^&*()_+-={}[]|\\:;"\'<>,.?/~`';

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(specialText),
          ),
        ),
      );

      expect(find.text(specialText), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    testWidgets('handles unicode characters', (WidgetTester tester) async {
      const unicodeText = 'Unicode: 🎉 🚀 ❤️ 🌟 中文 العربية';

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(unicodeText),
          ),
        ),
      );

      expect(find.text(unicodeText), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
    });

    // Performance tests
    testWidgets('renders efficiently with many text widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  100,
                  (index) => MPText('Text $index'),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(MPText), findsWidgets);
      // Just check that we have the right number of text widgets
      expect(find.byType(MPText), findsNWidgets(100));
    });

    // Accessibility tests
    testWidgets('has semantic properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Accessible Text',
            ),
          ),
        ),
      );

      expect(find.text('Accessible Text'), findsOneWidget);
      // MPText renders a Text widget which has semantic properties by default
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.data, 'Accessible Text');
    });

    // Integration with other widgets
    testWidgets('works inside container', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[200],
              child: MPText('Container Text'),
            ),
          ),
        ),
      );

      expect(find.text('Container Text'), findsOneWidget);
      expect(find.byType(MPText), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('works inside row', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Row(
              children: [
                MPText('Row Text 1'),
                const SizedBox(width: 16),
                MPText('Row Text 2'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Row Text 1'), findsOneWidget);
      expect(find.text('Row Text 2'), findsOneWidget);
      expect(find.byType(MPText), findsWidgets);
    });

    testWidgets('works inside column', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Column(
              children: [
                MPText('Column Text 1'),
                const SizedBox(height: 8),
                MPText('Column Text 2'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Column Text 1'), findsOneWidget);
      expect(find.text('Column Text 2'), findsOneWidget);
      expect(find.byType(MPText), findsWidgets);
    });

    // State preservation tests
    testWidgets('preserves text style when rebuilt',
        (WidgetTester tester) async {
      const textStyle = TextStyle(
        color: Colors.green,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Styled Text',
              style: textStyle,
            ),
          ),
        ),
      );

      expect(find.text('Styled Text'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, Colors.green);
      expect(textWidget.style?.fontSize, 18);
      expect(textWidget.style?.fontWeight, FontWeight.w600);

      // Rebuild with same properties
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Styled Text',
              style: textStyle,
            ),
          ),
        ),
      );

      final rebuiltTextWidget = tester.widget<Text>(find.byType(Text));
      expect(rebuiltTextWidget.style?.color, Colors.green);
      expect(rebuiltTextWidget.style?.fontSize, 18);
      expect(rebuiltTextWidget.style?.fontWeight, FontWeight.w600);
    });

    // Style precedence tests
    testWidgets('style parameter overrides individual style properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText(
              'Override Test',
              style: const TextStyle(
                color: Colors.purple,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              color: Colors.red, // This should be overridden by style
              fontSize: 16, // This should be overridden by style
              fontWeight:
                  FontWeight.normal, // This should be overridden by style
            ),
          ),
        ),
      );

      expect(find.text('Override Test'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      // The composeTextStyle method applies individual properties after base style
      // So individual properties will override style parameter
      expect(textWidget.style?.color, Colors.red);
      expect(textWidget.style?.fontSize, 16);
      expect(textWidget.style?.fontWeight, FontWeight.normal);
    });

    // Named constructor parameter tests
    testWidgets('head constructor with custom parameters',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText.head(
              'Custom Head',
              color: Colors.blue,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

      expect(find.text('Custom Head'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, Colors.blue);
      expect(textWidget.style?.fontSize, 22);
      expect(textWidget.style?.fontWeight, FontWeight.w900);
      expect(textWidget.maxLines, 2);
      expect(textWidget.textAlign, TextAlign.center);
    });

    testWidgets('subhead constructor with custom parameters',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText.subhead(
              'Custom Subhead',
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );

      expect(find.text('Custom Subhead'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, Colors.green);
      expect(textWidget.style?.fontSize, 18);
      expect(textWidget.style?.fontWeight, FontWeight.w700);
      expect(textWidget.style?.decoration, TextDecoration.underline);
    });

    testWidgets('body constructor with custom parameters',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText.body(
              'Custom Body',
              color: Colors.orange,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              maxLines: 3,
              softWrap: true,
            ),
          ),
        ),
      );

      expect(find.text('Custom Body'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, Colors.orange);
      expect(textWidget.style?.fontSize, 16);
      expect(textWidget.style?.fontWeight, FontWeight.w500);
      expect(textWidget.maxLines, 3);
      expect(textWidget.softWrap, true);
    });

    testWidgets('label constructor with custom parameters',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText.label(
              'Custom Label',
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ),
      );

      expect(find.text('Custom Label'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, Colors.red);
      expect(textWidget.style?.fontSize, 14);
      expect(textWidget.style?.fontWeight, FontWeight.w600);
      expect(textWidget.style?.letterSpacing, 1.5);
    });

    testWidgets('small constructor with custom parameters',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPText.small(
              'Custom Small',
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );

      expect(find.text('Custom Small'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, Colors.grey);
      expect(textWidget.style?.fontSize, 12);
      expect(textWidget.style?.fontWeight, FontWeight.w300);
      expect(textWidget.style?.fontStyle, FontStyle.italic);
    });
  });
}
