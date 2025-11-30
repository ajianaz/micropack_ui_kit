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
  bool isBookmarked1 = false;
  bool isBookmarked2 = true;
  int likeCount1 = 42;
  int likeCount2 = 128;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Card'),
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
              description: 'This is a small article card with image and basic content. Perfect for compact layouts.',
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
              onLike: () => setState(() {
                isLiked1 = !isLiked1;
                likeCount1 += isLiked1 ? 1 : -1;
              }),
              onBookmark: () => setState(() => isBookmarked1 = !isBookmarked1),
              onShare: () => _showSnackBar(context, 'Article shared!'),
            ),
            
            SizedBox(height: 16.h),
            
            // Medium Card with Outlined Variant
            MPArticleCard(
              title: 'Medium Outlined Article Card',
              description: 'This is a medium-sized article card with outlined variant. It includes metadata and action buttons for better user engagement.',
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
              description: 'This is a large article card with elevated variant. It showcases all available features including image, metadata, tags, and action buttons. Perfect for featured content or highlight sections.',
              imageUrl: 'https://picsum.photos/800/400',
              author: 'Michael Johnson',
              date: 'Nov 26, 2024',
              readTime: '12 min read',
              category: 'Development',
              tags: ['programming', 'flutter', 'best-practices', 'architecture'],
              size: MPArticleCardSize.large,
              variant: MPArticleCardVariant.elevated,
              isLiked: false,
              isBookmarked: false,
              likeCount: 256,
              onLike: () => _showSnackBar(context, 'Article liked!'),
              onBookmark: () => _showSnackBar(context, 'Article bookmarked!'),
              onShare: () => _showSnackBar(context, 'Article shared!'),
            ),
            
            SizedBox(height: 16.h),
            
            // Card without image
            MPArticleCard(
              title: 'Article Card Without Image',
              description: 'This card demonstrates how article cards look without images. Focus is on the text content and metadata.',
              author: 'Sarah Williams',
              date: 'Nov 25, 2024',
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
            
            // Card with custom action buttons
            MPArticleCard(
              title: 'Article Card with Custom Actions',
              description: 'This card demonstrates custom action buttons in addition to the default ones.',
              imageUrl: 'https://picsum.photos/500/250',
              author: 'Alex Brown',
              date: 'Nov 24, 2024',
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
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MPText(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
