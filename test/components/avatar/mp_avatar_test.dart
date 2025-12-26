import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('MPAvatar Widget Tests', () {

    group('Render Tests', () {
      testWidgets('renders with initials type', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              name: 'John Doe',
              type: MPAvatarType.initials,
            ),
          ),
        );

        expect(find.text('JD'), findsOneWidget);
      });

      testWidgets('renders with single name', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              name: 'John',
              type: MPAvatarType.initials,
            ),
          ),
        );

        expect(find.text('J'), findsOneWidget);
      });

      testWidgets('renders with icon type', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              icon: Icons.person,
              type: MPAvatarType.icon,
            ),
          ),
        );

        expect(find.byIcon(Icons.person), findsOneWidget);
      });

      testWidgets('renders with placeholder type', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              type: MPAvatarType.placeholder,
            ),
          ),
        );

        expect(find.byIcon(Icons.person_outline), findsOneWidget);
      });

      testWidgets('renders with image type', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              imageUrl: 'https://example.com/avatar.jpg',
              type: MPAvatarType.image,
            ),
          ),
        );

        expect(find.byType(Image), findsOneWidget);
      });

      testWidgets('renders with custom image provider', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              imageProvider: const AssetImage('assets/test.png'),
              type: MPAvatarType.image,
            ),
          ),
        );

        expect(find.byType(Image), findsOneWidget);
      });

      testWidgets('falls back to initials on image error', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              imageUrl: 'invalid-url',
              type: MPAvatarType.image,
              name: 'Error User',
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('EU'), findsOneWidget);
      });

      testWidgets('renders with badge', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              name: 'John Doe',
              type: MPAvatarType.initials,
              badge: MPBadge(label: '3'),
            ),
          ),
        );

        expect(find.byType(MPBadge), findsOneWidget);
        expect(find.text('3'), findsOneWidget);
      });
    });

    group('Size Tests', () {
      testWidgets('renders XS size correctly', (tester) async {
        final avatar = MPAvatar(
          name: 'Test',
          type: MPAvatarType.initials,
          size: MPAvatarSize.xs,
        );

        await tester.pumpWidget(MPTestHelpers.createTestApp(child: avatar));
        final size = tester.getSize(find.byType(MPAvatar));

        expect(size.width, equals(24.0));
        expect(size.height, equals(24.0));
      });

      testWidgets('renders small size correctly', (tester) async {
        final avatar = MPAvatar(
          name: 'Test',
          type: MPAvatarType.initials,
          size: MPAvatarSize.small,
        );

        await tester.pumpWidget(MPTestHelpers.createTestApp(child: avatar));
        final size = tester.getSize(find.byType(MPAvatar));

        expect(size.width, equals(32.0));
        expect(size.height, equals(32.0));
      });

      testWidgets('renders medium size correctly', (tester) async {
        final avatar = MPAvatar(
          name: 'Test',
          type: MPAvatarType.initials,
          size: MPAvatarSize.medium,
        );

        await tester.pumpWidget(MPTestHelpers.createTestApp(child: avatar));
        final size = tester.getSize(find.byType(MPAvatar));

        expect(size.width, equals(40.0));
        expect(size.height, equals(40.0));
      });

      testWidgets('renders large size correctly', (tester) async {
        final avatar = MPAvatar(
          name: 'Test',
          type: MPAvatarType.initials,
          size: MPAvatarSize.large,
        );

        await tester.pumpWidget(MPTestHelpers.createTestApp(child: avatar));
        final size = tester.getSize(find.byType(MPAvatar));

        expect(size.width, equals(56.0));
        expect(size.height, equals(56.0));
      });

      testWidgets('renders XL size correctly', (tester) async {
        final avatar = MPAvatar(
          name: 'Test',
          type: MPAvatarType.initials,
          size: MPAvatarSize.xl,
        );

        await tester.pumpWidget(MPTestHelpers.createTestApp(child: avatar));
        final size = tester.getSize(find.byType(MPAvatar));

        expect(size.width, equals(72.0));
        expect(size.height, equals(72.0));
      });

      testWidgets('renders XXL size correctly', (tester) async {
        final avatar = MPAvatar(
          name: 'Test',
          type: MPAvatarType.initials,
          size: MPAvatarSize.xxl,
        );

        await tester.pumpWidget(MPTestHelpers.createTestApp(child: avatar));
        final size = tester.getSize(find.byType(MPAvatar));

        expect(size.width, equals(96.0));
        expect(size.height, equals(96.0));
      });
    });

    group('Shape Tests', () {
      testWidgets('renders circle shape', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              name: 'Test',
              type: MPAvatarType.initials,
              shape: MPAvatarShape.circle,
            ),
          ),
        );

        final containerFinder = find.descendant(
          of: find.byType(MPAvatar),
          matching: find.byType(Container),
        );
        final containers = tester.widgetList<Container>(containerFinder);

        expect(containers.isNotEmpty, isTrue);
        final decoration = containers.first.decoration as BoxDecoration;
        expect(decoration.shape, equals(BoxShape.circle));
      });

      testWidgets('renders rounded square shape', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              name: 'Test',
              type: MPAvatarType.initials,
              shape: MPAvatarShape.roundedSquare,
            ),
          ),
        );

        final containerFinder = find.descendant(
          of: find.byType(MPAvatar),
          matching: find.byType(Container),
        );
        final containers = tester.widgetList<Container>(containerFinder);

        expect(containers.isNotEmpty, isTrue);
        final decoration = containers.first.decoration as BoxDecoration;
        expect(decoration.shape, equals(BoxShape.rectangle));
        expect(decoration.borderRadius, isNotNull);
      });

      testWidgets('applies custom border radius', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              name: 'Test',
              type: MPAvatarType.initials,
              shape: MPAvatarShape.roundedSquare,
              borderRadius: 20.0,
            ),
          ),
        );

        final containerFinder = find.descendant(
          of: find.byType(MPAvatar),
          matching: find.byType(Container),
        );
        final containers = tester.widgetList<Container>(containerFinder);

        expect(containers.isNotEmpty, isTrue);
        final decoration = containers.first.decoration as BoxDecoration;
        final borderRadius = decoration.borderRadius as BorderRadius;
        expect(borderRadius.topLeft.x, equals(20.0));
      });
    });

    group('Color Tests', () {
      testWidgets('applies custom background color', (tester) async {
        const customColor = Colors.purple;

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              name: 'Test',
              type: MPAvatarType.initials,
              backgroundColor: customColor,
            ),
          ),
        );

        final containerFinder = find.descendant(
          of: find.byType(MPAvatar),
          matching: find.byType(Container),
        );
        final containers = tester.widgetList<Container>(containerFinder);

        expect(containers.isNotEmpty, isTrue);
        expect(containers.first.color, equals(customColor));
      });

      testWidgets('applies custom text color', (tester) async {
        const customColor = Colors.white;

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              name: 'Test',
              type: MPAvatarType.initials,
              textColor: customColor,
            ),
          ),
        );

        final textFinder = find.descendant(
          of: find.byType(MPAvatar),
          matching: find.byType(MPText),
        );
        final texts = tester.widgetList<MPText>(textFinder);

        expect(texts.isNotEmpty, isTrue);
        expect(texts.first.style?.color, equals(customColor));
      });

      testWidgets('generates consistent color for same name', (tester) async {
        final avatar1 = MPAvatar(
          name: 'John Doe',
          type: MPAvatarType.initials,
        );

        final avatar2 = MPAvatar(
          name: 'John Doe',
          type: MPAvatarType.initials,
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: Column(
              children: [avatar1, avatar2],
            ),
          ),
        );

        final containerFinder = find.descendant(
          of: find.byType(MPAvatar),
          matching: find.byType(Container),
        );
        final containers = tester.widgetList<Container>(containerFinder);

        expect(containers.length, greaterThanOrEqualTo(2));
        expect(containers.elementAt(0).color, equals(containers.elementAt(1).color));
      });

      testWidgets('generates different colors for different names', (tester) async {
        final avatar1 = MPAvatar(
          name: 'John Doe',
          type: MPAvatarType.initials,
        );

        final avatar2 = MPAvatar(
          name: 'Jane Smith',
          type: MPAvatarType.initials,
        );

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: Column(
              children: [avatar1, avatar2],
            ),
          ),
        );

        final containerFinder = find.descendant(
          of: find.byType(MPAvatar),
          matching: find.byType(Container),
        );
        final containers = tester.widgetList<Container>(containerFinder);

        expect(containers.length, greaterThanOrEqualTo(2));
        expect(containers.elementAt(0).color, isNot(equals(containers.elementAt(1).color)));
      });
    });

    group('Accessibility Tests', () {
      testWidgets('has semantic label', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              name: 'John Doe',
              semanticLabel: 'User avatar',
            ),
          ),
        );

        expect(find.bySemanticsLabel('User avatar'), findsOneWidget);
      });

      testWidgets('uses name as default semantic label', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              name: 'John Doe',
            ),
          ),
        );

        expect(find.bySemanticsLabel('John Doe'), findsOneWidget);
      });
    });

    group('Integration Tests', () {
      testWidgets('works in list context', (tester) async {
        final users = ['John Doe', 'Jane Smith', 'Bob Johnson'];

        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: MPAvatar(
                    name: users[index],
                    type: MPAvatarType.initials,
                    size: MPAvatarSize.small,
                  ),
                  title: Text(users[index]),
                );
              },
            ),
          ),
        );

        expect(find.byType(MPAvatar), findsNWidgets(3));
      });

      testWidgets('badge positioned correctly', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: MPAvatar(
              name: 'Test',
              type: MPAvatarType.initials,
              badge: MPBadge(label: 'New'),
            ),
          ),
        );

        final stack = tester.widget<Stack>(find.byType(Stack));
        expect(stack.children.length, equals(2));
      });
    });
  });
}
