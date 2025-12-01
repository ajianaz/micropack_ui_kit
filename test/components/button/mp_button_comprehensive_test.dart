import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/mp_component_init_test.dart';

void main() {
  group('MPButton Comprehensive Tests', () {
    // Basic rendering tests
    testWidgets('renders with basic text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Test Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('renders with custom child widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Should not show',
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );

      expect(find.text('Should not show'), findsNothing);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byType(MPButton), findsOneWidget);
    });

    // Variant tests
    testWidgets('renders primary variant correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Primary',
              variant: MPButtonVariant.primary,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.style?.backgroundColor?.resolve({}), isNotNull);
    });

    testWidgets('renders outlined variant correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Outlined',
              variant: MPButtonVariant.outlined,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Outlined'), findsOneWidget);
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.style?.backgroundColor?.resolve({}), Colors.transparent);
    });

    testWidgets('renders ghost variant correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Ghost',
              variant: MPButtonVariant.ghost,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Ghost'), findsOneWidget);
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.style?.backgroundColor?.resolve({}), Colors.transparent);
    });

    testWidgets('renders text variant correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Text Button',
              variant: MPButtonVariant.text,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Text Button'), findsOneWidget);
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.style?.backgroundColor?.resolve({}), Colors.transparent);
    });

    testWidgets('renders danger variant correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Danger',
              variant: MPButtonVariant.danger,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Danger'), findsOneWidget);
    });

    testWidgets('renders success variant correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Success',
              variant: MPButtonVariant.success,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Success'), findsOneWidget);
    });

    testWidgets('renders warning variant correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Warning',
              variant: MPButtonVariant.warning,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Warning'), findsOneWidget);
    });

    testWidgets('renders info variant correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Info',
              variant: MPButtonVariant.info,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Info'), findsOneWidget);
    });

    // Size tests
    testWidgets('renders small size correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Small',
              size: MPButtonSize.small,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Small'), findsOneWidget);
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final padding = button.style?.padding?.resolve({});
      expect(padding, isNotNull);
    });

    testWidgets('renders regular size correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Regular',
              size: MPButtonSize.regular,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Regular'), findsOneWidget);
    });

    testWidgets('renders medium size correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Medium',
              size: MPButtonSize.medium,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Medium'), findsOneWidget);
    });

    testWidgets('renders large size correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Large',
              size: MPButtonSize.large,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Large'), findsOneWidget);
    });

    // State tests
    testWidgets('renders enabled state correctly', (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Enabled',
              enabled: true,
              onPressed: () => wasPressed = true,
            ),
          ),
        ),
      );

      expect(find.text('Enabled'), findsOneWidget);
      await tester.tap(find.byType(MPButton));
      expect(wasPressed, isTrue);
    });

    testWidgets('renders disabled state correctly',
        (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Disabled',
              enabled: false,
              onPressed: () => wasPressed = true,
            ),
          ),
        ),
      );

      expect(find.text('Disabled'), findsOneWidget);
      await tester.tap(find.byType(MPButton));
      expect(wasPressed, isFalse);
    });

    testWidgets('renders loading state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Loading',
              loading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Loading'), findsNothing);
      expect(find.byType(SpinKitThreeBounce), findsOneWidget);
    });

    testWidgets('renders loading with custom widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Loading',
              loading: true,
              loadingWidget: const CircularProgressIndicator(),
              onPressed: () {},
            ),
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
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Icon Left',
              icon: Icons.add,
              iconPosition: MPButtonIconPosition.left,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Icon Left'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('renders icon on right', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Icon Right',
              icon: Icons.add,
              iconPosition: MPButtonIconPosition.right,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Icon Right'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('renders icon on top', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Icon Top',
              icon: Icons.add,
              iconPosition: MPButtonIconPosition.top,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Icon Top'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('renders icon on bottom', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Icon Bottom',
              icon: Icons.add,
              iconPosition: MPButtonIconPosition.bottom,
              onPressed: () {},
            ),
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
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Press Me',
              onPressed: () => wasPressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MPButton));
      expect(wasPressed, isTrue);
    });

    testWidgets('calls onLongPress when long pressed',
        (WidgetTester tester) async {
      bool wasLongPressed = false;

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Long Press Me',
              onLongPress: () => wasLongPressed = true,
              onPressed: () {},
            ),
          ),
        ),
      );

      await tester.longPress(find.byType(MPButton));
      expect(wasLongPressed, isTrue);
    });

    testWidgets('does not call onPressed when disabled',
        (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Disabled',
              enabled: false,
              onPressed: () => wasPressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MPButton));
      expect(wasPressed, isFalse);
    });

    testWidgets('does not call onPressed when loading',
        (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Loading',
              loading: true,
              onPressed: () => wasPressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MPButton));
      expect(wasPressed, isFalse);
    });

    // Custom styling tests
    testWidgets('applies custom background color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Custom Color',
              background: Colors.purple,
              onPressed: () {},
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.style?.backgroundColor?.resolve({}), Colors.purple);
    });

    testWidgets('applies custom text color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Custom Text Color',
              textColor: Colors.orange,
              onPressed: () {},
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Custom Text Color'));
      expect(textWidget.style?.color, Colors.orange);
    });

    testWidgets('applies custom padding', (WidgetTester tester) async {
      const customPadding = EdgeInsets.all(20);

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Custom Padding',
              padding: customPadding,
              onPressed: () {},
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.style?.padding?.resolve({}), customPadding);
    });

    testWidgets('applies custom border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Custom Radius',
              radius: 20,
              onPressed: () {},
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final shape = button.style?.shape?.resolve({});
      expect(shape, isA<RoundedRectangleBorder>());
    });

    testWidgets('renders with full width', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Full Width',
              widthInfinity: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Full Width'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    // Accessibility tests
    testWidgets('has semantic label when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Button',
              semanticLabel: 'Custom semantic label',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel('Custom semantic label'), findsOneWidget);
    });

    // Focus tests
    testWidgets('handles focus node correctly', (WidgetTester tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: 'Focus Button',
              focusNode: focusNode,
              onPressed: () {},
            ),
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);

      focusNode.dispose();
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
              body: MPButton(
                text: 'Light Theme',
                variant: MPButtonVariant.primary,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('Light Theme'), findsOneWidget);
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
              body: MPButton(
                text: 'Dark Theme',
                variant: MPButtonVariant.primary,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('Dark Theme'), findsOneWidget);
    });

    // Error handling tests
    testWidgets('handles null text gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: null,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(MPButton), findsOneWidget);
    });

    testWidgets('handles empty text gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MPComponentInitTest(
          child: Scaffold(
            body: MPButton(
              text: '',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(MPButton), findsOneWidget);
    });
  });
}
