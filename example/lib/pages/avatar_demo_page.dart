import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class AvatarDemoPage extends StatelessWidget {
  const AvatarDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Avatar',
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
            _buildTypes(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildShapes(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithBadges(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildAvatars(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSizes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Avatar Sizes'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          children: [
            _AvatarDemo(
              label: 'XS',
              avatar: MPAvatar(
                name: 'John',
                size: MPAvatarSize.xs,
              ),
            ),
            _AvatarDemo(
              label: 'Small',
              avatar: MPAvatar(
                name: 'Jane',
                size: MPAvatarSize.small,
              ),
            ),
            _AvatarDemo(
              label: 'Medium',
              avatar: MPAvatar(
                name: 'Bob',
                size: MPAvatarSize.medium,
              ),
            ),
            _AvatarDemo(
              label: 'Large',
              avatar: MPAvatar(
                name: 'Alice',
                size: MPAvatarSize.large,
              ),
            ),
            _AvatarDemo(
              label: 'XL',
              avatar: MPAvatar(
                name: 'Charlie',
                size: MPAvatarSize.xl,
              ),
            ),
            _AvatarDemo(
              label: 'XXL',
              avatar: MPAvatar(
                name: 'Diana',
                size: MPAvatarSize.xxl,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Avatar Types'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          children: [
            _AvatarDemo(
              label: 'Initials',
              avatar: MPAvatar(
                name: 'John Doe',
                type: MPAvatarType.initials,
                size: MPAvatarSize.large,
              ),
            ),
            _AvatarDemo(
              label: 'Icon',
              avatar: MPAvatar(
                icon: Icons.person,
                type: MPAvatarType.icon,
                size: MPAvatarSize.large,
              ),
            ),
            _AvatarDemo(
              label: 'Placeholder',
              avatar: MPAvatar(
                type: MPAvatarType.placeholder,
                size: MPAvatarSize.large,
              ),
            ),
            _AvatarDemo(
              label: 'Image',
              avatar: MPAvatar(
                imageUrl: 'https://i.pravatar.cc/150?img=1',
                type: MPAvatarType.image,
                size: MPAvatarSize.large,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShapes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Avatar Shapes'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          children: [
            _AvatarDemo(
              label: 'Circle',
              avatar: MPAvatar(
                name: 'John',
                shape: MPAvatarShape.circle,
                size: MPAvatarSize.large,
              ),
            ),
            _AvatarDemo(
              label: 'Rounded Square',
              avatar: MPAvatar(
                name: 'Jane',
                shape: MPAvatarShape.roundedSquare,
                size: MPAvatarSize.large,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWithBadges(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Avatars with Badges'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          children: [
            MPAvatar(
              name: 'John',
              size: MPAvatarSize.large,
              badge: MPBadge(
                label: '3',
                variant: MPBadgeVariant.error,
                size: MPBadgeSize.small,
              ),
            ),
            MPAvatar(
              name: 'Jane',
              size: MPAvatarSize.large,
              badge: MPBadge(
                label: 'Online',
                variant: MPBadgeVariant.success,
                size: MPBadgeSize.small,
              ),
            ),
            MPAvatar(
              imageUrl: 'https://i.pravatar.cc/150?img=2',
              type: MPAvatarType.image,
              size: MPAvatarSize.large,
              badge: MPBadge(
                label: 'New',
                variant: MPBadgeVariant.primary,
                size: MPBadgeSize.small,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatars(BuildContext context) {
    final users = [
      'John Doe',
      'Jane Smith',
      'Bob Johnson',
      'Alice Brown',
      'Charlie Wilson',
      'Diana Miller',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Avatar List'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: users.map((name) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  MPAvatar(
                    name: name,
                    size: MPAvatarSize.medium,
                  ),
                  SizedBox(width: MPResponsivePadding.getMd(context)),
                  Expanded(
                    child: MPText(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: context.mp.textColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: context.mp.captionColor,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _AvatarDemo extends StatelessWidget {
  const _AvatarDemo({
    required this.label,
    required this.avatar,
  });

  final String label;
  final Widget avatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        avatar,
        SizedBox(height: MPResponsivePadding.getXs(context)),
        MPText(
          label,
          style: TextStyle(
            fontSize: 12,
            color: context.mp.captionColor,
          ),
        ),
      ],
    );
  }
}
