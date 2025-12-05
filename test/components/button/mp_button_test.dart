import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/test_helper.dart';

void main() {
  group('MPButton Tests', () {
    // Initialize MPErrorHandler before all tests
    setUpAll(() async {
      await MPTestHelper.initialize();
    });

    testWidgets('renders with basic text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Test Button',
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders with custom child widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Should not show',
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      );

      expect(find.text('Should not show'), findsNothing);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders primary variant correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Primary',
            variant: MPButtonVariant.primary,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders outlined variant correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Outlined',
            variant: MPButtonVariant.outlined,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Outlined'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders ghost variant correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Ghost',
            variant: MPButtonVariant.ghost,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Ghost'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders text variant correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Text Button',
            variant: MPButtonVariant.text,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Text Button'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders danger variant correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Danger',
            variant: MPButtonVariant.danger,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Danger'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders success variant correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Success',
            variant: MPButtonVariant.success,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Success'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders warning variant correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Warning',
            variant: MPButtonVariant.warning,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Warning'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders info variant correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Info',
            variant: MPButtonVariant.info,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Info'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    // Size tests
    testWidgets('renders small size correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Small',
            size: MPButtonSize.small,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Small'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders regular size correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Regular',
            size: MPButtonSize.regular,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Regular'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders medium size correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Medium',
            size: MPButtonSize.medium,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Medium'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders large size correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Large',
            size: MPButtonSize.large,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Large'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    // State tests
    testWidgets('renders enabled state correctly', (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Enabled',
            enabled: true,
            onPressed: () => wasPressed = true,
          ),
        ),
      );

      expect(find.text('Enabled'), findsOneWidget);
      await tester.tap(find.text('Enabled'));
      expect(wasPressed, isTrue);
    });

    testWidgets('renders disabled state correctly',
        (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Disabled',
            enabled: false,
            onPressed: () => wasPressed = true,
          ),
        ),
      );

      expect(find.text('Disabled'), findsOneWidget);
      await tester.tap(find.text('Disabled'));
      expect(wasPressed, isFalse);
    });

    testWidgets('renders loading state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Loading',
            loading: true,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Loading'), findsNothing);
      expect(find.byType(SpinKitThreeBounce), findsOneWidget);
    });

    testWidgets('renders loading with custom widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Loading',
            loading: true,
            loadingWidget: const CircularProgressIndicator(),
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Loading'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(SpinKitThreeBounce), findsNothing);
    });

    // Icon tests
    testWidgets('renders icon on left', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Icon Left',
            icon: Icons.add,
            iconPosition: MPButtonIconPosition.left,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Icon Left'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('renders icon on right', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Icon Right',
            icon: Icons.add,
            iconPosition: MPButtonIconPosition.right,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Icon Right'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('renders icon on top', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Icon Top',
            icon: Icons.add,
            iconPosition: MPButtonIconPosition.top,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Icon Top'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('renders icon on bottom', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Icon Bottom',
            icon: Icons.add,
            iconPosition: MPButtonIconPosition.bottom,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Icon Bottom'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    // Interaction tests
    testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Press Me',
            onPressed: () => wasPressed = true,
          ),
        ),
      );

      await tester.tap(find.text('Press Me'));
      expect(wasPressed, isTrue);
    });

    testWidgets('calls onLongPress when long pressed',
        (WidgetTester tester) async {
      bool wasLongPressed = false;

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Long Press Me',
            onLongPress: () => wasLongPressed = true,
            onPressed: () {},
          ),
        ),
      );

      await tester.longPress(find.text('Long Press Me'));
      expect(wasLongPressed, isTrue);
    });

    testWidgets('does not call onPressed when disabled',
        (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Disabled',
            enabled: false,
            onPressed: () => wasPressed = true,
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      expect(wasPressed, isFalse);
    });

    testWidgets('does not call onPressed when loading',
        (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Loading',
            loading: true,
            onPressed: () => wasPressed = true,
          ),
        ),
      );

      await tester.tap(find.byType(MPButton));
      expect(wasPressed, isFalse);
    });

    // Custom styling tests
    testWidgets('applies custom background color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Custom Color',
            background: Colors.purple,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Custom Color'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('applies custom text color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Custom Text Color',
            textColor: Colors.orange,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Custom Text Color'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('applies custom padding', (WidgetTester tester) async {
      const customPadding = EdgeInsets.all(20);

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Custom Padding',
            padding: customPadding,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Custom Padding'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('applies custom border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Custom Radius',
            radius: 20,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Custom Radius'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders with full width', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Full Width',
            widthInfinity: true,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Full Width'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    // Accessibility tests
    testWidgets('has semantic label when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Button',
            semanticLabel: 'Custom semantic label',
            onPressed: () {},
          ),
        ),
      );

      expect(find.bySemanticsLabel('Custom semantic label'), findsOneWidget);
    });

    // Focus tests
    testWidgets('handles focus node correctly', (WidgetTester tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: 'Focus Button',
            focusNode: focusNode,
            onPressed: () {},
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);

      focusNode.dispose();
    });

    // Error handling tests
    testWidgets('handles null text gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: null,
            onPressed: () {},
          ),
        ),
      );

      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('handles empty text gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPTestHelper.createTestWidgetWithInit(
          child: MPButton(
            text: '',
            onPressed: () {},
          ),
        ),
      );

      expect(find.byType(MPButton), findsOneWidget);
    });
  });
}
