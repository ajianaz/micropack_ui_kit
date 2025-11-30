import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

enum MPArticleCardVariant {
  standard,
  elevated,
  outlined,
}

enum MPArticleCardSize {
  small,
  medium,
  large,
}

class MPArticleCard extends StatelessWidget {
  const MPArticleCard({
    required this.title,
    super.key,
    this.description,
    this.imageUrl,
    this.imageWidget,
    this.author,
    this.date,
    this.readTime,
    this.onTap,
    this.onLike,
    this.onBookmark,
    this.onShare,
    this.category,
    this.tags,
    this.variant = MPArticleCardVariant.standard,
    this.size = MPArticleCardSize.medium,
    this.isLiked = false,
    this.isBookmarked = false,
    this.likeCount = 0,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.elevation,
    this.actionButtons,
  });

  final String title;
  final String? description;
  final String? imageUrl;
  final Widget? imageWidget;
  final String? author;
  final String? date;
  final String? readTime;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final VoidCallback? onBookmark;
  final VoidCallback? onShare;
  final String? category;
  final List<String>? tags;
  final MPArticleCardVariant variant;
  final MPArticleCardSize size;
  final bool isLiked;
  final bool isBookmarked;
  final int likeCount;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final Color? backgroundColor;
  final double? elevation;
  final List<Widget>? actionButtons;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorTheme = theme.extension<MPColorTheme>()!;

    return Container(
      margin: margin ?? _getDefaultMargin(),
      child: Material(
        color: _getBackgroundColor(colorTheme, context),
        borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        elevation: elevation ?? _getElevation(),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          child: Container(
            padding: padding ?? _getDefaultPadding(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
              border: variant == MPArticleCardVariant.outlined
                  ? Border.all(color: context.mp.adaptiveBorderColor)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_hasImage()) ...[
                  _buildImage(),
                  SizedBox(height: _getSpacing()),
                ],
                if (category != null) ...[
                  _buildCategory(category!),
                  SizedBox(height: _getSpacing() / 2),
                ],
                _buildTitle(),
                if (description != null) ...[
                  SizedBox(height: _getSpacing() / 2),
                  _buildDescription(),
                ],
                if (author != null || date != null || readTime != null) ...[
                  SizedBox(height: _getSpacing()),
                  _buildMetadata(context),
                ],
                if (tags != null && tags!.isNotEmpty) ...[
                  SizedBox(height: _getSpacing()),
                  _buildTags(),
                ],
                if (_hasActions()) ...[
                  SizedBox(height: _getSpacing()),
                  _buildActions(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imageWidget != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: _getImageHeight(),
          ),
          child: imageWidget!,
        ),
      );
    }

    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.network(
          imageUrl!,
          width: double.infinity,
          height: _getImageHeight(),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: double.infinity,
              height: _getImageHeight(),
              color: Colors.grey.shade200,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: double.infinity,
      height: _getImageHeight(),
      color: Colors.grey.shade200,
      child: Icon(
        Icons.image_not_supported,
        size: 40.r,
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _buildCategory(String category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: MpUiKit.colorBrand.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: MPText(
        category,
        style: MPTextStyle.body2(
          color: MpUiKit.colorBrand,
          fontWeight: FontWeight.w500,
        ).copyWith(fontSize: (_getFontSize() - 4).sp),
      ),
    );
  }

  Widget _buildTitle() {
    return MPText(
      title,
      maxLines: size == MPArticleCardSize.small ? 2 : 3,
      style: MPTextStyle.heading3(
        color: MpUiKit.colorText,
        fontWeight: FontWeight.bold,
      ).copyWith(fontSize: (_getFontSize() + 2).sp),
    );
  }

  Widget _buildDescription() {
    return MPText(
      description!,
      maxLines: size == MPArticleCardSize.small ? 2 : 3,
      style: MPTextStyle.body2(
        color: MpUiKit.colorText.withValues(alpha: 0.7),
      ).copyWith(fontSize: (_getFontSize() - 2).sp),
    );
  }

  Widget _buildMetadata(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 4.h,
      children: [
        if (author != null) ...[
          Icon(
            Icons.person,
            size: 14.r,
            color: context.mp.captionColor,
          ),
          SizedBox(width: 4.w),
          MPText(
            author!,
            style: MPTextStyle.caption(
              color: context.mp.captionColor,
            ).copyWith(fontSize: (_getFontSize() - 4).sp),
          ),
        ],
        if (date != null) ...[
          Icon(
            Icons.calendar_today,
            size: 14.r,
            color: context.mp.captionColor,
          ),
          SizedBox(width: 4.w),
          MPText(
            date!,
            style: MPTextStyle.caption(
              color: context.mp.captionColor,
            ).copyWith(fontSize: (_getFontSize() - 4).sp),
          ),
        ],
        if (readTime != null) ...[
          Icon(
            Icons.access_time,
            size: 14.r,
            color: context.mp.captionColor,
          ),
          SizedBox(width: 4.w),
          MPText(
            readTime!,
            style: MPTextStyle.caption(
              color: context.mp.captionColor,
            ).copyWith(fontSize: (_getFontSize() - 4).sp),
          ),
        ],
      ],
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 6.w,
      runSpacing: 4.h,
      children: tags!.map((tag) => _buildTag(tag)).toList(),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: MPText(
        tag,
        style: MPTextStyle.caption(
          color: Colors.grey.shade700,
        ).copyWith(fontSize: (_getFontSize() - 6).sp),
      ),
    );
  }

  Widget _buildActions() {
    final actions = <Widget>[];

    if (onLike != null) {
      actions.add(
        MPButton(
          text: '$likeCount',
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            size: 18.r,
            color: isLiked ? Colors.red : MpUiKit.colorText.withValues(alpha: 0.6),
          ),
          onPressed: onLike,
          background: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          textSize: _getFontSize() - 4.sp,
          textColor: MpUiKit.colorText.withValues(alpha: 0.6),
        ),
      );
    }

    if (onBookmark != null) {
      actions.add(
        MPButton(
          text: '',
          child: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            size: 18.r,
            color: MpUiKit.colorText.withValues(alpha: 0.6),
          ),
          onPressed: onBookmark,
          background: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        ),
      );
    }

