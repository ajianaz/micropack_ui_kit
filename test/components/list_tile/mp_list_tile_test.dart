import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPListTile', () {
    testWidgets('renders with title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders with title and subtitle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              subtitle: 'Test Subtitle',
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
    });

    testWidgets('renders with leading widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              leading: CircleAvatar(
                child: Text('JD'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('renders with tertiary text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              subtitle: 'Test Subtitle',
              tertiary: 'Additional Info',
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
      expect(find.text('Additional Info'), findsOneWidget);
    });

    testWidgets('renders with different sizes', (tester) async {
      for (final size in MPListTileSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPListTile(
                title: 'Test Title',
                size: size,
              ),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
      }
    });

    testWidgets('renders with different variants', (tester) async {
      for (final variant in MPListTileVariant.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPListTile(
                title: 'Test Title',
                variant: variant,
              ),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
      }
    });

    testWidgets('renders in disabled state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              enabled: false,
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders in selected state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              selected: true,
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('calls onTap callback', (tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              onTap: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Test Title'));
      expect(wasTapped, true);
    });

    testWidgets('calls onLongPress callback', (tester) async {
      bool wasLongPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              onLongPress: () {
                wasLongPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.longPress(find.text('Test Title'));
      expect(wasLongPressed, true);
    });

    testWidgets('does not call onTap when disabled', (tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              enabled: false,
              onTap: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Test Title'));
      expect(wasTapped, false);
    });

    testWidgets('renders with dense layout', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              dense: true,
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders with custom padding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              padding: const EdgeInsets.all(24),
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders with custom border radius', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              borderRadius: 8,
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders with custom background color', (tester) async {
      const customColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              backgroundColor: customColor,
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders with semantic label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPListTile(
              title: 'Test Title',
              semanticLabel: 'List item for testing',
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(
        find.bySemanticsLabel('List item for testing'),
        findsOneWidget,
      );
    });
  });
}
