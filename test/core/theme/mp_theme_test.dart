import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_color_theme.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_helper.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('MPThemeUtilities', () {
    testWidgets('adaptiveTextColor returns correct color for light mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MPTheme.main(isDarkMode: false).copyWith(
            extensions: [MPColorTheme.light],
          ),
          home: Builder(
            builder: (context) {
              final color = context.mp.adaptiveTextColor(1.0);
              expect(color, MPColorTheme.light.neutral20);
              expect(Theme.of(context).brightness, Brightness.light);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('adaptiveTextColor returns correct color for dark mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MPTheme.main(isDarkMode: true).copyWith(
            extensions: [MPColorTheme.dark],
          ),
          home: Builder(
            builder: (context) {
              final color = context.mp.adaptiveTextColor(1.0);
              expect(color, MPColorTheme.dark.neutral90);
              expect(Theme.of(context).brightness, Brightness.dark);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('adaptiveBackgroundColor returns correct color for light mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MPTheme.main(isDarkMode: false).copyWith(
            extensions: [MPColorTheme.light],
          ),
          home: Builder(
            builder: (context) {
              final color = context.mp.adaptiveBackgroundColor;
              expect(color, MPColorTheme.light.neutral100);
              expect(Theme.of(context).brightness, Brightness.light);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('adaptiveBackgroundColor returns correct color for dark mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MPTheme.main(isDarkMode: true).copyWith(
            extensions: [MPColorTheme.dark],
          ),
          home: Builder(
            builder: (context) {
              final color = context.mp.adaptiveBackgroundColor;
              expect(color, MPColorTheme.dark.neutral20);
              expect(Theme.of(context).brightness, Brightness.dark);
              return Container();
            },
          ),
        ),
      );
    });
  });
}
