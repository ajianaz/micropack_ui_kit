import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPCheckbox', () {
    testWidgets('renders unchecked checkbox', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPCheckbox(
              value: false,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(MPCheckbox), findsOneWidget);
    });

    testWidgets('renders checked checkbox', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPCheckbox(
              value: true,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(MPCheckbox), findsOneWidget);
    });

    testWidgets('calls onChanged when tapped', (tester) async {
      bool? newValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPCheckbox(
              value: false,
              onChanged: (value) => newValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MPCheckbox));
      expect(newValue, true);
    });

    testWidgets('does not call onChanged when disabled', (tester) async {
      bool? newValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPCheckbox(
              value: false,
              onChanged: (value) => newValue = value,
              enabled: false,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MPCheckbox));
      expect(newValue, false);
    });

    testWidgets('renders with different sizes', (tester) async {
      for (final size in MPCheckboxSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPCheckbox(
                value: true,
                onChanged: (_) {},
                size: size,
              ),
            ),
          ),
        );

        expect(find.byType(MPCheckbox), findsOneWidget);
      }
    });

    testWidgets('renders indeterminate state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPCheckbox(
              checkState: MPCheckboxCheckState.indeterminate,
              value: false,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(MPCheckbox), findsOneWidget);
    });
  });
}
