import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class PlatformAdaptiveDemoPage extends StatelessWidget {
  const PlatformAdaptiveDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Platform Adaptive Demo',
          style: TextStyle(color: context.mp.textColor),
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWidgets(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildBuilders(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildExamples(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Platform Adaptive Widgets',
          fontSize: 18,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          runSpacing: MPResponsivePadding.getSm(context),
          children: [
            _DemoButton(
              label: 'Simple Widget',
              onPressed: () => _showSimpleWidget(context),
            ),
            _DemoButton(
              label: 'All Platforms',
              onPressed: () => _showAllPlatforms(context),
            ),
            _DemoButton(
              label: 'With Fallback',
              onPressed: () => _showWithFallback(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBuilders(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Platform Adaptive Builders',
          fontSize: 18,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          runSpacing: MPResponsivePadding.getSm(context),
          children: [
            _DemoButton(
              label: 'Builder Example',
              onPressed: () => _showBuilderExample(context),
            ),
            _DemoButton(
              label: 'Context Access',
              onPressed: () => _showContextAccess(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Practical Examples',
          fontSize: 18,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          runSpacing: MPResponsivePadding.getSm(context),
          children: [
            _DemoButton(
              label: 'Navigation',
              onPressed: () => _showNavigation(context),
            ),
            _DemoButton(
              label: 'Buttons',
              onPressed: () => _showButtons(context),
            ),
            _DemoButton(
              label: 'Lists',
              onPressed: () => _showLists(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _DemoButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return MPButton(
      text: label,
      onPressed: onPressed,
      variant: MPButtonVariant.outlined,
    );
  }

  // Show Methods

  void _showSimpleWidget(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'Simple Platform Adaptive',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          children: [
            MPText.head('Simple Widget Example'),
            SizedBox(height: 16),
            MPText.label(
              'This platform adaptive widget shows different content '
              'based on the current platform (iOS, Android, Web, etc.).',
            ),
            SizedBox(height: 24),
            MPPlatformAdaptive(
              iOS: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.phone_iphone, color: Colors.blue, size: 32),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MPText.head('iOS', color: Colors.blue),
                        MPText.label('Cupertino-style interface'),
                      ],
                    ),
                  ],
                ),
              ),
              android: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.android, color: Colors.green, size: 32),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MPText.head('Android', color: Colors.green),
                        MPText.label('Material Design interface'),
                      ],
                    ),
                  ],
                ),
              ),
              fallback: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.devices, color: Colors.grey, size: 32),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MPText.head('Default', color: Colors.grey),
                        MPText.label('Fallback interface'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAllPlatforms(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'All Platforms Example',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          children: [
            MPText.head('All Platforms Covered'),
            SizedBox(height: 16),
            Column(
              children: [
                _PlatformCard(
                  icon: Icons.phone_iphone,
                  label: 'iOS',
                  description: 'iPhone, iPad, iPod',
                  color: Colors.blue,
                ),
                SizedBox(height: 8),
                _PlatformCard(
                  icon: Icons.android,
                  label: 'Android',
                  description: 'Android phones and tablets',
                  color: Colors.green,
                ),
                SizedBox(height: 8),
                _PlatformCard(
                  icon: Icons.laptop_mac,
                  label: 'macOS',
                  description: 'MacBook, iMac, Mac',
                  color: Colors.purple,
                ),
                SizedBox(height: 8),
                _PlatformCard(
                  icon: Icons.computer,
                  label: 'Windows/Linux',
                  description: 'Desktop platforms',
                  color: Colors.orange,
                ),
                SizedBox(height: 8),
                _PlatformCard(
                  icon: Icons.web,
                  label: 'Web',
                  description: 'Chrome, Firefox, Safari',
                  color: Colors.cyan,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _PlatformCard({
    required IconData icon,
    required String label,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText.head(label, color: color, fontSize: 16),
                MPText.label(description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showWithFallback(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'Fallback Strategy',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          children: [
            MPText.head('Fallback Options'),
            SizedBox(height: 16),
            MPText.label(
              'If a specific platform widget is not provided, '
              'you can choose how to handle it:',
            ),
            SizedBox(height: 16),
            _FallbackOption(
              context,
              title: 'Default Widget',
              description: 'Shows a default/fallback widget',
              strategy: MPPlatformFallback.defaultWidget,
            ),
            SizedBox(height: 12),
            _FallbackOption(
              context,
              title: 'Closest Platform',
              description: 'Shows the nearest available platform',
              strategy: MPPlatformFallback.closestPlatform,
            ),
            SizedBox(height: 12),
            _FallbackOption(
              context,
              title: 'Error',
              description: 'Throws an exception',
              strategy: MPPlatformFallback.error,
            ),
          ],
        ),
      ),
    );
  }

  Widget _FallbackOption(
    BuildContext context, {
    required String title,
    required String description,
    required MPPlatformFallback strategy,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.mp.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText.head(title, fontSize: 16),
          SizedBox(height: 4),
          MPText.label(description),
          SizedBox(height: 8),
          MPText.label(
            'Strategy: ${strategy.toString().split('.').last}',
            style: TextStyle(color: context.mp.primary),
          ),
        ],
      ),
    );
  }

  void _showBuilderExample(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'Builder Example',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          children: [
            MPText.head('Platform Builders'),
            SizedBox(height: 16),
            MPPlatformAdaptiveBuilder(
              iOS: (context) => _PlatformCard(
                icon: Icons.phone_iphone,
                label: 'iOS Builder',
                description: 'Lazy widget construction',
                color: Colors.blue,
              ),
              android: (context) => _PlatformCard(
                icon: Icons.android,
                label: 'Android Builder',
                description: 'Lazy widget construction',
                color: Colors.green,
              ),
              fallback: (context) => _PlatformCard(
                icon: Icons.devices,
                label: 'Fallback Builder',
                description: 'Lazy widget construction',
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContextAccess(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'Context Access',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          children: [
            MPText.head('Context Access'),
            SizedBox(height: 16),
            MPText.label(
              'Platform builders receive BuildContext, allowing access '
              'to theme, media queries, and other context-dependent values.',
            ),
            SizedBox(height: 16),
            MPPlatformAdaptiveBuilder(
              iOS: (context) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.mp.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    MPText.head('iOS Context'),
                    SizedBox(height: 8),
                    MPText.label(
                      'Theme: ${Theme.of(context).brightness}',
                    ),
                  ],
                ),
              ),
              android: (context) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.mp.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    MPText.head('Android Context'),
                    SizedBox(height: 8),
                    MPText.label(
                      'Theme: ${Theme.of(context).brightness}',
                    ),
                  ],
                ),
              ),
              fallback: (context) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.mp.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    MPText.head('Default Context'),
                    SizedBox(height: 8),
                    MPText.label(
                      'Theme: ${Theme.of(context).brightness}',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNavigation(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'Platform Navigation',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          children: [
            MPText.head('Platform-Specific Navigation'),
            SizedBox(height: 16),
            MPPlatformAdaptive(
              iOS: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(Icons.arrow_back_ios, color: Colors.blue, size: 32),
                    SizedBox(height: 8),
                    MPText.head('iOS Back', color: Colors.blue),
                  ],
                ),
              ),
              android: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.green, size: 32),
                    SizedBox(height: 8),
                    MPText.head('Android Back', color: Colors.green),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showButtons(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'Platform Buttons',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          children: [
            MPText.head('Platform-Specific Buttons'),
            SizedBox(height: 16),
            MPPlatformAdaptive(
              iOS: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () {},
                child: const Text('iOS Button'),
              ),
              android: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () {},
                child: const Text('Android Button'),
              ),
              fallback: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () {},
                child: const Text('Default Button'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLists(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'Platform Lists',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          children: [
            MPText.head('Platform-Specific Lists'),
            SizedBox(height: 16),
            MPPlatformAdaptive(
              iOS: Column(
                children: [
                  _ListItem(icon: Icons.check, title: 'iOS List Item 1'),
                  _ListItem(icon: Icons.check, title: 'iOS List Item 2'),
                  _ListItem(icon: Icons.check, title: 'iOS List Item 3'),
                ],
              ),
              android: Column(
                children: [
                  _ListItem(icon: Icons.radio_button_checked, title: 'Android List Item 1'),
                  _ListItem(icon: Icons.radio_button_checked, title: 'Android List Item 2'),
                  _ListItem(icon: Icons.radio_button_checked, title: 'Android List Item 3'),
                ],
              ),
              fallback: Column(
                children: [
                  _ListItem(icon: Icons.circle, title: 'Default List Item 1'),
                  _ListItem(icon: Icons.circle, title: 'Default List Item 2'),
                  _ListItem(icon: Icons.circle, title: 'Default List Item 3'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ListItem({
    required IconData icon,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 12),
          MPText.head(title, fontSize: 16),
        ],
      ),
    );
  }
}
