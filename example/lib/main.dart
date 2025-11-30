import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import 'package:micropack_ui_kit_example/app.dart';
import 'package:micropack_ui_kit_example/contanta.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MPTextStyle.defaultFontFamily = defaultFontFamily;

  // Initialize MPThemeManager before running the app
  try {
    await MPThemeManager.initialize();
    debugPrint('MPThemeManager initialized successfully');
  } catch (e) {
    debugPrint('Failed to initialize MPThemeManager: $e');
  }

  runApp(const App());
}
