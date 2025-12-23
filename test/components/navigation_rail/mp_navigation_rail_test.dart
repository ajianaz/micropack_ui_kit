import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('MPNavigationRail Widget Tests', () {
    group('Render Tests', () {
      testWidgets('renders with destinations', (tester) async {
        final rail = MPNavigationRail(
          selectedIndex: 0,
          onDestinationSelected: (_) {},
          destinations: [
            MPNavigationRailDestination(
              icon: Icons.home,
              label: 'Home',
            ),
            MPNavigationRailDestination(
              icon: Icons.settings,
              label: 'Settings',
            ),
          ],
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: rail),
        );

        expect(find.byIcon(Icons.home), findsOneWidget);
        expect(find.byIcon(Icons.settings), findsOneWidget);
      });

      testWidgets('renders with no labels', (tester) async {
        final rail = MPNavigationRail(
          selectedIndex: 0,
          labelType: MPNavigationRailLabelType.none,
          onDestinationSelected: (_) {},
          destinations: [
            MPNavigationRailDestination(
              icon: Icons.home,
              label: 'Home',
            ),
          ],
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: rail),
        );

        expect(find.byIcon(Icons.home), findsOneWidget);
        expect(find.text('Home'), findsNothing);
      });

      testWidgets('renders with all labels', (tester) async {
        final rail = MPNavigationRail(
          selectedIndex: 0,
          labelType: MPNavigationRailLabelType.all,
          onDestinationSelected: (_) {},
          destinations: [
            MPNavigationRailDestination(
              icon: Icons.home,
              label: 'Home',
            ),
          ],
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: rail),
        );

        expect(find.byIcon(Icons.home), findsOneWidget);
        expect(find.text('Home'), findsOneWidget);
      });

      testWidgets('renders with selected labels only', (tester) async {
        final rail = MPNavigationRail(
          selectedIndex: 0,
          labelType: MPNavigationRailLabelType.selected,
          onDestinationSelected: (_) {},
          destinations: [
            MPNavigationRailDestination(
              icon: Icons.home,
              label: 'Home',
            ),
            MPNavigationRailDestination(
              icon: Icons.settings,
              label: 'Settings',
            ),
          ],
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: rail),
        );

        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Settings'), findsNothing);
      });
    });

    group('Size Tests', () {
      testWidgets('renders compact size', (tester) async {
        final rail = MPNavigationRail(
          selectedIndex: 0,
          size: MPNavigationRailSize.compact,
          onDestinationSelected: (_) {},
          destinations: [
            MPNavigationRailDestination(
              icon: Icons.home,
              label: 'Home',
            ),
          ],
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: rail),
        );

        expect(find.byIcon(Icons.home), findsOneWidget);
        expect(find.text('Home'), findsNothing);
      });

      testWidgets('renders medium size', (tester) async {
        final rail = MPNavigationRail(
          selectedIndex: 0,
          size: MPNavigationRailSize.medium,
          onDestinationSelected: (_) {},
          destinations: [
            MPNavigationRailDestination(
              icon: Icons.home,
              label: 'Home',
            ),
          ],
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: rail),
        );

        expect(find.byIcon(Icons.home), findsOneWidget);
      });

      testWidgets('renders expanded size', (tester) async {
        final rail = MPNavigationRail(
          selectedIndex: 0,
          size: MPNavigationRailSize.expanded,
          onDestinationSelected: (_) {},
          destinations: [
            MPNavigationRailDestination(
              icon: Icons.home,
              label: 'Home',
            ),
          ],
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: rail),
        );

        expect(find.byIcon(Icons.home), findsOneWidget);
        expect(find.text('Home'), findsOneWidget);
      });
    });

    group('Selection Tests', () {
      testWidgets('calls onDestinationSelected', (tester) async {
        var selected = -1;

        final rail = MPNavigationRail(
          selectedIndex: 0,
          onDestinationSelected: (index) {
            selected = index;
          },
          destinations: [
            MPNavigationRailDestination(
              icon: Icons.home,
              label: 'Home',
            ),
            MPNavigationRailDestination(
              icon: Icons.settings,
              label: 'Settings',
            ),
          ],
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: rail),
        );

        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();

        expect(selected, equals(1));
      });

      testWidgets('updates selected index', (tester) async {
        final rail = MPNavigationRail(
          selectedIndex: 0,
          onDestinationSelected: (_) {},
          destinations: [
            MPNavigationRailDestination(
              icon: Icons.home,
              label: 'Home',
            ),
            MPNavigationRailDestination(
              icon: Icons.settings,
              label: 'Settings',
            ),
          ],
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: rail),
        );

        expect(find.text('Home'), findsOneWidget);

        // Update selected index
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPNavigationRail(
              selectedIndex: 1,
              onDestinationSelected: (_) {},
              destinations: [
                MPNavigationRailDestination(
                  icon: Icons.home,
                  label: 'Home',
                ),
                MPNavigationRailDestination(
                  icon: Icons.settings,
                  label: 'Settings',
                ),
              ],
            ),
          ),
        );

        expect(find.text('Home'), findsNothing);
        expect(find.text('Settings'), findsOneWidget);
      });
    });

    group('Badge Tests', () {
      testWidgets('renders badge on destination', (tester) async {
        final rail = MPNavigationRail(
          selectedIndex: 0,
          onDestinationSelected: (_) {},
          destinations: [
            MPNavigationRailDestination(
              icon: Icons.notifications,
              label: 'Notifications',
              badge: MPBadge(label: '3'),
            ),
          ],
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: rail),
        );

        expect(find.byType(MPBadge), findsOneWidget);
        expect(find.text('3'), findsOneWidget);
      });
    });

    group('Placement Tests', () {
      testWidgets('renders in leading position', (tester) async {
        final rail = MPNavigationRail(
          selectedIndex: 0,
          placement: MPNavigationRailPlacement.leading,
          onDestinationSelected: (_) {},
          destinations: [
            MPNavigationRailDestination(
              icon: Icons.home,
              label: 'Home',
            ),
          ],
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: rail),
        );

        expect(find.byType(MPNavigationRail), findsOneWidget);
      });

      testWidgets('renders in trailing position', (tester) async {
        final rail = MPNavigationRail(
          selectedIndex: 0,
          placement: MPNavigationRailPlacement.trailing,
          onDestinationSelected: (_) {},
          destinations: [
            MPNavigationRailDestination(
              icon: Icons.home,
              label: 'Home',
            ),
          ],
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(child: rail),
        );

        expect(find.byType(MPNavigationRail), findsOneWidget);
      });
    });

    group('Accessibility Tests', () {
      testWidgets('has semantic label', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPNavigationRail(
              selectedIndex: 0,
              semanticLabel: 'Navigation rail',
              onDestinationSelected: (_) {},
              destinations: [
                MPNavigationRailDestination(
                  icon: Icons.home,
                  label: 'Home',
                ),
              ],
            ),
          ),
        );

        expect(find.bySemanticsLabel('Navigation rail'), findsOneWidget);
      });
    });

    group('Integration Tests', () {
      testWidgets('works with Scaffold and body', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: Scaffold(
              body: Row(
                children: [
                  MPNavigationRail(
                    selectedIndex: 0,
                    onDestinationSelected: (_) {},
                    destinations: [
                      MPNavigationRailDestination(
                        icon: Icons.home,
                        label: 'Home',
                      ),
                      MPNavigationRailDestination(
                        icon: Icons.search,
                        label: 'Search',
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Text('Content'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(MPNavigationRail), findsOneWidget);
      });
    });
  });
}
