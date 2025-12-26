import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('MPEmptyState Widget Tests', () {
    group('Render Tests', () {
      testWidgets('renders with no data variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.noData,
            ),
          ),
        );

        expect(find.text('No data'), findsOneWidget);
      });

      testWidgets('renders with no results variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.noResults,
            ),
          ),
        );

        expect(find.text('No results found'), findsOneWidget);
      });

      testWidgets('renders with no network variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.noNetwork,
            ),
          ),
        );

        expect(find.text('No connection'), findsOneWidget);
      });

      testWidgets('renders with error variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.error,
            ),
          ),
        );

        expect(find.text('Something went wrong'), findsOneWidget);
      });

      testWidgets('renders with custom variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.custom,
            ),
          ),
        );

        expect(find.text('Empty'), findsOneWidget);
      });
    });

    group('Size Tests', () {
      testWidgets('renders small size', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.noData,
              size: MPEmptyStateSize.small,
            ),
          ),
        );

        expect(find.byType(MPEmptyState), findsOneWidget);
        expect(find.byIcon(Icons.inbox), findsOneWidget);
      });

      testWidgets('renders medium size', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.noData,
              size: MPEmptyStateSize.medium,
            ),
          ),
        );

        expect(find.byType(MPEmptyState), findsOneWidget);
        expect(find.byIcon(Icons.inbox), findsOneWidget);
      });

      testWidgets('renders large size', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.noData,
              size: MPEmptyStateSize.large,
            ),
          ),
        );

        expect(find.byType(MPEmptyState), findsOneWidget);
        expect(find.byIcon(Icons.inbox), findsOneWidget);
      });
    });

    group('Custom Content Tests', () {
      testWidgets('renders with custom title', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.custom,
              title: 'Custom Title',
            ),
          ),
        );

        expect(find.text('Custom Title'), findsOneWidget);
        expect(find.text('This section is currently empty.'), findsOneWidget);
      });

      testWidgets('renders with custom description', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.custom,
              description: 'Custom description text.',
            ),
          ),
        );

        expect(find.text('Empty'), findsOneWidget);
        expect(find.text('Custom description text.'), findsOneWidget);
      });

      testWidgets('renders with custom icon', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.custom,
              icon: Icons.favorite,
            ),
          ),
        );

        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.byIcon(Icons.info_outline), findsNothing);
      });

      testWidgets('renders with custom image', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPEmptyState(
              variant: MPEmptyStateVariant.custom,
              image: FlutterLogo(size: 64),
            ),
          ),
        );

        expect(find.byType(FlutterLogo), findsOneWidget);
        expect(find.byIcon(Icons.info_outline), findsNothing);
      });

      testWidgets('renders with both custom title and description', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.custom,
              title: 'No Items',
              description: 'Add items to get started.',
            ),
          ),
        );

        expect(find.text('No Items'), findsOneWidget);
        expect(find.text('Add items to get started.'), findsOneWidget);
      });
    });

    group('Action Tests', () {
      testWidgets('renders with action button', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPEmptyState(
              variant: MPEmptyStateVariant.noResults,
              actionLabel: 'Clear Search',
              onAction: () {},
            ),
          ),
        );

        expect(find.text('Clear Search'), findsOneWidget);
        expect(find.byType(MPButton), findsOneWidget);
      });

      testWidgets('action button is clickable', (tester) async {
        var actionCalled = false;
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPEmptyState(
              variant: MPEmptyStateVariant.noResults,
              actionLabel: 'Retry',
              onAction: () {
                actionCalled = true;
              },
            ),
          ),
        );

        await tester.tap(find.text('Retry'));
        await tester.pumpAndSettle();

        expect(actionCalled, isTrue);
      });

      testWidgets('renders without action when null', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.noData,
            ),
          ),
        );

        expect(find.byType(MPButton), findsNothing);
      });
    });

    group('Icon Tests', () {
      testWidgets('renders correct icon for each variant', (tester) async {
        final iconMap = {
          MPEmptyStateVariant.noData: Icons.inbox,
          MPEmptyStateVariant.noResults: Icons.search_off,
          MPEmptyStateVariant.noNetwork: Icons.cloud_off,
          MPEmptyStateVariant.error: Icons.error_outline,
          MPEmptyStateVariant.custom: Icons.info_outline,
        };

        for (final entry in iconMap.entries) {
          await tester.pumpWidget(
            MPTestHelpers.createTestApp(
              child: MPEmptyState(
                variant: entry.key,
                size: MPEmptyStateSize.small,
              ),
            ),
          );

          expect(find.byIcon(entry.value), findsOneWidget);

          // Clean up for next test
          await tester.pumpWidget(
            MPTestHelpers.createTestApp(
              child: const SizedBox(),
            ),
          );
        }
      });
    });

    group('Text Tests', () {
      testWidgets('renders default title for each variant', (tester) async {
        final titleMap = {
          MPEmptyStateVariant.noData: 'No data',
          MPEmptyStateVariant.noResults: 'No results found',
          MPEmptyStateVariant.noNetwork: 'No connection',
          MPEmptyStateVariant.error: 'Something went wrong',
          MPEmptyStateVariant.custom: 'Empty',
        };

        for (final entry in titleMap.entries) {
          await tester.pumpWidget(
            MPTestHelpers.createTestApp(
              child: MPEmptyState(
                variant: entry.key,
                size: MPEmptyStateSize.small,
              ),
            ),
          );

          expect(find.text(entry.value), findsOneWidget);

          // Clean up for next test
          await tester.pumpWidget(
            MPTestHelpers.createTestApp(
              child: const SizedBox(),
            ),
          );
        }
      });

      testWidgets('renders default description for each variant', (tester) async {
        final descriptionMap = {
          MPEmptyStateVariant.noData:
              'There is no data to display at this time.',
          MPEmptyStateVariant.noResults:
              'We couldn\'t find any results. Try different search terms.',
          MPEmptyStateVariant.noNetwork:
              'Please check your internet connection and try again.',
          MPEmptyStateVariant.error:
              'An error occurred. Please try again later.',
          MPEmptyStateVariant.custom: 'This section is currently empty.',
        };

        for (final entry in descriptionMap.entries) {
          await tester.pumpWidget(
            MPTestHelpers.createTestApp(
              child: MPEmptyState(
                variant: entry.key,
                size: MPEmptyStateSize.small,
              ),
            ),
          );

          expect(find.text(entry.value), findsOneWidget);

          // Clean up for next test
          await tester.pumpWidget(
            MPTestHelpers.createTestApp(
              child: const SizedBox(),
            ),
          );
        }
      });
    });

    group('Accessibility Tests', () {
      testWidgets('has semantic label', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.noData,
              semanticLabel: 'Empty data state',
            ),
          ),
        );

        expect(find.bySemanticsLabel('Empty data state'), findsOneWidget);
      });

      testWidgets('uses title as default semantic label', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const MPEmptyState(
              variant: MPEmptyStateVariant.noData,
            ),
          ),
        );

        expect(find.bySemanticsLabel('No data'), findsOneWidget);
      });
    });

    group('Integration Tests', () {
      testWidgets('works with custom styling container', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const MPEmptyState(
                variant: MPEmptyStateVariant.noData,
                size: MPEmptyStateSize.small,
              ),
            ),
          ),
        );

        expect(find.byType(MPEmptyState), findsOneWidget);
      });

      testWidgets('works in ListView', (tester) async {
        final items = <String>[];

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(items[index]));
              },
            ),
          ),
        );

        // Add empty state as child of ListView
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: ListView(
              children: const [
                MPEmptyState(
                  variant: MPEmptyStateVariant.noData,
                ),
              ],
            ),
          ),
        );

        expect(find.byType(MPEmptyState), findsOneWidget);
      });

      testWidgets('works with Center widget', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const Center(
              child: MPEmptyState(
                variant: MPEmptyStateVariant.noData,
              ),
            ),
          ),
        );

        expect(find.byType(MPEmptyState), findsOneWidget);
      });

      testWidgets('works with Padding widget', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: const Padding(
              padding: EdgeInsets.all(32),
              child: MPEmptyState(
                variant: MPEmptyStateVariant.noData,
              ),
            ),
          ),
        );

        expect(find.byType(MPEmptyState), findsOneWidget);
      });
    });
  });
}
