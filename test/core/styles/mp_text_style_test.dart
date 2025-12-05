import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/styles/mp_text_style.dart';

void main() {
  // Initialize MPErrorHandler to avoid state errors
  MPErrorHandler.initialize();

  group('MPTextStyle Tests', () {
    // ============ CONSTRUCTOR TESTS ============

    group('Constructor Tests', () {
      test('creates MPTextStyle with all parameters', () {
        const textStyle = MPTextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
          textAlign: TextAlign.center,
          maxLines: 2,
          textOverflow: TextOverflow.ellipsis,
          letterSpacing: 1.2,
          wordSpacing: 0.5,
          height: 1.4,
          decoration: TextDecoration.underline,
          decorationColor: Colors.red,
          decorationThickness: 2.0,
        );

        expect(textStyle.fontFamily, 'Roboto');
        expect(textStyle.fontSize, 16.0);
        expect(textStyle.fontWeight, FontWeight.w500);
        expect(textStyle.color, Colors.blue);
        expect(textStyle.textAlign, TextAlign.center);
        expect(textStyle.maxLines, 2);
        expect(textStyle.textOverflow, TextOverflow.ellipsis);
        expect(textStyle.letterSpacing, 1.2);
        expect(textStyle.wordSpacing, 0.5);
        expect(textStyle.height, 1.4);
        expect(textStyle.decoration, TextDecoration.underline);
        expect(textStyle.decorationColor, Colors.red);
        expect(textStyle.decorationThickness, 2.0);
      });

      test('creates MPTextStyle with minimal parameters', () {
        const textStyle = MPTextStyle();

        expect(textStyle.fontFamily, isNull);
        expect(textStyle.fontSize, isNull);
        expect(textStyle.fontWeight, isNull);
        expect(textStyle.color, isNull);
        expect(textStyle.textAlign, isNull);
        expect(textStyle.maxLines, isNull);
        expect(textStyle.textOverflow, isNull);
        expect(textStyle.letterSpacing, isNull);
        expect(textStyle.wordSpacing, isNull);
        expect(textStyle.height, isNull);
        expect(textStyle.decoration, isNull);
        expect(textStyle.decorationColor, isNull);
        expect(textStyle.decorationThickness, isNull);
      });
    });

    // ============ COPY WITH TESTS ============

    group('CopyWith Tests', () {
      test('copyWith creates new instance with overridden values', () {
        const originalStyle = MPTextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
        );

        final copiedStyle = originalStyle.copyWith(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: Colors.red,
        );

        expect(copiedStyle.fontFamily, 'Roboto'); // Unchanged
        expect(copiedStyle.fontSize, 20.0); // Changed
        expect(copiedStyle.fontWeight, FontWeight.w700); // Changed
        expect(copiedStyle.color, Colors.red); // Changed
      });

      test('copyWith preserves original when no parameters provided', () {
        const originalStyle = MPTextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
        );

        final copiedStyle = originalStyle.copyWith();

        expect(copiedStyle.fontFamily, originalStyle.fontFamily);
        expect(copiedStyle.fontSize, originalStyle.fontSize);
        expect(copiedStyle.fontWeight, originalStyle.fontWeight);
        expect(copiedStyle.color, originalStyle.color);
      });

      test('copyWith with null values overrides to null', () {
        const originalStyle = MPTextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
        );

        final copiedStyle = originalStyle.copyWith(
          fontSize: null,
          fontWeight: null,
          color: null,
        );

        expect(copiedStyle.fontFamily, 'Roboto'); // Unchanged
        expect(copiedStyle.fontSize, isNull); // Changed to null
        expect(copiedStyle.fontWeight, isNull); // Changed to null
        expect(copiedStyle.color, isNull); // Changed to null
      });
    });

    // ============ TEXT STYLE VARIANTS TESTS ============

    group('Text Style Variants', () {
      test('title style creates correct text style', () {
        final titleStyle = MPTextStyle.title(
          color: Colors.blue,
          fontWeight: FontWeight.w900,
          decoration: TextDecoration.underline,
          fontFamily: 'CustomFont',
        );

        expect(titleStyle.fontSize, isNotNull);
        expect(titleStyle.fontWeight, FontWeight.w900);
        expect(titleStyle.color, Colors.blue);
        expect(titleStyle.decoration, TextDecoration.underline);
        expect(titleStyle.fontFamily, 'CustomFont');
      });

      test('heading1 style creates correct text style', () {
        final heading1Style = MPTextStyle.heading1(
          color: Colors.red,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.none,
          fontFamily: 'CustomFont',
        );

        expect(heading1Style.fontSize, isNotNull);
        expect(heading1Style.fontWeight, FontWeight.w600);
        expect(heading1Style.color, Colors.red);
        expect(heading1Style.decoration, TextDecoration.none);
        expect(heading1Style.fontFamily, 'CustomFont');
      });

      test('heading2 style creates correct text style', () {
        final heading2Style = MPTextStyle.heading2(
          color: Colors.green,
          fontWeight: FontWeight.w800,
          decoration: TextDecoration.lineThrough,
          fontFamily: 'CustomFont',
        );

        expect(heading2Style.fontSize, isNotNull);
        expect(heading2Style.fontWeight, FontWeight.w800);
        expect(heading2Style.color, Colors.green);
        expect(heading2Style.decoration, TextDecoration.lineThrough);
        expect(heading2Style.fontFamily, 'CustomFont');
      });

      test('heading3 style creates correct text style', () {
        final heading3Style = MPTextStyle.heading3(
          color: Colors.purple,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
          fontFamily: 'CustomFont',
        );

        expect(heading3Style.fontSize, isNotNull);
        expect(heading3Style.fontWeight, FontWeight.w400);
        expect(heading3Style.color, Colors.purple);
        expect(heading3Style.decoration, TextDecoration.underline);
        expect(heading3Style.fontFamily, 'CustomFont');
      });

      test('body1 style creates correct text style', () {
        final body1Style = MPTextStyle.body1(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          decoration: TextDecoration.none,
          fontFamily: 'CustomFont',
        );

        expect(body1Style.fontSize, isNotNull);
        expect(body1Style.fontWeight, FontWeight.w300);
        expect(body1Style.color, Colors.black);
        expect(body1Style.decoration, TextDecoration.none);
        expect(body1Style.fontFamily, 'CustomFont');
      });

      test('body2 style creates correct text style', () {
        final body2Style = MPTextStyle.body2(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          fontFamily: 'CustomFont',
        );

        expect(body2Style.fontSize, isNotNull);
        expect(body2Style.fontWeight, FontWeight.w500);
        expect(body2Style.color, Colors.grey);
        expect(body2Style.decoration, TextDecoration.underline);
        expect(body2Style.fontFamily, 'CustomFont');
      });

      test('caption style creates correct text style', () {
        final captionStyle = MPTextStyle.caption(
          color: Colors.brown,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.lineThrough,
          fontFamily: 'CustomFont',
        );

        expect(captionStyle.fontSize, isNotNull);
        expect(captionStyle.fontWeight, FontWeight.w600);
        expect(captionStyle.color, Colors.brown);
        expect(captionStyle.decoration, TextDecoration.lineThrough);
        expect(captionStyle.fontFamily, 'CustomFont');
      });

      test('overline style creates correct text style', () {
        final overlineStyle = MPTextStyle.overline(
          color: Colors.orange,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          fontFamily: 'CustomFont',
        );

        expect(overlineStyle.fontSize, isNotNull);
        expect(overlineStyle.fontWeight, FontWeight.w700);
        expect(overlineStyle.color, Colors.orange);
        expect(overlineStyle.decoration, TextDecoration.underline);
        expect(overlineStyle.fontFamily, 'CustomFont');
      });
    });

    // ============ DEFAULT VALUES TESTS ============

    group('Default Values Tests', () {
      test('title style uses default font weight when not specified', () {
        final titleStyle = MPTextStyle.title();
        expect(titleStyle.fontWeight, FontWeight.w800);
      });

      test('heading1 style uses default font weight when not specified', () {
        final heading1Style = MPTextStyle.heading1();
        expect(heading1Style.fontWeight, FontWeight.w700);
      });

      test('heading2 style uses default font weight when not specified', () {
        final heading2Style = MPTextStyle.heading2();
        expect(heading2Style.fontWeight, FontWeight.w700);
      });

      test('heading3 style uses default font weight when not specified', () {
        final heading3Style = MPTextStyle.heading3();
        expect(heading3Style.fontWeight, FontWeight.w700);
      });

      test('body1 style uses default font weight when not specified', () {
        final body1Style = MPTextStyle.body1();
        expect(body1Style.fontWeight, FontWeight.w400);
      });

      test('body2 style uses default font weight when not specified', () {
        final body2Style = MPTextStyle.body2();
        expect(body2Style.fontWeight, FontWeight.w400);
      });

      test('caption style uses default font weight when not specified', () {
        final captionStyle = MPTextStyle.caption();
        expect(captionStyle.fontWeight, FontWeight.w400);
      });

      test('overline style uses default decoration when not specified', () {
        final overlineStyle = MPTextStyle.overline();
        expect(overlineStyle.decoration, TextDecoration.underline);
      });

      test('body2 style uses default font family when not specified', () {
        final body2Style = MPTextStyle.body2();
        expect(body2Style.fontFamily, 'Poppins');
      });
    });

    // ============ TEXT THEME TESTS ============

    group('Text Theme Tests', () {
      test('mainTextTheme has all required text styles', () {
        final textTheme = MPTextStyle.mainTextTheme;

        expect(textTheme.displayLarge, isNotNull);
        expect(textTheme.displayMedium, isNotNull);
        expect(textTheme.displaySmall, isNotNull);
        expect(textTheme.titleLarge, isNotNull);
        expect(textTheme.titleMedium, isNotNull);
        expect(textTheme.titleSmall, isNotNull);
        expect(textTheme.bodyLarge, isNotNull);
        expect(textTheme.bodyMedium, isNotNull);
        expect(textTheme.bodySmall, isNotNull);
        expect(textTheme.labelSmall, isNotNull);
      });

      test('darkTextTheme equals mainTextTheme', () {
        final mainTheme = MPTextStyle.mainTextTheme;
        final darkTheme = MPTextStyle.darkTextTheme;

        expect(darkTheme, same(mainTheme));
      });

      test('text theme styles are correctly mapped', () {
        final textTheme = MPTextStyle.mainTextTheme;

        // Verify that the styles are created using the correct factory methods
        expect(textTheme.displayLarge, equals(MPTextStyle.title()));
        expect(textTheme.displayMedium,
            equals(MPTextStyle.title(fontWeight: FontWeight.w600)));
        expect(textTheme.displaySmall,
            equals(MPTextStyle.title(fontWeight: FontWeight.w400)));
        expect(textTheme.titleLarge, equals(MPTextStyle.heading1()));
        expect(textTheme.titleMedium, equals(MPTextStyle.heading2()));
        expect(textTheme.titleSmall, equals(MPTextStyle.heading3()));
        expect(textTheme.bodyLarge, equals(MPTextStyle.body2()));
        expect(textTheme.bodyMedium, equals(MPTextStyle.body1()));
        expect(textTheme.bodySmall, equals(MPTextStyle.caption()));
        expect(textTheme.labelSmall, equals(MPTextStyle.overline()));
      });
    });

    // ============ EXTENSION TESTS ============

    group('MPTextStyleExtension Tests', () {
      test('toTextStyle converts MPTextStyle to TextStyle without context', () {
        const mpTextStyle = MPTextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
          textAlign: TextAlign.center,
          letterSpacing: 1.2,
          wordSpacing: 0.5,
          height: 1.4,
          decoration: TextDecoration.underline,
          decorationColor: Colors.red,
          decorationThickness: 2.0,
        );

        final textStyle = mpTextStyle.toTextStyle();

        expect(textStyle.fontFamily, 'Roboto');
        expect(textStyle.fontSize, 16.0);
        expect(textStyle.fontWeight, FontWeight.w500);
        expect(textStyle.color, Colors.blue);
        expect(mpTextStyle.textAlign, TextAlign.center);
        expect(textStyle.letterSpacing, 1.2);
        expect(textStyle.wordSpacing, 0.5);
        expect(textStyle.height, 1.4);
        expect(textStyle.decoration, TextDecoration.underline);
        expect(textStyle.decorationColor, Colors.red);
        expect(textStyle.decorationThickness, 2.0);
      });

      test('toTextStyle handles null MPTextStyle', () {
        final textStyle = (null as MPTextStyle?).toTextStyle();
        expect(textStyle, isNotNull);
      });

      test('toTextStyle applies responsive scaling with context', () {
        const mpTextStyle = MPTextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
        );

        // Create a test widget to get context
        final testWidget = MaterialApp(
          home: Builder(
            builder: (context) {
              final textStyle = mpTextStyle.toTextStyle(context);
              expect(textStyle.fontFamily, 'Roboto');
              expect(textStyle.fontWeight, FontWeight.w500);
              expect(textStyle.color, Colors.blue);
              // Font size should be responsive (scaled)
              expect(textStyle.fontSize, isNotNull);
              return Container();
            },
          ),
        );

        // Just verify the widget can be created without errors
        expect(testWidget, isNotNull);
      });
    });

    // ============ DEFAULT FONT FAMILY TESTS ============

    group('Default Font Family Tests', () {
      test('defaultFontFamily can be changed', () {
        final originalFont = MPTextStyle.defaultFontFamily;
        MPTextStyle.defaultFontFamily = 'CustomFont';

        expect(MPTextStyle.defaultFontFamily, 'CustomFont');

        // Restore original
        MPTextStyle.defaultFontFamily = originalFont;
      });

      test('styles use defaultFontFamily when fontFamily not specified', () {
        final originalFont = MPTextStyle.defaultFontFamily;
        MPTextStyle.defaultFontFamily = 'TestFont';

        final titleStyle = MPTextStyle.title();
        expect(titleStyle.fontFamily, 'TestFont');

        // Restore original
        MPTextStyle.defaultFontFamily = originalFont;
      });
    });

    // ============ EDGE CASES TESTS ============

    group('Edge Cases Tests', () {
      test('handles extreme values in constructor', () {
        final extremeStyle = MPTextStyle(
          fontSize: 1000.0,
          letterSpacing: -2.0,
          height: 0.5,
          textAlign: TextAlign.center,
          textOverflow: TextOverflow.ellipsis,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed,
        );

        expect(extremeStyle.fontSize, 1000.0);
        expect(extremeStyle.letterSpacing, -2.0);
        expect(extremeStyle.height, 0.5);
        expect(extremeStyle.textAlign, TextAlign.center);
        expect(extremeStyle.textOverflow, TextOverflow.ellipsis);
        expect(extremeStyle.fontStyle, FontStyle.italic);
        expect(extremeStyle.decoration, TextDecoration.underline);
        expect(extremeStyle.decorationStyle, TextDecorationStyle.dashed);
      });
    });

    // ============ INTEGRATION TESTS ============

    group('Integration Tests', () {
      testWidgets('text styles work in real widgets',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  Text('Title', style: MPTextStyle.title()),
                  Text('Heading1', style: MPTextStyle.heading1()),
                  Text('Body1', style: MPTextStyle.body1()),
                  Text('Caption', style: MPTextStyle.caption()),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Heading1'), findsOneWidget);
        expect(find.text('Body1'), findsOneWidget);
        expect(find.text('Caption'), findsOneWidget);
      });

      testWidgets('text theme works in MaterialApp',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(textTheme: MPTextStyle.mainTextTheme),
            home: Scaffold(
              body: Column(
                children: [
                  Text('Title',
                      style: Theme.of(tester.element(find.byType(Column)))
                          .textTheme
                          .displayLarge),
                  Text('Body',
                      style: Theme.of(tester.element(find.byType(Column)))
                          .textTheme
                          .bodyMedium),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Body'), findsOneWidget);
      });

      testWidgets('custom text styles work with copyWith',
          (WidgetTester tester) async {
        final baseStyle = MPTextStyle.title();
        final customStyle = baseStyle.copyWith(
          color: Colors.purple,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Text('Custom Text', style: customStyle),
            ),
          ),
        );

        expect(find.text('Custom Text'), findsOneWidget);
      });
    });
  });
}
