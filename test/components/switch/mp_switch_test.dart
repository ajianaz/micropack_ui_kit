import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPSwitch', () {
    testWidgets('renders unchecked switch', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSwitch(
              value: false,
              onToggle: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(MPSwitch), findsOneWidget);
    });

    testWidgets('renders checked switch', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSwitch(
              value: true,
              onToggle: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(MPSwitch), findsOneWidget);
    });

    testWidgets('calls onToggle when tapped', (tester) async {
      bool? newValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSwitch(
              value: false,
              onToggle: (value) => newValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MPSwitch));
      expect(newValue, true);
    });

    testWidgets('does not call onToggle when disabled', (tester) async {
      bool? newValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSwitch(
              value: false,
              onToggle: (value) => newValue = value,
              disabled: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MPSwitch));
      expect(newValue, false);
    });

    testWidgets('renders with custom dimensions', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSwitch(
              value: true,
              onToggle: (_) {},
              width: 60.0,
              height: 32.0,
            ),
          ),
        ),
      );

      expect(find.byType(MPSwitch), findsOneWidget);
    });

    testWidgets('shows ON/OFF text when enabled', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSwitch(
              value: true,
              onToggle: (_) {},
              showOnOff: true,
            ),
          ),
        ),
      );

      expect(find.byType(MPSwitch), findsOneWidget);
      expect(find.text('ON'), findsOneWidget);
    });
  });
}
