import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ColorPage extends StatelessWidget {
  const ColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get color theme from context.mp instead of Theme.of(context)
    final mpColors = context.mp.colorTheme;
    if (mpColors == null) {
      return Scaffold(
        backgroundColor: context.mp.adaptiveBackgroundColor,
        appBar: AppBar(
          title: MPText.head(
            'Colors',
            style: TextStyle(color: context.mp.textColor),
            fontSize: 20,
          ),
          backgroundColor: context.mp.adaptiveBackgroundColor,
          elevation: 0,
        ),
        body: Center(
          child: Text(
            'Color theme not available',
            style: TextStyle(color: context.mp.textColor),
          ),
        ),
      );
    }

    final names = mpColors!
        .toString()
        .replaceAll('MPColorTheme(', '')
        .replaceAll(')', '')
        .split(', ');
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Colors',
          style: TextStyle(color: context.mp.textColor),
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: ListView(
        children: List.generate(
          colorCollection(mpColors).length,
          (index) {
            final color = colorCollection(mpColors)[index];
            final name = names[index].split(': ')[0];

            return ListTile(
              tileColor: color,
              title: SelectableText(
                '$color - $name',
                style: TextStyle(
                  color: _getContrastColor(color ?? Colors.grey),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getContrastColor(Color backgroundColor) {
    // Calculate luminance to determine if we should use black or white text
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  List<Color?> colorCollection(MPColorTheme mpColors) => [
        mpColors?.primary,
        mpColors?.primarySurface,
        mpColors?.primaryFocus,
        mpColors?.primaryBorder,
        mpColors?.primaryHover,
        mpColors?.primaryPressed,
        mpColors?.neutral10,
        mpColors?.neutral20,
        mpColors?.neutral30,
        mpColors?.neutral40,
        mpColors?.neutral50,
        mpColors?.neutral60,
        mpColors?.neutral70,
        mpColors?.neutral80,
        mpColors?.neutral90,
        mpColors?.neutral100,
      ];
}
