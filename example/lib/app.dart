import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import 'package:micropack_ui_kit_example/pages/home_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) => MPComponentInit(
        builder: (_) => MaterialApp(
          title: 'Micropack UI KIT',
          theme: MPTheme.main().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              MPColorTheme.light,
            ],
          ),
          darkTheme: MPTheme.main().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              MPColorTheme.dark,
            ],
          ),
          themeMode: _themeMode,
          home: HomePage(
            themeMode: _themeMode,
            onThemeChanged: (ThemeMode mode) {
              print('App theme changing to: $mode');
              setState(() {
                _themeMode = mode;
              });
              print('App theme changed to: $_themeMode');
            },
          ),
        ),
      );
}
