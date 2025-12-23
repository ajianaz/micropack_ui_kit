import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPBadge Widget Tests', () {
    testWidgets('renders with default props', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPBadge(label: 'Test'),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('renders with primary variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPBadge(
              label: 'Primary',
              variant: MPBadgeVariant.primary,
            ),
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
    });

    testWidgets('renders with outlined variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPBadge(
              label: '',
              variant: MPBadgeVariant.outlined,
            ),
          ),
        ),
      );

      expect(find.byType(MPBadge), findsOneWidget);
    });

    testWidgets('renders with filled variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPBadge(
              label: '5',
              variant: MPBadgeVariant.filled,
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });

    group('Size Tests', () {
      testWidgets('renders with small size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Small',
                size: MPBadgeSize.small,
              ),
            ),
          ),
        );

        expect(find.text('Small'), findsOneWidget);
      });

      testWidgets('renders with medium size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Medium',
                size: MPBadgeSize.medium,
              ),
            ),
          ),
        );

        expect(find.text('Medium'), findsOneWidget);
      });

      testWidgets('renders with large size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Large',
                size: MPBadgeSize.large,
              ),
            ),
          ),
        );

        expect(find.text('Large'), findsOneWidget);
      });
    });

    group('Leading/Trailing Widgets', () {
      testWidgets('renders with leading icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Badge',
                leading: Icon(Icons.star),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.text('Badge'), findsOneWidget);
      });

      testWidgets('renders with trailing widget', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Badge',
                trailing: Icon(Icons.check),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.check), findsOneWidget);
        expect(find.text('Badge'), findsOneWidget);
      });
    });

    group('Custom Styling', () {
      testWidgets('applies custom background color', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Custom',
                backgroundColor: Colors.red,
              ),
            ),
          ),
        );

        final badgeFinder = find.byType(Container);
        final badgeWidget = tester.widget<Container>(badgeFinder.first);

        expect(badgeWidget.decoration, isNotNull);
      });

      testWidgets('applies custom text color', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Custom',
                textColor: Colors.blue,
              ),
            ),
          ),
        );

        expect(find.text('Custom'), findsOneWidget);
      });

      testWidgets('applies custom border color', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Custom',
                borderColor: Colors.green,
                borderWidth: 2.0,
              ),
            ),
          ),
        );

        expect(find.text('Custom'), findsOneWidget);
      });
    });

    group('Enabled State', () {
      testWidgets('renders as enabled by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Enabled',
                enabled: true,
              ),
            ),
          ),
        );

        expect(find.text('Enabled'), findsOneWidget);
      });

      testWidgets('renders as disabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Disabled',
                enabled: false,
              ),
            ),
          ),
        );

        expect(find.text('Disabled'), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('applies semantic label', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Accessible',
                semanticLabel: 'Badge showing count',
              ),
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(MPBadge));
        expect(
          semantics.label,
          contains('Badge showing count'),
        );
      });

      testWidgets('is accessible by screen readers', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'Screen Reader Test',
              ),
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(MPBadge));
        expect(semantics.label, 'Screen Reader Test');
      });
    });

    group('Theme Integration', () {
      testWidgets('adapts to light theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              body: MPBadge(label: 'Light'),
            ),
          ),
        );

        expect(find.text('Light'), findsOneWidget);
      });

      testWidgets('adapts to dark theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: MPBadge(label: 'Dark'),
            ),
          ),
        );

        expect(find.text('Dark'), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles empty label gracefully', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(label: ''),
            ),
          ),
        );

        expect(find.byType(MPBadge), findsOneWidget);
      });

      testWidgets('handles very long label', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: 'This is a very long badge label that should wrap properly',
              ),
            ),
          ),
        );

        expect(find.byType(MPBadge), findsOneWidget);
      });

      testWidgets('handles special characters in label', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPBadge(
                label: r'Test @#$%^&*()',
              ),
            ),
          ),
        );

        expect(find.text(r'Test @#$%^&*()'), findsOneWidget);
      });
    });
  });
}
