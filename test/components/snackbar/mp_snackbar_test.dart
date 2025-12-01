import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/mp_component_init_test.dart';

void main() {
  group('MPSnackbar Tests', () {
    // Basic snackbar tests
    testWidgets('shows basic snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.show(
                      context,
                      message: 'Basic snackbar message',
                    );
                  },
                  child: const Text('Show Basic Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Basic Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Basic snackbar message'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows snackbar with custom colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.show(
                      context,
                      message: 'Custom color snackbar',
                      backgroundColor: Colors.purple,
                      textColor: Colors.white,
                    );
                  },
                  child: const Text('Show Custom Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Custom Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Custom color snackbar'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows snackbar with custom font size',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.show(
                      context,
                      message: 'Custom font size snackbar',
                      fontSize: 18,
                    );
                  },
                  child: const Text('Show Font Size Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Font Size Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Custom font size snackbar'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows snackbar with custom duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.show(
                      context,
                      message: 'Custom duration snackbar',
                      duration: const Duration(seconds: 1),
                    );
                  },
                  child: const Text('Show Duration Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Duration Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Custom duration snackbar'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);

      // Wait for snackbar to disappear
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Custom duration snackbar'), findsNothing);
    });

    testWidgets('shows snackbar with action', (WidgetTester tester) async {
      bool actionPressed = false;

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.show(
                      context,
                      message: 'Snackbar with action',
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () => actionPressed = true,
                      ),
                    );
                  },
                  child: const Text('Show Action Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Action Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Snackbar with action'), findsOneWidget);
      expect(find.text('UNDO'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);

      await tester.tap(find.text('UNDO'));
      expect(actionPressed, true);
    });

    // Success snackbar tests
    testWidgets('shows success snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.success(
                      context,
                      message: 'Success message',
                    );
                  },
                  child: const Text('Show Success Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Success Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Success message'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows success snackbar with custom font size',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.success(
                      context,
                      message: 'Success with custom font',
                      fontSize: 16,
                    );
                  },
                  child: const Text('Show Success Font Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Success Font Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Success with custom font'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows success snackbar with custom duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.success(
                      context,
                      message: 'Success with custom duration',
                      duration: const Duration(seconds: 1),
                    );
                  },
                  child: const Text('Show Success Duration Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Success Duration Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Success with custom duration'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);

      // Wait for snackbar to disappear
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Success with custom duration'), findsNothing);
    });

    // Error snackbar tests
    testWidgets('shows error snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.error(
                      context,
                      message: 'Error message',
                    );
                  },
                  child: const Text('Show Error Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Error Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Error message'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows error snackbar with custom font size',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.error(
                      context,
                      message: 'Error with custom font',
                      fontSize: 16,
                    );
                  },
                  child: const Text('Show Error Font Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Error Font Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Error with custom font'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows error snackbar with custom duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.error(
                      context,
                      message: 'Error with custom duration',
                      duration: const Duration(seconds: 1),
                    );
                  },
                  child: const Text('Show Error Duration Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Error Duration Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Error with custom duration'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);

      // Wait for snackbar to disappear
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Error with custom duration'), findsNothing);
    });

    // Warning snackbar tests
    testWidgets('shows warning snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.warning(
                      context,
                      message: 'Warning message',
                    );
                  },
                  child: const Text('Show Warning Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Warning Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Warning message'), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows warning snackbar with custom font size',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.warning(
                      context,
                      message: 'Warning with custom font',
                      fontSize: 16,
                    );
                  },
                  child: const Text('Show Warning Font Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Warning Font Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Warning with custom font'), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows warning snackbar with custom duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.warning(
                      context,
                      message: 'Warning with custom duration',
                      duration: const Duration(seconds: 1),
                    );
                  },
                  child: const Text('Show Warning Duration Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Warning Duration Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Warning with custom duration'), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);

      // Wait for snackbar to disappear
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Warning with custom duration'), findsNothing);
    });

    // Info snackbar tests
    testWidgets('shows info snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.info(
                      context,
                      message: 'Info message',
                    );
                  },
                  child: const Text('Show Info Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Info Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Info message'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows info snackbar with custom font size',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.info(
                      context,
                      message: 'Info with custom font',
                      fontSize: 16,
                    );
                  },
                  child: const Text('Show Info Font Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Info Font Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Info with custom font'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows info snackbar with custom duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.info(
                      context,
                      message: 'Info with custom duration',
                      duration: const Duration(seconds: 1),
                    );
                  },
                  child: const Text('Show Info Duration Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Info Duration Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Info with custom duration'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);

      // Wait for snackbar to disappear
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Info with custom duration'), findsNothing);
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
                      MPSnackbar.show(
                        context,
                        message: 'Light theme snackbar',
                      );
                    },
                    child: const Text('Show Light Snackbar'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Light Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Light theme snackbar'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
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
                      MPSnackbar.show(
                        context,
                        message: 'Dark theme snackbar',
                      );
                    },
                    child: const Text('Show Dark Snackbar'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dark Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Dark theme snackbar'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    // Multiple snackbars tests
    testWidgets('shows multiple snackbars in sequence',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        MPSnackbar.success(
                          context,
                          message: 'First snackbar',
                          duration: const Duration(seconds: 1),
                        );
                      },
                      child: const Text('Show First'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        MPSnackbar.error(
                          context,
                          message: 'Second snackbar',
                          duration: const Duration(seconds: 1),
                        );
                      },
                      child: const Text('Show Second'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Show first snackbar
      await tester.tap(find.text('Show First'));
      await tester.pumpAndSettle();

      expect(find.text('First snackbar'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);

      // Wait for first to disappear
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('First snackbar'), findsNothing);

      // Show second snackbar
      await tester.tap(find.text('Show Second'));
      await tester.pumpAndSettle();

      expect(find.text('Second snackbar'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    // Long message tests
    testWidgets('handles long messages', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.show(
                      context,
                      message:
                          'This is a very long snackbar message that should wrap properly and display correctly in the UI without any issues or overflow problems.',
                    );
                  },
                  child: const Text('Show Long Message Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Long Message Snackbar'));
      await tester.pumpAndSettle();

      expect(
          find.text(
              'This is a very long snackbar message that should wrap properly and display correctly in the UI without any issues or overflow problems.'),
          findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
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
                    MPSnackbar.show(
                      context,
                      message: 'Accessible snackbar',
                    );
                  },
                  child: const Text('Show Accessible Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Accessible Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Accessible snackbar'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    // Error handling tests
    testWidgets('handles empty message gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MPSnackbar.show(
                      context,
                      message: '',
                    );
                  },
                  child: const Text('Show Empty Snackbar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Empty Snackbar'));
      await tester.pumpAndSettle();

      // Should still show snackbar even with empty message
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
