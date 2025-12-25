import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPPlatformInteraction', () {
    late MPPlatformInteraction interaction;

    setUp(() {
      interaction = MPPlatformInteraction.instance;
    });

    test('should return singleton instance', () {
      final instance1 = MPPlatformInteraction.instance;
      final instance2 = MPPlatformInteraction.instance;
      expect(instance1, same(instance2));
    });

    test('should detect current platform correctly', () {
      final platform = interaction.currentPlatform;

      if (Platform.isIOS) {
        expect(platform, MPPlatform.iOS);
      } else if (Platform.isAndroid) {
        expect(platform, MPPlatform.android);
      } else if (Platform.isMacOS) {
        expect(platform.toString(), contains('macOS'));
      } else if (Platform.isWindows) {
        expect(platform, MPPlatform.windows);
      } else if (Platform.isLinux) {
        expect(platform, MPPlatform.linux);
      }
    });

    test('should return correct mobile status', () {
      final isMobile = interaction.isMobile;
      expect(isMobile, Platform.isIOS || Platform.isAndroid);
    });

    test('should return correct desktop status', () {
      final isDesktop = interaction.isDesktop;
      expect(
        isDesktop,
        Platform.isMacOS || Platform.isWindows || Platform.isLinux,
      );
    });

    test('should return appropriate min tap target size', () {
      final size = interaction.minTapTargetSize;

      if (Platform.isIOS || Platform.isAndroid) {
        expect(size, 48.0);
      } else if (Platform.isMacOS ||
          Platform.isWindows ||
          Platform.isLinux) {
        expect(size, 32.0);
      }
    });

    test('should return appropriate button padding', () {
      final padding = interaction.buttonPadding;

      if (Platform.isIOS) {
        expect(padding.horizontal, 20.0);
      } else if (Platform.isAndroid) {
        expect(padding.horizontal, 16.0);
      }
    });

    test('should return appropriate border radius', () {
      final radius = interaction.borderRadius;
      expect(radius, isPositive);
      expect(radius, lessThanOrEqualTo(8.0));
    });

    test('should enable hover effects on desktop', () {
      final hoverEnabled = interaction.enableHoverEffects;
      expect(
        hoverEnabled,
        Platform.isMacOS || Platform.isWindows || Platform.isLinux,
      );
    });

    test('should enable ripple effects correctly', () {
      final rippleEnabled = interaction.enableRippleEffects;
      // Android and web should have ripple effects
      expect(rippleEnabled, isA<bool>());
    });

    test('should return correct haptic support', () {
      final supportsHaptics = interaction.supportsHaptics;
      expect(
        supportsHaptics,
        Platform.isIOS || Platform.isAndroid,
      );
    });

    test('should support keyboard shortcuts on desktop', () {
      final supportsShortcuts = interaction.supportsKeyboardShortcuts;
      expect(
        supportsShortcuts,
        Platform.isMacOS || Platform.isWindows || Platform.isLinux,
      );
    });

    test('should return appropriate scroll physics', () {
      final physics = interaction.scrollPhysics;
      expect(physics, isA<ScrollPhysics>());
    });

    test('should return valid dialog animation duration', () {
      final duration = interaction.dialogAnimationDuration;
      expect(duration, isA<Duration>());
      expect(duration.inMilliseconds, greaterThan(0));
      expect(duration.inMilliseconds, lessThan(500));
    });

    test('should return valid page transition duration', () {
      final duration = interaction.pageTransitionDuration;
      expect(duration, isA<Duration>());
      expect(duration.inMilliseconds, greaterThan(0));
      expect(duration.inMilliseconds, lessThan(500));
    });
  });

  group('MPHapticType', () {
    test('should have correct number of types', () {
      expect(MPHapticType.values.length, 4);
    });

    test('should contain expected types', () {
      expect(MPHapticType.values, contains(MPHapticType.light));
      expect(MPHapticType.values, contains(MPHapticType.medium));
      expect(MPHapticType.values, contains(MPHapticType.heavy));
      expect(MPHapticType.values, contains(MPHapticType.selection));
    });
  });

  group('MPPlatformInteractionContext extension', () {
    testWidgets('should provide platform interaction via context',
        (WidgetTester tester) async {
      final key = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            key: key,
            builder: (context) {
              final isMobile = context.isMobile;
              final isDesktop = context.isDesktop;
              final minSize = context.minTapTargetSize;

              return Scaffold(
                body: Column(
                  children: [
                    Text('Mobile: $isMobile'),
                    Text('Desktop: $isDesktop'),
                    Text('Min size: $minSize'),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(find.text('Mobile: ${Platform.isIOS || Platform.isAndroid}'),
          findsOneWidget);
    });

    testWidgets('should provide scroll physics via context',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final physics = context.platformScrollPhysics;
              return ListView(
                physics: physics,
                children: const [Text('Item')],
              );
            },
          ),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
