import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MPCard Accessibility Test'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Testing MPCard with accessibility features',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              // Basic card with accessibility
              MPCard(
                variant: MPCardVariant.primary,
                child: const Text('Basic card with accessibility enabled'),
                semanticLabel: 'Test basic card',
                accessibilityConfig: const MPCardAccessibilityConfig(
                  enabled: true,
                  enableFocusManagement: true,
                  enableKeyboardNavigation: true,
                  enableHighContrast: true,
                  respectReducedMotion: true,
                ),
              ),
              const SizedBox(height: 16),
              // Card with custom semantic label and hint
              MPCard(
                variant: MPCardVariant.elevated,
                child: const Text('Card with custom semantics'),
                semanticLabel: 'Custom labeled card',
                semanticHint:
                    'This is a test card with custom accessibility hints',
                accessibilityConfig: MPCardAccessibilityConfig(
                  enabled: true,
                  onSemanticLabel: (context, variant,
                          {headerData, footerData}) =>
                      'Custom label for ${variant.name} card',
                  onSemanticHint: (context, variant) =>
                      'Custom hint for ${variant.name} card',
                ),
              ),
              const SizedBox(height: 16),
              // Interactive card
              MPCard(
                variant: MPCardVariant.interactive,
                child: const Text('Interactive card'),
                onTap: () => print('Interactive card tapped'),
                semanticLabel: 'Interactive test card',
                accessibilityConfig: const MPCardAccessibilityConfig(
                  enabled: true,
                  enableFocusManagement: true,
                  enableKeyboardNavigation: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
