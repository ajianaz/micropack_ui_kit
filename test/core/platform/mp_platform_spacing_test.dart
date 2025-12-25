import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPPlatformSpacing', () {
    late MPPlatformSpacing spacing;

    setUp(() {
      spacing = MPPlatformSpacing.instance;
    });

    test('should return singleton instance', () {
      final instance1 = MPPlatformSpacing.instance;
      final instance2 = MPPlatformSpacing.instance;
      expect(instance1, same(instance2));
    });

    test('should return positive spacing scale', () {
      final scale = spacing.spacingScale;
      expect(scale, greaterThan(0));
      expect(scale, lessThanOrEqualTo(1.5));
    });

    test('should return positive sizing scale', () {
      final scale = spacing.sizingScale;
      expect(scale, greaterThan(0));
      expect(scale, lessThanOrEqualTo(1.5));
    });

    test('should return valid base spacing', () {
      final base = spacing.base;
      expect(base, greaterThan(0));
    });

    test('should return all spacing values in ascending order', () {
      expect(spacing.xs, lessThan(spacing.sm));
      expect(spacing.sm, lessThan(spacing.md));
      expect(spacing.md, lessThan(spacing.lg));
      expect(spacing.lg, lessThan(spacing.xl));
      expect(spacing.xl, lessThan(spacing.xxl));
      expect(spacing.xxl, lessThan(spacing.xxxl));
    });

    test('should return valid card padding', () {
      final padding = spacing.cardPadding;
      expect(padding, isA<EdgeInsets>());
    });

    test('should return valid card margin', () {
      final margin = spacing.cardMargin;
      expect(margin, isA<EdgeInsets>());
    });

    test('should return valid page padding', () {
      final padding = spacing.pagePadding;
      expect(padding, isA<EdgeInsets>());
    });

    test('should return valid section padding', () {
      final padding = spacing.sectionPadding;
      expect(padding, isA<EdgeInsets>());
    });

    test('should return positive gaps', () {
      expect(spacing.itemGap, greaterThan(0));
      expect(spacing.formFieldGap, greaterThan(0));
      expect(spacing.listItemGap, greaterThan(0));
    });

    test('should return valid icon sizes', () {
      expect(spacing.iconSizeSm, greaterThan(0));
      expect(spacing.iconSizeMd, greaterThan(spacing.iconSizeSm));
      expect(spacing.iconSizeLg, greaterThan(spacing.iconSizeMd));
    });

    test('should return valid button heights', () {
      expect(spacing.buttonHeightSm, greaterThan(0));
      expect(spacing.buttonHeightMd, greaterThan(spacing.buttonHeightSm));
      expect(spacing.buttonHeightLg, greaterThan(spacing.buttonHeightMd));
    });

    test('should return valid border radii', () {
      expect(spacing.borderRadiusSm, greaterThan(0));
      expect(spacing.borderRadiusMd, greaterThan(spacing.borderRadiusSm));
      expect(spacing.borderRadiusLg, greaterThan(spacing.borderRadiusMd));
    });

    test('should return valid avatar sizes', () {
      expect(spacing.avatarSizeSm, greaterThan(0));
      expect(spacing.avatarSizeMd, greaterThan(spacing.avatarSizeSm));
      expect(spacing.avatarSizeLg, greaterThan(spacing.avatarSizeMd));
    });

    test('should scale spacing values correctly', () {
      final value = 10.0;
      final scaled = spacing.scaleSpacing(value);
      expect(scaled, closeTo(value * spacing.spacingScale, 0.01));
    });

    test('should scale sizing values correctly', () {
      final value = 10.0;
      final scaled = spacing.scaleSizing(value);
      expect(scaled, closeTo(value * spacing.sizingScale, 0.01));
    });

    test('should return responsive value for mobile', () {
      final mobile = 10.0;
      final result = spacing.responsive(mobile);
      expect(result, mobile);
    });

    test('should get screen size from constraints', () {
      final constraints = BoxConstraints(maxWidth: 400);
      final size = MPPlatformSpacing.getScreenSize(constraints);
      expect(size, MPScreenSize.mobile);
    });

    test('should get screen size from constraints for tablet', () {
      final constraints = BoxConstraints(maxWidth: 800);
      final size = MPPlatformSpacing.getScreenSize(constraints);
      expect(size, MPScreenSize.tablet);
    });

    test('should get screen size from constraints for desktop', () {
      final constraints = BoxConstraints(maxWidth: 1100);
      final size = MPPlatformSpacing.getScreenSize(constraints);
      expect(size, MPScreenSize.desktop);
    });

    test('should get screen size from constraints for large desktop', () {
      final constraints = BoxConstraints(maxWidth: 1400);
      final size = MPPlatformSpacing.getScreenSize(constraints);
      expect(size, MPScreenSize.desktopLarge);
    });

    test('should return responsive padding for each screen size', () {
      for (final size in MPScreenSize.values) {
        final padding = MPPlatformSpacing.responsivePaddingForScreen(size);
        expect(padding, isA<EdgeInsets>());
      }
    });

    test('should return appropriate grid columns for width', () {
      expect(MPPlatformSpacing.gridColumnsForWidth(400), 1);
      expect(MPPlatformSpacing.gridColumnsForWidth(600), 2);
      expect(MPPlatformSpacing.gridColumnsForWidth(800), 3);
      expect(MPPlatformSpacing.gridColumnsForWidth(1100), 4);
      expect(MPPlatformSpacing.gridColumnsForWidth(1500), 5);
    });
  });

  group('MPPlatformSize', () {
    test('should have correct number of sizes', () {
      expect(MPPlatformSize.values.length, 3);
    });

    test('should contain expected sizes', () {
      expect(MPPlatformSize.values, contains(MPPlatformSize.mobile));
      expect(MPPlatformSize.values, contains(MPPlatformSize.desktop));
      expect(MPPlatformSize.values, contains(MPPlatformSize.web));
    });
  });

  group('MPScreenSize', () {
    test('should have correct number of sizes', () {
      expect(MPScreenSize.values.length, 5);
    });

    test('should contain expected sizes', () {
      expect(MPScreenSize.values, contains(MPScreenSize.mobile));
      expect(MPScreenSize.values, contains(MPScreenSize.mobileLarge));
      expect(MPScreenSize.values, contains(MPScreenSize.tablet));
      expect(MPScreenSize.values, contains(MPScreenSize.desktop));
      expect(MPScreenSize.values, contains(MPScreenSize.desktopLarge));
    });
  });

  group('MPPlatformSpacingContext extension', () {
    testWidgets('should provide platform spacing via context',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final baseSpacing = context.baseSpacing;
              final lgSpacing = context.spacingLg;
              final cardPadding = context.cardPadding;

              return Scaffold(
                body: Column(
                  children: [
                    Text('Base: $baseSpacing'),
                    Text('LG: $lgSpacing'),
                    Container(
                  padding: cardPadding,
                  child: const Text('Card'),
                ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('should determine screen size from context',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final screenSize = context.screenSize;
              final isMobile = context.isMobileScreen;
              final isDesktop = context.isDesktopScreen;
              final isTablet = context.isTabletScreen;

              return Scaffold(
                body: Column(
                  children: [
                    Text('Screen: $screenSize'),
                    Text('Mobile: $isMobile'),
                    Text('Desktop: $isDesktop'),
                    Text('Tablet: $isTablet'),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should provide responsive padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final padding = context.responsivePadding;

              return Scaffold(
                body: Container(
                  padding: padding,
                  child: const Text('Content'),
                ),
              );
            },
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });
  });
}
