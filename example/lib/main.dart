import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:provider/provider.dart';

import 'package:micropack_ui_kit_example/app.dart';
import 'package:micropack_ui_kit_example/contanta.dart';
import 'package:micropack_ui_kit_example/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MPTextStyle.defaultFontFamily = defaultFontFamily;

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    ChangeNotifierProvider.value(
      value: themeProvider,
      child: const App(),
    ),
  );
}
