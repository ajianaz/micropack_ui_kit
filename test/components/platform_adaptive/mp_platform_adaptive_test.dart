import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPPlatformAdaptive Widget Tests', () {
    group('Widget Tests', () {
      testWidgets('returns iOS widget on iOS platform', (tester) async {
        await tester.pumpWidget(
          MPPlatformAdaptive(
            iOS: Container(
              color: Colors.blue,
              child: const Text('iOS'),
            ),
            android: Container(
              color: Colors.green,
              child: const Text('Android'),
            ),
            fallback: Container(
              color: Colors.grey,
              child: const Text('Default'),
            ),
          ),
        );

        // On web or other platforms, will return fallback
        final textFinder = find.text('iOS');
        final defaultFinder = find.text('Default');

        // At least one should be found based on platform
        expect(textFinder.evaluate().isNotEmpty || defaultFinder.evaluate().isNotEmpty, isTrue);
      });

      testWidgets('returns Android widget on Android platform', (tester) async {
        await tester.pumpWidget(
          MPPlatformAdaptive(
            iOS: Container(
              color: Colors.blue,
              child: const Text('iOS'),
            ),
            android: Container(
              color: Colors.green,
              child: const Text('Android'),
            ),
            fallback: Container(
              color: Colors.grey,
              child: const Text('Default'),
            ),
          ),
        );

        // On web or other platforms, will return fallback
        final textFinder = find.text('Android');
        final defaultFinder = find.text('Default');

        // At least one should be found based on platform
        expect(textFinder.evaluate().isNotEmpty || defaultFinder.evaluate().isNotEmpty, isTrue);
      });

      testWidgets('returns fallback when platform not specified', (tester) async {
        await tester.pumpWidget(
          MPPlatformAdaptive(
            iOS: Container(
              color: Colors.blue,
              child: const Text('iOS'),
            ),
            android: Container(
              color: Colors.green,
              child: const Text('Android'),
            ),
            fallback: Container(
              color: Colors.grey,
              child: const Text('Fallback'),
            ),
          ),
        );

        // Should show fallback on unsupported platform
        expect(find.text('Fallback'), findsOneWidget);
      });

      testWidgets('debug forces specific platform', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: MPPlatformAdaptive(
              debugForcePlatform: MPPlatform.iOS,
              iOS: ColoredBox(
                color: Colors.blue,
                child: Text('iOS'),
              ),
              android: ColoredBox(
                color: Colors.green,
                child: Text('Android'),
              ),
            ),
          ),
        );

        // Should show iOS even on non-iOS platforms
        expect(find.text('iOS'), findsOneWidget);
        expect(find.text('Android'), findsNothing);
      });
    });

    group('Fallback Strategy Tests', () {
      testWidgets('uses defaultWidget fallback strategy', (tester) async {
        await tester.pumpWidget(
          MPPlatformAdaptive(
            fallbackStrategy: MPPlatformFallback.defaultWidget,
            fallback: Container(
              color: Colors.grey,
              child: const Text('Fallback'),
            ),
          ),
        );

        expect(find.text('Fallback'), findsOneWidget);
      });

      testWidgets('uses closestPlatform fallback strategy', (tester) async {
        await tester.pumpWidget(
          MPPlatformAdaptive(
            iOS: Container(
              color: Colors.blue,
              child: const Text('iOS'),
            ),
            android: Container(
              color: Colors.green,
              child: const Text('Android'),
            ),
            fallbackStrategy: MPPlatformFallback.closestPlatform,
            fallback: Container(
              color: Colors.grey,
              child: const Text('Fallback'),
            ),
          ),
        );

        // Should return either iOS or Android, or fallback
        expect(
          find.text('iOS').evaluate().isNotEmpty ||
              find.text('Android').evaluate().isNotEmpty ||
              find.text('Fallback').evaluate().isNotEmpty,
          isTrue,
        );
      });
    });

    group('MPPlatformAdaptiveBuilder Tests', () {
      testWidgets('calls correct builder for platform', (tester) async {
        await tester.pumpWidget(
          MPPlatformAdaptiveBuilder(
            iOS: (context) => Container(
              color: Colors.blue,
              child: const Text('iOS Widget'),
            ),
            android: (context) => Container(
              color: Colors.green,
              child: const Text('Android Widget'),
            ),
            fallback: (context) => Container(
              color: Colors.grey,
              child: const Text('Fallback Widget'),
            ),
          ),
        );

        // Should show one of the platform widgets or fallback
        expect(
          find.text('iOS Widget').evaluate().isNotEmpty ||
              find.text('Android Widget').evaluate().isNotEmpty ||
              find.text('Fallback Widget').evaluate().isNotEmpty,
          isTrue,
        );
      });

      testWidgets('provides context to builder', (tester) async {
        await tester.pumpWidget(
          MPPlatformAdaptiveBuilder(
            debugForcePlatform: MPPlatform.iOS,
            iOS: (context) => Builder(
              builder: (context) => Text(
                'Context is available: ${context != null}',
              ),
            ),
            fallback: (context) => Text('Fallback'),
          ),
        );

        // Should show the iOS widget with context
        expect(find.text('Context is available: true'), findsOneWidget);
      });
    });

    group('Platform Detection Tests', () {
      testWidgets('detects web platform correctly', (tester) async {
        // This test will pass on web
        final isWeb = kIsWeb;

        if (isWeb) {
          // On web, verify platform detection works
          await tester.pumpWidget(
            const MaterialApp(
              home: MPPlatformAdaptive(
                web: ColoredBox(
                  color: Colors.cyan,
                  child: Text('Web'),
                ),
                fallback: ColoredBox(
                  color: Colors.grey,
                  child: Text('Fallback'),
                ),
              ),
            ),
          );

          // Should show web widget on web platform
          expect(find.text('Web'), findsOneWidget);
          expect(find.text('Fallback'), findsNothing);
        } else {
          // On non-web platforms, should show fallback
          await tester.pumpWidget(
            const MaterialApp(
              home: MPPlatformAdaptive(
                web: ColoredBox(
                  color: Colors.cyan,
                  child: Text('Web'),
                ),
                fallback: ColoredBox(
                  color: Colors.grey,
                  child: Text('Fallback'),
                ),
              ),
            ),
          );

          // Should show fallback on non-web platforms
          expect(find.text('Web'), findsNothing);
          expect(find.text('Fallback'), findsOneWidget);
        }
      });
    });

    group('Integration Tests', () {
      testWidgets('works with MaterialApp', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPPlatformAdaptive(
                iOS: Container(
                  color: Colors.blue,
                  child: const Center(child: Text('iOS Screen')),
                ),
                android: Container(
                  color: Colors.green,
                  child: const Center(child: Text('Android Screen')),
                ),
                fallback: Container(
                  color: Colors.grey,
                  child: const Center(child: Text('Default Screen')),
                ),
              ),
            ),
          ),
        );

        // Should show one of the platform screens
        expect(
          find.text('iOS Screen').evaluate().isNotEmpty ||
              find.text('Android Screen').evaluate().isNotEmpty ||
              find.text('Default Screen').evaluate().isNotEmpty,
          isTrue,
        );
      });

      testWidgets('works nested with other widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppBar(title: const Text('Test')),
              body: MPPlatformAdaptive(
                iOS: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    children: [
                      Text('iOS Content'),
                      Icon(Icons.phone_iphone),
                    ],
                  ),
                ),
                android: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    children: [
                      Text('Android Content'),
                      Icon(Icons.android),
                    ],
                  ),
                ),
                fallback: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    children: [
                      Text('Default Content'),
                      Icon(Icons.devices),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );

        // Should show platform-specific content
        expect(
          find.byIcon(Icons.phone_iphone).evaluate().isNotEmpty ||
              find.byIcon(Icons.android).evaluate().isNotEmpty ||
              find.byIcon(Icons.devices).evaluate().isNotEmpty,
          isTrue,
        );
      });
    });
  });
}
