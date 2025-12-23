import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class BadgeDemoPage extends StatelessWidget {
  const BadgeDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Badge Demo',
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
            _buildWithIcons(context),
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
          'Badge Variants',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _BadgeCard(
          context: context,
          title: 'Standard Badge',
          description: 'Number badge for notifications',
          child: Row(
            children: [
              Icon(Icons.notifications),
              const SizedBox(width: 12),
              MPBadge(label: '5'),
            ],
          ),
        ),
        SizedBox(height: 16),
        _BadgeCard(
          context: context,
          title: 'Dot Badge',
          description: 'Simple dot indicator',
          child: Row(
            children: [
              Icon(Icons.notifications),
              const SizedBox(width: 12),
              MPBadge(
                label: '',
                variant: MPBadgeVariant.primary,
                size: MPBadgeSize.small,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _BadgeCard(
          context: context,
          title: 'Notification Badge',
          description: 'Styled notification indicator',
          child: Row(
            children: [
              Icon(Icons.mail),
              const SizedBox(width: 12),
              MPBadge(
                variant: MPBadgeVariant.primary,
                label: '12',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSizes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Badge Sizes',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _BadgeCard(
          context: context,
          title: 'Small',
          description: 'Compact size',
          child: Row(
            children: [
              Icon(Icons.message),
              const SizedBox(width: 12),
              MPBadge(label: '99+', size: MPBadgeSize.small),
            ],
          ),
        ),
        SizedBox(height: 16),
        _BadgeCard(
          context: context,
          title: 'Medium',
          description: 'Default medium size',
          child: Row(
            children: [
              Icon(Icons.message),
              const SizedBox(width: 12),
              MPBadge(label: '5', size: MPBadgeSize.medium),
            ],
          ),
        ),
        SizedBox(height: 16),
        _BadgeCard(
          context: context,
          title: 'Large',
          description: 'Prominent large size',
          child: Row(
            children: [
              Icon(Icons.message),
              const SizedBox(width: 12),
              MPBadge(label: '3', size: MPBadgeSize.large),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWithIcons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Badges with Icons',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _BadgeCard(
          context: context,
          title: 'Warning',
          description: 'Warning icon badge',
          child: MPBadge(
            label: '!',
            leading: Icon(Icons.warning, size: 16),
          ),
        ),
        SizedBox(height: 16),
        _BadgeCard(
          context: context,
          title: 'Success',
          description: 'Success icon badge',
          child: MPBadge(
            label: '✓',
            leading: Icon(Icons.check_circle, size: 16),
          ),
        ),
        SizedBox(height: 16),
        _BadgeCard(
          context: context,
          title: 'Error',
          description: 'Error icon badge',
          child: MPBadge(
            label: '!',
            leading: Icon(Icons.error, size: 16),
          ),
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
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _ExampleCard(
          context: context,
          title: 'App Icon with Notification',
          description: 'Mobile app icon style with badge',
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.mp.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.mp.borderColor,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: context.mp.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.phone_iphone,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: -4,
                      right: -4,
                      child: MPBadge(
                        label: '3',
                        size: MPBadgeSize.medium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          context: context,
          title: 'Menu Item',
          description: 'Badge in menu/list item',
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.mp.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.mp.borderColor,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.dashboard, color: context.mp.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: MPText.head('Dashboard'),
                ),
                MPBadge(label: 'New'),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          context: context,
          title: 'Button with Badge',
          description: 'Action button with notification count',
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.mp.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.mp.borderColor,
                width: 1,
              ),
            ),
            child: Stack(
              children: [
                MPButton(
                  text: 'Messages',
                  variant: MPButtonVariant.primary,
                  onPressed: () {},
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: const Offset(4, -4),
                    child: MPBadge(
                      label: '5',
                      size: MPBadgeSize.small,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _BadgeCard({
    required BuildContext context,
    required String title,
    required String description,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.mp.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText.head(
            title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 4),
          MPText.label(
            description,
            style: TextStyle(
              color: context.mp.subtitleColor,
            ),
          ),
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _ExampleCard({
    required BuildContext context,
    required String title,
    required String description,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.mp.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText.head(
                  title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 4),
                MPText.label(
                  description,
                  style: TextStyle(
                    color: context.mp.subtitleColor,
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
