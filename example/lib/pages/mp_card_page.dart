import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// MPCard page demonstrating all MPCard features
class MPCardPage extends StatefulWidget {
  const MPCardPage({super.key});

  @override
  State<MPCardPage> createState() => _MPCardPageState();
}

class _MPCardPageState extends State<MPCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'MPCard',
          style: TextStyle(color: context.mp.textColor),
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: MPResponsivePadding.page(context),
        children: [
          MPText.head('Enhanced MPCard Examples'),
          SizedBox(height: 24),

          // Basic card with child
          MPCard(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: MPText('Basic card with child content'),
            ),
          ),
          SizedBox(height: 16),

          // Card with structured header
          MPCard.withHeader(
            headerData: MPCardHeaderData(
              title: 'Card with Header',
              subtitle: 'This card uses structured header data',
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: MPText('This is body content with structured header.'),
            ),
          ),
          SizedBox(height: 16),

          // Card with structured footer
          MPCard.withFooter(
            footerData: MPCardFooterData(
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: MPText('This card has structured footer with actions.'),
            ),
          ),
          SizedBox(height: 16),

          // Card with both header and footer
          MPCard.withSections(
            headerData: MPCardHeaderData(
              title: 'Complete Card',
              subtitle: 'Header and footer example',
              leading: CircleAvatar(
                backgroundColor: context.mp.primary,
                child: const Text('AB', style: TextStyle(color: Colors.white)),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: MPText(
                  'This card demonstrates both structured header and footer sections.'),
            ),
            footerData: MPCardFooterData(
              content: MPText.small('Additional footer content'),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Action'),
                ),
              ],
            ),
            variant: MPCardVariant.elevated,
          ),
          SizedBox(height: 16),

          // Interactive card with overflow handling
          MPCard(
            variant: MPCardVariant.interactive,
            enableOverflowHandling: true,
            onTap: () {
              _showSnackBar(context, 'Card tapped!');
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText.subhead('Interactive Card'),
                SizedBox(height: 8),
                MPText(
                    'This card has overflow handling enabled for long content.'),
                SizedBox(height: 8),
                ...List.generate(
                    10,
                    (index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.circle, size: 8),
                              SizedBox(width: 8),
                              Expanded(
                                child: MPText(
                                  'Content item ${index + 1} with some longer text to test overflow',
                                ),
                              ),
                            ],
                          ),
                        )),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Responsive card
          MPCard.withSections(
            headerData: MPCardHeaderData(
              title: 'Responsive Card',
              subtitle: 'Adapts to screen size',
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: MPText(
                  'This card uses responsive configuration to adapt layout based on screen size.'),
            ),
            footerData: MPCardFooterData(
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Learn More'),
                ),
              ],
            ),
            layout: MPCardLayout.adaptive,
            responsive: MPCardResponsiveConfig(
              mobileLayout: MPCardLayout.vertical,
              tabletLayout: MPCardLayout.horizontal,
              desktopLayout: MPCardLayout.horizontal,
              enableOrientationAdaptation: true,
              enableHorizontalScrolling: true,
              enableResponsiveImages: true,
              enableResponsiveTypography: true,
              mobileSize: MPCardSize.small,
              tabletSize: MPCardSize.medium,
              desktopSize: MPCardSize.large,
              mobilePadding: EdgeInsets.all(12),
              tabletPadding: EdgeInsets.all(16),
              desktopPadding: EdgeInsets.all(20),
              mobileImageHeight: 160,
              tabletImageHeight: 200,
              desktopImageHeight: 240,
            ),
          ),
          SizedBox(height: 24),

          // Advanced Responsive Examples Section
          MPText.head('Advanced Responsive Features'),
          SizedBox(height: 16),

          // Responsive Grid Layout
          MPText.subhead('Responsive Grid Layout'),
          SizedBox(height: 8),
          MPCard.withSections(
            headerData: MPCardHeaderData(
              title: 'Grid Layout Card',
              subtitle: 'Automatically adjusts columns',
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: MPText(
                  'This card demonstrates responsive grid layout that adjusts column count based on screen size.'),
            ),
            footerData: MPCardFooterData(
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text('View Grid'),
                ),
              ],
            ),
            layout: MPCardLayout.grid,
            responsive: MPCardResponsiveConfig(
              enableOrientationAdaptation: true,
              mobileSize: MPCardSize.small,
              tabletSize: MPCardSize.medium,
              desktopSize: MPCardSize.large,
            ),
          ),
          SizedBox(height: 16),

          // Responsive Media Card
          MPText.subhead('Responsive Media Card'),
          SizedBox(height: 8),
          MPCard.media(
            mediaData: MPCardMediaData(
              imageUrl: 'https://picsum.photos/400/200',
              title: 'Responsive Media',
              subtitle: 'Adaptive image sizing',
              description:
                  'This media card demonstrates responsive image heights that scale based on screen size.',
            ),
            responsive: MPCardResponsiveConfig(
              enableResponsiveImages: true,
              mobileImageHeight: 120,
              tabletImageHeight: 180,
              desktopImageHeight: 240,
              mobileSize: MPCardSize.small,
              tabletSize: MPCardSize.medium,
              desktopSize: MPCardSize.large,
            ),
          ),
          SizedBox(height: 16),

          // Elevation Examples Section
          MPText.head('Elevation Level Examples'),
          SizedBox(height: 16),

          // Different elevation levels
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              // Level 0 (No elevation)
              MPCard(
                elevationLevel: MPCardElevation.level0,
                size: MPCardSize.small,
                child: Column(
                  children: [
                    MPText.subhead('Level 0'),
                    MPText.small('No elevation'),
                  ],
                ),
              ),
              // Level 1 (Subtle elevation)
              MPCard(
                elevationLevel: MPCardElevation.level1,
                size: MPCardSize.small,
                child: Column(
                  children: [
                    MPText.subhead('Level 1'),
                    MPText.small('Subtle elevation'),
                  ],
                ),
              ),
              // Level 2 (Light elevation)
              MPCard(
                elevationLevel: MPCardElevation.level2,
                size: MPCardSize.small,
                child: Column(
                  children: [
                    MPText.subhead('Level 2'),
                    MPText.small('Light elevation'),
                  ],
                ),
              ),
              // Level 4 (Moderate elevation)
              MPCard(
                elevationLevel: MPCardElevation.level4,
                size: MPCardSize.small,
                child: Column(
                  children: [
                    MPText.subhead('Level 4'),
                    MPText.small('Moderate elevation'),
                  ],
                ),
              ),
              // Level 8 (High elevation)
              MPCard(
                elevationLevel: MPCardElevation.level8,
                size: MPCardSize.small,
                child: Column(
                  children: [
                    MPText.subhead('Level 8'),
                    MPText.small('High elevation'),
                  ],
                ),
              ),
              // Level 16 (Extreme elevation)
              MPCard(
                elevationLevel: MPCardElevation.level16,
                size: MPCardSize.small,
                child: Column(
                  children: [
                    MPText.subhead('Level 16'),
                    MPText.small('Extreme elevation'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Use case-specific variants section
          _buildUseCaseVariants(context),
        ],
      ),
    );
  }

  /// Build use case-specific variants section
  Widget _buildUseCaseVariants(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        MPText.head('Use Case-Specific Variants'),
        SizedBox(height: 24),

        // Media Card Example
        MPText.subhead('Media Card'),
        SizedBox(height: 16),
        MPCard.media(
          mediaData: MPCardMediaData(
            imageUrl: 'https://picsum.photos/400/200',
            title: 'Beautiful Landscape',
            subtitle: 'Nature Photography',
            description:
                'A stunning view of mountains and lakes during golden hour, showcasing beauty of natural landscapes.',
            metadata: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: context.mp.subtitleColor,
                ),
                SizedBox(width: 4),
                MPText.small('2 days ago', color: context.mp.subtitleColor),
                SizedBox(width: 16),
                Icon(
                  Icons.favorite_border,
                  size: 16,
                  color: context.mp.subtitleColor,
                ),
                SizedBox(width: 4),
                MPText.small('234', color: context.mp.subtitleColor),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('Share'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                child: const Text('View'),
              ),
            ],
          ),
          onTap: () {
            _showSnackBar(context, 'Media card tapped!');
          },
        ),
        SizedBox(height: 16),

        // Content Card Example
        MPText.subhead('Content Card'),
        SizedBox(height: 16),
        MPCard.content(
          contentData: MPCardContentData(
            title: 'Design Principles',
            subtitle: 'UI/UX Fundamentals',
            description:
                'Understanding core principles of design helps create better user experiences. This includes visual hierarchy, color theory, typography, and layout fundamentals.',
            icon: Icon(Icons.palette, color: context.mp.primary),
            showDivider: true,
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('Read More'),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Product Card Example
        MPText.subhead('Product Card'),
        SizedBox(height: 16),
        MPCard.product(
          productData: MPCardProductData(
            name: 'Premium Headphones',
            description:
                'Wireless noise-canceling headphones with premium sound quality and 30-hour battery life.',
            price: '299.99',
            originalPrice: '399.99',
            currency: '\$',
            imageUrl: 'https://picsum.photos/400/300',
            rating: 4.5,
            reviewCount: 128,
            features: [
              'Active Noise Cancellation',
              '30-hour Battery Life',
              'Premium Sound Quality',
              'Comfortable Design'
            ],
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Profile Card Example
        MPText.subhead('Profile Card'),
        SizedBox(height: 16),
        MPCard.profile(
          profileData: MPCardProfileData(
            name: 'Sarah Johnson',
            username: 'sarahj_design',
            bio:
                'UI/UX Designer passionate about creating beautiful and functional user experiences. Love working with emerging technologies.',
            avatarUrl: 'https://picsum.photos/100/100',
            showVerifiedBadge: true,
            isOnline: true,
            stats: const {
              'Projects': '42',
              'Followers': '1.2K',
              'Following': '89'
            },
            socialLinks: [
              IconButton(
                icon: const Icon(Icons.link),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.email),
                onPressed: () {},
              ),
            ],
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('Follow'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Message'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    MPSnackbar.show(
      context,
      message: message,
      duration: const Duration(seconds: 2),
    );
  }
}
