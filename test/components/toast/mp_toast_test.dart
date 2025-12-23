import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPToast', () {
    testWidgets('renders toast widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPToast.show(
                    context,
                    message: 'Test toast',
                  );
                },
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Test toast'), findsOneWidget);
    });

    testWidgets('renders with different variants', (tester) async {
      for (final variant in MPToastVariant.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    MPToast.show(
                      context,
                      message: 'Test toast',
                      variant: variant,
                    );
                  },
                  child: const Text('Show Toast'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Toast'));
        await tester.pumpAndSettle();

        expect(find.text('Test toast'), findsOneWidget);

        // Clear previous toast
        await tester.pumpAndSettle();
      }
    });

    testWidgets('renders with different positions', (tester) async {
      for (final position in MPToastPosition.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    MPToast.show(
                      context,
                      message: 'Test toast',
                      position: position,
                    );
                  },
                  child: const Text('Show Toast'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Toast'));
        await tester.pumpAndSettle();

        expect(find.text('Test toast'), findsOneWidget);

        await tester.pumpAndSettle();
      }
    });

    testWidgets('renders with different durations', (tester) async {
      for (final duration in MPToastDuration.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    MPToast.show(
                      context,
                      message: 'Test toast',
                      duration: duration,
                    );
                  },
                  child: const Text('Show Toast'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Toast'));
        await tester.pumpAndSettle();

        expect(find.text('Test toast'), findsOneWidget);

        await tester.pumpAndSettle();
      }
    });

    testWidgets('renders success toast', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPToast.success(
                    context,
                    message: 'Success message',
                  );
                },
                child: const Text('Show Success Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Success Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Success message'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('renders error toast', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPToast.error(
                    context,
                    message: 'Error message',
                  );
                },
                child: const Text('Show Error Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Error Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Error message'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('renders warning toast', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPToast.warning(
                    context,
                    message: 'Warning message',
                  );
                },
                child: const Text('Show Warning Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Warning Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Warning message'), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
    });

    testWidgets('renders info toast', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPToast.info(
                    context,
                    message: 'Info message',
                  );
                },
                child: const Text('Show Info Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Info Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Info message'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('renders with leading widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPToast.show(
                    context,
                    message: 'Test toast',
                    leading: const Icon(Icons.star),
                  );
                },
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Test toast'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPToast.show(
                    context,
                    message: 'Test toast',
                    trailing: const Icon(Icons.close),
                  );
                },
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Test toast'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('auto-dismisses after duration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPToast.show(
                    context,
                    message: 'Test toast',
                    duration: MPToastDuration.short,
                  );
                },
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Test toast'), findsOneWidget);

      // Wait for auto-dismiss (short duration = 2 seconds)
      await tester.pump(const Duration(seconds: 3));

      expect(find.text('Test toast'), findsNothing);
    });

    testWidgets('can be dismissed by tapping', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPToast.show(
                    context,
                    message: 'Test toast',
                    dismissible: true,
                  );
                },
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Test toast'), findsOneWidget);

      // Tap the toast to dismiss
      await tester.tap(find.text('Test toast'));
      await tester.pumpAndSettle();

      expect(find.text('Test toast'), findsNothing);
    });

    testWidgets('non-dismissible toast ignores tap', (tester) async {
      bool wasDismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPToast.show(
                    context,
                    message: 'Test toast',
                    dismissible: false,
                    onDismiss: () {
                      wasDismissed = true;
                    },
                  );
                },
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Test toast'), findsOneWidget);

      // Try to tap the toast
      await tester.tap(find.text('Test toast'));
      await tester.pumpAndSettle();

      // Toast should still be visible
      expect(find.text('Test toast'), findsOneWidget);
      expect(wasDismissed, false);
    });

    testWidgets('calls onDismiss callback', (tester) async {
      bool wasDismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPToast.show(
                    context,
                    message: 'Test toast',
                    onDismiss: () {
                      wasDismissed = true;
                    },
                  );
                },
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Test toast'), findsOneWidget);

      // Tap to dismiss
      await tester.tap(find.text('Test toast'));
      await tester.pumpAndSettle();

      expect(wasDismissed, true);
    });

    testWidgets('renders with custom icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPToast.show(
                    context,
                    message: 'Test toast',
                    icon: Icons.star,
                  );
                },
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Test toast'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });
}
