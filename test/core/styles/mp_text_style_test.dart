import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/styles/mp_text_style.dart';

void main() {
  // Initialize MPErrorHandler to avoid state errors
  MPErrorHandler.initialize();
  
  // Configure Google Fonts for testing - disable network loading
  setUpAll(() async {
    // Disable runtime font fetching to avoid network errors
    GoogleFonts.config.allowRuntimeFetching = false;
    TestWidgetsFlutterBinding.ensureInitialized();
    
    // Set default font family to avoid Google Fonts loading
    MPTextStyle.defaultFontFamily = 'system';
  });

  group('MPTextStyle Simple Tests', () {
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
    });

    // ============ DEFAULT VALUES TESTS ============

    group('Default Values Tests', () {
      test('defaultFontFamily can be changed', () {
        final originalFont = MPTextStyle.defaultFontFamily;
        MPTextStyle.defaultFontFamily = 'CustomFont';

        expect(MPTextStyle.defaultFontFamily, 'CustomFont');

        // Restore original
        MPTextStyle.defaultFontFamily = originalFont;
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
                  Text('Title', style: const TextStyle(fontSize: 24)),
                  Text('Heading1', style: const TextStyle(fontSize: 20)),
                  Text('Body1', style: const TextStyle(fontSize: 16)),
                  Text('Caption', style: const TextStyle(fontSize: 12)),
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

      testWidgets('custom text styles work with copyWith',
          (WidgetTester tester) async {
        const baseStyle = MPTextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
        );

        final customStyle = baseStyle.copyWith(
          color: Colors.purple,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Text('Custom Text', style: customStyle.toTextStyle()),
            ),
          ),
        );

        expect(find.text('Custom Text'), findsOneWidget);
      });
    });
  });
}
