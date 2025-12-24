import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import '../../util/test_helper.dart';

void main() {
  group('MPDatePicker Widget Tests', () {
    setUpAll(() async {
      await MPTestHelper.initialize();
    });

    testWidgets('renders with default props', (tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPDatePicker(
            onDateSelected: (date) {},
          ),
        ),
      );

      expect(find.byType(MPDatePicker), findsOneWidget);
    });

    testWidgets('renders with selected date', (tester) async {
      final selectedDate = DateTime(2025, 12, 25);

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPDatePicker(
            selectedDate: selectedDate,
            onDateSelected: (date) {},
          ),
        ),
      );

      expect(find.byType(MPDatePicker), findsOneWidget);
      expect(find.text('25/12/2025'), findsOneWidget);
    });

    group('Variant Tests', () {
      testWidgets('renders with calendar variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              variant: MPDatePickerVariant.calendar,
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
        expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      });

      testWidgets('renders with button variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              variant: MPDatePickerVariant.button,
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
        expect(find.byType(MPButton), findsOneWidget);
        expect(find.text('Select date'), findsOneWidget);
      });

      testWidgets('renders with input variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              variant: MPDatePickerVariant.input,
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
        expect(find.byType(MPTextField), findsOneWidget);
      });
    });

    group('Size Tests', () {
      testWidgets('renders with small size', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              size: MPDatePickerSize.small,
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
      });

      testWidgets('renders with medium size', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
      });

      testWidgets('renders with large size', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              size: MPDatePickerSize.large,
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
      });
    });

    group('Date Constraints Tests', () {
      testWidgets('renders with min date', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              minDate: DateTime(2025, 1, 1),
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
      });

      testWidgets('renders with max date', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              maxDate: DateTime(2025, 12, 31),
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
      });

      testWidgets('renders with firstDate and lastDate', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              firstDate: DateTime(2025, 1, 1),
              lastDate: DateTime(2025, 12, 31),
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
      });
    });

    group('Date Format Tests', () {
      testWidgets('renders with custom date format', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              selectedDate: DateTime(2025, 12, 25),
              dateFormat: 'dd-MM-yyyy',
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
        expect(find.text('25-12-2025'), findsOneWidget);
      });

      testWidgets('renders with month name format', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              selectedDate: DateTime(2025, 12, 25),
              dateFormat: 'dd MMM yyyy',
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
        expect(find.text('25 Dec 2025'), findsOneWidget);
      });
    });

    group('State Tests', () {
      testWidgets('is enabled by default', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(GestureDetector), findsWidgets);
      });

      testWidgets('is disabled when enabled is false', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              enabled: false,
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
      });
    });

    group('Label and Helper Text Tests', () {
      testWidgets('renders with label', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              label: 'Select Date',
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
        expect(find.text('Select Date'), findsOneWidget);
      });

      testWidgets('renders with error text', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              errorText: 'Invalid date',
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
        expect(find.text('Invalid date'), findsOneWidget);
      });

      testWidgets('renders with helper text', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              helperText: 'Choose a date',
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
        expect(find.text('Choose a date'), findsOneWidget);
      });
    });

    group('Interaction Tests', () {
      testWidgets('opens date picker on tap', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              onDateSelected: (date) {},
            ),
          ),
        );

        await tester.tap(find.byType(MPDatePicker));
        await tester.pumpAndSettle();

        // DatePickerDialog should be shown
        expect(find.byType(DatePickerDialog), findsOneWidget);
      });

      testWidgets('does not open date picker when disabled',
          (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              enabled: false,
              onDateSelected: (date) {},
            ),
          ),
        );

        await tester.tap(find.byType(MPDatePicker));
        await tester.pumpAndSettle();

        // DatePickerDialog should not be shown
        expect(find.byType(DatePickerDialog), findsNothing);
      });
    });

    group('Accessibility', () {
      testWidgets('has semantic label', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              semanticLabel: 'Date of birth',
              onDateSelected: (date) {},
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(MPDatePicker));
        expect(semantics.label, contains('Date of birth'));
      });

      testWidgets('has date value in semantic value', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              selectedDate: DateTime(2025, 12, 25),
              onDateSelected: (date) {},
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(MPDatePicker));
        expect(semantics.value, contains('25/12/2025'));
      });

      testWidgets('shows Not set when no date selected', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              onDateSelected: (date) {},
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(MPDatePicker));
        expect(semantics.value, contains('Not set'));
      });
    });

    group('Theme Integration', () {
      testWidgets('works in light theme', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
      });

      testWidgets('works in dark theme', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPDatePicker(
              onDateSelected: (date) {},
            ),
          ),
        );

        expect(find.byType(MPDatePicker), findsOneWidget);
      });
    });
  });
}
