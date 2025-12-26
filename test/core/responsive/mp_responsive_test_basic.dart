import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPResponsive Basic Tests', () {
    // ============ BREAKPOINT TESTS ============

    group('Breakpoint Detection', () {
      test('detects small mobile device', () {
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(300);
        expect(deviceSize, MPDeviceSize.smallMobile);
      });

      test('detects mobile device', () {
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(380);
        expect(deviceSize, MPDeviceSize.mobile);
      });

      test('detects large mobile device', () {
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(420);
        expect(deviceSize, MPDeviceSize.mobile);
      });

      test('detects small tablet device', () {
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(650);
        expect(deviceSize, MPDeviceSize.largeMobile);
      });

      test('detects tablet device', () {
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(700);
        expect(deviceSize, MPDeviceSize.largeMobile);
      });

      test('detects large tablet device', () {
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(800);
        expect(deviceSize, MPDeviceSize.smallTablet);
      });

      test('detects small desktop device', () {
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(1100);
        expect(deviceSize, MPDeviceSize.largeTablet);
      });

      test('detects desktop device', () {
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(1300);
        expect(deviceSize, MPDeviceSize.largeTablet);
      });

      test('detects large desktop device', () {
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(1500);
        expect(deviceSize, MPDeviceSize.desktop);
      });

      test('detects ultra wide device', () {
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(2000);
        expect(deviceSize, MPDeviceSize.largeDesktop);
      });

      test('correctly identifies mobile devices', () {
        // Test mobile widths
        for (final width in [300.0, 380.0, 420.0]) {
          expect(MPResponsiveBreakpoints.isMobile(width), isTrue,
              reason: 'Width $width should be detected as mobile');
          expect(MPResponsiveBreakpoints.isTablet(width), isFalse,
              reason: 'Width $width should not be detected as tablet');
          expect(MPResponsiveBreakpoints.isDesktop(width), isFalse,
              reason: 'Width $width should not be detected as desktop');
        }
      });

      test('correctly identifies tablet devices', () {
        // Test tablet widths
        for (final width in [650.0, 768.0, 900.0]) {
          expect(MPResponsiveBreakpoints.isMobile(width), isFalse,
              reason: 'Width $width should not be detected as mobile');
          expect(MPResponsiveBreakpoints.isTablet(width), isTrue,
              reason: 'Width $width should be detected as tablet');
          expect(MPResponsiveBreakpoints.isDesktop(width), isFalse,
              reason: 'Width $width should not be detected as desktop');
        }
      });

      test('correctly identifies desktop devices', () {
        // Test desktop widths
        for (final width in [1024.0, 1200.0, 1400.0, 1700.0]) {
          expect(MPResponsiveBreakpoints.isMobile(width), isFalse,
              reason: 'Width $width should not be detected as mobile');
          expect(MPResponsiveBreakpoints.isTablet(width), isFalse,
              reason: 'Width $width should not be detected as tablet');
          expect(MPResponsiveBreakpoints.isDesktop(width), isTrue,
              reason: 'Width $width should be detected as desktop');
        }
      });
    });

    // ============ CACHE MANAGEMENT TESTS ============

    group('Cache Management', () {
      test('clears all caches', () {
        MPResponsive.clearCaches();

        final stats = MPResponsive.getCacheStats();
        expect(stats['deviceSizeCacheSize'], 0);
        expect(stats['orientationCacheSize'], 0);
        expect(stats['valueCacheSize'], 0);
      });

      test('gets cache statistics', () {
        final stats = MPResponsive.getCacheStats();

        expect(stats, contains('deviceSizeCacheSize'));
        expect(stats, contains('orientationCacheSize'));
        expect(stats, contains('valueCacheSize'));

        expect(stats['deviceSizeCacheSize'], isA<int>());
        expect(stats['orientationCacheSize'], isA<int>());
        expect(stats['valueCacheSize'], isA<int>());
      });
    });

    // ============ FORM FACTOR TESTS ============

    group('Form Factor Detection', () {
      test('correctly identifies phone form factor for small mobile', () {
        // Test phone portrait - small mobile
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(300);
        expect(deviceSize, MPDeviceSize.smallMobile);
      });

      test('correctly identifies tablet form factor for tablet', () {
        // Test tablet - small tablet
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(700);
        expect(deviceSize, MPDeviceSize.largeMobile);
      });

      test('correctly identifies desktop form factor for desktop', () {
        // Test desktop - large tablet
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(1100);
        expect(deviceSize, MPDeviceSize.largeTablet);
      });
    });
  });
}
