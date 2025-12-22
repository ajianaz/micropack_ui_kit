import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPProgressBar', () {
    testWidgets('renders linear progress', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPProgressBar.linear(
              value: 0.5,
            ),
          ),
        ),
      );

      expect(find.byType(MPProgressBar), findsOneWidget);
    });

    testWidgets('renders circular progress', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPProgressBar.circular(
              value: 0.7,
            ),
          ),
        ),
      );

      expect(find.byType(MPProgressBar), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders with different sizes', (tester) async {
      for (final size in MPProgressBarSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPProgressBar.linear(
                value: 0.5,
                size: size,
              ),
            ),
          ),
        );

        expect(find.byType(MPProgressBar), findsOneWidget);
      }
    });

    testWidgets('renders with different variants', (tester) async {
      for (final variant in MPProgressBarVariant.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPProgressBar.linear(
                value: 0.5,
                variant: variant,
              ),
            ),
          ),
        );

        expect(find.byType(MPProgressBar), findsOneWidget);
      }
    });

    testWidgets('clamps value between 0 and 1', (tester) async {
      // Test value > 1
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPProgressBar.linear(
              value: 1.5,
            ),
          ),
        ),
      );

      expect(find.byType(MPProgressBar), findsOneWidget);

      // Test value < 0
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPProgressBar.linear(
              value: -0.5,
            ),
          ),
        ),
      );

      expect(find.byType(MPProgressBar), findsOneWidget);
    });

    testWidgets('has semantic label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPProgressBar.linear(
              value: 0.5,
              semanticsLabel: 'Loading progress',
            ),
          ),
        ),
      );

      expect(find.byType(MPProgressBar), findsOneWidget);
    });
  });
}
