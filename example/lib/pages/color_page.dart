import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ColorPage extends StatelessWidget {
  const ColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mpColors = Theme.of(context).extension<MPColorTheme>()!;
    final names = mpColors
        .toString()
        .replaceAll('MPColorTheme(', '')
        .replaceAll(')', '')
        .split(', ');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colors'),
      ),
      body: ListView(
        children: List.generate(colorCollection(mpColors).length, 
        (index) {
          final color = colorCollection(mpColors)[index];
          final name = names[index].split(': ')[0];

          return ListTile(
            tileColor: color,
            title: SelectableText(
              '$color - $name',
            ),
          );
        },
        ),
      ),
    );
  }


  List<Color?> colorCollection(MPColorTheme mpColors) => [
    
    mpColors.primary,
    mpColors.primarySurface,
    mpColors.primaryFocus,
    mpColors.primaryBorder,
    mpColors.primaryHover,
    mpColors.primaryPressed,
    mpColors.neutral10,
    mpColors.neutral20,
    mpColors.neutral30,
    mpColors.neutral40,
    mpColors.neutral50,
    mpColors.neutral60,
    mpColors.neutral70,
    mpColors.neutral80,
    mpColors.neutral90,
    mpColors.neutral100,
    
    
  ];
}
