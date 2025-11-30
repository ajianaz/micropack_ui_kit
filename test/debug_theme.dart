import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme.dart';

void main() {
  test('Debug MPTheme.main', () {
    try {
      final theme = MPTheme.main(isDarkMode: true);
      print('Theme created successfully: ${theme.brightness}');
    } catch (e, s) {
      print('Error creating theme: $e');
      print('Stack trace: $s');
    }
  });
}
