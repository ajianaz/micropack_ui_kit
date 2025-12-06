import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Performance tests for MPButton widget rebuild scenarios
void main() {
  group('MPButton Performance Tests', () {
    testWidgets('should not rebuild unnecessarily with const constructor',
        (WidgetTester tester) async {
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                buildCount++;
                return MPButton(
                  text: 'Test Button',
                  onPressed: () {},
                  variant: MPButtonVariant.primary,
                );
              },
            ),
          ),
        ),
      );

      // Initial build
      expect(buildCount, equals(1));

      // Pump again without state changes
      await tester.pump();
      expect(buildCount, equals(1),
          reason: 'Widget should not rebuild without state changes');
    });

    testWidgets('should use cached style values for consistent performance',
        (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();

      // Build multiple instances with same parameters
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: List.generate(
                  100,
                  (index) => MPButton(
                        text: 'Button $index',
                        onPressed: () {},
                        variant: MPButtonVariant.primary,
                      )),
            ),
          ),
        ),
      );

      stopwatch.stop();

      // Should complete within reasonable time (adjust threshold as needed)
      expect(stopwatch.elapsedMilliseconds, lessThan(1000),
          reason:
              'Building 100 identical buttons should be fast due to caching');
    });

    testWidgets('should rebuild efficiently when properties change',
        (WidgetTester tester) async {
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                buildCount++;
                return MPButton(
                  text: 'Dynamic Button',
                  onPressed: () {},
                  variant: MPButtonVariant.primary,
                  key: ValueKey(buildCount),
                );
              },
            ),
          ),
        ),
      );

      expect(buildCount, equals(1));

      // Trigger rebuild with different key
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                buildCount++;
                return MPButton(
                  text: 'Updated Button',
                  onPressed: () {},
                  variant: MPButtonVariant.primary,
                  key: ValueKey(buildCount),
                );
              },
            ),
          ),
        ),
      );

      expect(buildCount, equals(2),
          reason: 'Should rebuild exactly once when properties change');
    });

    testWidgets('should handle rapid state changes efficiently',
        (WidgetTester tester) async {
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                buildCount++;
                return MPButton(
                  text: 'Rapid Update Button',
                  onPressed: () {},
                  loading: buildCount % 2 == 0, // Toggle loading state
                  key: ValueKey(buildCount),
                );
              },
            ),
          ),
        ),
      );

      expect(buildCount, equals(1));

      // Simulate rapid state changes
      for (int i = 0; i < 10; i++) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  buildCount++;
                  return MPButton(
                    text: 'Rapid Update Button',
                    onPressed: () {},
                    loading: (buildCount + i) % 2 == 0,
                    key: ValueKey('${buildCount}_$i'),
                  );
                },
              ),
            ),
          ),
        );
      }

      expect(buildCount, equals(11),
          reason: 'Should handle rapid state changes efficiently');
    });

    testWidgets('should maintain performance with complex theme switching',
        (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
          ),
          home: Scaffold(
            body: Column(
              children: List.generate(
                  50,
                  (index) => MPButton(
                        text: 'Theme Button $index',
                        onPressed: () {},
                        variant: MPButtonVariant.primary,
                      )),
            ),
          ),
        ),
      );

      stopwatch.stop();
      final themeBuildTime = stopwatch.elapsedMilliseconds;

      // Switch theme
      stopwatch.reset();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.green,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              brightness: Brightness.dark,
            ),
          ),
          home: Scaffold(
            body: Column(
              children: List.generate(
                  50,
                  (index) => MPButton(
                        text: 'Theme Button $index',
                        onPressed: () {},
                        variant: MPButtonVariant.primary,
                      )),
            ),
          ),
        ),
      );

      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(themeBuildTime * 1.5),
          reason:
              'Theme switching should not significantly impact performance');
    });
  });
}
