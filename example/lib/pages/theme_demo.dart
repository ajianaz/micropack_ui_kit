import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_config.dart';

class ThemeDemoPage extends StatelessWidget {
  const ThemeDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MPText.head(
          'MPThemeConfig Demo',
          fontSize: 20,
          style: TextStyle(color: MPThemeConfig.getNeutral(10)),
        ),
        backgroundColor: MPThemeConfig.getPrimary(),
        foregroundColor: MPThemeConfig.getNeutral(10),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Primary Colors'),
            _buildPrimaryColorsDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Neutral Colors'),
            _buildNeutralColorsDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Semantic Colors'),
            _buildSemanticColorsDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Theme Validation'),
            _buildThemeValidationDemo(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPrimaryColorsDemo() {
    return Card(
      color: MPThemeConfig.getNeutral(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildColorRow('Primary', MPThemeConfig.getPrimary()),
            _buildColorRow('Primary Hover', MPThemeConfig.getPrimaryHover()),
            _buildColorRow(
                'Primary Pressed', MPThemeConfig.getPrimaryPressed()),
            _buildColorRow('Primary Focus', MPThemeConfig.getPrimaryFocus()),
            _buildColorRow('Primary Border', MPThemeConfig.getPrimaryBorder()),
            _buildColorRow(
                'Primary Surface', MPThemeConfig.getPrimarySurface()),
          ],
        ),
      ),
    );
  }

  Widget _buildNeutralColorsDemo() {
    return Card(
      color: MPThemeConfig.getNeutral(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildColorRow('Neutral 10 (White)', MPThemeConfig.getNeutral(10)),
            _buildColorRow('Neutral 20', MPThemeConfig.getNeutral(20)),
            _buildColorRow('Neutral 30', MPThemeConfig.getNeutral(30)),
            _buildColorRow('Neutral 40', MPThemeConfig.getNeutral(40)),
            _buildColorRow('Neutral 50', MPThemeConfig.getNeutral(50)),
            _buildColorRow('Neutral 60', MPThemeConfig.getNeutral(60)),
            _buildColorRow('Neutral 70', MPThemeConfig.getNeutral(70)),
            _buildColorRow('Neutral 80', MPThemeConfig.getNeutral(80)),
            _buildColorRow('Neutral 90', MPThemeConfig.getNeutral(90)),
            _buildColorRow('Neutral 100', MPThemeConfig.getNeutral(100)),
          ],
        ),
      ),
    );
  }

  Widget _buildSemanticColorsDemo() {
    return Card(
      color: MPThemeConfig.getNeutral(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildColorRow('Success', MPThemeConfig.getSuccessColor()),
            _buildColorRow('Success Background',
                MPThemeConfig.getSuccessBackgroundColor()),
            _buildColorRow('Warning', MPThemeConfig.getWarningColor()),
            _buildColorRow('Warning Background',
                MPThemeConfig.getWarningBackgroundColor()),
            _buildColorRow('Error', MPThemeConfig.getErrorColor()),
            _buildColorRow(
                'Error Background', MPThemeConfig.getErrorBackgroundColor()),
            _buildColorRow('Info', MPThemeConfig.getInfoColor()),
            _buildColorRow(
                'Info Background', MPThemeConfig.getInfoBackgroundColor()),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeValidationDemo() {
    final validation = MPThemeConfig.validateThemeContrast(isDarkMode: false);

    return Card(
      color: MPThemeConfig.getNeutral(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Theme Validation Results',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...validation.entries.map((entry) {
              final status = entry.value ? '✅ PASS' : '❌ FAIL';
              final color = entry.value ? Colors.green : Colors.red;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(
                      entry.value ? Icons.check_circle : Icons.error,
                      color: color,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${entry.key}: $status',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildColorRow(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: MPThemeConfig.getNeutral(70)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  color.value.toString().toUpperCase(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
