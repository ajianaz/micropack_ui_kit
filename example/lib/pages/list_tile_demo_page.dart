import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ListTileDemoPage extends StatelessWidget {
  const ListTileDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'List Tile',
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
            _buildSizes(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildVariants(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithLeading(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithTrailing(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithSubtitle(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithTertiary(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildStates(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildDense(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildExamples(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSizes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('List Tile Sizes'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            _SectionLabel('Small'),
            MPListTile(
              title: 'Small List Tile',
              subtitle: 'Compact version',
              size: MPListTileSize.small,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _SectionLabel('Medium'),
            MPListTile(
              title: 'Medium List Tile',
              subtitle: 'Standard size',
              size: MPListTileSize.medium,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _SectionLabel('Large'),
            MPListTile(
              title: 'Large List Tile',
              subtitle: 'Expanded version',
              size: MPListTileSize.large,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVariants(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('List Tile Variants'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            _SectionLabel('Standard'),
            MPListTile(
              title: 'Standard Variant',
              variant: MPListTileVariant.standard,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _SectionLabel('Primary'),
            MPListTile(
              title: 'Primary Variant',
              variant: MPListTileVariant.primary,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _SectionLabel('Subtle'),
            MPListTile(
              title: 'Subtle Variant',
              variant: MPListTileVariant.subtle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWithLeading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('List Tiles with Leading'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            MPListTile(
              title: 'With Avatar',
              subtitle: 'Using initials avatar',
              leading: MPAvatar(
                name: 'John Doe',
                size: MPAvatarSize.medium,
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPListTile(
              title: 'With Icon',
              subtitle: 'Using Material icon',
              leading: Icon(
                Icons.person,
                color: context.mp.primary,
                size: 24,
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPListTile(
              title: 'With Custom Widget',
              subtitle: 'Custom leading widget',
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.mp.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.star,
                  color: context.mp.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWithTrailing(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('List Tiles with Trailing'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            MPListTile(
              title: 'With Chevron',
              subtitle: 'Navigational indicator',
              trailing: Icon(
                Icons.chevron_right,
                color: context.mp.captionColor,
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPListTile(
              title: 'With Switch',
              subtitle: 'Toggle action',
              trailing: MPSwitch(
                value: true,
                onToggle: (value) {},
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPListTile(
              title: 'With Checkbox',
              subtitle: 'Selection action',
              trailing: MPCheckbox(
                value: true,
                onChanged: (value) {},
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPListTile(
              title: 'With Badge',
              subtitle: 'Status indicator',
              trailing: MPBadge(
                label: '3',
                variant: MPBadgeVariant.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWithSubtitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('List Tiles with Subtitle'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            MPListTile(
              title: 'John Doe',
              subtitle: 'Software Engineer',
              leading: MPAvatar(
                name: 'John Doe',
                size: MPAvatarSize.medium,
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPListTile(
              title: 'Jane Smith',
              subtitle: 'Product Manager',
              leading: MPAvatar(
                name: 'Jane Smith',
                size: MPAvatarSize.medium,
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPListTile(
              title: 'Bob Johnson',
              subtitle: 'Designer',
              leading: MPAvatar(
                name: 'Bob Johnson',
                size: MPAvatarSize.medium,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWithTertiary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('List Tiles with Tertiary'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            MPListTile(
              title: 'Project Alpha',
              subtitle: 'In Progress',
              tertiary: 'Due: Dec 31, 2025',
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.mp.warningColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.folder,
                  color: context.mp.warningColor,
                ),
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPListTile(
              title: 'Project Beta',
              subtitle: 'Completed',
              tertiary: 'Delivered: Dec 15, 2025',
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.mp.successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.check_circle,
                  color: context.mp.successColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStates(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('List Tile States'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            _SectionLabel('Selected'),
            MPListTile(
              title: 'Selected Item',
              selected: true,
              leading: Icon(Icons.check, color: context.mp.primary),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _SectionLabel('Disabled'),
            MPListTile(
              title: 'Disabled Item',
              enabled: false,
              leading: Icon(Icons.block, color: context.mp.captionColor),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _SectionLabel('Selected & Disabled'),
            MPListTile(
              title: 'Selected Disabled',
              selected: true,
              enabled: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDense(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Dense List Tiles'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            _SectionLabel('Regular Padding'),
            MPListTile(
              title: 'Regular List Tile',
              subtitle: 'Standard padding',
              dense: false,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _SectionLabel('Dense Padding'),
            MPListTile(
              title: 'Dense List Tile',
              subtitle: 'Reduced padding',
              dense: true,
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
        MPText.head('Practical Examples'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        _buildUserList(context),
        SizedBox(height: MPResponsivePadding.getLg(context)),
        _buildSettingsList(context),
        SizedBox(height: MPResponsivePadding.getLg(context)),
        _buildNavigationList(context),
      ],
    );
  }

  Widget _buildUserList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel('User List'),
        Container(
          decoration: BoxDecoration(
            color: context.mp.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.mp.borderColor,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              MPListTile(
                title: 'John Doe',
                subtitle: 'Software Engineer',
                tertiary: 'Online',
                leading: MPAvatar(
                  name: 'John Doe',
                  type: MPAvatarType.initials,
                  size: MPAvatarSize.medium,
                ),
                trailing: Icon(Icons.chevron_right),
              ),
              MPDivider(thickness: MPDividerThickness.thin),
              MPListTile(
                title: 'Jane Smith',
                subtitle: 'Product Manager',
                tertiary: 'Away',
                leading: MPAvatar(
                  name: 'Jane Smith',
                  type: MPAvatarType.initials,
                  size: MPAvatarSize.medium,
                ),
                trailing: Icon(Icons.chevron_right),
              ),
              MPDivider(thickness: MPDividerThickness.thin),
              MPListTile(
                title: 'Bob Johnson',
                subtitle: 'Designer',
                tertiary: 'Offline',
                leading: MPAvatar(
                  name: 'Bob Johnson',
                  type: MPAvatarType.initials,
                  size: MPAvatarSize.medium,
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel('Settings List'),
        Container(
          decoration: BoxDecoration(
            color: context.mp.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.mp.borderColor,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              MPListTile(
                title: 'Notifications',
                subtitle: 'Enable push notifications',
                leading: Icon(Icons.notifications),
                trailing: MPSwitch(
                  value: true,
                  onToggle: (value) {},
                ),
              ),
              MPDivider(thickness: MPDividerThickness.thin),
              MPListTile(
                title: 'Dark Mode',
                subtitle: 'Use dark theme',
                leading: Icon(Icons.dark_mode),
                trailing: MPSwitch(
                  value: false,
                  onToggle: (value) {},
                ),
              ),
              MPDivider(thickness: MPDividerThickness.thin),
              MPListTile(
                title: 'Language',
                subtitle: 'English (US)',
                leading: Icon(Icons.language),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel('Navigation List'),
        Container(
          decoration: BoxDecoration(
            color: context.mp.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.mp.borderColor,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              MPListTile(
                title: 'Dashboard',
                leading: Icon(Icons.dashboard),
                trailing: Icon(Icons.chevron_right),
              ),
              MPDivider(thickness: MPDividerThickness.thin),
              MPListTile(
                title: 'Profile',
                leading: Icon(Icons.person),
                trailing: Icon(Icons.chevron_right),
              ),
              MPDivider(thickness: MPDividerThickness.thin),
              MPListTile(
                title: 'Settings',
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.chevron_right),
              ),
              MPDivider(thickness: MPDividerThickness.thin),
              MPListTile(
                title: 'Help & Support',
                leading: Icon(Icons.help),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MPResponsivePadding.getXs(context),
      ),
      child: MPText.label(
        text,
        style: TextStyle(
          color: context.mp.captionColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
