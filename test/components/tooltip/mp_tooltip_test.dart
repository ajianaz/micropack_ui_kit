import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPTooltip', () {
    testWidgets('wraps child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPTooltip(
              message: 'Test tooltip',
              child: const Icon(Icons.info),
            ),
          ),
        ),
      );

      expect(find.byType(MPTooltip), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('renders with different variants', (tester) async {
      for (final variant in MPTooltipVariant.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPTooltip(
                message: 'Test',
                variant: variant,
                child: const Icon(Icons.info),
              ),
            ),
          ),
        );

        expect(find.byType(MPTooltip), findsOneWidget);
      }
    });

    testWidgets('shows tooltip on long press', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPTooltip(
              message: 'Test tooltip',
              child: const Icon(Icons.info),
            ),
          ),
        ),
      );

      // Trigger tooltip
      await tester.longPress(find.byIcon(Icons.info));
      await tester.pumpAndSettle();

      expect(find.text('Test tooltip'), findsOneWidget);
    });

    testWidgets('respects wait duration', (tester) async {
      final tooltipKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPTooltip(
              key: tooltipKey,
              message: 'Test tooltip',
              waitDuration: const Duration(milliseconds: 100),
              child: const Icon(Icons.info),
            ),
          ),
        ),
      );

      await tester.longPress(find.byIcon(Icons.info));
      await tester.pump(const Duration(milliseconds: 50));

      // Tooltip should not be visible yet
      expect(find.text('Test tooltip'), findsNothing);

      // Wait for tooltip to appear
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Test tooltip'), findsOneWidget);
    });
  });
}
