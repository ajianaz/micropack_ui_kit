import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPBadge', () {
    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPBadge(
              label: 'Test',
            ),
          ),
        ),
      );

      expect(find.byType(MPBadge), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('renders with different variants', (tester) async {
      for (final variant in MPBadgeVariant.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Test',
                variant: variant,
              ),
            ),
          ),
        );

        expect(find.byType(MPBadge), findsOneWidget);
      }
    });

    testWidgets('renders with different sizes', (tester) async {
      for (final size in MPBadgeSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Test',
                size: size,
              ),
            ),
          ),
        );

        expect(find.byType(MPBadge), findsOneWidget);
      }
    });

    testWidgets('renders with leading widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPBadge(
              label: 'Test',
              leading: const Icon(Icons.check),
            ),
          ),
        ),
      );

      expect(find.byType(MPBadge), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPBadge(
              label: 'Test',
              trailing: const Icon(Icons.close),
            ),
          ),
        ),
      );

      expect(find.byType(MPBadge), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('renders disabled state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPBadge(
              label: 'Test',
              enabled: false,
            ),
          ),
        ),
      );

      expect(find.byType(MPBadge), findsOneWidget);
    });
  });
}
