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

class MPArticleCard extends StatefulWidget {
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
    this.enabled = true,
    this.semanticLabel,
    this.onHover,
    this.focusNode,
    this.autofocus = false,
    this.cursor,
    this.hoverColor,
    this.splashColor,
    this.focusColor,
    this.highlightColor,
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
  final bool enabled;
  final String? semanticLabel;
  final ValueChanged<bool>? onHover;
  final FocusNode? focusNode;
  final bool autofocus;
  final MouseCursor? cursor;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? focusColor;
  final Color? highlightColor;

  @override
  State<MPArticleCard> createState() => _MPArticleCardState();
}

class _MPArticleCardState extends State<MPArticleCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel ?? _buildSemanticLabel(),
      button: widget.onTap != null,
      enabled: widget.enabled,
      child: Container(
        margin: widget.margin ?? _getDefaultMargin(),
        child: Material(
          color: _getBackgroundColor(context),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
          elevation: widget.elevation ?? _getElevation(),
          child: MouseRegion(
            onEnter: (_) {
              if (widget.enabled) {
                setState(() => _isHovered = true);
                widget.onHover?.call(true);
              }
            },
            onExit: (_) {
              if (widget.enabled) {
                setState(() => _isHovered = false);
                widget.onHover?.call(false);
              }
            },
            child: GestureDetector(
              onTap: widget.enabled ? widget.onTap : null,
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: widget.padding ?? _getDefaultPadding(),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 12.r),
                  border: widget.variant == MPArticleCardVariant.outlined
                      ? Border.all(color: context.mp.adaptiveBorderColor)
                      : null,
                  color: _getInteractionBackgroundColor(context),
                  boxShadow: _getBoxShadow(context),
                ),
                child: Focus(
                  focusNode: widget.focusNode,
                  autofocus: widget.autofocus,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_hasImage()) ...[
                        _buildImage(),
                        SizedBox(height: _getSpacing()),
                      ],
                      if (widget.category != null) ...[
                        _buildCategory(widget.category!),
                        SizedBox(height: _getSpacing() / 2),
                      ],
                      _buildTitle(),
                      if (widget.description != null) ...[
                        SizedBox(height: _getSpacing() / 2),
                        _buildDescription(),
                      ],
                      if (widget.author != null ||
                          widget.date != null ||
                          widget.readTime != null) ...[
                        SizedBox(height: _getSpacing()),
                        _buildMetadata(context),
                      ],
                      if (widget.tags != null && widget.tags!.isNotEmpty) ...[
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
          ),
        ),
      ),
    );
  }

  // Helper methods for new functionality
  String _buildSemanticLabel() {
    final parts = <String>[];
    if (widget.category != null) parts.add('Category: ${widget.category}');
    parts.add('Title: ${widget.title}');
    if (widget.description != null)
      parts.add('Description: ${widget.description}');
    if (widget.author != null) parts.add('Author: ${widget.author}');
    if (widget.date != null) parts.add('Date: ${widget.date}');
    if (widget.readTime != null) parts.add('Read time: ${widget.readTime}');
    if (widget.likeCount > 0) parts.add('${widget.likeCount} likes');
    if (widget.isLiked) parts.add('Liked');
    if (widget.isBookmarked) parts.add('Bookmarked');
    return parts.join(', ');
  }

  Color _getInteractionBackgroundColor(BuildContext context) {
    // Theme-aware interaction background color
    if (!widget.enabled) {
      // Use muted background for disabled state
      // Dark mode: neutral80 (dark) with reduced opacity
      // Light mode: neutral20 (light) with reduced opacity
      return context.mp.isDarkMode
          ? context.mp.neutral80.withValues(alpha: 0.5)
          : context.mp.neutral20.withValues(alpha: 0.5);
    }

    if (_isPressed) {
      final highlightColor = widget.highlightColor;
      if (highlightColor != null) {
        return highlightColor;
      }

      // Use theme-aware hover color for pressed state
      // Dark mode: neutral60 (medium gray) - clear pressed feedback
      // Light mode: neutral40 (medium-light gray) - clear pressed feedback
      return context.mp.isDarkMode
          ? context.mp.neutral60
          : context.mp.neutral40;
    }

    if (_isHovered) {
      final hoverColor = widget.hoverColor;
      if (hoverColor != null) {
        return hoverColor;
      }

      // Use theme-aware hover color with clear visual distinction
      // Dark mode: neutral70 (medium-dark gray) - clear but subtle
      // Light mode: neutral30 (light gray) - more visible than neutral20
      return context.mp.isDarkMode
          ? context.mp.neutral70
          : context.mp.neutral30;
    }

    return _getBackgroundColor(context);
  }

  List<BoxShadow> _getBoxShadow(BuildContext context) {
    if (widget.variant == MPArticleCardVariant.elevated) {
      return [
        BoxShadow(
          // Use theme-aware shadow color for better visibility in both modes
          color: context.mp.adaptiveShadowColor,
          blurRadius: _isHovered ? 8 : 4,
          offset: Offset(0, _isHovered ? 4 : 2),
        ),
      ];
    }
    return [];
  }

  Widget _buildImage() {
    if (widget.imageWidget != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: _getImageHeight(),
          ),
          child: widget.imageWidget!,
        ),
      );
    }

    if (widget.imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.network(
          widget.imageUrl!,
          width: double.infinity,
          height: _getImageHeight(),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildImagePlaceholder(),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: double.infinity,
              height: _getImageHeight(),
              // Use theme-aware neutral color for loading background
              color: context.mp.neutral30,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  // Use theme-aware primary color for progress indicator
                  color: context.mp.primary,
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
      // Use theme-aware neutral color for placeholder background
      color: context.mp.neutral30,
      child: Icon(
        Icons.image_not_supported,
        size: 40.r,
        // Use theme-aware caption color for placeholder icon
        color: context.mp.captionColor,
      ),
    );
  }

  Widget _buildCategory(String category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        // Use theme-aware primary color with opacity for category background
        color: context.mp.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: MPText(
        category,
        style: MPTextStyle.body2(
          // Use theme-aware primary color for category text
          color: context.mp.primary,
          fontWeight: FontWeight.w500,
        ).copyWith(fontSize: (_getFontSize() - 4).sp),
      ),
    );
  }

  Widget _buildTitle() {
    return MPText(
      widget.title,
      maxLines: widget.size == MPArticleCardSize.small ? 2 : 3,
      style: MPTextStyle.heading3(
        color: widget.enabled
            ? context.mp.textColor
            : context.mp.textColor.withValues(alpha: 0.4),
        fontWeight: FontWeight.bold,
      ).copyWith(fontSize: (_getFontSize() + 2).sp),
    );
  }

  Widget _buildDescription() {
    return MPText(
      widget.description!,
      maxLines: widget.size == MPArticleCardSize.small ? 2 : 3,
      style: MPTextStyle.body2(
        color: widget.enabled
            ? context.mp.textColor.withValues(alpha: 0.7)
            : context.mp.textColor.withValues(alpha: 0.3),
      ).copyWith(fontSize: (_getFontSize() - 2).sp),
    );
  }

  Widget _buildMetadata(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 4.h,
      children: [
        if (widget.author != null) ...[
          Icon(
            Icons.person,
            size: 14.r,
            color: widget.enabled
                ? context.mp.captionColor
                : context.mp.captionColor.withValues(alpha: 0.4),
          ),
          SizedBox(width: 4.w),
          MPText(
            widget.author!,
            style: MPTextStyle.caption(
              color: widget.enabled
                  ? context.mp.captionColor
                  : context.mp.captionColor.withValues(alpha: 0.4),
            ).copyWith(fontSize: (_getFontSize() - 4).sp),
          ),
        ],
        if (widget.date != null) ...[
          Icon(
            Icons.calendar_today,
            size: 14.r,
            color: widget.enabled
                ? context.mp.captionColor
                : context.mp.captionColor.withValues(alpha: 0.4),
          ),
          SizedBox(width: 4.w),
          MPText(
            widget.date!,
            style: MPTextStyle.caption(
              color: widget.enabled
                  ? context.mp.captionColor
                  : context.mp.captionColor.withValues(alpha: 0.4),
            ).copyWith(fontSize: (_getFontSize() - 4).sp),
          ),
        ],
        if (widget.readTime != null) ...[
          Icon(
            Icons.access_time,
            size: 14.r,
            color: widget.enabled
                ? context.mp.captionColor
                : context.mp.captionColor.withValues(alpha: 0.4),
          ),
          SizedBox(width: 4.w),
          MPText(
            widget.readTime!,
            style: MPTextStyle.caption(
              color: widget.enabled
                  ? context.mp.captionColor
                  : context.mp.captionColor.withValues(alpha: 0.4),
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
      children: widget.tags!.map((tag) => _buildTag(tag)).toList(),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        // Use theme-aware neutral color for tag background
        // Enabled state: neutral20, Disabled state: neutral30 with opacity
        color: widget.enabled
            ? context.mp.neutral20
            : context.mp.neutral30.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: MPText(
        tag,
        style: MPTextStyle.caption(
          // Use theme-aware neutral color for tag text
          // Enabled state: neutral70, Disabled state: neutral70 with reduced opacity
          color: widget.enabled
              ? context.mp.neutral70
              : context.mp.neutral70.withValues(alpha: 0.4),
        ).copyWith(fontSize: (_getFontSize() - 6).sp),
      ),
    );
  }

  Widget _buildActions() {
    final actions = <Widget>[];

    if (widget.onLike != null) {
      actions.add(
        MPButton(
          text: '${widget.likeCount}',
          child: Icon(
            widget.isLiked ? Icons.favorite : Icons.favorite_border,
            size: 18.r,
            // Use theme-aware colors for like icon
            // Liked state: errorColor (red), Default state: subtitleColor
            color: widget.isLiked
                ? context.mp.errorColor
                : context.mp.subtitleColor,
          ),
          onPressed: widget.enabled ? widget.onLike : null,
          // Use theme-aware transparent background
          background: context.mp.adaptiveBackgroundColor.withValues(alpha: 0),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          textSize: _getFontSize() - 4.sp,
          // Use theme-aware subtitle color for like count text
          textColor: context.mp.subtitleColor,
        ),
      );
    }

    if (widget.onBookmark != null) {
      actions.add(
        MPButton(
          text: '',
          child: Icon(
            widget.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            size: 18.r,
            // Use theme-aware subtitle color for bookmark icon
            color: context.mp.subtitleColor,
          ),
          onPressed: widget.enabled ? widget.onBookmark : null,
          // Use theme-aware transparent background
          background: context.mp.adaptiveBackgroundColor.withValues(alpha: 0),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        ),
      );
    }

    if (widget.onShare != null) {
      actions.add(
        MPButton(
          text: '',
          child: Icon(
            Icons.share,
            size: 18.r,
            // Use theme-aware subtitle color for share icon
            color: context.mp.subtitleColor,
          ),
          onPressed: widget.enabled ? widget.onShare : null,
          // Use theme-aware transparent background
          background: context.mp.adaptiveBackgroundColor.withValues(alpha: 0),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        ),
      );
    }

    // Add custom action buttons
    if (widget.actionButtons != null) {
      actions.addAll(widget.actionButtons!);
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
  bool _hasImage() => widget.imageUrl != null || widget.imageWidget != null;
  bool _hasActions() =>
      widget.onLike != null ||
      widget.onBookmark != null ||
      widget.onShare != null ||
      (widget.actionButtons != null && widget.actionButtons!.isNotEmpty);

  double _getFontSize() {
    switch (widget.size) {
      case MPArticleCardSize.small:
        return 12;
      case MPArticleCardSize.medium:
        return 14;
      case MPArticleCardSize.large:
        return 16;
    }
  }

  double _getSpacing() {
    switch (widget.size) {
      case MPArticleCardSize.small:
        return 8.h;
      case MPArticleCardSize.medium:
        return 12.h;
      case MPArticleCardSize.large:
        return 16.h;
    }
  }

  double _getImageHeight() {
    switch (widget.size) {
      case MPArticleCardSize.small:
        return 120.h;
      case MPArticleCardSize.medium:
        return 180.h;
      case MPArticleCardSize.large:
        return 240.h;
    }
  }

  EdgeInsets _getDefaultPadding() {
    switch (widget.size) {
      case MPArticleCardSize.small:
        return EdgeInsets.all(12.r);
      case MPArticleCardSize.medium:
        return EdgeInsets.all(16.r);
      case MPArticleCardSize.large:
        return EdgeInsets.all(20.r);
    }
  }

  EdgeInsets _getDefaultMargin() {
    switch (widget.size) {
      case MPArticleCardSize.small:
        return EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h);
      case MPArticleCardSize.medium:
        return EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h);
      case MPArticleCardSize.large:
        return EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h);
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    if (widget.backgroundColor != null) return widget.backgroundColor!;

    // Use theme-aware colors for better dark mode support
    switch (widget.variant) {
      case MPArticleCardVariant.standard:
        return context.mp.adaptiveBackgroundColor;
      case MPArticleCardVariant.elevated:
        return context.mp.adaptiveBackgroundColor;
      case MPArticleCardVariant.outlined:
        return context.mp.adaptiveBackgroundColor;
    }
  }

  double _getElevation() {
    if (widget.elevation != null) return widget.elevation!;

    switch (widget.variant) {
      case MPArticleCardVariant.standard:
        return 0;
      case MPArticleCardVariant.elevated:
        return 4;
      case MPArticleCardVariant.outlined:
        return 0;
    }
  }
}
