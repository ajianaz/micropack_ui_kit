import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPDropdown', () {
    testWidgets('renders with items', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPDropdown<int>(
              items: const [
                MPDropdownItem(value: 1, label: 'Option 1'),
                MPDropdownItem(value: 2, label: 'Option 2'),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(MPDropdown<int>), findsOneWidget);
    });

    testWidgets('renders selected value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPDropdown<int>(
              value: 1,
              items: const [
                MPDropdownItem(value: 1, label: 'Option 1'),
                MPDropdownItem(value: 2, label: 'Option 2'),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(MPDropdown<int>), findsOneWidget);
    });

    testWidgets('calls onChanged when item selected', (tester) async {
      int? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPDropdown<int>(
              items: const [
                MPDropdownItem(value: 1, label: 'Option 1'),
                MPDropdownItem(value: 2, label: 'Option 2'),
              ],
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      // Tap dropdown to open menu
      await tester.tap(find.byType(MPDropdown<int>));
      await tester.pumpAndSettle();

      // Tap on an item
      await tester.tap(find.text('Option 1').last);
      await tester.pumpAndSettle();

      expect(selectedValue, 1);
    });

    testWidgets('renders with hint when no value selected', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPDropdown<int>(
              hint: 'Select an option',
              items: const [
                MPDropdownItem(value: 1, label: 'Option 1'),
                MPDropdownItem(value: 2, label: 'Option 2'),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Select an option'), findsOneWidget);
    });

    testWidgets('renders with different sizes', (tester) async {
      for (final size in MPDropdownSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPDropdown<int>(
                items: const [
                  MPDropdownItem(value: 1, label: 'Option 1'),
                ],
                onChanged: (_) {},
                size: size,
              ),
            ),
          ),
        );

        expect(find.byType(MPDropdown<int>), findsOneWidget);
      }
    });

    testWidgets('does not open menu when disabled', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPDropdown<int>(
              items: const [
                MPDropdownItem(value: 1, label: 'Option 1'),
                MPDropdownItem(value: 2, label: 'Option 2'),
              ],
              onChanged: (_) {},
              enabled: false,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MPDropdown<int>));
      await tester.pumpAndSettle();

      // Menu should not open
      expect(find.text('Option 1'), findsNothing);
    });

    testWidgets('renders item with leading widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPDropdown<int>(
              items: const [
                MPDropdownItem(
                  value: 1,
                  label: 'Option 1',
                  leading: Icon(Icons.star),
                ),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(MPDropdown<int>), findsOneWidget);
    });
  });
}
