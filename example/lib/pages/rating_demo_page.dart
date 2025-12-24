import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class RatingDemoPage extends StatefulWidget {
  const RatingDemoPage({super.key});

  @override
  State<RatingDemoPage> createState() => _RatingDemoPageState();
}

class _RatingDemoPageState extends State<RatingDemoPage> {
  // Variant ratings
  double _starsRating = 3.5;
  double _heartsRating = 4.0;
  double _thumbsRating = 2.5;

  // Size ratings
  double _smallRating = 4.0;
  double _mediumRating = 3.5;
  double _largeRating = 4.5;
  double _extraLargeRating = 5.0;

  // Interactive ratings
  double _interactiveRating = 3.5;
  double _readOnlyRating = 4.0;

  // Custom star count
  double _threeStars = 2.0;
  double _sevenStars = 5.0;
  double _tenStars = 7.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Rating Bar Demo',
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
            _buildStarCounts(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildStates(context),
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
          'Rating Variants',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _RatingCard(
          title: 'Stars',
          description: 'Star rating icons',
          rating: _starsRating,
          child: MPRatingBar(
            rating: _starsRating,
            variant: MPRatingVariant.stars,
            onRatingChanged: (rating) => setState(() => _starsRating = rating),
          ),
        ),
        SizedBox(height: 16),
        _RatingCard(
          title: 'Hearts',
          description: 'Heart rating icons',
          rating: _heartsRating,
          child: MPRatingBar(
            rating: _heartsRating,
            variant: MPRatingVariant.hearts,
            onRatingChanged: (rating) => setState(() => _heartsRating = rating),
          ),
        ),
        SizedBox(height: 16),
        _RatingCard(
          title: 'Thumbs Up',
          description: 'Thumb rating icons',
          rating: _thumbsRating,
          child: MPRatingBar(
            rating: _thumbsRating,
            variant: MPRatingVariant.thumbs,
            onRatingChanged: (rating) => setState(() => _thumbsRating = rating),
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
          'Rating Sizes',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _RatingCard(
          title: 'Small',
          description: 'Compact size rating (16px)',
          rating: _smallRating,
          child: MPRatingBar(
            rating: _smallRating,
            size: MPRatingSize.small,
            onRatingChanged: (rating) => setState(() => _smallRating = rating),
          ),
        ),
        SizedBox(height: 16),
        _RatingCard(
          title: 'Medium',
          description: 'Default medium size (24px)',
          rating: _mediumRating,
          child: MPRatingBar(
            rating: _mediumRating,
            size: MPRatingSize.medium,
            onRatingChanged: (rating) => setState(() => _mediumRating = rating),
          ),
        ),
        SizedBox(height: 16),
        _RatingCard(
          title: 'Large',
          description: 'Prominent large size (32px)',
          rating: _largeRating,
          child: MPRatingBar(
            rating: _largeRating,
            size: MPRatingSize.large,
            onRatingChanged: (rating) => setState(() => _largeRating = rating),
          ),
        ),
        SizedBox(height: 16),
        _RatingCard(
          title: 'Extra Large',
          description: 'Extra large size (48px)',
          rating: _extraLargeRating,
          child: MPRatingBar(
            rating: _extraLargeRating,
            size: MPRatingSize.extraLarge,
            onRatingChanged: (rating) => setState(() => _extraLargeRating = rating),
          ),
        ),
      ],
    );
  }

  Widget _buildStarCounts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Star Counts',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _RatingCard(
          title: '3 Stars',
          description: 'Rating with 3 stars',
          rating: _threeStars,
          child: MPRatingBar(
            rating: _threeStars,
            starCount: 3,
            onRatingChanged: (rating) => setState(() => _threeStars = rating),
          ),
        ),
        SizedBox(height: 16),
        _RatingCard(
          title: '7 Stars',
          description: 'Rating with 7 stars',
          rating: _sevenStars,
          child: MPRatingBar(
            rating: _sevenStars,
            starCount: 7,
            onRatingChanged: (rating) => setState(() => _sevenStars = rating),
          ),
        ),
        SizedBox(height: 16),
        _RatingCard(
          title: '10 Stars',
          description: 'Rating with 10 stars',
          rating: _tenStars,
          child: MPRatingBar(
            rating: _tenStars,
            starCount: 10,
            onRatingChanged: (rating) => setState(() => _tenStars = rating),
          ),
        ),
      ],
    );
  }

  Widget _buildStates(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Rating States',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _RatingCard(
          title: 'Interactive',
          description: 'Tap to set rating',
          rating: _interactiveRating,
          child: MPRatingBar(
            rating: _interactiveRating,
            onRatingChanged: (rating) => setState(() => _interactiveRating = rating),
          ),
        ),
        SizedBox(height: 16),
        _RatingCard(
          title: 'Read Only',
          description: 'Display-only rating',
          rating: _readOnlyRating,
          child: MPRatingBar(
            rating: _readOnlyRating,
            readOnly: true,
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
          title: 'Product Rating',
          description: 'Customer product rating with review count',
          subtitle: 'Based on 128 reviews',
          icon: Icons.shopping_bag,
          rating: 4.5,
          ratingCount: 128,
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Service Feedback',
          description: 'Service quality feedback',
          subtitle: 'How was your experience?',
          icon: Icons.support_agent,
          rating: 3.5,
          variant: MPRatingVariant.hearts,
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Skill Level',
          description: 'User skill assessment',
          subtitle: 'Beginner to Expert',
          icon: Icons.school,
          rating: 2.0,
          variant: MPRatingVariant.thumbs,
          starCount: 3,
        ),
      ],
    );
  }

  Widget _RatingCard({
    required String title,
    required String description,
    required double rating,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MPText.head(
                title,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              MPText.label(
                '${rating.toStringAsFixed(1)}',
                style: TextStyle(
                  color: context.mp.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
    required String title,
    required String description,
    required String subtitle,
    required IconData icon,
    required double rating,
    int? ratingCount,
    MPRatingVariant variant = MPRatingVariant.stars,
    int starCount = 5,
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
        boxShadow: [
          BoxShadow(
            color: context.mp.adaptiveShadowColor.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.mp.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: context.mp.primary, size: 20),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPText.head(title, fontSize: 16),
                    SizedBox(height: 2),
                    MPText.label(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.mp.subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          MPRatingBar(
            rating: rating,
            variant: variant,
            starCount: starCount,
            readOnly: true,
          ),
          if (ratingCount != null) ...[
            SizedBox(height: 4),
            MPText.label(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: context.mp.captionColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
