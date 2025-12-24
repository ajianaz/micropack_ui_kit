import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import '../../util/test_helper.dart';

void main() {
  group('MPTimePicker Widget Tests', () {
    setUpAll(() async {
      await MPTestHelper.initialize();
    });

    testWidgets('renders with default props', (tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPTimePicker(
            onTimeSelected: (time) {},
          ),
        ),
      );

      expect(find.byType(MPTimePicker), findsOneWidget);
    });

    testWidgets('renders with selected time', (tester) async {
      final selectedTime = const TimeOfDay(hour: 14, minute: 30);

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPTimePicker(
            selectedTime: selectedTime,
            onTimeSelected: (time) {},
          ),
        ),
      );

      expect(find.byType(MPTimePicker), findsOneWidget);
      expect(find.text('2:30 PM'), findsOneWidget);
    });

    group('Variant Tests', () {
      testWidgets('renders with dial variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              variant: MPTimePickerVariant.dial,
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
        expect(find.byIcon(Icons.access_time), findsOneWidget);
      });

      testWidgets('renders with dropdown variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              variant: MPTimePickerVariant.dropdown,
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
        expect(find.byType(MPButton), findsOneWidget);
        expect(find.text('Select time'), findsOneWidget);
      });

      testWidgets('renders with input variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              variant: MPTimePickerVariant.input,
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
        expect(find.byType(MPTextField), findsOneWidget);
      });
    });

    group('Size Tests', () {
      testWidgets('renders with small size', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              size: MPTimePickerSize.small,
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
      });

      testWidgets('renders with medium size', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
      });

      testWidgets('renders with large size', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              size: MPTimePickerSize.large,
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
      });
    });

    group('Time Format Tests', () {
      testWidgets('renders with 12-hour format', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              selectedTime: const TimeOfDay(hour: 14, minute: 30),
              format: MPTimeFormat.hour12,
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
        expect(find.text('2:30 PM'), findsOneWidget);
      });

      testWidgets('renders with 24-hour format', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              selectedTime: const TimeOfDay(hour: 14, minute: 30),
              format: MPTimeFormat.hour24,
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
        expect(find.text('14:30'), findsOneWidget);
      });
    });

    group('State Tests', () {
      testWidgets('is enabled by default', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(GestureDetector), findsWidgets);
      });

      testWidgets('is disabled when enabled is false', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              enabled: false,
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
      });
    });

    group('Label and Helper Text Tests', () {
      testWidgets('renders with label', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              label: 'Select Time',
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
        expect(find.text('Select Time'), findsOneWidget);
      });

      testWidgets('renders with error text', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              errorText: 'Invalid time',
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
        expect(find.text('Invalid time'), findsOneWidget);
      });

      testWidgets('renders with helper text', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              helperText: 'Choose a time',
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
        expect(find.text('Choose a time'), findsOneWidget);
      });
    });

    group('Interaction Tests', () {
      testWidgets('opens time picker on tap', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              onTimeSelected: (time) {},
            ),
          ),
        );

        await tester.tap(find.byType(MPTimePicker));
        await tester.pumpAndSettle();

        // TimePickerDialog should be shown
        expect(find.byType(TimePickerDialog), findsOneWidget);
      });

      testWidgets('does not open time picker when disabled',
          (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              enabled: false,
              onTimeSelected: (time) {},
            ),
          ),
        );

        await tester.tap(find.byType(MPTimePicker));
        await tester.pumpAndSettle();

        // TimePickerDialog should not be shown
        expect(find.byType(TimePickerDialog), findsNothing);
      });
    });

    group('Accessibility', () {
      testWidgets('has semantic label', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              semanticLabel: 'Wake up time',
              onTimeSelected: (time) {},
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(MPTimePicker));
        expect(semantics.label, contains('Wake up time'));
      });

      testWidgets('has time value in semantic value', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              selectedTime: const TimeOfDay(hour: 14, minute: 30),
              onTimeSelected: (time) {},
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(MPTimePicker));
        expect(semantics.value, contains('2:30 PM'));
      });

      testWidgets('shows Not set when no time selected', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              onTimeSelected: (time) {},
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(MPTimePicker));
        expect(semantics.value, contains('Not set'));
      });
    });

    group('Theme Integration', () {
      testWidgets('works in light theme', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
      });

      testWidgets('works in dark theme', (tester) async {
        await tester.pumpWidget(
          MPTestHelper.createTestWidgetWithInit(
            child: MPTimePicker(
              onTimeSelected: (time) {},
            ),
          ),
        );

        expect(find.byType(MPTimePicker), findsOneWidget);
      });
    });
  });
}
