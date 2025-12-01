import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/mp_component_init_test.dart';

void main() {
  group('MPTabRounded Tests', () {
    // Basic rendering tests
    testWidgets('renders tab with title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Test Tab',
            ),
          ),
        ),
      );

      expect(find.text('Test Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    testWidgets('renders tab with icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Icon Tab',
              icon: Icons.home,
            ),
          ),
        ),
      );

      expect(find.text('Icon Tab'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    testWidgets('renders tab with badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Badge Tab',
              badge: '3',
            ),
          ),
        ),
      );

      expect(find.text('Badge Tab'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    // Variant tests
    testWidgets('renders standard variant tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Standard Tab',
              variant: MPTabRoundedVariant.standard,
            ),
          ),
        ),
      );

      expect(find.text('Standard Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    testWidgets('renders outlined variant tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Outlined Tab',
              variant: MPTabRoundedVariant.outlined,
            ),
          ),
        ),
      );

      expect(find.text('Outlined Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    testWidgets('renders filled variant tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Filled Tab',
              variant: MPTabRoundedVariant.filled,
            ),
          ),
        ),
      );

      expect(find.text('Filled Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    // Size tests
    testWidgets('renders small size tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Small Tab',
              size: MPTabRoundedSize.small,
            ),
          ),
        ),
      );

      expect(find.text('Small Tab'), findsOneWidget);
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(MPTabRounded),
          matching: find.byType(Container),
        ),
      );
      expect(container.constraints?.maxHeight, 40);
    });

    testWidgets('renders medium size tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Medium Tab',
              size: MPTabRoundedSize.medium,
            ),
          ),
        ),
      );

      expect(find.text('Medium Tab'), findsOneWidget);
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(MPTabRounded),
          matching: find.byType(Container),
        ),
      );
      expect(container.constraints?.maxHeight, 50);
    });

    testWidgets('renders large size tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Large Tab',
              size: MPTabRoundedSize.large,
            ),
          ),
        ),
      );

      expect(find.text('Large Tab'), findsOneWidget);
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(MPTabRounded),
          matching: find.byType(Container),
        ),
      );
      expect(container.constraints?.maxHeight, 60);
    });

    // State tests
    testWidgets('renders active tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Active Tab',
              isActiveTab: true,
            ),
          ),
        ),
      );

      expect(find.text('Active Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    testWidgets('renders disabled tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Disabled Tab',
              isDisabled: true,
            ),
          ),
        ),
      );

      expect(find.text('Disabled Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    // Location tests
    testWidgets('renders left positioned tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Left Tab',
              tabLocation: 'left',
            ),
          ),
        ),
      );

      expect(find.text('Left Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    testWidgets('renders center positioned tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Center Tab',
              tabLocation: 'center',
            ),
          ),
        ),
      );

      expect(find.text('Center Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    testWidgets('renders right positioned tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Right Tab',
              tabLocation: 'right',
            ),
          ),
        ),
      );

      expect(find.text('Right Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    // Custom styling tests
    testWidgets('renders with custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Custom Tab',
              tabColor: Colors.blue,
              tabColorActive: Colors.red,
              textColor: Colors.green,
              textColorActive: Colors.yellow,
            ),
          ),
        ),
      );

      expect(find.text('Custom Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    testWidgets('renders with custom height', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Height Tab',
              height: 70,
            ),
          ),
        ),
      );

      expect(find.text('Height Tab'), findsOneWidget);
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(MPTabRounded),
          matching: find.byType(Container),
        ),
      );
      expect(container.constraints?.maxHeight, 70);
    });

    testWidgets('renders with custom padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Padding Tab',
              padding: const EdgeInsets.all(20),
            ),
          ),
        ),
      );

      expect(find.text('Padding Tab'), findsOneWidget);
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(MPTabRounded),
          matching: find.byType(Container),
        ),
      );
      expect(container.padding, const EdgeInsets.all(20));
    });

    testWidgets('renders with custom border radius',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Radius Tab',
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      );

      expect(find.text('Radius Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    testWidgets('renders with custom icon size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Icon Size Tab',
              icon: Icons.settings,
              iconSize: 24,
            ),
          ),
        ),
      );

      expect(find.text('Icon Size Tab'), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
      final icon = tester.widget<Icon>(find.byIcon(Icons.settings));
      expect(icon.size, 24);
    });

    testWidgets('renders with custom badge colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Badge Color Tab',
              badge: '5',
              badgeColor: Colors.purple,
              badgeTextColor: Colors.white,
            ),
          ),
        ),
      );

      expect(find.text('Badge Color Tab'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    // Indicator tests
    testWidgets('shows indicator when active and enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Indicator Tab',
              isActiveTab: true,
              showIndicator: true,
            ),
          ),
        ),
      );

      expect(find.text('Indicator Tab'), findsOneWidget);
      expect(find.byType(Positioned), findsOneWidget);
    });

    testWidgets('hides indicator when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'No Indicator Tab',
              isActiveTab: true,
              showIndicator: false,
            ),
          ),
        ),
      );

      expect(find.text('No Indicator Tab'), findsOneWidget);
      expect(find.byType(Positioned), findsNothing);
    });

    testWidgets('renders with custom indicator properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Custom Indicator Tab',
              isActiveTab: true,
              indicatorColor: Colors.orange,
              indicatorHeight: 5,
              indicatorWidth: 50,
            ),
          ),
        ),
      );

      expect(find.text('Custom Indicator Tab'), findsOneWidget);
      expect(find.byType(Positioned), findsOneWidget);
    });

    // Interaction tests
    testWidgets('triggers onTab callback when tapped',
        (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Tap Tab',
              onTab: () => wasTapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Tab'));
      await tester.pump();

      expect(wasTapped, true);
    });

    testWidgets('triggers onLongPress callback when long pressed',
        (WidgetTester tester) async {
      bool wasLongPressed = false;

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Long Press Tab',
              onLongPress: () => wasLongPressed = true,
            ),
          ),
        ),
      );

      await tester.longPress(find.text('Long Press Tab'));
      await tester.pump();

      expect(wasLongPressed, true);
    });

    testWidgets('does not trigger callback when disabled',
        (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Disabled Tab',
              isDisabled: true,
              onTab: () => wasTapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled Tab'));
      await tester.pump();

      expect(wasTapped, false);
    });

    // Animation tests
    testWidgets('animates when isActiveTab changes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Animated Tab',
              key: const Key('animated-tab'),
              isActiveTab: false,
            ),
          ),
        ),
      );

      expect(find.text('Animated Tab'), findsOneWidget);

      // Update to active
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Animated Tab',
              key: const Key('animated-tab'),
              isActiveTab: true,
            ),
          ),
        ),
      );

      await tester.pump(); // Start animation
      await tester.pump(const Duration(milliseconds: 100)); // Mid animation
      await tester.pump(const Duration(milliseconds: 200)); // End animation

      expect(find.text('Animated Tab'), findsOneWidget);
    });

    testWidgets('renders with custom animation duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Custom Animation Tab',
              animationDuration: const Duration(milliseconds: 500),
            ),
          ),
        ),
      );

      expect(find.text('Custom Animation Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    // Hover tests
    testWidgets('responds to hover state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Hover Tab',
            ),
          ),
        ),
      );

      expect(find.text('Hover Tab'), findsOneWidget);

      // Test hover by entering and exiting using MouseRegion
      final TestGesture gesture = await tester.startGesture(
        tester.getCenter(find.text('Hover Tab')),
      );
      await gesture.moveTo(tester.getCenter(find.text('Hover Tab')));
      await tester.pump();

      await gesture.up();
      await tester.pump();

      expect(find.text('Hover Tab'), findsOneWidget);
    });

    // Theme adaptation tests
    testWidgets('adapts to light theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: MaterialApp(
            theme: MPTheme.main().copyWith(
              extensions: <ThemeExtension<dynamic>>[
                MPColorTheme.light,
              ],
            ),
            home: Scaffold(
              body: MPTabRounded(
                title: 'Light Theme Tab',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Light Theme Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    testWidgets('adapts to dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: MaterialApp(
            theme: MPTheme.main().copyWith(
              extensions: <ThemeExtension<dynamic>>[
                MPColorTheme.dark,
              ],
            ),
            home: Scaffold(
              body: MPTabRounded(
                title: 'Dark Theme Tab',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Dark Theme Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    // Complex content tests
    testWidgets('renders tab with icon, text, and badge',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Complex Tab',
              icon: Icons.notifications,
              badge: '12',
            ),
          ),
        ),
      );

      expect(find.text('Complex Tab'), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    // Flex tests
    testWidgets('respects flex property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: MPTabRounded(
                    title: 'Flex Tab 1',
                    flex: 2,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: MPTabRounded(
                    title: 'Flex Tab 2',
                    flex: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Flex Tab 1'), findsOneWidget);
      expect(find.text('Flex Tab 2'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsNWidgets(2));
    });

    // Accessibility tests
    testWidgets('has semantic properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPTabRounded(
              title: 'Accessible Tab',
              semanticLabel: 'Custom semantic label',
            ),
          ),
        ),
      );

      expect(find.text('Accessible Tab'), findsOneWidget);
      expect(find.byType(MPTabRounded), findsOneWidget);
    });

    // Performance tests
    testWidgets('renders efficiently with multiple tabs',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: Column(
              children: List.generate(
                10,
                (index) => MPTabRounded(
                  title: 'Tab $index',
                  icon: Icons.tab,
                  badge: index.toString(),
                ),
              ),
            ),
          ),
        ),
      );

      for (int i = 0; i < 10; i++) {
        expect(find.text('Tab $i'), findsOneWidget);
        expect(find.text(i.toString()), findsOneWidget);
      }
      expect(find.byType(MPTabRounded), findsNWidgets(10));
    });
  });
}