    if (onShare != null) {
      actions.add(
        MPButton(
          text: '',
          child: Icon(
            Icons.share,
            size: 18.r,
            color: MpUiKit.colorText.withValues(alpha: 0.6),
          ),
          onPressed: onShare,
          background: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        ),
      );
    }

    // Add custom action buttons
    if (actionButtons != null) {
      actions.addAll(actionButtons!);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        Row(
          children: actions,
        ),
      ],
    );
  }

  // Helper methods
  bool _hasImage() => imageUrl != null || imageWidget != null;
  bool _hasActions() => onLike != null || onBookmark != null || onShare != null || (actionButtons != null && actionButtons!.isNotEmpty);

  double _getFontSize() {
    switch (size) {
      case MPArticleCardSize.small:
        return 12;
      case MPArticleCardSize.medium:
        return 14;
      case MPArticleCardSize.large:
        return 16;
    }
  }

  double _getSpacing() {
    switch (size) {
      case MPArticleCardSize.small:
        return 8.h;
      case MPArticleCardSize.medium:
        return 12.h;
      case MPArticleCardSize.large:
        return 16.h;
    }
  }

  double _getImageHeight() {
    switch (size) {
      case MPArticleCardSize.small:
        return 120.h;
      case MPArticleCardSize.medium:
        return 180.h;
      case MPArticleCardSize.large:
        return 240.h;
    }
  }

  EdgeInsets _getDefaultPadding() {
    switch (size) {
      case MPArticleCardSize.small:
        return EdgeInsets.all(12.r);
      case MPArticleCardSize.medium:
        return EdgeInsets.all(16.r);
      case MPArticleCardSize.large:
        return EdgeInsets.all(20.r);
    }
  }

  EdgeInsets _getDefaultMargin() {
    switch (size) {
      case MPArticleCardSize.small:
        return EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h);
      case MPArticleCardSize.medium:
        return EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h);
      case MPArticleCardSize.large:
        return EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h);
    }
  }

  Color _getBackgroundColor(MPColorTheme colorTheme, BuildContext context) {
    if (backgroundColor != null) return backgroundColor!;
    
    // Use theme-aware colors for better dark mode support
    switch (variant) {
      case MPArticleCardVariant.standard:
        return context.mp.adaptiveBackgroundColor;
      case MPArticleCardVariant.elevated:
        return context.mp.adaptiveBackgroundColor;
      case MPArticleCardVariant.outlined:
        return context.mp.adaptiveBackgroundColor;
    }
  }

  double _getElevation() {
    if (elevation != null) return elevation!;
    
    switch (variant) {
      case MPArticleCardVariant.standard:
        return 0;
      case MPArticleCardVariant.elevated:
        return 4;
      case MPArticleCardVariant.outlined:
        return 0;
    }
  }


}
