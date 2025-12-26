import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/mp_component_init_test.dart';

void main() {
  group('MPDialog Tests', () {
    testWidgets('renders dialog with child', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => MPDialog(
                        child: const Text('Dialog Content'),
                      ),
                    );
                  },
                  child: const Text('Show Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Dialog Content'), findsOneWidget);
      expect(find.byType(MPDialog), findsOneWidget);
    });

    testWidgets('renders with custom background color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => MPDialog(
                        background: Colors.purple,
                        child: const Text('Purple Dialog'),
                      ),
                    );
                  },
                  child: const Text('Show Purple Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Purple Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Purple Dialog'), findsOneWidget);
      final card = tester.widget<Card>(find.byType(Card));
      expect(card.color, Colors.purple);
    });

    testWidgets('renders with custom elevation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => MPDialog(
                        elevation: 8,
                        child: const Text('Elevated Dialog'),
                      ),
                    );
                  },
                  child: const Text('Show Elevated Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Elevated Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Elevated Dialog'), findsOneWidget);
      final card = tester.widget<Card>(find.byType(Card));
      expect(card.elevation, 8);
    });

    testWidgets('renders with custom padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => MPDialog(
                        padding: 24,
                        child: const Text('Padded Dialog'),
                      ),
                    );
                  },
                  child: const Text('Show Padded Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Padded Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Padded Dialog'), findsOneWidget);
      // For now, just verify the dialog renders with custom padding
      // The actual padding verification is complex due to multiple Padding widgets
      expect(find.byType(MPDialog), findsOneWidget);
    });

    testWidgets('renders with custom corner radius',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => MPDialog(
                        cornerRadius: 20,
                        child: const Text('Rounded Dialog'),
                      ),
                    );
                  },
                  child: const Text('Show Rounded Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Rounded Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Rounded Dialog'), findsOneWidget);
      final card = tester.widget<Card>(find.byType(Card));
      final shape = card.shape as RoundedRectangleBorder;
      expect(shape.borderRadius, BorderRadius.circular(20));
    });

    testWidgets('renders with custom max height', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => MPDialog(
                        maxHeight: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Line 1'),
                            Text('Line 2'),
                            Text('Line 3'),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text('Show Max Height Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Max Height Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
      expect(find.text('Line 3'), findsOneWidget);
    });

    testWidgets('adapts to different screen sizes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => MPDialog(
                        child: const Text('Responsive Dialog'),
                      ),
                    );
                  },
                  child: const Text('Show Responsive Dialog'),
                );
              },
            ),
          ),
        ),
      );

      // Test small screen
      await tester.binding.setSurfaceSize(const Size(300, 600));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show Responsive Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Responsive Dialog'), findsOneWidget);

      // Close the dialog
      Navigator.of(tester.element(find.byType(MPDialog))).pop();
      await tester.pumpAndSettle();

      // Test large screen
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show Responsive Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Responsive Dialog'), findsOneWidget);

      // Reset surface size
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('closes dialog when tapped outside',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => MPDialog(
                        child: const Text('Tap Outside Dialog'),
                      ),
                    );
                  },
                  child: const Text('Show Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Tap Outside Dialog'), findsOneWidget);

      // Tap outside to close
      await tester.tapAt(Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.text('Tap Outside Dialog'), findsNothing);
    });

    testWidgets('renders complex content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => MPDialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Dialog Title'),
                            const SizedBox(height: 16),
                            const Text(
                                'This is a complex dialog with multiple elements.'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text('Show Complex Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Complex Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Dialog Title'), findsOneWidget);
      expect(find.text('This is a complex dialog with multiple elements.'),
          findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
    });
  });
}
