import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MPCardPage extends StatefulWidget {
  const MPCardPage({super.key});

  @override
  State<MPCardPage> createState() => _MPCardPageState();
}

class _MPCardPageState extends State<MPCardPage> {
  @override
  void initState() {
    super.initState();
    // Add listener for theme changes
    try {
      MPThemeManager.instance.addListener(_onThemeChanged);
    } catch (e) {
      // Manager might not be initialized yet, ignore
      debugPrint('Failed to add theme listener: $e');
    }
  }

  @override
  void dispose() {
    // Remove theme listener
    try {
      MPThemeManager.instance.removeListener(_onThemeChanged);
    } catch (e) {
      // Manager might not be initialized, ignore
      debugPrint('Failed to remove theme listener: $e');
    }
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {
        // Rebuild UI when theme changes
      });
    }
  }

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
        actions: [
          IconButton(
            icon: Icon(
              _getThemeIcon(),
              color: context.mp.textColor,
            ),
            onPressed: () async {
              // Toggle theme between light and dark
              final currentTheme = _getCurrentThemeMode();
              final newTheme = currentTheme == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
              await _setThemeMode(newTheme);
              _showSnackBar(context,
                  'Switched to ${newTheme == ThemeMode.light ? 'Light' : 'Dark'} theme');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText.head('Enhanced MPCard Examples'),
            SizedBox(height: 24.h),

            // Basic card with child
            MPCard(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: MPText('Basic card with child content'),
              ),
            ),
            SizedBox(height: 16.h),

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
                padding: EdgeInsets.all(16.r),
                child: MPText('This is body content with structured header.'),
              ),
            ),
            SizedBox(height: 16.h),

            // Card with structured footer
            MPCard.withFooter(
              footerData: MPCardFooterData(
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Save'),
                  ),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.all(16.r),
                child: MPText('This card has structured footer with actions.'),
              ),
            ),
            SizedBox(height: 16.h),

            // Card with both header and footer
            MPCard.withSections(
              headerData: MPCardHeaderData(
                title: 'Complete Card',
                subtitle: 'Header and footer example',
                leading: CircleAvatar(
                  backgroundColor: context.mp.primary,
                  child:
                      const Text('AB', style: TextStyle(color: Colors.white)),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.all(16.r),
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
            SizedBox(height: 16.h),

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
                  SizedBox(height: 8.h),
                  MPText(
                      'This card has overflow handling enabled for long content.'),
                  SizedBox(height: 8.h),
                  ...List.generate(
                      10,
                      (index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Row(
                              children: [
                                const Icon(Icons.circle, size: 8),
                                SizedBox(width: 8.w),
                                Expanded(
                                    child: MPText(
                                        'Content item ${index + 1} with some longer text to test overflow')),
                              ],
                            ),
                          )),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Responsive card
            MPCard.withSections(
              headerData: MPCardHeaderData(
                title: 'Responsive Card',
                subtitle: 'Adapts to screen size',
              ),
              body: Padding(
                padding: EdgeInsets.all(16.r),
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
                mobilePadding: EdgeInsets.all(12.r),
                tabletPadding: EdgeInsets.all(16.r),
                desktopPadding: EdgeInsets.all(20.r),
                mobileImageHeight: 160,
                tabletImageHeight: 200,
                desktopImageHeight: 240,
              ),
            ),
            SizedBox(height: 24.h),

            // Advanced Responsive Examples Section
            MPText.head('Advanced Responsive Features'),
            SizedBox(height: 16.h),

            // Responsive Grid Layout
            MPText.subhead('Responsive Grid Layout'),
            SizedBox(height: 8.h),
            MPCard.withSections(
              headerData: MPCardHeaderData(
                title: 'Grid Layout Card',
                subtitle: 'Automatically adjusts columns',
              ),
              body: Padding(
                padding: EdgeInsets.all(16.r),
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
            SizedBox(height: 16.h),

            // Responsive Media Card
            MPText.subhead('Responsive Media Card'),
            SizedBox(height: 8.h),
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
            SizedBox(height: 16.h),

            // Responsive Typography Card
            MPText.subhead('Responsive Typography Card'),
            SizedBox(height: 8.h),
            MPCard.content(
              contentData: MPCardContentData(
                title: 'Responsive Typography',
                subtitle: 'Scalable text sizes',
                description:
                    'This card demonstrates responsive typography that scales based on screen size for optimal readability.',
                icon: Icon(Icons.text_fields, color: context.mp.primary),
              ),
              responsive: MPCardResponsiveConfig(
                enableResponsiveTypography: true,
                mobileSize: MPCardSize.small,
                tabletSize: MPCardSize.medium,
                desktopSize: MPCardSize.large,
                mobilePadding: EdgeInsets.all(12.r),
                tabletPadding: EdgeInsets.all(16.r),
                desktopPadding: EdgeInsets.all(20.r),
              ),
            ),
            SizedBox(height: 16.h),

            // Responsive Constraints Card
            MPText.subhead('Responsive Constraints Card'),
            SizedBox(height: 8.h),
            MPCard.withSections(
              headerData: MPCardHeaderData(
                title: 'Responsive Constraints',
                subtitle: 'Screen-aware sizing',
              ),
              body: Padding(
                padding: EdgeInsets.all(16.r),
                child: MPText(
                    'This card demonstrates responsive constraints that adapt to available screen space.'),
              ),
              footerData: MPCardFooterData(
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('View Details'),
                  ),
                ],
              ),
              responsive: MPCardResponsiveConfig(
                mobileConstraints: BoxConstraints(
                  minWidth: 280,
                  maxWidth: 400,
                  minHeight: 200,
                ),
                tabletConstraints: BoxConstraints(
                  minWidth: 400,
                  maxWidth: 600,
                  minHeight: 250,
                ),
                desktopConstraints: BoxConstraints(
                  minWidth: 500,
                  maxWidth: 800,
                  minHeight: 300,
                ),
                mobileMaxWidth: 600,
                tabletMaxWidth: 1024,
              ),
            ),
            SizedBox(height: 24.h),

            // Elevation Examples Section
            MPText.head('Elevation Level Examples'),
            SizedBox(height: 16.h),

            // Different elevation levels
            Wrap(
              spacing: 16.w,
              runSpacing: 16.h,
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
            SizedBox(height: 24.h),

            // Use case-specific variants section
            _buildUseCaseVariants(context),
          ],
        ),
      ),
    );
  }

  /// New section for use case-specific variants
  Widget _buildUseCaseVariants(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        MPText.head('Use Case-Specific Variants'),
        SizedBox(height: 24.h),

        // Media Card Example
        MPText.subhead('Media Card'),
        SizedBox(height: 16.h),
        MPCard.media(
          mediaData: MPCardMediaData(
            imageUrl: 'https://picsum.photos/400/200',
            title: 'Beautiful Landscape',
            subtitle: 'Nature Photography',
            description:
                'A stunning view of mountains and lakes during golden hour, showcasing beauty of natural landscapes.',
            metadata: Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 16, color: context.mp.subtitleColor),
                SizedBox(width: 4.w),
                MPText.small('2 days ago', color: context.mp.subtitleColor),
                SizedBox(width: 16.w),
                Icon(Icons.favorite_border,
                    size: 16, color: context.mp.subtitleColor),
                SizedBox(width: 4.w),
                MPText.small('234', color: context.mp.subtitleColor),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('Share'),
              ),
              SizedBox(width: 8.w),
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
        SizedBox(height: 16.h),

        // Content Card Example
        MPText.subhead('Content Card'),
        SizedBox(height: 16.h),
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
        SizedBox(height: 16.h),

        // Product Card Example
        MPText.subhead('Product Card'),
        SizedBox(height: 16.h),
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
        SizedBox(height: 16.h),

        // Profile Card Example
        MPText.subhead('Profile Card'),
        SizedBox(height: 16.h),
        MPCard.profile(
          profileData: MPCardProfileData(
            name: 'Sarah Johnson',
            username: 'sarahj_design',
            bio:
                'UI/UX Designer passionate about creating beautiful and functional user experiences. Love working with emerging technologies.',
            avatarUrl: 'https://picsum.photos/100/100',
            showVerifiedBadge: true,
            isOnline: true,
            stats: {'Projects': '42', 'Followers': '1.2K', 'Following': '89'},
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
              SizedBox(width: 8.w),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Message'),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Notification Card Example
        MPText.subhead('Notification Card'),
        SizedBox(height: 16.h),
        MPCard.notification(
          notificationData: MPCardNotificationData(
            title: 'System Update',
            message:
                'A new system update is available. Install now to get latest features and security improvements.',
            timestamp: '5 minutes ago',
            iconData: Icons.system_update,
            iconColor: Colors.blue,
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('Dismiss'),
              ),
              SizedBox(width: 8.w),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Install'),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Dashboard Card Example
        MPText.subhead('Dashboard Card'),
        SizedBox(height: 16.h),
        MPCard.dashboard(
          dashboardData: MPCardDashboardData(
            title: 'Monthly Revenue',
            value: '24,568',
            unit: 'USD',
            subtitle: '12% increase from last month',
            showTrend: true,
            trend: '+12%',
            trendColor: Colors.green,
            icon: Icon(Icons.trending_up, color: Colors.green),
            chart: Container(
              height: 60.h,
              width: 100.w,
              child: const Placeholder(
                color: Colors.grey,
                strokeWidth: 1,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('View Details'),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Interaction States Section
        MPText.subhead('Interaction States'),
        SizedBox(height: 16.h),

        // Basic interaction config example
        MPText.small('Basic Hover, Press, and Disabled States'),
        SizedBox(height: 8.h),
        MPCard(
          variant: MPCardVariant.interactive,
          interactionConfig: MPCardInteractionConfig(
            hoverDuration: const Duration(milliseconds: 200),
            pressDuration: const Duration(milliseconds: 100),
            disabledOpacity: 0.38,
            pressedScale: 0.98,
            enableRipple: true,
            hoverColor: context.mp.primaryHover.withValues(alpha: 0.1),
            pressedColor: context.mp.primaryPressed.withValues(alpha: 0.1),
            onStateChanged: (state) {
              debugPrint('Interaction state changed to: $state');
            },
          ),
          onTap: () => _showSnackBar(context, 'Card tapped!'),
          onLongPress: () => _showSnackBar(context, 'Card long pressed!'),
          onHover: (isHovered) => debugPrint('Hover state: $isHovered'),
          body: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText.subhead('Interactive States Demo'),
                SizedBox(height: 8.h),
                MPText('This card demonstrates all interaction states:'),
                SizedBox(height: 8.h),
                MPText.small('• Hover over the card to see hover color'),
                MPText.small(
                    '• Press and hold to see pressed state with scale'),
                MPText.small('• Tap to see ripple effect'),
                MPText.small('• Long press for long press callback'),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Disabled state example
        Row(
          children: [
            Expanded(
              child: MPCard(
                variant: MPCardVariant.primary,
                interactionConfig: MPCardInteractionConfig(
                  disabledOpacity: 0.5,
                  enableRipple: false,
                ),
                enabled: false,
                body: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MPText.subhead('Disabled Card'),
                      SizedBox(height: 8.h),
                      MPText.small(
                          'This card is disabled with reduced opacity'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: MPCard(
                variant: MPCardVariant.primary,
                onTap: () => _showSnackBar(context, 'Enabled card tapped!'),
                body: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MPText.subhead('Enabled Card'),
                      SizedBox(height: 8.h),
                      MPText.small('This card is enabled for comparison'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Custom interaction colors
        MPText.small('Custom Interaction Colors'),
        SizedBox(height: 8.h),
        MPCard(
          variant: MPCardVariant.surface,
          interactionConfig: MPCardInteractionConfig(
            hoverColor: Colors.blue.withValues(alpha: 0.1),
            pressedColor: Colors.green.withValues(alpha: 0.1),
            rippleColor: Colors.orange.withValues(alpha: 0.3),
            pressedScale: 0.95,
            hoverDuration: const Duration(milliseconds: 300),
            pressDuration: const Duration(milliseconds: 150),
          ),
          onTap: () => _showSnackBar(context, 'Custom colors card tapped!'),
          body: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText.subhead('Custom Colors'),
                SizedBox(height: 8.h),
                MPText('This card uses custom interaction colors:'),
                SizedBox(height: 8.h),
                MPText.small('• Blue hover color'),
                MPText.small('• Green pressed color'),
                MPText.small('• Orange ripple effect'),
                MPText.small('• Custom scale and durations'),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // State change callbacks
        MPText.small('State Change Callbacks'),
        SizedBox(height: 8.h),
        MPCard(
          variant: MPCardVariant.elevated,
          interactionConfig: MPCardInteractionConfig(
            onStateChanged: (state) {
              String stateMessage;
              switch (state) {
                case MPCardInteractionState.normal:
                  stateMessage = 'Normal state';
                  break;
                case MPCardInteractionState.hover:
                  stateMessage = 'Hover state';
                  break;
                case MPCardInteractionState.pressed:
                  stateMessage = 'Pressed state';
                  break;
                case MPCardInteractionState.disabled:
                  stateMessage = 'Disabled state';
                  break;
                case MPCardInteractionState.focused:
                  stateMessage = 'Focused state';
                  break;
              }
              _showSnackBar(context, 'State: $stateMessage');
            },
          ),
          onTap: () {},
          body: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText.subhead('State Callbacks'),
                SizedBox(height: 8.h),
                MPText('This card shows state change callbacks'),
                SizedBox(height: 8.h),
                MPText.small('Interact with this card to see state changes'),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Media card with interaction config
        MPText.small('Media Card with Interaction Config'),
        SizedBox(height: 8.h),
        MPCard.mediaInteraction(
          mediaData: MPCardMediaData(
            imageUrl: 'https://picsum.photos/400/200',
            title: 'Interactive Media Card',
            subtitle: 'With custom interaction states',
            description:
                'This media card demonstrates interaction config with all the visual feedback features.',
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('Like'),
              ),
              SizedBox(width: 8.w),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Share'),
              ),
            ],
          ),
          interactionConfig: MPCardInteractionConfig(
            hoverDuration: const Duration(milliseconds: 250),
            pressDuration: const Duration(milliseconds: 120),
            pressedScale: 0.97,
            enableRipple: true,
            rippleColor: context.mp.primary.withValues(alpha: 0.4),
          ),
          onTap: () => _showSnackBar(
              context, 'Media card with interaction config tapped!'),
        ),
        SizedBox(height: 16.h),

        // Interactive Features Section
        MPText.subhead('Interactive Features'),
        SizedBox(height: 16.h),

        // Expandable Card Example
        MPText.small('Expandable Card'),
        SizedBox(height: 8.h),
        MPCard.content(
          contentData: MPCardContentData(
            title: 'Expandable Content',
            description:
                'This card can be expanded to show more content. Click button below to toggle.',
            icon: Icon(Icons.expand_more, color: context.mp.primary),
          ),
          interactiveConfig: MPCardInteractiveConfig(
            enableExpandable: true,
            initiallyExpanded: false,
            onExpand: () {
              _showSnackBar(context, 'Card expanded!');
            },
            onCollapse: () {
              _showSnackBar(context, 'Card collapsed!');
            },
          ),
        ),
        SizedBox(height: 16.h),

        // Quick Actions Card Example
        MPText.small('Quick Actions on Hover'),
        SizedBox(height: 8.h),
        MPCard.media(
          mediaData: MPCardMediaData(
            imageUrl: 'https://picsum.photos/400/200',
            title: 'Interactive Media Card',
            subtitle: 'Hover to see quick actions',
            description:
                'This card shows quick action buttons when you hover over it.',
          ),
          interactiveConfig: MPCardInteractiveConfig(
            enableQuickActions: true,
            quickActions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  _showSnackBar(context, 'Liked!');
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  _showSnackBar(context, 'Shared!');
                },
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {
                  _showSnackBar(context, 'Bookmarked!');
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Swipe-to-Dismiss Card Example
        MPText.small('Swipe-to-Dismiss Card'),
        SizedBox(height: 8.h),
        MPCard.notification(
          notificationData: MPCardNotificationData(
            title: 'Swipeable Notification',
            message: 'Swipe this card left or right to dismiss it.',
            timestamp: 'Just now',
            iconData: Icons.swipe,
            iconColor: context.mp.primary,
          ),
          interactiveConfig: MPCardInteractiveConfig(
            enableSwipeToDismiss: true,
            onSwipeLeft: () {
              _showSnackBar(context, 'Swiped left!');
            },
            onSwipeRight: () {
              _showSnackBar(context, 'Swiped right!');
            },
            onDismiss: () {
              _showSnackBar(context, 'Card dismissed!');
            },
          ),
        ),
      ],
    );
  }

  /// Get current theme icon from MPThemeManager
  IconData _getThemeIcon() {
    try {
      return MPThemeManager.instance.getThemeIcon();
    } catch (e) {
      debugPrint('Failed to get theme icon: $e');
      return Icons.settings_brightness; // Fallback
    }
  }

  /// Get current theme mode from MPThemeManager
  ThemeMode _getCurrentThemeMode() {
    try {
      return MPThemeManager.instance.themeMode;
    } catch (e) {
      debugPrint('Failed to get theme mode: $e');
      return ThemeMode.system; // Fallback
    }
  }

  /// Set theme mode using MPThemeManager
  Future<void> _setThemeMode(ThemeMode mode) async {
    try {
      await MPThemeManager.instance.setThemeMode(mode);
    } catch (e) {
      debugPrint('Failed to set theme mode: $e');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    MPSnackbar.show(
      context,
      message: message,
      duration: const Duration(seconds: 2),
    );
  }
}
