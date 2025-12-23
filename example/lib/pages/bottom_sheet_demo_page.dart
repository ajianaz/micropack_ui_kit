import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class BottomSheetDemoPage extends StatelessWidget {
  const BottomSheetDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Bottom Sheet Demo',
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
            _buildVariants(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildSizes(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithActions(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildExamples(context),
          ],
        ),
      ),
    );
  }

  Widget _buildVariants(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Bottom Sheet Variants',
          fontSize: 18,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          runSpacing: MPResponsivePadding.getSm(context),
          children: [
            _DemoButton(
              label: 'Standard',
              onPressed: () => _showStandard(context),
            ),
            _DemoButton(
              label: 'Rounded',
              onPressed: () => _showRounded(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSizes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Bottom Sheet Sizes',
          fontSize: 18,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          runSpacing: MPResponsivePadding.getSm(context),
          children: [
            _DemoButton(
              label: 'Compact',
              onPressed: () => _showCompact(context),
            ),
            _DemoButton(
              label: 'Medium',
              onPressed: () => _showMedium(context),
            ),
            _DemoButton(
              label: 'Large',
              onPressed: () => _showLarge(context),
            ),
            _DemoButton(
              label: 'Auto',
              onPressed: () => _showAuto(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWithActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Bottom Sheets with Actions',
          fontSize: 18,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          runSpacing: MPResponsivePadding.getSm(context),
          children: [
            _DemoButton(
              label: 'Confirm Dialog',
              onPressed: () => _showConfirmDialog(context),
            ),
            _DemoButton(
              label: 'Destructive Action',
              onPressed: () => _showDestructive(context),
            ),
            _DemoButton(
              label: 'Three Actions',
              onPressed: () => _showThreeActions(context),
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
              label: 'Settings Menu',
              onPressed: () => _showSettingsMenu(context),
            ),
            _DemoButton(
              label: 'Filter Options',
              onPressed: () => _showFilterOptions(context),
            ),
            _DemoButton(
              label: 'Share Options',
              onPressed: () => _showShareOptions(context),
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

  void _showStandard(BuildContext context) {
    MPBottomSheet.show(
      context: context,
      variant: MPBottomSheetVariant.standard,
      title: 'Standard Bottom Sheet',
      child: _buildContent(context),
    );
  }

  void _showRounded(BuildContext context) {
    MPBottomSheet.show(
      context: context,
      variant: MPBottomSheetVariant.rounded,
      title: 'Rounded Bottom Sheet',
      child: _buildContent(context),
    );
  }

  void _showCompact(BuildContext context) {
    MPBottomSheet.show(
      context: context,
      size: MPBottomSheetSize.compact,
      variant: MPBottomSheetVariant.rounded,
      title: 'Compact Bottom Sheet',
      child: _buildContent(context),
    );
  }

  void _showMedium(BuildContext context) {
    MPBottomSheet.show(
      context: context,
      size: MPBottomSheetSize.medium,
      variant: MPBottomSheetVariant.rounded,
      title: 'Medium Bottom Sheet',
      child: _buildContent(context),
    );
  }

  void _showLarge(BuildContext context) {
    MPBottomSheet.show(
      context: context,
      size: MPBottomSheetSize.large,
      variant: MPBottomSheetVariant.rounded,
      title: 'Large Bottom Sheet',
      child: _buildContent(context),
    );
  }

  void _showAuto(BuildContext context) {
    MPBottomSheet.show(
      context: context,
      size: MPBottomSheetSize.auto,
      variant: MPBottomSheetVariant.rounded,
      title: 'Auto Bottom Sheet',
      child: _buildContent(context),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    MPBottomSheet.show(
      context: context,
      title: 'Confirm Action',
      subtitle: 'Are you sure you want to proceed?',
      size: MPBottomSheetSize.compact,
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Cancel',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
        MPBottomSheetAction(
          label: 'Confirm',
          style: MPBottomSheetActionStyle.primary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showDestructive(BuildContext context) {
    MPBottomSheet.show(
      context: context,
      title: 'Delete Item',
      subtitle: 'This action cannot be undone.',
      size: MPBottomSheetSize.compact,
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Cancel',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
        MPBottomSheetAction(
          label: 'Delete',
          style: MPBottomSheetActionStyle.destructive,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showThreeActions(BuildContext context) {
    MPBottomSheet.show(
      context: context,
      title: 'Select Option',
      size: MPBottomSheetSize.compact,
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Option 1',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () {},
        ),
        MPBottomSheetAction(
          label: 'Option 2',
          style: MPBottomSheetActionStyle.primary,
          onPressed: () {},
        ),
        MPBottomSheetAction(
          label: 'Option 3',
          style: MPBottomSheetActionStyle.destructive,
          onPressed: () {},
        ),
      ],
    );
  }

  void _showSettingsMenu(BuildContext context) {
    MPBottomSheet.show(
      context: context,
      title: 'Settings',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Column(
        children: [
          MPListTile(
            title: 'Notifications',
            leading: Icon(Icons.notifications, color: context.mp.primary),
            trailing: MPSwitch(
              value: true,
              onToggle: (value) {},
            ),
          ),
          MPDivider(),
          MPListTile(
            title: 'Dark Mode',
            leading: Icon(Icons.dark_mode, color: context.mp.primary),
            trailing: MPSwitch(
              value: false,
              onToggle: (value) {},
            ),
          ),
          MPDivider(),
          MPListTile(
            title: 'Language',
            leading: Icon(Icons.language, color: context.mp.primary),
            trailing: Icon(Icons.chevron_right, color: context.mp.captionColor),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    MPBottomSheet.show(
      context: context,
      title: 'Filter Options',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Reset',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () {},
        ),
        MPBottomSheetAction(
          label: 'Apply',
          style: MPBottomSheetActionStyle.primary,
          onPressed: () {},
        ),
      ],
      child: Column(
        children: [
          _FilterOption('All Items'),
          _FilterOption('Active'),
          _FilterOption('Completed'),
          _FilterOption('Archived'),
        ],
      ),
    );
  }

  Widget _FilterOption(String label) {
    return MPListTile(
      title: label,
      leading: Icon(Icons.circle_outlined, size: 16),
      onTap: () {},
    );
  }

  void _showShareOptions(BuildContext context) {
    MPBottomSheet.show(
      context: context,
      title: 'Share',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Cancel',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _ShareOption(context, Icons.copy, 'Copy Link'),
            _ShareOption(context, Icons.email, 'Email'),
            _ShareOption(context, Icons.message, 'Message'),
            _ShareOption(context, Icons.chat, 'WhatsApp'),
            _ShareOption(context, Icons.share, 'Facebook'),
            _ShareOption(context, Icons.send, 'Telegram'),
            _ShareOption(context, Icons.link, 'Copy'),
            _ShareOption(context, Icons.more_horiz, 'More'),
          ],
        ),
      ),
    );
  }

  Widget _ShareOption(BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.mp.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.mp.borderColor,
              width: 1,
            ),
          ),
          child: Icon(icon, size: 32, color: context.mp.primary),
        ),
        SizedBox(height: 8),
        MPText.label(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: MPResponsivePadding.card(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText.head('Content Example'),
          SizedBox(height: 8),
          MPText.label(
            'This is example content for the bottom sheet. '
            'You can place any widget here, including forms, lists, '
            'images, or custom layouts.',
          ),
          SizedBox(height: 16),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: context.mp.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.widgets,
                size: 48,
                color: context.mp.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
