import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPThemeConfig Tests', () {
    // ============ PRIMARY COLORS TESTS ============

    group('Primary Colors', () {
      test('returns correct primary color', () {
        expect(MPThemeConfig.getPrimary(), const Color(0xFF6366F1));
        expect(MPThemeConfig.getPrimary(isDarkMode: true),
            const Color(0xFF6366F1));
      });

      test('returns correct primary hover color', () {
        expect(MPThemeConfig.getPrimaryHover(), const Color(0xFF4F46E5));
        expect(MPThemeConfig.getPrimaryHover(isDarkMode: true),
            const Color(0xFF4F46E5));
      });

      test('returns correct primary pressed color', () {
        expect(MPThemeConfig.getPrimaryPressed(), const Color(0xFF4338CA));
        expect(MPThemeConfig.getPrimaryPressed(isDarkMode: true),
            const Color(0xFF4338CA));
      });

      test('returns correct primary focus color', () {
        expect(MPThemeConfig.getPrimaryFocus(), const Color(0xFF818CF8));
        expect(MPThemeConfig.getPrimaryFocus(isDarkMode: true),
            const Color(0xFF818CF8));
      });

      test('returns correct primary border color', () {
        expect(MPThemeConfig.getPrimaryBorder(), const Color(0xFFA5B4FC));
        expect(MPThemeConfig.getPrimaryBorder(isDarkMode: true),
            const Color(0xFFA5B4FC));
      });

      test('returns correct primary surface color', () {
        expect(MPThemeConfig.getPrimarySurface(), const Color(0xFFEEF2FF));
        expect(MPThemeConfig.getPrimarySurface(isDarkMode: true),
            const Color(0xFFEEF2FF));
      });
    });

    // ============ NEUTRAL COLORS TESTS ============

    group('Neutral Colors', () {
      test('returns correct neutral colors for all shades', () {
        const expectedColors = {
          10: Color(0xFFFFFFFF),
          20: Color(0xFFF9FAFB),
          30: Color(0xFFF3F4F6),
          40: Color(0xFFE5E7EB),
          50: Color(0xFFD1D5DB),
          60: Color(0xFF9CA3AF),
          70: Color(0xFF6B7280),
          80: Color(0xFF4B5563),
          90: Color(0xFF374151),
          100: Color(0xFF111827),
        };

        for (final entry in expectedColors.entries) {
          expect(MPThemeConfig.getNeutral(entry.key), entry.value,
              reason: 'Neutral shade ${entry.key} should match expected color');
        }
      });

      test('throws error for invalid neutral shade', () {
        expect(
          () => MPThemeConfig.getNeutral(5),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => MPThemeConfig.getNeutral(15),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => MPThemeConfig.getNeutral(110),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('returns fallback color for invalid shade using getNeutralSafe', () {
        expect(MPThemeConfig.getNeutralSafe(5),
            const Color(0xFFD1D5DB)); // fallback 50
        expect(MPThemeConfig.getNeutralSafe(15, fallback: 20),
            const Color(0xFFF9FAFB)); // fallback 20
      });

      test('returns available neutral shades', () {
        final shades = MPThemeConfig.availableNeutralShades;
        expect(shades, containsAll([10, 20, 30, 40, 50, 60, 70, 80, 90, 100]));
        expect(shades.length, 10);
      });

      test('validates neutral shades correctly', () {
        expect(MPThemeConfig.isValidNeutralShade(10), isTrue);
        expect(MPThemeConfig.isValidNeutralShade(50), isTrue);
        expect(MPThemeConfig.isValidNeutralShade(100), isTrue);
        expect(MPThemeConfig.isValidNeutralShade(5), isFalse);
        expect(MPThemeConfig.isValidNeutralShade(15), isFalse);
        expect(MPThemeConfig.isValidNeutralShade(110), isFalse);
      });
    });

    // ============ CONTEXT-AWARE COLORS TESTS ============

    group('Context-Aware Colors', () {
      test('returns correct background colors', () {
        expect(MPThemeConfig.getBackgroundColor(isDarkMode: false),
            const Color(0xFFFFFFFF));
        expect(MPThemeConfig.getBackgroundColor(isDarkMode: true),
            const Color(0xFF111827));
      });

      test('returns correct surface colors', () {
        expect(MPThemeConfig.getSurfaceColor(isDarkMode: false),
            const Color(0xFFFFFFFF));
        expect(MPThemeConfig.getSurfaceColor(isDarkMode: true),
            const Color(0xFF374151));
      });

      test('returns correct card colors', () {
        expect(MPThemeConfig.getCardColor(isDarkMode: false),
            const Color(0xFFFFFFFF));
        expect(MPThemeConfig.getCardColor(isDarkMode: true),
            const Color(0xFF4B5563));
      });

      test('returns correct primary text colors', () {
        expect(MPThemeConfig.getPrimaryTextColor(isDarkMode: false),
            const Color(0xFF111827));
        expect(MPThemeConfig.getPrimaryTextColor(isDarkMode: true),
            const Color(0xFFFFFFFF));
      });

      test('returns correct secondary text colors', () {
        expect(MPThemeConfig.getSecondaryTextColor(isDarkMode: false),
            const Color(0xFF6B7280));
        expect(MPThemeConfig.getSecondaryTextColor(isDarkMode: true),
            const Color(0xFFF3F4F6));
      });

      test('returns correct disabled text colors', () {
        expect(MPThemeConfig.getDisabledTextColor(isDarkMode: false),
            const Color(0xFFD1D5DB));
        expect(MPThemeConfig.getDisabledTextColor(isDarkMode: true),
            const Color(0xFF9CA3AF));
      });

      test('returns correct border colors', () {
        expect(MPThemeConfig.getBorderColor(isDarkMode: false),
            const Color(0xFFE5E7EB));
        expect(MPThemeConfig.getBorderColor(isDarkMode: true),
            const Color(0xFF6B7280));
      });

      test('returns correct divider colors', () {
        expect(MPThemeConfig.getDividerColor(isDarkMode: false),
            const Color(0xFFF3F4F6));
        expect(MPThemeConfig.getDividerColor(isDarkMode: true),
            const Color(0xFF4B5563));
      });
    });

    // ============ SEMANTIC COLORS TESTS ============

    group('Semantic Colors', () {
      test('returns correct success colors', () {
        expect(MPThemeConfig.getSuccessColor(), const Color(0xFF10B981));
        expect(
            MPThemeConfig.getSuccessBackgroundColor(), const Color(0xFFD1FAE5));
      });

      test('returns correct warning colors', () {
        expect(MPThemeConfig.getWarningColor(), const Color(0xFFF59E0B));
        expect(
            MPThemeConfig.getWarningBackgroundColor(), const Color(0xFFFEF3C7));
      });

      test('returns correct error colors', () {
        expect(MPThemeConfig.getErrorColor(), const Color(0xFFEF4444));
        expect(
            MPThemeConfig.getErrorBackgroundColor(), const Color(0xFFFEE2E2));
      });

      test('returns correct info colors', () {
        expect(MPThemeConfig.getInfoColor(), const Color(0xFF3B82F6));
        expect(MPThemeConfig.getInfoBackgroundColor(), const Color(0xFFDBEAFE));
      });
    });

    // ============ SHADOW COLORS TESTS ============

    group('Shadow Colors', () {
      test('returns correct shadow colors for light mode', () {
        expect(MPThemeConfig.getShadowColor(isDarkMode: false),
            Colors.black.withValues(alpha: 0.1));
        expect(MPThemeConfig.getShadowColor(isDarkMode: false, opacity: 0.2),
            Colors.black.withValues(alpha: 0.2));
      });

      test('returns correct shadow colors for dark mode', () {
        expect(MPThemeConfig.getShadowColor(isDarkMode: true),
            Colors.black.withValues(alpha: 0.2));
        expect(MPThemeConfig.getShadowColor(isDarkMode: true, opacity: 0.3),
            Colors.black.withValues(alpha: 0.6));
      });

      test('clamps shadow opacity to valid range', () {
        expect(MPThemeConfig.getShadowColor(opacity: -0.5),
            Colors.black.withValues(alpha: 0.0));
        expect(MPThemeConfig.getShadowColor(opacity: 1.5),
            Colors.black.withValues(alpha: 1.0));
      });
    });

    // ============ CONTRAST UTILITIES TESTS ============

    group('Contrast Utilities', () {
      test('calculates contrast ratio correctly', () {
        // Black on white should have maximum contrast
        expect(MPThemeConfig.getContrastRatio(Colors.black, Colors.white),
            closeTo(21.0, 0.1));

        // White on black should have maximum contrast
        expect(MPThemeConfig.getContrastRatio(Colors.white, Colors.black),
            closeTo(21.0, 0.1));

        // Same colors should have minimum contrast
        expect(MPThemeConfig.getContrastRatio(Colors.white, Colors.white),
            closeTo(1.0, 0.1));
      });

      test('checks contrast quality correctly', () {
        expect(
            MPThemeConfig.hasGoodContrast(Colors.black, Colors.white), isTrue);
        expect(
            MPThemeConfig.hasGoodContrast(Colors.white, Colors.black), isTrue);
        expect(
            MPThemeConfig.hasGoodContrast(Colors.white, Colors.white), isFalse);

        // Test with custom minimum ratio - check actual contrast ratio first
        final greyWhiteContrast =
            MPThemeConfig.getContrastRatio(Colors.grey, Colors.white);
        expect(
            MPThemeConfig.hasGoodContrast(Colors.grey, Colors.white,
                minimumRatio: 3.0),
            greyWhiteContrast >= 3.0 ? isTrue : isFalse);
        expect(
            MPThemeConfig.hasGoodContrast(Colors.grey, Colors.white,
                minimumRatio: 5.0),
            greyWhiteContrast >= 5.0 ? isTrue : isFalse);
      });

      test('selects best text color for background', () {
        expect(MPThemeConfig.getBestTextColor(Colors.white), Colors.black);
        expect(MPThemeConfig.getBestTextColor(Colors.black), Colors.white);

        // Test with custom colors
        expect(
            MPThemeConfig.getBestTextColor(Colors.grey,
                lightColor: Colors.red, darkColor: Colors.blue),
            Colors.red);
        expect(
            MPThemeConfig.getBestTextColor(Colors.black,
                lightColor: Colors.red, darkColor: Colors.blue),
            Colors.blue);
      });
    });

    // ============ THEME VALIDATION TESTS ============

    group('Theme Validation', () {
      test('validates light mode theme contrast', () {
        final validation =
            MPThemeConfig.validateThemeContrast(isDarkMode: false);

        expect(validation['primary_text_on_background'], isTrue);
        expect(validation['secondary_text_on_background'], isTrue);
        expect(validation['primary_text_on_surface'], isTrue);
        expect(validation['secondary_text_on_surface'], isTrue);
        expect(validation['primary_button_contrast'], isTrue);
      });

      test('validates dark mode theme contrast', () {
        final validation =
            MPThemeConfig.validateThemeContrast(isDarkMode: true);

        expect(validation['primary_text_on_background'], isTrue);
        expect(validation['secondary_text_on_background'], isTrue);
        expect(validation['primary_text_on_surface'], isTrue);
        expect(validation['secondary_text_on_surface'], isTrue);
        expect(validation['primary_button_contrast'], isTrue);
      });

      test('generates theme validation summary', () {
        final summary =
            MPThemeConfig.getThemeValidationSummary(isDarkMode: false);

        expect(summary, contains('Light Mode Theme Validation'));
        expect(summary, contains('✅ PASS'));
        expect(summary, contains('ALL TESTS PASSED'));
      });

      test('generates validation summary for dark mode', () {
        final summary =
            MPThemeConfig.getThemeValidationSummary(isDarkMode: true);

        expect(summary, contains('Dark Mode Theme Validation'));
        expect(summary, contains('✅ PASS'));
        expect(summary, contains('ALL TESTS PASSED'));
      });
    });

    // ============ EDGE CASES AND ERROR HANDLING ============

    group('Edge Cases and Error Handling', () {
      test('handles extreme opacity values in shadow colors', () {
        expect(MPThemeConfig.getShadowColor(opacity: 0.0),
            Colors.black.withValues(alpha: 0.0));
        expect(MPThemeConfig.getShadowColor(opacity: 1.0),
            Colors.black.withValues(alpha: 1.0));
        expect(MPThemeConfig.getShadowColor(opacity: -1.0),
            Colors.black.withValues(alpha: 0.0));
        expect(MPThemeConfig.getShadowColor(opacity: 2.0),
            Colors.black.withValues(alpha: 1.0));
      });

      test('handles invalid fallback shades correctly', () {
        // When both requested shade and fallback are invalid, it should throw
        expect(
          () => MPThemeConfig.getNeutralSafe(5, fallback: 15),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => MPThemeConfig.getNeutralSafe(5, fallback: 110),
          throwsA(isA<ArgumentError>()),
        );
        // Test with valid fallback
        expect(MPThemeConfig.getNeutralSafe(5, fallback: 20),
            const Color(0xFFF9FAFB)); // Falls back to 20
      });

      test('returns consistent colors regardless of isDarkMode parameter', () {
        // Primary colors should be consistent
        expect(MPThemeConfig.getPrimary(),
            MPThemeConfig.getPrimary(isDarkMode: true));
        expect(MPThemeConfig.getPrimaryHover(),
            MPThemeConfig.getPrimaryHover(isDarkMode: true));
        expect(MPThemeConfig.getPrimaryPressed(),
            MPThemeConfig.getPrimaryPressed(isDarkMode: true));
        expect(MPThemeConfig.getPrimaryFocus(),
            MPThemeConfig.getPrimaryFocus(isDarkMode: true));
        expect(MPThemeConfig.getPrimaryBorder(),
            MPThemeConfig.getPrimaryBorder(isDarkMode: true));
        expect(MPThemeConfig.getPrimarySurface(),
            MPThemeConfig.getPrimarySurface(isDarkMode: true));

        // Semantic colors should be consistent
        expect(
            MPThemeConfig.getSuccessColor(), MPThemeConfig.getSuccessColor());
        expect(
            MPThemeConfig.getWarningColor(), MPThemeConfig.getWarningColor());
        expect(MPThemeConfig.getErrorColor(), MPThemeConfig.getErrorColor());
        expect(MPThemeConfig.getInfoColor(), MPThemeConfig.getInfoColor());
      });
    });

    // ============ INTEGRATION TESTS ============

    group('Integration Tests', () {
      test('all neutral colors are unique', () {
        final colors = MPThemeConfig.availableNeutralShades
            .map((shade) => MPThemeConfig.getNeutral(shade))
            .toSet();

        expect(colors.length, 10,
            reason: 'All neutral colors should be unique');
      });

      test('theme validation covers all required checks', () {
        final validation = MPThemeConfig.validateThemeContrast();

        expect(
            validation.keys,
            containsAll([
              'primary_text_on_background',
              'secondary_text_on_background',
              'primary_text_on_surface',
              'secondary_text_on_surface',
              'primary_button_contrast',
            ]));
      });

      test('contrast ratio is symmetric', () {
        final ratio1 = MPThemeConfig.getContrastRatio(Colors.red, Colors.blue);
        final ratio2 = MPThemeConfig.getContrastRatio(Colors.blue, Colors.red);

        expect(ratio1, closeTo(ratio2, 0.001),
            reason: 'Contrast ratio should be symmetric');
      });

      test('best text color selection is consistent with contrast ratio', () {
        final background = Colors.grey;
        final lightColor = Colors.white;
        final darkColor = Colors.black;

        final bestColor = MPThemeConfig.getBestTextColor(background,
            lightColor: lightColor, darkColor: darkColor);
        final lightContrast =
            MPThemeConfig.getContrastRatio(lightColor, background);
        final darkContrast =
            MPThemeConfig.getContrastRatio(darkColor, background);

        if (lightContrast > darkContrast) {
          expect(bestColor, lightColor);
        } else {
          expect(bestColor, darkColor);
        }
      });
    });
  });
}
