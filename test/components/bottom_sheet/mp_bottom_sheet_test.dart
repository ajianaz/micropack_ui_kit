import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('MPBottomSheet Widget Tests', () {
    group('Show Method Tests', () {
      testWidgets('shows bottom sheet with static method', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPBottomSheet.show(
                    context: context,
                    title: 'Test Title',
                    child: const Text('Content'),
                  );
                },
                child: const Text('Show Bottom Sheet'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Bottom Sheet'));
        await tester.pumpAndSettle();

        expect(find.text('Test Title'), findsOneWidget);
        expect(find.text('Content'), findsOneWidget);
      });

      testWidgets('shows bottom sheet with actions', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  MPBottomSheet.show(
                    context: context,
                    title: 'Confirm Action',
                    actions: [
                      MPBottomSheetAction(
                        label: 'Cancel',
                        onPressed: () {},
                      ),
                      MPBottomSheetAction(
                        label: 'Confirm',
                        style: MPBottomSheetActionStyle.primary,
                        onPressed: () {},
                      ),
                    ],
                    child: const Text('Content'),
                  );
                },
                child: const Text('Show Bottom Sheet'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Bottom Sheet'));
        await tester.pumpAndSettle();

        expect(find.text('Confirm Action'), findsOneWidget);
        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('Confirm'), findsOneWidget);
      });
    });

    group('Render Tests', () {
      testWidgets('renders with title', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPBottomSheet(
              title: 'Test Title',
              child: const Text('Content'),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
      });

      testWidgets('renders with subtitle', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPBottomSheet(
              title: 'Test Title',
              subtitle: 'Test Subtitle',
              child: const Text('Content'),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
        expect(find.text('Test Subtitle'), findsOneWidget);
      });

      testWidgets('renders with close button', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPBottomSheet(
              title: 'Test Title',
              dismissible: true,
              child: const Text('Content'),
            ),
          ),
        );

        expect(find.byIcon(Icons.close), findsOneWidget);
      });

      testWidgets('does not render close button when not dismissible', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPBottomSheet(
              title: 'Test Title',
              dismissible: false,
              child: const Text('Content'),
            ),
          ),
        );

        expect(find.byIcon(Icons.close), findsNothing);
      });
    });

    group('Variant Tests', () {
      testWidgets('renders standard variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPBottomSheet(
              variant: MPBottomSheetVariant.standard,
              child: Text('Content'),
            ),
          ),
        );

        expect(find.byType(MPBottomSheet), findsOneWidget);
      });

      testWidgets('renders rounded variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPBottomSheet(
              variant: MPBottomSheetVariant.rounded,
              child: Text('Content'),
            ),
          ),
        );

        expect(find.byType(MPBottomSheet), findsOneWidget);
      });
    });

    group('Size Tests', () {
      testWidgets('renders compact size', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPBottomSheet(
              size: MPBottomSheetSize.compact,
              child: Text('Content'),
            ),
          ),
        );

        expect(find.byType(MPBottomSheet), findsOneWidget);
      });

      testWidgets('renders medium size', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPBottomSheet(
              size: MPBottomSheetSize.medium,
              child: Text('Content'),
            ),
          ),
        );

        expect(find.byType(MPBottomSheet), findsOneWidget);
      });

      testWidgets('renders large size', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPBottomSheet(
              size: MPBottomSheetSize.large,
              child: Text('Content'),
            ),
          ),
        );

        expect(find.byType(MPBottomSheet), findsOneWidget);
      });
    });

    group('Action Tests', () {
      testWidgets('renders primary action button', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPBottomSheet(
              actions: [
                MPBottomSheetAction(
                  label: 'Primary',
                  style: MPBottomSheetActionStyle.primary,
                  onPressed: () {},
                ),
              ],
              child: const Text('Content'),
            ),
          ),
        );

        expect(find.text('Primary'), findsOneWidget);
      });

      testWidgets('renders secondary action button', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPBottomSheet(
              actions: [
                MPBottomSheetAction(
                  label: 'Secondary',
                  style: MPBottomSheetActionStyle.secondary,
                  onPressed: () {},
                ),
              ],
              child: const Text('Content'),
            ),
          ),
        );

        expect(find.text('Secondary'), findsOneWidget);
      });

      testWidgets('renders destructive action button', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPBottomSheet(
              actions: [
                MPBottomSheetAction(
                  label: 'Delete',
                  style: MPBottomSheetActionStyle.destructive,
                  onPressed: () {},
                ),
              ],
              child: const Text('Content'),
            ),
          ),

        );

        expect(find.text('Delete'), findsOneWidget);
      });

      testWidgets('action button is disabled', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPBottomSheet(
              actions: [
                MPBottomSheetAction(
                  label: 'Disabled',
                  disabled: true,
                  onPressed: () {},
                ),
              ],
              child: const Text('Content'),
            ),
          ),
        );

        expect(find.text('Disabled'), findsOneWidget);
      });
    });

    group('Accessibility Tests', () {
      testWidgets('has semantic label', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPBottomSheet(
              semanticLabel: 'Bottom sheet for options',
              child: Text('Content'),
            ),
          ),
        );

        expect(find.bySemanticsLabel('Bottom sheet for options'), findsOneWidget);
      });

      testWidgets('action buttons have semantic labels', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPBottomSheet(
              actions: [
                MPBottomSheetAction(
                  label: 'Confirm',
                  onPressed: () {},
                ),
              ],
              child: const Text('Content'),
            ),
          ),
        );

        expect(find.bySemanticsLabel('Confirm'), findsOneWidget);
      });
    });

    group('Integration Tests', () {
      testWidgets('works with scrollable content', (tester) async {
        final items = List.generate(20, (index) => 'Item $index');

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPBottomSheet(
              title: 'List of Items',
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(items[index]));
                },
              ),
            ),
          ),
        );

        expect(find.byType(ListView), findsOneWidget);
      });

      testWidgets('works with custom content widget', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPBottomSheet(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Custom Content'),
              ),
            ),
          ),
        );

        expect(find.text('Custom Content'), findsOneWidget);
      });
    });
  });
}
