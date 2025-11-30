import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:provider/provider.dart';

import 'package:micropack_ui_kit_example/pages/home_page.dart';
import 'package:micropack_ui_kit_example/providers/theme_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MPComponentInit(
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
            themeMode: themeProvider.themeMode,
            home: const HomePage(),
          ),
        );
      },
    );
  }
}
