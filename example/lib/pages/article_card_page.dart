import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ArticleCardPage extends StatefulWidget {
  const ArticleCardPage({super.key});

  @override
  State<ArticleCardPage> createState() => _ArticleCardPageState();
}

class _ArticleCardPageState extends State<ArticleCardPage> {
  bool isLiked1 = false;
  bool isLiked2 = true;
  bool isLiked3 = false;
  bool isBookmarked1 = false;
  bool isBookmarked2 = true;
  bool isBookmarked3 = false;
  int likeCount1 = 42;
  int likeCount2 = 128;
  int likeCount3 = 256;
  bool isHovered = false;

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
        title: Text(
          'Article Card',
          style: TextStyle(color: context.mp.textColor),
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
            MPText.head('Article Card Variants'),
            SizedBox(height: 16.h),

            // Small Card
            MPArticleCard(
              title: 'Small Article Card with Image',
              description:
                  'This is a small article card with image and basic content. Perfect for compact layouts.',
              imageUrl: 'https://picsum.photos/400/200',
              author: 'John Doe',
              date: 'Nov 28, 2024',
              readTime: '5 min read',
              category: 'Technology',
              tags: ['flutter', 'ui', 'design'],
              size: MPArticleCardSize.small,
              variant: MPArticleCardVariant.standard,
              isLiked: isLiked1,
              isBookmarked: isBookmarked1,
              likeCount: likeCount1,
              onTap: () => _showSnackBar(
                  context, 'Opening article: Small Article Card with Image'),
              onLike: () => setState(() {
                isLiked1 = !isLiked1;
                likeCount1 += isLiked1 ? 1 : -1;
              }),
              onBookmark: () => setState(() => isBookmarked1 = !isBookmarked1),
              onShare: () => _showSnackBar(context, 'Article shared!'),
              onHover: (hovered) => setState(() => isHovered = hovered),
            ),

            SizedBox(height: 16.h),

            // Medium Card with Outlined Variant
            MPArticleCard(
              title: 'Medium Outlined Article Card',
              description:
                  'This is a medium-sized article card with outlined variant. It includes metadata and action buttons for better user engagement.',
              imageUrl: 'https://picsum.photos/600/300',
              author: 'Jane Smith',
              date: 'Nov 27, 2024',
              readTime: '8 min read',
              category: 'Design',
              tags: ['ux', 'interface', 'mobile'],
              size: MPArticleCardSize.medium,
              variant: MPArticleCardVariant.outlined,
              isLiked: isLiked2,
              isBookmarked: isBookmarked2,
              likeCount: likeCount2,
              onTap: () => _showSnackBar(
                  context, 'Opening article: Medium Outlined Article Card'),
              onLike: () => setState(() {
                isLiked2 = !isLiked2;
                likeCount2 += isLiked2 ? 1 : -1;
              }),
              onBookmark: () => setState(() => isBookmarked2 = !isBookmarked2),
              onShare: () => _showSnackBar(context, 'Article shared!'),
            ),

            SizedBox(height: 16.h),

            // Large Elevated Card
            MPArticleCard(
              title: 'Large Elevated Article Card with Comprehensive Content',
              description:
                  'This is a large article card with elevated variant. It showcases all available features including image, metadata, tags, and action buttons. Perfect for featured content or highlight sections.',
              imageUrl: 'https://picsum.photos/800/400',
              author: 'Michael Johnson',
              date: 'Nov 26, 2024',
              readTime: '12 min read',
              category: 'Development',
              tags: [
                'programming',
                'flutter',
                'best-practices',
                'architecture'
              ],
              size: MPArticleCardSize.large,
              variant: MPArticleCardVariant.elevated,
              isLiked: isLiked3,
              isBookmarked: isBookmarked3,
              likeCount: likeCount3,
              onTap: () => _showSnackBar(context,
                  'Opening article: Large Elevated Article Card with Comprehensive Content'),
              onLike: () => setState(() {
                isLiked3 = !isLiked3;
                likeCount3 += isLiked3 ? 1 : -1;
              }),
              onBookmark: () => setState(() => isBookmarked3 = !isBookmarked3),
              onShare: () => _showSnackBar(context, 'Article shared!'),
            ),

            SizedBox(height: 24.h),
            MPText.head('Interaction States'),
            SizedBox(height: 16.h),

            // Disabled Card
            MPArticleCard(
              title: 'Disabled Article Card',
              description:
                  'This card is disabled and cannot be interacted with. All interactions are blocked.',
              imageUrl: 'https://picsum.photos/600/300',
              author: 'Disabled User',
              date: 'Nov 25, 2024',
              readTime: '7 min read',
              category: 'Disabled',
              tags: ['disabled', 'demo'],
              size: MPArticleCardSize.medium,
              variant: MPArticleCardVariant.standard,
              enabled: false,
              isLiked: false,
              isBookmarked: false,
              likeCount: 999,
            ),

            SizedBox(height: 16.h),

            // Card with custom colors
            MPArticleCard(
              title: 'Card with Custom Colors',
              description:
                  'This card demonstrates custom hover and highlight colors for brand consistency.',
              imageUrl: 'https://picsum.photos/600/300',
              author: 'Custom Colors',
              date: 'Nov 24, 2024',
              readTime: '9 min read',
              category: 'Customization',
              tags: ['colors', 'brand', 'custom'],
              size: MPArticleCardSize.medium,
              variant: MPArticleCardVariant.elevated,
              hoverColor: context.mp.primary.withValues(alpha: 0.15),
              highlightColor: context.mp.primary.withValues(alpha: 0.25),
              isLiked: false,
              isBookmarked: false,
              likeCount: 777,
              onLike: () => _showSnackBar(context, 'Custom like action!'),
              onBookmark: () =>
                  _showSnackBar(context, 'Custom bookmark action!'),
              onShare: () => _showSnackBar(context, 'Custom share action!'),
            ),

            SizedBox(height: 24.h),
            MPText.head('Special Cases'),
            SizedBox(height: 16.h),

            // Card without image
            MPArticleCard(
              title: 'Article Card Without Image',
              description:
                  'This card demonstrates how article cards look without images. Focus is on text content and metadata.',
              author: 'Sarah Williams',
              date: 'Nov 23, 2024',
              readTime: '6 min read',
              category: 'Tutorial',
              tags: ['guide', 'learning'],
              size: MPArticleCardSize.medium,
              variant: MPArticleCardVariant.standard,
              isLiked: false,
              isBookmarked: false,
              likeCount: 89,
              onLike: () => _showSnackBar(context, 'Article liked!'),
              onBookmark: () => _showSnackBar(context, 'Article bookmarked!'),
              onShare: () => _showSnackBar(context, 'Article shared!'),
            ),

            SizedBox(height: 16.h),

            // Card with custom widget image
            MPArticleCard(
              title: 'Card with Custom Widget Image',
              description:
                  'This card uses a custom widget instead of a network image. Perfect for placeholders or custom graphics.',
              imageWidget: Container(
                height: 180.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.mp.primary,
                      context.mp.primary.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 60.r,
                    color: context.mp.neutral100,
                  ),
                ),
              ),
              author: 'Custom Widget',
              date: 'Nov 22, 2024',
              readTime: '4 min read',
              category: 'Customization',
              tags: ['widget', 'custom', 'gradient'],
              size: MPArticleCardSize.medium,
              variant: MPArticleCardVariant.elevated,
              isLiked: false,
              isBookmarked: false,
              likeCount: 456,
              onLike: () => _showSnackBar(context, 'Custom widget liked!'),
              onBookmark: () =>
                  _showSnackBar(context, 'Custom widget bookmarked!'),
              onShare: () => _showSnackBar(context, 'Custom widget shared!'),
            ),

            SizedBox(height: 16.h),

            // Card with custom action buttons
            MPArticleCard(
              title: 'Card with Custom Actions',
              description:
                  'This card demonstrates custom action buttons in addition to default ones.',
              imageUrl: 'https://picsum.photos/500/250',
              author: 'Alex Brown',
              date: 'Nov 21, 2024',
              readTime: '10 min read',
              category: 'Innovation',
              tags: ['future', 'tech'],
              size: MPArticleCardSize.medium,
              variant: MPArticleCardVariant.elevated,
              isLiked: false,
              isBookmarked: false,
              likeCount: 156,
              onLike: () => _showSnackBar(context, 'Article liked!'),
              actionButtons: [
                MPButton(
                  text: 'Read More',
                  onPressed: () => _showSnackBar(context, 'Opening article...'),
                  textSize: 12.sp,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                ),
                MPButton(
                  text: 'Save',
                  variant: MPButtonVariant.outlined,
                  onPressed: () => _showSnackBar(context, 'Article saved!'),
                  textSize: 12.sp,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                ),
              ],
            ),

            SizedBox(height: 24.h),
            MPText.head('Accessibility Features'),
            SizedBox(height: 16.h),

            // Card with semantic label
            MPArticleCard(
              title: 'Card with Accessibility Features',
              description:
                  'This card includes semantic labels for screen readers and proper accessibility support.',
              imageUrl: 'https://picsum.photos/600/300',
              author: 'Accessibility Demo',
              date: 'Nov 20, 2024',
              readTime: '8 min read',
              category: 'Accessibility',
              tags: ['a11y', 'screen-reader', 'inclusive'],
              size: MPArticleCardSize.medium,
              variant: MPArticleCardVariant.standard,
              semanticLabel:
                  'Article about accessibility features in Flutter UI components, published on Nov 20, 2024',
              isLiked: false,
              isBookmarked: false,
              likeCount: 123,
              onLike: () =>
                  _showSnackBar(context, 'Accessibility article liked!'),
              onBookmark: () =>
                  _showSnackBar(context, 'Accessibility article bookmarked!'),
              onShare: () =>
                  _showSnackBar(context, 'Accessibility article shared!'),
            ),

            SizedBox(height: 16.h),

            // Status indicator
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: context.mp.neutral20,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MPText.subhead('Interactive Status'),
                  SizedBox(height: 8.h),
                  MPText.body(
                      'Hovering over card: ${isHovered ? "Yes" : "No"}'),
                  SizedBox(height: 4.h),
                  MPText.small(
                      'Try hovering over the first card to see the interaction state change.'),
                ],
              ),
            ),
          ],
        ),
      ),
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
