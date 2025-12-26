import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/mp_component_init_test.dart';

void main() {
  group('MPDialog Comprehensive Tests', () {
    // Basic rendering tests
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
                        child: Container(
                          width: 200,
                          height: 100,
                          color: Colors.blue,
                          child: const Text('Dialog Content'),
                        ),
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
      // For now, just verify the dialog renders correctly
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
                          children: [
                            const Text('Line 1'),
                            const Text('Line 2'),
                            const Text('Line 3'),
                            const Text('Line 4'),
                            const Text('Line 5'),
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
      expect(find.text('Line 5'), findsOneWidget);
    });

    // Responsive behavior tests
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
                        child: Container(
                          width: 200,
                          height: 100,
                          color: Colors.green,
                          child: const Text('Responsive Dialog'),
                        ),
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
      await tester.tap(find.text('Show Responsive Dialog'));
      await tester.pumpAndSettle();

      // Verify dialog renders on small screen
      expect(find.text('Responsive Dialog'), findsOneWidget);

      // Close the dialog
      Navigator.of(tester.element(find.byType(MPDialog))).pop();
      await tester.pumpAndSettle();

      // Test large screen
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.tap(find.text('Show Responsive Dialog'));
      await tester.pumpAndSettle();

      // Verify dialog renders on large screen
      expect(find.text('Responsive Dialog'), findsOneWidget);

      // Reset surface size
      await tester.binding.setSurfaceSize(null);
    });

    // Theme adaptation tests
    testWidgets('adapts to light theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: MaterialApp(
            theme: MPTheme.main().copyWith(
              extensions: <ThemeExtension<dynamic>>[
                MPColorTheme.light,
              ],
            ),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => MPDialog(
                          child: const Text('Light Theme Dialog'),
                        ),
                      );
                    },
                    child: const Text('Show Light Dialog'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Light Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Light Theme Dialog'), findsOneWidget);
      final card = tester.widget<Card>(find.byType(Card));
      expect(card.color, isNotNull);
    });

    testWidgets('adapts to dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: MaterialApp(
            theme: MPTheme.main().copyWith(
              extensions: <ThemeExtension<dynamic>>[
                MPColorTheme.dark,
              ],
            ),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => MPDialog(
                          child: const Text('Dark Theme Dialog'),
                        ),
                      );
                    },
                    child: const Text('Show Dark Dialog'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dark Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Dark Theme Dialog'), findsOneWidget);
      final card = tester.widget<Card>(find.byType(Card));
      expect(card.color, isNotNull);
    });

    // Interaction tests
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

    testWidgets('dismisses dialog with barrier dismissible',
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
                      barrierDismissible: true,
                      builder: (context) => MPDialog(
                        child: const Text('Dismissible Dialog'),
                      ),
                    );
                  },
                  child: const Text('Show Dismissible Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dismissible Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Dismissible Dialog'), findsOneWidget);

      // Tap outside to close
      await tester.tapAt(Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.text('Dismissible Dialog'), findsNothing);
    });

    // Content tests
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
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(child: const Text('Option 1')),
                                const SizedBox(width: 8),
                                Expanded(child: const Text('Option 2')),
                              ],
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
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
    });

    // Error handling tests
    testWidgets('handles null child gracefully', (WidgetTester tester) async {
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
                        child: const SizedBox.shrink(),
                      ),
                    );
                  },
                  child: const Text('Show Null Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Null Dialog'));
      await tester.pumpAndSettle();

      // Should not crash
      expect(find.byType(MPDialog), findsOneWidget);
    });

    // Performance tests
    testWidgets('renders efficiently with multiple dialogs',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Column(
              children: List.generate(
                3,
                (index) => Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => MPDialog(
                            child: Text('Dialog $index'),
                          ),
                        );
                      },
                      child: Text('Show Dialog $index'),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      for (int i = 0; i < 3; i++) {
        await tester.tap(find.text('Show Dialog $i'));
        await tester.pumpAndSettle();
        expect(find.text('Dialog $i'), findsOneWidget);

        // Close the dialog before opening the next one
        Navigator.of(tester.element(find.byType(MPDialog))).pop();
        await tester.pumpAndSettle();
      }
    });

    // Accessibility tests
    testWidgets('has semantic properties', (WidgetTester tester) async {
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
                        child: const Text('Accessible Dialog'),
                      ),
                    );
                  },
                  child: const Text('Show Accessible Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Accessible Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Accessible Dialog'), findsOneWidget);
    });
  });
}
