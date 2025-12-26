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

    final colorMap = _getColorMap(mpColors);
    final colorKeys = colorMap.keys.toList();

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
      body: ListView.builder(
        itemCount: colorKeys.length,
        itemBuilder: (context, index) {
          final name = colorKeys[index];
          final color = colorMap[name];

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
    );
  }

  Color _getContrastColor(Color backgroundColor) {
    // Calculate luminance to determine if we should use black or white text
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  Map<String, Color?> _getColorMap(MPColorTheme theme) => {
        'primary': theme.primary,
        'primarySurface': theme.primarySurface,
        'primaryFocus': theme.primaryFocus,
        'primaryBorder': theme.primaryBorder,
        'primaryHover': theme.primaryHover,
        'primaryPressed': theme.primaryPressed,
        'neutral10': theme.neutral10,
        'neutral20': theme.neutral20,
        'neutral30': theme.neutral30,
        'neutral40': theme.neutral40,
        'neutral50': theme.neutral50,
        'neutral60': theme.neutral60,
        'neutral70': theme.neutral70,
        'neutral80': theme.neutral80,
        'neutral90': theme.neutral90,
        'neutral100': theme.neutral100,
      };
}
