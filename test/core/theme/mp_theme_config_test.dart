import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_config.dart';

void main() {
  group('MPThemeConfig Tests', () {
    group('Primary Colors', () {
      test('should return consistent primary colors for both modes', () {
        final lightPrimary = MPThemeConfig.getPrimary(isDarkMode: false);
        final darkPrimary = MPThemeConfig.getPrimary(isDarkMode: true);

        expect(lightPrimary, equals(darkPrimary));
        expect(lightPrimary, equals(const Color(0xFF6366F1)));
      });

      test('should return correct primary variants', () {
        final hover = MPThemeConfig.getPrimaryHover();
        final pressed = MPThemeConfig.getPrimaryPressed();
        final focus = MPThemeConfig.getPrimaryFocus();
        final border = MPThemeConfig.getPrimaryBorder();
        final surface = MPThemeConfig.getPrimarySurface();

        expect(hover, equals(const Color(0xFF4F46E5)));
        expect(pressed, equals(const Color(0xFF4338CA)));
        expect(focus, equals(const Color(0xFF818CF8)));
        expect(border, equals(const Color(0xFFA5B4FC)));
        expect(surface, equals(const Color(0xFFEEF2FF)));
      });
    });

    group('Neutral Colors', () {
      test('should return correct neutral colors for valid shades', () {
        expect(MPThemeConfig.getNeutral(10), equals(const Color(0xFFFFFFFF)));
        expect(MPThemeConfig.getNeutral(20), equals(const Color(0xFFF9FAFB)));
        expect(MPThemeConfig.getNeutral(30), equals(const Color(0xFFF3F4F6)));
        expect(MPThemeConfig.getNeutral(40), equals(const Color(0xFFE5E7EB)));
        expect(MPThemeConfig.getNeutral(50), equals(const Color(0xFFD1D5DB)));
        expect(MPThemeConfig.getNeutral(60), equals(const Color(0xFF9CA3AF)));
        expect(MPThemeConfig.getNeutral(70), equals(const Color(0xFF6B7280)));
        expect(MPThemeConfig.getNeutral(80), equals(const Color(0xFF4B5563)));
        expect(MPThemeConfig.getNeutral(90), equals(const Color(0xFF374151)));
        expect(MPThemeConfig.getNeutral(100), equals(const Color(0xFF111827)));
      });

      test('should throw ArgumentError for invalid neutral shades', () {
        expect(() => MPThemeConfig.getNeutral(5), throwsArgumentError);
        expect(() => MPThemeConfig.getNeutral(15), throwsArgumentError);
        expect(() => MPThemeConfig.getNeutral(105), throwsArgumentError);
        expect(() => MPThemeConfig.getNeutral(0), throwsArgumentError);
      });

      test(
          'should return fallback color for invalid shades using getNeutralSafe',
          () {
        final fallback = MPThemeConfig.getNeutralSafe(15, fallback: 50);
        expect(fallback, equals(MPThemeConfig.getNeutral(50)));
      });

      test('should return all available neutral shades', () {
        final shades = MPThemeConfig.availableNeutralShades;
        expect(shades, containsAll([10, 20, 30, 40, 50, 60, 70, 80, 90, 100]));
        expect(shades.length, equals(10));
      });

      test('should validate neutral shades correctly', () {
        expect(MPThemeConfig.isValidNeutralShade(10), isTrue);
        expect(MPThemeConfig.isValidNeutralShade(50), isTrue);
        expect(MPThemeConfig.isValidNeutralShade(100), isTrue);
        expect(MPThemeConfig.isValidNeutralShade(15), isFalse);
        expect(MPThemeConfig.isValidNeutralShade(0), isFalse);
      });
    });

    group('Context-Aware Colors', () {
      test('should return correct background colors', () {
        final lightBg = MPThemeConfig.getBackgroundColor(isDarkMode: false);
        final darkBg = MPThemeConfig.getBackgroundColor(isDarkMode: true);

        expect(lightBg, equals(const Color(0xFFFFFFFF))); // neutral10
        expect(darkBg, equals(const Color(0xFF111827))); // neutral100
      });

      test('should return correct surface colors', () {
        final lightSurface = MPThemeConfig.getSurfaceColor(isDarkMode: false);
        final darkSurface = MPThemeConfig.getSurfaceColor(isDarkMode: true);

        expect(lightSurface, equals(const Color(0xFFFFFFFF))); // neutral10
        expect(darkSurface, equals(const Color(0xFF374151))); // neutral90
      });

      test('should return correct card colors', () {
        final lightCard = MPThemeConfig.getCardColor(isDarkMode: false);
        final darkCard = MPThemeConfig.getCardColor(isDarkMode: true);

        expect(lightCard, equals(const Color(0xFFFFFFFF))); // neutral10
        expect(darkCard, equals(const Color(0xFF4B5563))); // neutral80
      });

      test('should return correct text colors', () {
        final lightPrimaryText =
            MPThemeConfig.getPrimaryTextColor(isDarkMode: false);
        final darkPrimaryText =
            MPThemeConfig.getPrimaryTextColor(isDarkMode: true);

        expect(lightPrimaryText, equals(const Color(0xFF111827))); // neutral100
        expect(darkPrimaryText, equals(const Color(0xFFFFFFFF))); // neutral10

        final lightSecondaryText =
            MPThemeConfig.getSecondaryTextColor(isDarkMode: false);
        final darkSecondaryText =
            MPThemeConfig.getSecondaryTextColor(isDarkMode: true);

        expect(
            lightSecondaryText, equals(const Color(0xFF6B7280))); // neutral70
        expect(darkSecondaryText, equals(const Color(0xFFF3F4F6))); // neutral30
      });

      test('should return correct border colors', () {
        final lightBorder = MPThemeConfig.getBorderColor(isDarkMode: false);
        final darkBorder = MPThemeConfig.getBorderColor(isDarkMode: true);

        expect(lightBorder, equals(const Color(0xFFE5E7EB))); // neutral40
        expect(darkBorder, equals(const Color(0xFF6B7280))); // neutral70
      });
    });

    group('Semantic Colors', () {
      test('should return correct semantic colors', () {
        expect(
            MPThemeConfig.getSuccessColor(), equals(const Color(0xFF10B981)));
        expect(MPThemeConfig.getSuccessBackgroundColor(),
            equals(const Color(0xFFD1FAE5)));

        expect(
            MPThemeConfig.getWarningColor(), equals(const Color(0xFFF59E0B)));
        expect(MPThemeConfig.getWarningBackgroundColor(),
            equals(const Color(0xFFFEF3C7)));

        expect(MPThemeConfig.getErrorColor(), equals(const Color(0xFFEF4444)));
        expect(MPThemeConfig.getErrorBackgroundColor(),
            equals(const Color(0xFFFEE2E2)));

        expect(MPThemeConfig.getInfoColor(), equals(const Color(0xFF3B82F6)));
        expect(MPThemeConfig.getInfoBackgroundColor(),
            equals(const Color(0xFFDBEAFE)));
      });
    });

    group('Shadow Colors', () {
      test('should return appropriate shadow colors', () {
        final lightShadow = MPThemeConfig.getShadowColor(isDarkMode: false);
        final darkShadow = MPThemeConfig.getShadowColor(isDarkMode: true);

        expect(lightShadow.opacity, closeTo(0.1, 0.01));
        expect(darkShadow.opacity, closeTo(0.2, 0.01)); // 0.1 * 2

        final customShadow =
            MPThemeConfig.getShadowColor(isDarkMode: false, opacity: 0.3);
        expect(customShadow.opacity, closeTo(0.3, 0.01));
      });
    });

    group('Contrast and Accessibility', () {
      test('should calculate contrast ratio correctly', () {
        final white = const Color(0xFFFFFFFF);
        final black = const Color(0xFF000000);

        final contrast = MPThemeConfig.getContrastRatio(white, black);
        expect(contrast, equals(21.0)); // Maximum contrast
      });

      test('should check good contrast correctly', () {
        final white = const Color(0xFFFFFFFF);
        final black = const Color(0xFF000000);
        final almostWhite = const Color(
            0xFFF5F5F5); // Almost white - very poor contrast with white

        expect(MPThemeConfig.hasGoodContrast(white, black), isTrue);
        expect(MPThemeConfig.hasGoodContrast(black, white), isTrue);
        expect(MPThemeConfig.hasGoodContrast(almostWhite, white), isFalse);
      });

      test('should select best text color for background', () {
        final whiteBg = const Color(0xFFFFFFFF);
        final darkBg = const Color(0xFF111827);

        expect(MPThemeConfig.getBestTextColor(whiteBg),
            equals(const Color(0xFF000000)));
        expect(MPThemeConfig.getBestTextColor(darkBg),
            equals(const Color(0xFFFFFFFF)));
      });
    });

    group('Theme Validation', () {
      test('should validate light theme contrast', () {
        final validation =
            MPThemeConfig.validateThemeContrast(isDarkMode: false);

        expect(validation['primary_text_on_background'], isTrue);
        expect(validation['secondary_text_on_background'], isTrue);
        expect(validation['primary_text_on_surface'], isTrue);
        expect(validation['secondary_text_on_surface'], isTrue);
        expect(validation['primary_button_contrast'], isTrue);
      });

      test('should validate dark theme contrast', () {
        final validation =
            MPThemeConfig.validateThemeContrast(isDarkMode: true);

        expect(validation['primary_text_on_background'], isTrue);
        expect(validation['secondary_text_on_background'], isTrue);
        expect(validation['primary_text_on_surface'], isTrue);
        expect(validation['secondary_text_on_surface'], isTrue);
        expect(validation['primary_button_contrast'], isTrue);
      });

      test('should generate validation summary', () {
        final summary =
            MPThemeConfig.getThemeValidationSummary(isDarkMode: false);

        expect(summary, contains('Light Mode Theme Validation'));
        expect(summary, contains('✅ PASS'));
      });
    });
  });
}
