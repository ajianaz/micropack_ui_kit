import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_empty_state_enums.dart';

/// MPEmptyState - Theme-aware empty state component
///
/// This component provides predefined empty states for common scenarios
/// with customizable content and animations.
///
/// Example:
/// ```dart
/// MPEmptyState(
///   variant: MPEmptyStateVariant.noResults,
///   size: MPEmptyStateSize.large,
///   title: 'No results found',
///   description: 'Try adjusting your search terms',
///   actionLabel: 'Clear Search',
///   onAction: () {
///     // Handle action
///   },
/// )
/// ```
class MPEmptyState extends StatelessWidget {
  const MPEmptyState({
    super.key,
    this.variant = MPEmptyStateVariant.noData,
    this.size = MPEmptyStateSize.medium,
    this.title,
    this.description,
    this.icon,
    this.image,
    this.actionLabel,
    this.onAction,
    this.semanticLabel,
  });

  /// The predefined variant of the empty state.
  final MPEmptyStateVariant variant;

  /// The size of the empty state.
  final MPEmptyStateSize size;

  /// Optional custom title.
  ///
  /// If null, uses default title based on variant.
  final String? title;

  /// Optional custom description.
  ///
  /// If null, uses default description based on variant.
  final String? description;

  /// Optional custom icon.
  ///
  /// If null, uses default icon based on variant.
  final IconData? icon;

  /// Optional custom image widget.
  ///
  /// If provided, overrides icon.
  final Widget? image;

  /// Optional label for action button.
  final String? actionLabel;

  /// Callback for action button.
  final VoidCallback? onAction;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final config = _MPEmptyStateConfig();

    return Semantics(
      label: semanticLabel ?? title ?? config.getTitle(variant),
      child: Padding(
        padding: _getPadding(context, config),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: _buildContent(context, config),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, _MPEmptyStateConfig config) {
    return FadeTransition(
      opacity: const AlwaysStoppedAnimation(1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (image != null) ...[
            SizedBox(
              width: config.getImageSize(size),
              height: config.getImageSize(size),
              child: image,
            ),
            SizedBox(height: _getSpacing(context)),
          ] else ...[
            Icon(
              icon ?? config.getDefaultIcon(variant),
              size: config.getIconSize(size),
              color: context.mp.captionColor,
            ),
            SizedBox(height: _getSpacing(context)),
          ],
          MPText.head(
            title ?? config.getTitle(variant),
            style: TextStyle(
              color: context.mp.textColor,
              fontSize: config.getTitleFontSize(size),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: config.getDescriptionSpacing(size)),
          MPText.label(
            description ?? config.getDescription(variant),
            style: TextStyle(
              color: context.mp.subtitleColor,
              fontSize: config.getDescriptionFontSize(size),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          if (actionLabel != null && onAction != null) ...[
            SizedBox(height: config.getActionSpacing(size)),
            MPButton(
              text: actionLabel!,
              onPressed: onAction,
              size: MPButtonSize.regular,
            ),
          ],
        ],
      ),
    );
  }

  double _getSpacing(BuildContext context) {
    return MPResponsivePadding.getMd(context);
  }

  EdgeInsets _getPadding(
    BuildContext context,
    _MPEmptyStateConfig config,
  ) {
    return EdgeInsets.symmetric(
      horizontal: config.getHorizontalPadding(size),
      vertical: config.getVerticalPadding(size),
    );
  }
}

/// Configuration class for MPEmptyState
class _MPEmptyStateConfig {
  double getIconSize(MPEmptyStateSize size) {
    switch (size) {
      case MPEmptyStateSize.small:
        return 48.0;
      case MPEmptyStateSize.medium:
        return 64.0;
      case MPEmptyStateSize.large:
        return 96.0;
    }
  }

  double getImageSize(MPEmptyStateSize size) {
    switch (size) {
      case MPEmptyStateSize.small:
        return 80.0;
      case MPEmptyStateSize.medium:
        return 120.0;
      case MPEmptyStateSize.large:
        return 200.0;
    }
  }

  double getTitleFontSize(MPEmptyStateSize size) {
    switch (size) {
      case MPEmptyStateSize.small:
        return 16.0;
      case MPEmptyStateSize.medium:
        return 18.0;
      case MPEmptyStateSize.large:
        return 24.0;
    }
  }

  double getDescriptionFontSize(MPEmptyStateSize size) {
    switch (size) {
      case MPEmptyStateSize.small:
        return 12.0;
      case MPEmptyStateSize.medium:
        return 14.0;
      case MPEmptyStateSize.large:
        return 16.0;
    }
  }

  double getHorizontalPadding(MPEmptyStateSize size) {
    switch (size) {
      case MPEmptyStateSize.small:
        return 16.0;
      case MPEmptyStateSize.medium:
        return 24.0;
      case MPEmptyStateSize.large:
        return 32.0;
    }
  }

  double getVerticalPadding(MPEmptyStateSize size) {
    switch (size) {
      case MPEmptyStateSize.small:
        return 24.0;
      case MPEmptyStateSize.medium:
        return 32.0;
      case MPEmptyStateSize.large:
        return 48.0;
    }
  }

  double getDescriptionSpacing(MPEmptyStateSize size) {
    switch (size) {
      case MPEmptyStateSize.small:
        return 8.0;
      case MPEmptyStateSize.medium:
        return 12.0;
      case MPEmptyStateSize.large:
        return 16.0;
    }
  }

  double getActionSpacing(MPEmptyStateSize size) {
    switch (size) {
      case MPEmptyStateSize.small:
        return 12.0;
      case MPEmptyStateSize.medium:
        return 16.0;
      case MPEmptyStateSize.large:
        return 24.0;
    }
  }

  IconData getDefaultIcon(MPEmptyStateVariant variant) {
    switch (variant) {
      case MPEmptyStateVariant.noData:
        return Icons.inbox;
      case MPEmptyStateVariant.noResults:
        return Icons.search_off;
      case MPEmptyStateVariant.noNetwork:
        return Icons.cloud_off;
      case MPEmptyStateVariant.error:
        return Icons.error_outline;
      case MPEmptyStateVariant.custom:
        return Icons.info_outline;
    }
  }

  String getTitle(MPEmptyStateVariant variant) {
    switch (variant) {
      case MPEmptyStateVariant.noData:
        return 'No data';
      case MPEmptyStateVariant.noResults:
        return 'No results found';
      case MPEmptyStateVariant.noNetwork:
        return 'No connection';
      case MPEmptyStateVariant.error:
        return 'Something went wrong';
      case MPEmptyStateVariant.custom:
        return 'Empty';
    }
  }

  String getDescription(MPEmptyStateVariant variant) {
    switch (variant) {
      case MPEmptyStateVariant.noData:
        return 'There is no data to display at this time.';
      case MPEmptyStateVariant.noResults:
        return 'We couldn\'t find any results. Try different search terms.';
      case MPEmptyStateVariant.noNetwork:
        return 'Please check your internet connection and try again.';
      case MPEmptyStateVariant.error:
        return 'An error occurred. Please try again later.';
      case MPEmptyStateVariant.custom:
        return 'This section is currently empty.';
    }
  }
}
