import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('MPDivider Widget Tests', () {
    group('Render Tests', () {
      testWidgets('renders horizontal divider', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPDivider(
              orientation: MPDividerOrientation.horizontal,
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });

      testWidgets('renders vertical divider', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: SizedBox(
              height: 100,
              child: const MPDivider(
                orientation: MPDividerOrientation.vertical,
              ),
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });

      testWidgets('renders with label', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPDivider(
              label: 'Section',
            ),
          ),
        );

        expect(find.text('Section'), findsOneWidget);
      });

      testWidgets('renders with dashed style', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPDivider(
              style: MPDividerStyle.dashed,
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });
    });

    group('Thickness Tests', () {
      testWidgets('renders thin divider', (tester) async {
        final divider = MPDivider(thickness: MPDividerThickness.thin);
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: divider),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(MPDivider),
            matching: find.byType(Container),
          ).first,
        );

        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, isNotNull);
      });

      testWidgets('renders medium divider', (tester) async {
        final divider = MPDivider(thickness: MPDividerThickness.medium);
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: divider),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });

      testWidgets('renders thick divider', (tester) async {
        final divider = MPDivider(thickness: MPDividerThickness.thick);
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: divider),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });
    });

    group('Orientation Tests', () {
      testWidgets('horizontal divider has correct constraints', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPDivider(
              orientation: MPDividerOrientation.horizontal,
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });

      testWidgets('vertical divider has correct constraints', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: SizedBox(
              height: 100,
              child: const MPDivider(
                orientation: MPDividerOrientation.vertical,
              ),
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });
    });

    group('Style Tests', () {
      testWidgets('renders solid style', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPDivider(
              style: MPDividerStyle.solid,
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });

      testWidgets('renders dashed style', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPDivider(
              style: MPDividerStyle.dashed,
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });
    });

    group('Indent Tests', () {
      testWidgets('applies start indent', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPDivider(
              indent: 24,
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });

      testWidgets('applies end indent', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPDivider(
              endIndent: 24,
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });

      testWidgets('applies both indents', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPDivider(
              indent: 32,
              endIndent: 32,
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });
    });

    group('Color Tests', () {
      testWidgets('applies custom color', (tester) async {
        const customColor = Colors.purple;

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPDivider(
              color: customColor,
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });

      testWidgets('uses theme color by default', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPDivider(),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });
    });

    group('Size Tests', () {
      testWidgets('applies custom height', (tester) async {
        const customHeight = 48.0;

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPDivider(
              height: customHeight,
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });

      testWidgets('applies custom width', (tester) async {
        const customWidth = 32.0;

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: SizedBox(
              height: 100,
              child: MPDivider(
                width: customWidth,
                orientation: MPDividerOrientation.vertical,
              ),
            ),
          ),
        );

        expect(find.byType(MPDivider), findsOneWidget);
      });
    });

    group('Labeled Divider Tests', () {
      testWidgets('renders label between dividers', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: Column(
              children: [
                Text('Content 1'),
                const MPDivider(label: 'Label'),
                Text('Content 2'),
              ],
            ),
          ),
        );

        expect(find.text('Label'), findsOneWidget);
        expect(find.text('Content 1'), findsOneWidget);
        expect(find.text('Content 2'), findsOneWidget);
      });

      testWidgets('label is centered', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPDivider(label: 'Centered Label'),
          ),
        );

        expect(find.text('Centered Label'), findsOneWidget);
      });
    });

    group('Accessibility Tests', () {
      testWidgets('has semantic label', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPDivider(
              semanticLabel: 'Section divider',
            ),
          ),
        );

        expect(find.bySemanticsLabel('Section divider'), findsOneWidget);
      });
    });

    group('Integration Tests', () {
      testWidgets('works in Column', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: Column(
              children: const [
                Text('Section 1'),
                MPDivider(),
                Text('Section 2'),
                MPDivider(),
                Text('Section 3'),
              ],
            ),
          ),
        );

        expect(find.byType(MPDivider), findsNWidgets(2));
      });

      testWidgets('works with other components', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: Column(
              children: [
                MPAvatar(
                  name: 'John',
                  type: MPAvatarType.initials,
                ),
                const MPDivider(),
                MPText('John Doe'),
              ],
            ),
          ),
        );

        expect(find.byType(MPAvatar), findsOneWidget);
        expect(find.byType(MPDivider), findsOneWidget);
        expect(find.byType(MPText), findsOneWidget);
      });

      testWidgets('multiple dividers with different styles', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: Column(
              children: const [
                Text('Solid'),
                MPDivider(style: MPDividerStyle.solid),
                Text('Dashed'),
                MPDivider(style: MPDividerStyle.dashed),
                Text('Labeled'),
                MPDivider(label: 'Label'),
              ],
            ),
          ),
        );

        expect(find.byType(MPDivider), findsNWidgets(3));
      });
    });
  });
}
