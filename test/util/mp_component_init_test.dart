import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MPComponentInitTest extends StatelessWidget {
  const MPComponentInitTest({
    required this.child, super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => MPComponentInit(
    builder: (_) => MaterialApp(
      title: 'Micropack UI Kit',
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
      home: child,
    ),
  );
}
