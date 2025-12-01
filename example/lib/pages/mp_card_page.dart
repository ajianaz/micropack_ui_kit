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
