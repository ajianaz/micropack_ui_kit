import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPChip', () {
    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPChip(
              label: 'Test',
            ),
          ),
        ),
      );

      expect(find.byType(MPChip), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('renders with different variants', (tester) async {
      for (final variant in MPChipVariant.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPChip(
                label: 'Test',
                variant: variant,
              ),
            ),
          ),
        );

        expect(find.byType(MPChip), findsOneWidget);
      }
    });

    testWidgets('renders selected state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPChip(
              label: 'Test',
              selected: true,
            ),
          ),
        ),
      );

      expect(find.byType(MPChip), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPChip(
              label: 'Test',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MPChip));
      expect(pressed, true);
    });

    testWidgets('calls onDeleted when delete button tapped', (tester) async {
      bool deleted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPChip(
              label: 'Test',
              onDeleted: () => deleted = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      expect(deleted, true);
    });

    testWidgets('renders with avatar', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPChip(
              label: 'Test',
              avatar: const FlutterLogo(),
            ),
          ),
        ),
      );

      expect(find.byType(MPChip), findsOneWidget);
      expect(find.byType(FlutterLogo), findsOneWidget);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPChip(
              label: 'Test',
              onPressed: () => pressed = true,
              enabled: false,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MPChip));
      expect(pressed, false);
    });
  });
}
