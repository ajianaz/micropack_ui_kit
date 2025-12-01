import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// MPCard variant enum for different visual styles
enum MPCardVariant {
  /// Foundation variants (like MPButton)
  primary, // Uses theme primary color
  secondary, // Uses theme secondary colors
  surface, // Uses theme surface colors

  /// Structural variants (like MPArticleCard)
  elevated, // Has elevation and shadow
  outlined, // Has border only
  filled, // Has solid background

  /// Specialized variants
  interactive, // Optimized for interaction
  display, // Optimized for content display
  glass, // Translucent with blur effect

  /// Use case-specific variants
  media, // Optimized for media content (images, videos)
  content, // Text-focused with minimal visual elements
  product, // Product cards with pricing and features
  profile, // User profile with avatar and stats
  notification, // Alert cards with actions and timestamps
  dashboard, // Metrics and data visualization cards
}

/// MPCard size enum for different dimensions
enum MPCardSize {
  small, // Compact cards for dense layouts
  medium, // Standard card size (default)
  large, // Large cards for emphasis
  xlarge, // Extra large for hero content
  fluid, // Responsive sizing based on container
}

/// MPCard layout enum for content arrangement
enum MPCardLayout {
  vertical, // Header-Body-Footer stacked
  horizontal, // Side-by-side layout
  grid, // Grid-based layout
  adaptive, // Automatically switches based on screen size
}

/// MPCard elevation levels for different visual hierarchy
enum MPCardElevation {
  level0, // No elevation (flat)
  level1, // Subtle elevation
  level2, // Light elevation
  level3, // Standard elevation
  level4, // Moderate elevation
  level8, // High elevation
  level12, // Very high elevation
  level16, // Extreme elevation
  level24, // Maximum elevation
}

/// MPCard elevation constants for consistent shadow values
class MPCardElevationConstants {
  static const double level0 = 0.0;
  static const double level1 = 1.0;
  static const double level2 = 2.0;
  static const double level3 = 3.0;
  static const double level4 = 4.0;
  static const double level8 = 8.0;
  static const double level12 = 12.0;
  static const double level16 = 16.0;
  static const double level24 = 24.0;

  /// Get elevation value from enum
  static double getValue(MPCardElevation elevation) {
    switch (elevation) {
      case MPCardElevation.level0:
        return level0;
      case MPCardElevation.level1:
        return level1;
      case MPCardElevation.level2:
        return level2;
      case MPCardElevation.level3:
        return level3;
      case MPCardElevation.level4:
        return level4;
      case MPCardElevation.level8:
        return level8;
      case MPCardElevation.level12:
        return level12;
      case MPCardElevation.level16:
        return level16;
      case MPCardElevation.level24:
        return level24;
    }
  }
}

/// MPCard responsive configuration for different screen sizes
class MPCardResponsiveConfig {
  final MPCardLayout? mobileLayout;
  final MPCardLayout? tabletLayout;
  final MPCardLayout? desktopLayout;
  final double? mobileMaxWidth;
  final double? tabletMaxWidth;
  final bool enableOrientationAdaptation;
  final Duration? layoutTransitionDuration;

  const MPCardResponsiveConfig({
    this.mobileLayout,
    this.tabletLayout,
    this.desktopLayout,
    this.mobileMaxWidth = 600,
    this.tabletMaxWidth = 1024,
    this.enableOrientationAdaptation = true,
    this.layoutTransitionDuration = const Duration(milliseconds: 200),
  });
}

/// MPCard breakpoints for responsive behavior
class MPCardBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
}

/// MPCard theme data for custom styling
class MPCardThemeData {
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final Color? hoverColor;
  final Color? pressedColor;
  final Color? focusColor;
  final Color? selectedColor;

  const MPCardThemeData({
    this.backgroundColor,
    this.borderColor,
    this.shadowColor,
    this.hoverColor,
    this.pressedColor,
    this.focusColor,
    this.selectedColor,
  });
}

/// MPCard header configuration for structured header content
class MPCardHeaderData {
  final String? title;
  final String? subtitle;
  final Widget? titleWidget;
  final Widget? subtitleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final EdgeInsets? padding;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;

  const MPCardHeaderData({
    this.title,
    this.subtitle,
    this.titleWidget,
    this.subtitleWidget,
    this.actions,
    this.leading,
    this.padding,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  });
}

/// MPCard footer configuration for structured footer content
class MPCardFooterData {
  final List<Widget>? actions;
  final Widget? content;
  final EdgeInsets? padding;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;

  const MPCardFooterData({
    this.actions,
    this.content,
    this.padding,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  });
}

/// MPCard media data for media-focused cards
class MPCardMediaData {
  final Widget? image;
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final String? description;
  final List<Widget>? actions;
  final Widget? metadata;
  final double? imageHeight;
  final double? imageWidth;
  final BoxFit? imageFit;
  final bool showImageOverlay;
  final Widget? overlayContent;

  const MPCardMediaData({
    this.image,
    this.imageUrl,
    this.title,
    this.subtitle,
    this.description,
    this.actions,
    this.metadata,
    this.imageHeight,
    this.imageWidth,
    this.imageFit = BoxFit.cover,
    this.showImageOverlay = false,
    this.overlayContent,
  });
}

/// MPCard content data for text-focused cards
class MPCardContentData {
  final String? title;
  final String? subtitle;
  final String? description;
  final Widget? content;
  final List<Widget>? actions;
  final Widget? metadata;
  final Widget? icon;
  final bool showDivider;

  const MPCardContentData({
    this.title,
    this.subtitle,
    this.description,
    this.content,
    this.actions,
    this.metadata,
    this.icon,
    this.showDivider = false,
  });
}

/// MPCard product data for product cards
class MPCardProductData {
  final String? name;
  final String? description;
  final String? price;
  final String? originalPrice;
  final String? currency;
  final Widget? image;
  final String? imageUrl;
  final List<String>? features;
  final List<Widget>? actions;
  final Widget? badge;
  final double? rating;
  final int? reviewCount;
  final bool isAvailable;

  const MPCardProductData({
    this.name,
    this.description,
    this.price,
    this.originalPrice,
    this.currency = '\$',
    this.image,
    this.imageUrl,
    this.features,
    this.actions,
    this.badge,
    this.rating,
    this.reviewCount,
    this.isAvailable = true,
  });
}

/// MPCard profile data for user profile cards
class MPCardProfileData {
  final String? name;
  final String? username;
  final String? bio;
  final Widget? avatar;
  final String? avatarUrl;
  final List<Widget>? actions;
  final Map<String, String>? stats;
  final List<Widget>? socialLinks;
  final bool showVerifiedBadge;
  final bool isOnline;

  const MPCardProfileData({
    this.name,
    this.username,
    this.bio,
    this.avatar,
    this.avatarUrl,
    this.actions,
    this.stats,
    this.socialLinks,
    this.showVerifiedBadge = false,
    this.isOnline = false,
  });
}

/// MPCard notification data for notification cards
class MPCardNotificationData {
  final String? title;
  final String? message;
  final String? timestamp;
  final Widget? icon;
  final IconData? iconData;
  final Color? iconColor;
  final List<Widget>? actions;
  final bool isRead;
  final bool showTimestamp;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const MPCardNotificationData({
    this.title,
    this.message,
    this.timestamp,
    this.icon,
    this.iconData,
    this.iconColor,
    this.actions,
    this.isRead = false,
    this.showTimestamp = true,
    this.onTap,
    this.onDismiss,
  });
}

/// MPCard dashboard data for metric cards
class MPCardDashboardData {
  final String? title;
  final String? value;
  final String? subtitle;
  final String? unit;
  final Widget? chart;
  final List<Widget>? actions;
  final Widget? icon;
  final Color? valueColor;
  final Color? trendColor;
  final String? trend;
  final bool showTrend;

  const MPCardDashboardData({
    this.title,
    this.value,
    this.subtitle,
    this.unit,
    this.chart,
    this.actions,
    this.icon,
    this.valueColor,
    this.trendColor,
    this.trend,
    this.showTrend = false,
  });
}

/// MPCard interactive configuration for advanced interactions
class MPCardInteractiveConfig {
  /// Whether card is initially expanded
  final bool initiallyExpanded;

  /// Whether to enable swipe-to-dismiss functionality
  final bool enableSwipeToDismiss;

  /// Whether to enable quick actions on hover
  final bool enableQuickActions;

  /// Whether to enable expandable content
  final bool enableExpandable;

  /// Animation duration for interactive elements
  final Duration animationDuration;

  /// Quick actions to show on hover
  final List<Widget>? quickActions;

  /// Left swipe action
  final VoidCallback? onSwipeLeft;

  /// Right swipe action
  final VoidCallback? onSwipeRight;

  /// Dismiss action
  final VoidCallback? onDismiss;

  /// Expand action
  final VoidCallback? onExpand;

  /// Collapse action
  final VoidCallback? onCollapse;

  const MPCardInteractiveConfig({
    this.initiallyExpanded = false,
    this.enableSwipeToDismiss = false,
    this.enableQuickActions = false,
    this.enableExpandable = false,
    this.animationDuration = const Duration(milliseconds: 200),
    this.quickActions,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onDismiss,
    this.onExpand,
    this.onCollapse,
  });
}

/// A flexible, theme-aware card component designed for dynamic use cases across the Micropack UI Kit.
///
/// MPCard combines the foundation approach of MPButton with the content flexibility of MPArticleCard,
/// supporting multiple variants, responsive layouts, comprehensive theme integration, and elevation levels.
///
/// Example usage:
/// ```dart
/// // Basic card with content
/// MPCard(
///   child: Text('Card content'),
/// )
///
/// // Card with structured header
/// MPCard.withHeader(
///   headerData: MPCardHeaderData(
///     title: 'Card Title',
///     subtitle: 'Card subtitle',
///     actions: [Icon(Icons.more_vert)],
///   ),
///   body: Text('Body content'),
/// )
///
/// // Card with structured footer
/// MPCard.withFooter(
///   footerData: MPCardFooterData(
///     actions: [
///       TextButton(onPressed: () {}, child: Text('Cancel')),
///       ElevatedButton(onPressed: () {}, child: Text('Save')),
///     ],
///   ),
///   body: Text('Body content'),
/// )
///
/// // Card with both header and footer
/// MPCard.withSections(
///   headerData: MPCardHeaderData(title: 'Complete Card'),
///   body: Text('Body content'),
///   footerData: MPCardFooterData(
///     actions: [TextButton(onPressed: () {}, child: Text('Action'))],
///   ),
///   variant: MPCardVariant.elevated,
/// )
///
/// // Interactive card with overflow handling
/// MPCard(
///   variant: MPCardVariant.interactive,
///   enableOverflowHandling: true,
///   onTap: () => print('Card tapped'),
///   body: Text('Card content'),
/// )
///
/// // Card with custom elevation level
/// MPCard(
///   elevationLevel: MPCardElevation.level8,
///   child: Text('High elevation card'),
/// )
///
/// // Card with custom elevation value
/// MPCard(
///   elevation: 12.0,
///   child: Text('Custom elevation card'),
/// )
/// ```
class MPCard extends StatefulWidget {
  /// Creates a new [MPCard] widget.
  const MPCard({
    super.key,
    this.header,
    this.headerData,
    this.body,
    this.footer,
    this.footerData,
    this.child,
    this.layout = MPCardLayout.vertical,
    this.variant = MPCardVariant.surface,
    this.size = MPCardSize.medium,
    this.responsive,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.elevation,
    this.elevationLevel,
    this.padding,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.onHover,
    this.enabled = true,
    this.selectable = false,
    this.selected = false,
    this.themeData,
    this.semanticLabel,
    this.semanticHint,
    this.focusNode,
    this.autofocus = false,
    this.enableOverflowHandling = true,
    this.clipBehavior = Clip.antiAlias,
    this.interactiveConfig,
  });

  /// Header content widget (custom widget)
  final Widget? header;

  /// Header structured data (title, subtitle, actions)
  final MPCardHeaderData? headerData;

  /// Body content widget
  final Widget? body;

  /// Footer content widget (custom widget)
  final Widget? footer;

  /// Footer structured data (actions, content)
  final MPCardFooterData? footerData;

  /// Single child content (alternative to body for simple cases)
  final Widget? child;

  /// Layout configuration
  final MPCardLayout layout;

  /// Visual variant
  final MPCardVariant variant;

  /// Card size
  final MPCardSize size;

  /// Responsive configuration
  final MPCardResponsiveConfig? responsive;

  /// Custom background color
  final Color? backgroundColor;

  /// Custom border color
  final Color? borderColor;

  /// Custom border width
  final double? borderWidth;

  /// Custom border radius
  final double? borderRadius;

  /// Custom elevation (overrides elevationLevel)
  final double? elevation;

  /// Elevation level from predefined values
  final MPCardElevation? elevationLevel;

  /// Custom padding
  final EdgeInsets? padding;

  /// Custom margin
  final EdgeInsets? margin;

  /// Tap callback
  final VoidCallback? onTap;

  /// Long press callback
  final VoidCallback? onLongPress;

  /// Hover state change callback
  final ValueChanged<bool>? onHover;

  /// Whether the card is enabled
  final bool enabled;

  /// Whether the card is selectable
  final bool selectable;

  /// Whether the card is selected
  final bool selected;

  /// Custom theme data
  final MPCardThemeData? themeData;

  /// Semantic label for accessibility
  final String? semanticLabel;

  /// Semantic hint for accessibility
  final String? semanticHint;

  /// Focus node
  final FocusNode? focusNode;

  /// Whether to autofocus
  final bool autofocus;

  /// Whether to enable overflow handling with scrollable content
  final bool enableOverflowHandling;

  /// Clip behavior for the card
  final Clip clipBehavior;

  /// Interactive elements configuration
  final MPCardInteractiveConfig? interactiveConfig;

  @override
  State<MPCard> createState() => _MPCardState();

  /// Creates a card with structured header data
  factory MPCard.withHeader({
    Key? key,
    required MPCardHeaderData headerData,
    Widget? body,
    Widget? footer,
    MPCardFooterData? footerData,
    MPCardLayout layout = MPCardLayout.vertical,
    MPCardVariant variant = MPCardVariant.surface,
    MPCardSize size = MPCardSize.medium,
    MPCardResponsiveConfig? responsive,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? elevation,
    MPCardElevation? elevationLevel,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    bool enabled = true,
    bool selectable = false,
    bool selected = false,
    MPCardThemeData? themeData,
    String? semanticLabel,
    String? semanticHint,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableOverflowHandling = true,
    Clip clipBehavior = Clip.antiAlias,
    MPCardInteractiveConfig? interactiveConfig,
  }) {
    return MPCard(
      key: key,
      headerData: headerData,
      body: body,
      footer: footer,
      footerData: footerData,
      layout: layout,
      variant: variant,
      size: size,
      responsive: responsive,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      elevation: elevation,
      elevationLevel: elevationLevel,
      padding: padding,
      margin: margin,
      onTap: onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      enabled: enabled,
      selectable: selectable,
      selected: selected,
      themeData: themeData,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      focusNode: focusNode,
      autofocus: autofocus,
      enableOverflowHandling: enableOverflowHandling,
      clipBehavior: clipBehavior,
      interactiveConfig: interactiveConfig,
    );
  }

  /// Creates a card with structured footer data
  factory MPCard.withFooter({
    Key? key,
    Widget? header,
    MPCardHeaderData? headerData,
    Widget? body,
    required MPCardFooterData footerData,
    MPCardLayout layout = MPCardLayout.vertical,
    MPCardVariant variant = MPCardVariant.surface,
    MPCardSize size = MPCardSize.medium,
    MPCardResponsiveConfig? responsive,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? elevation,
    MPCardElevation? elevationLevel,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    bool enabled = true,
    bool selectable = false,
    bool selected = false,
    MPCardThemeData? themeData,
    String? semanticLabel,
    String? semanticHint,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableOverflowHandling = true,
    Clip clipBehavior = Clip.antiAlias,
    MPCardInteractiveConfig? interactiveConfig,
  }) {
    return MPCard(
      key: key,
      header: header,
      headerData: headerData,
      body: body,
      footerData: footerData,
      layout: layout,
      variant: variant,
      size: size,
      responsive: responsive,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      elevation: elevation,
      elevationLevel: elevationLevel,
      padding: padding,
      margin: margin,
      onTap: onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      enabled: enabled,
      selectable: selectable,
      selected: selected,
      themeData: themeData,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      focusNode: focusNode,
      autofocus: autofocus,
      enableOverflowHandling: enableOverflowHandling,
      clipBehavior: clipBehavior,
      interactiveConfig: interactiveConfig,
    );
  }

  /// Creates a card with both structured header and footer data
  factory MPCard.withSections({
    Key? key,
    required MPCardHeaderData headerData,
    Widget? body,
    required MPCardFooterData footerData,
    MPCardLayout layout = MPCardLayout.vertical,
    MPCardVariant variant = MPCardVariant.surface,
    MPCardSize size = MPCardSize.medium,
    MPCardResponsiveConfig? responsive,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? elevation,
    MPCardElevation? elevationLevel,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    bool enabled = true,
    bool selectable = false,
    bool selected = false,
    MPCardThemeData? themeData,
    String? semanticLabel,
    String? semanticHint,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableOverflowHandling = true,
    Clip clipBehavior = Clip.antiAlias,
    MPCardInteractiveConfig? interactiveConfig,
  }) {
    return MPCard(
      key: key,
      headerData: headerData,
      body: body,
      footerData: footerData,
      layout: layout,
      variant: variant,
      size: size,
      responsive: responsive,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      elevation: elevation,
      elevationLevel: elevationLevel,
      padding: padding,
      margin: margin,
      onTap: onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      enabled: enabled,
      selectable: selectable,
      selected: selected,
      themeData: themeData,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      focusNode: focusNode,
      autofocus: autofocus,
      enableOverflowHandling: enableOverflowHandling,
      clipBehavior: clipBehavior,
    );
  }

  /// Creates a media card with image, title, subtitle, and metadata
  factory MPCard.media({
    Key? key,
    required MPCardMediaData mediaData,
    MPCardSize size = MPCardSize.medium,
    MPCardLayout layout = MPCardLayout.vertical,
    MPCardResponsiveConfig? responsive,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? elevation,
    MPCardElevation? elevationLevel,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    bool enabled = true,
    bool selectable = false,
    bool selected = false,
    MPCardThemeData? themeData,
    String? semanticLabel,
    String? semanticHint,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableOverflowHandling = true,
    Clip clipBehavior = Clip.antiAlias,
    MPCardInteractiveConfig? interactiveConfig,
  }) {
    return MPCard(
      key: key,
      variant: MPCardVariant.media,
      size: size,
      layout: layout,
      responsive: responsive,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      elevation: elevation,
      elevationLevel: elevationLevel,
      padding: padding,
      margin: margin,
      onTap: onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      enabled: enabled,
      selectable: selectable,
      selected: selected,
      themeData: themeData,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      focusNode: focusNode,
      autofocus: autofocus,
      enableOverflowHandling: enableOverflowHandling,
      clipBehavior: clipBehavior,
      body: _buildMediaContent(mediaData),
    );
  }

  /// Creates a content card with text-focused layout
  factory MPCard.content({
    Key? key,
    required MPCardContentData contentData,
    MPCardSize size = MPCardSize.medium,
    MPCardLayout layout = MPCardLayout.vertical,
    MPCardResponsiveConfig? responsive,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? elevation,
    MPCardElevation? elevationLevel,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    bool enabled = true,
    bool selectable = false,
    bool selected = false,
    MPCardThemeData? themeData,
    String? semanticLabel,
    String? semanticHint,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableOverflowHandling = true,
    Clip clipBehavior = Clip.antiAlias,
    MPCardInteractiveConfig? interactiveConfig,
  }) {
    return MPCard(
      key: key,
      variant: MPCardVariant.content,
      size: size,
      layout: layout,
      responsive: responsive,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      elevation: elevation,
      elevationLevel: elevationLevel,
      padding: padding,
      margin: margin,
      onTap: onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      enabled: enabled,
      selectable: selectable,
      selected: selected,
      themeData: themeData,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      focusNode: focusNode,
      autofocus: autofocus,
      enableOverflowHandling: enableOverflowHandling,
      clipBehavior: clipBehavior,
      body: _buildContentCard(contentData),
    );
  }

  /// Creates a product card with pricing, features, and actions
  factory MPCard.product({
    Key? key,
    required MPCardProductData productData,
    MPCardSize size = MPCardSize.medium,
    MPCardLayout layout = MPCardLayout.vertical,
    MPCardResponsiveConfig? responsive,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? elevation,
    MPCardElevation? elevationLevel,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    bool enabled = true,
    bool selectable = false,
    bool selected = false,
    MPCardThemeData? themeData,
    String? semanticLabel,
    String? semanticHint,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableOverflowHandling = true,
    Clip clipBehavior = Clip.antiAlias,
    MPCardInteractiveConfig? interactiveConfig,
  }) {
    return MPCard(
      key: key,
      variant: MPCardVariant.product,
      size: size,
      layout: layout,
      responsive: responsive,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      elevation: elevation,
      elevationLevel: elevationLevel,
      padding: padding,
      margin: margin,
      onTap: onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      enabled: enabled,
      selectable: selectable,
      selected: selected,
      themeData: themeData,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      focusNode: focusNode,
      autofocus: autofocus,
      enableOverflowHandling: enableOverflowHandling,
      clipBehavior: clipBehavior,
      body: _buildProductContent(productData),
    );
  }

  /// Creates a profile card with avatar, user info, and stats
  factory MPCard.profile({
    Key? key,
    required MPCardProfileData profileData,
    MPCardSize size = MPCardSize.medium,
    MPCardLayout layout = MPCardLayout.vertical,
    MPCardResponsiveConfig? responsive,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? elevation,
    MPCardElevation? elevationLevel,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    bool enabled = true,
    bool selectable = false,
    bool selected = false,
    MPCardThemeData? themeData,
    String? semanticLabel,
    String? semanticHint,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableOverflowHandling = true,
    Clip clipBehavior = Clip.antiAlias,
    MPCardInteractiveConfig? interactiveConfig,
  }) {
    return MPCard(
      key: key,
      variant: MPCardVariant.profile,
      size: size,
      layout: layout,
      responsive: responsive,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      elevation: elevation,
      elevationLevel: elevationLevel,
      padding: padding,
      margin: margin,
      onTap: onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      enabled: enabled,
      selectable: selectable,
      selected: selected,
      themeData: themeData,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      focusNode: focusNode,
      autofocus: autofocus,
      enableOverflowHandling: enableOverflowHandling,
      clipBehavior: clipBehavior,
      body: _buildProfileContent(profileData),
    );
  }

  /// Creates a notification card with alerts, actions, and timestamps
  factory MPCard.notification({
    Key? key,
    required MPCardNotificationData notificationData,
    MPCardSize size = MPCardSize.medium,
    MPCardLayout layout = MPCardLayout.horizontal,
    MPCardResponsiveConfig? responsive,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? elevation,
    MPCardElevation? elevationLevel,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    bool enabled = true,
    bool selectable = false,
    bool selected = false,
    MPCardThemeData? themeData,
    String? semanticLabel,
    String? semanticHint,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableOverflowHandling = true,
    Clip clipBehavior = Clip.antiAlias,
    MPCardInteractiveConfig? interactiveConfig,
  }) {
    return MPCard(
      key: key,
      variant: MPCardVariant.notification,
      size: size,
      layout: layout,
      responsive: responsive,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      elevation: elevation,
      elevationLevel: elevationLevel,
      padding: padding,
      margin: margin,
      onTap: onTap ?? notificationData.onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      enabled: enabled,
      selectable: selectable,
      selected: selected,
      themeData: themeData,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      focusNode: focusNode,
      autofocus: autofocus,
      enableOverflowHandling: enableOverflowHandling,
      clipBehavior: clipBehavior,
      body: _buildNotificationContent(notificationData),
    );
  }

  /// Creates a dashboard card with metrics, charts, and data visualization
  factory MPCard.dashboard({
    Key? key,
    required MPCardDashboardData dashboardData,
    MPCardSize size = MPCardSize.medium,
    MPCardLayout layout = MPCardLayout.vertical,
    MPCardResponsiveConfig? responsive,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? elevation,
    MPCardElevation? elevationLevel,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    bool enabled = true,
    bool selectable = false,
    bool selected = false,
    MPCardThemeData? themeData,
    String? semanticLabel,
    String? semanticHint,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableOverflowHandling = true,
    Clip clipBehavior = Clip.antiAlias,
    MPCardInteractiveConfig? interactiveConfig,
  }) {
    return MPCard(
      key: key,
      variant: MPCardVariant.dashboard,
      size: size,
      layout: layout,
      responsive: responsive,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      elevation: elevation,
      elevationLevel: elevationLevel,
      padding: padding,
      margin: margin,
      onTap: onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      enabled: enabled,
      selectable: selectable,
      selected: selected,
      themeData: themeData,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      focusNode: focusNode,
      autofocus: autofocus,
      enableOverflowHandling: enableOverflowHandling,
      clipBehavior: clipBehavior,
      body: _buildDashboardContent(dashboardData),
    );
  }
}

/// Content builders for different card variants
class _MPCardContentBuilders {
  /// Builds content for media cards
  static Widget buildMediaContent(MPCardMediaData data, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image section
        if (data.image != null || data.imageUrl != null) ...[
          _buildImageSection(data, context),
          const SizedBox(height: 12),
        ],

        // Title section
        if (data.title != null) ...[
          MPText.subhead(
            data.title!,
            fontWeight: FontWeight.w600,
            color: context.mp.textColor,
          ),
          const SizedBox(height: 4),
        ],

        // Subtitle section
        if (data.subtitle != null) ...[
          MPText.small(
            data.subtitle!,
            color: context.mp.subtitleColor,
          ),
          const SizedBox(height: 8),
        ],

        // Description section
        if (data.description != null) ...[
          MPText.body(
            data.description!,
            color: context.mp.textColor,
            maxLines: 3,
            textOverflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
        ],

        // Metadata section
        if (data.metadata != null) ...[
          data.metadata!,
          const SizedBox(height: 12),
        ],

        // Actions section
        if (data.actions != null && data.actions!.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: data.actions!,
          ),
      ],
    );
  }

  /// Builds image section for media cards
  static Widget _buildImageSection(MPCardMediaData data, BuildContext context) {
    Widget imageWidget;

    if (data.image != null) {
      imageWidget = data.image!;
    } else if (data.imageUrl != null) {
      imageWidget = Image.network(
        data.imageUrl!,
        height: data.imageHeight ?? 200,
        width: data.imageWidth,
        fit: data.imageFit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: data.imageHeight ?? 200,
            width: data.imageWidth,
            color: context.mp.neutral20,
            child: Icon(
              Icons.broken_image,
              color: context.mp.neutral60,
              size: 48,
            ),
          );
        },
      );
    } else {
      return const SizedBox.shrink();
    }

    if (data.showImageOverlay && data.overlayContent != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imageWidget,
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: data.overlayContent,
              ),
            ),
          ),
        ],
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageWidget,
    );
  }

  /// Builds content for content cards
  static Widget buildContentCardContent(
      MPCardContentData data, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon and title row
        if (data.icon != null || data.title != null) ...[
          Row(
            children: [
              if (data.icon != null) ...[
                data.icon!,
                const SizedBox(width: 12),
              ],
              if (data.title != null)
                Expanded(
                  child: MPText.subhead(
                    data.title!,
                    fontWeight: FontWeight.w600,
                    color: context.mp.textColor,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],

        // Subtitle section
        if (data.subtitle != null) ...[
          MPText.small(
            data.subtitle!,
            color: context.mp.subtitleColor,
          ),
          const SizedBox(height: 8),
        ],

        // Description section
        if (data.description != null) ...[
          MPText.body(
            data.description!,
            color: context.mp.textColor,
          ),
          const SizedBox(height: 8),
        ],

        // Custom content
        if (data.content != null) ...[
          data.content!,
          const SizedBox(height: 8),
        ],

        // Divider
        if (data.showDivider) ...[
          Divider(color: context.mp.neutral20),
          const SizedBox(height: 8),
        ],

        // Metadata section
        if (data.metadata != null) ...[
          data.metadata!,
          const SizedBox(height: 12),
        ],

        // Actions section
        if (data.actions != null && data.actions!.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: data.actions!,
          ),
      ],
    );
  }

  /// Builds content for product cards
  static Widget buildProductContent(
      MPCardProductData data, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image
        if (data.image != null || data.imageUrl != null) ...[
          _buildProductImage(data, context),
          const SizedBox(height: 12),
        ],

        // Product name and badge
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: MPText.subhead(
                data.name ?? 'Product',
                fontWeight: FontWeight.w600,
                color: context.mp.textColor,
              ),
            ),
            if (data.badge != null) ...[
              const SizedBox(width: 8),
              data.badge!,
            ],
          ],
        ),
        const SizedBox(height: 8),

        // Product description
        if (data.description != null) ...[
          MPText.body(
            data.description!,
            color: context.mp.textColor,
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
        ],

        // Rating and reviews
        if (data.rating != null) ...[
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return Icon(
                    index < data.rating!.floor()
                        ? Icons.star
                        : index < data.rating!.ceil()
                            ? Icons.star_half
                            : Icons.star_border,
                    color: Colors.amber,
                    size: 16,
                  );
                }),
              ),
              const SizedBox(width: 4),
              MPText.small(
                data.rating!.toStringAsFixed(1),
                color: context.mp.textColor,
              ),
              if (data.reviewCount != null) ...[
                const SizedBox(width: 4),
                MPText.small(
                  '(${data.reviewCount})',
                  color: context.mp.subtitleColor,
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
        ],

        // Features list
        if (data.features != null && data.features!.isNotEmpty) ...[
          ...data.features!.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: context.mp.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: MPText.small(
                        feature,
                        color: context.mp.textColor,
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 12),
        ],

        // Price section
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (data.price != null) ...[
              MPText.subhead(
                '${data.currency}${data.price}',
                fontWeight: FontWeight.w700,
                color: data.isAvailable
                    ? context.mp.primary
                    : context.mp.neutral60,
              ),
              if (data.originalPrice != null &&
                  data.originalPrice != data.price) ...[
                const SizedBox(width: 8),
                MPText.small(
                  '${data.currency}${data.originalPrice}',
                  color: context.mp.neutral60,
                  decoration: TextDecoration.lineThrough,
                ),
              ],
            ],
            const Spacer(),
            // Availability status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: data.isAvailable
                    ? context.mp.primary
                    : context.mp.neutral20,
                borderRadius: BorderRadius.circular(12),
              ),
              child: MPText.small(
                data.isAvailable ? 'Available' : 'Out of Stock',
                color: data.isAvailable ? Colors.white : context.mp.neutral60,
              ),
            ),
          ],
        ),

        // Actions section
        if (data.actions != null && data.actions!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: data.actions!,
          ),
        ],
      ],
    );
  }

  /// Builds product image
  static Widget _buildProductImage(
      MPCardProductData data, BuildContext context) {
    Widget imageWidget;

    if (data.image != null) {
      imageWidget = data.image!;
    } else if (data.imageUrl != null) {
      imageWidget = Image.network(
        data.imageUrl!,
        height: 180,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 180,
            color: context.mp.neutral20,
            child: Icon(
              Icons.shopping_bag_outlined,
              color: context.mp.neutral60,
              size: 48,
            ),
          );
        },
      );
    } else {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageWidget,
    );
  }

  /// Builds content for profile cards
  static Widget buildProfileContent(
      MPCardProfileData data, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar section
        _buildProfileAvatar(data, context),
        const SizedBox(height: 16),

        // Name section
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (data.name != null)
              MPText.subhead(
                data.name!,
                fontWeight: FontWeight.w600,
                color: context.mp.textColor,
              ),
            if (data.showVerifiedBadge && data.name != null) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.verified,
                color: context.mp.primary,
                size: 16,
              ),
            ],
          ],
        ),

        // Username section
        if (data.username != null) ...[
          const SizedBox(height: 4),
          MPText.small(
            '@${data.username}',
            color: context.mp.subtitleColor,
          ),
        ],

        // Online status
        if (data.isOnline) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: context.mp.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              MPText.small(
                'Online',
                color: context.mp.primary,
              ),
            ],
          ),
        ],

        // Bio section
        if (data.bio != null) ...[
          const SizedBox(height: 12),
          MPText.body(
            data.bio!,
            color: context.mp.textColor,
            textAlign: TextAlign.center,
            maxLines: 3,
            textOverflow: TextOverflow.ellipsis,
          ),
        ],

        // Stats section
        if (data.stats != null && data.stats!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: data.stats!.entries
                .map((entry) => Column(
                      children: [
                        MPText.subhead(
                          entry.value,
                          fontWeight: FontWeight.w600,
                          color: context.mp.textColor,
                        ),
                        MPText.small(
                          entry.key,
                          color: context.mp.subtitleColor,
                        ),
                      ],
                    ))
                .toList(),
          ),
        ],

        // Social links
        if (data.socialLinks != null && data.socialLinks!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: data.socialLinks!,
          ),
        ],

        // Actions section
        if (data.actions != null && data.actions!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: data.actions!,
          ),
        ],
      ],
    );
  }

  /// Builds profile avatar
  static Widget _buildProfileAvatar(
      MPCardProfileData data, BuildContext context) {
    Widget avatarWidget;

    if (data.avatar != null) {
      avatarWidget = data.avatar!;
    } else if (data.avatarUrl != null) {
      avatarWidget = CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(data.avatarUrl!),
        backgroundColor: context.mp.neutral20,
        child: data.avatarUrl == null
            ? Icon(
                Icons.person,
                color: context.mp.neutral60,
                size: 40,
              )
            : null,
      );
    } else {
      avatarWidget = CircleAvatar(
        radius: 40,
        backgroundColor: context.mp.primary,
        child: data.name != null
            ? MPText.head(
                data.name![0].toUpperCase(),
                color: Colors.white,
              )
            : Icon(
                Icons.person,
                color: Colors.white,
                size: 40,
              ),
      );
    }

    // Online indicator
    if (data.isOnline) {
      return Stack(
        children: [
          avatarWidget,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: context.mp.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.mp.adaptiveBackgroundColor,
                  width: 3,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return avatarWidget;
  }

  /// Builds content for notification cards
  static Widget buildNotificationContent(
      MPCardNotificationData data, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon section
        if (data.icon != null || data.iconData != null) ...[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  (data.iconColor ?? context.mp.primary).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: data.icon ??
                Icon(
                  data.iconData ?? Icons.notifications,
                  color: data.iconColor ?? context.mp.primary,
                  size: 20,
                ),
          ),
          const SizedBox(width: 12),
        ],

        // Content section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title section
              if (data.title != null) ...[
                MPText.subhead(
                  data.title!,
                  fontWeight: FontWeight.w600,
                  color: context.mp.textColor,
                ),
                const SizedBox(height: 4),
              ],

              // Message section
              if (data.message != null)
                MPText.body(
                  data.message!,
                  color: context.mp.textColor,
                  maxLines: 3,
                  textOverflow: TextOverflow.ellipsis,
                ),

              // Timestamp section
              if (data.showTimestamp && data.timestamp != null) ...[
                const SizedBox(height: 8),
                MPText.small(
                  data.timestamp!,
                  color: context.mp.subtitleColor,
                ),
              ],
            ],
          ),
        ),

        // Actions section
        if (data.actions != null && data.actions!.isNotEmpty) ...[
          const SizedBox(width: 12),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: data.actions!,
          ),
        ],
      ],
    );
  }

  /// Builds content for dashboard cards
  static Widget buildDashboardContent(
      MPCardDashboardData data, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with title and icon
        Row(
          children: [
            if (data.icon != null) ...[
              data.icon!,
              const SizedBox(width: 12),
            ],
            Expanded(
              child: MPText.subhead(
                data.title ?? 'Metric',
                fontWeight: FontWeight.w600,
                color: context.mp.textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Main content area
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Value section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MPText.head(
                      data.value ?? '0',
                      fontWeight: FontWeight.w700,
                      color: data.valueColor ?? context.mp.textColor,
                    ),
                    if (data.unit != null) ...[
                      const SizedBox(width: 4),
                      MPText.body(
                        data.unit!,
                        color: context.mp.subtitleColor,
                      ),
                    ],
                  ],
                ),

                // Subtitle
                if (data.subtitle != null) ...[
                  const SizedBox(height: 4),
                  MPText.small(
                    data.subtitle!,
                    color: context.mp.subtitleColor,
                  ),
                ],

                // Trend
                if (data.showTrend && data.trend != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        data.trend!.startsWith('+')
                            ? Icons.trending_up
                            : data.trend!.startsWith('-')
                                ? Icons.trending_down
                                : Icons.trending_flat,
                        size: 16,
                        color: data.trendColor ?? context.mp.primary,
                      ),
                      const SizedBox(width: 4),
                      MPText.small(
                        data.trend!,
                        color: data.trendColor ?? context.mp.primary,
                      ),
                    ],
                  ),
                ],
              ],
            ),

            const Spacer(),

            // Chart section
            if (data.chart != null) data.chart!,
          ],
        ),

        // Actions section
        if (data.actions != null && data.actions!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: data.actions!,
          ),
        ],
      ],
    );
  }
}

// Helper functions for building content
Widget _buildMediaContent(MPCardMediaData data) {
  return Builder(
    builder: (context) =>
        _MPCardContentBuilders.buildMediaContent(data, context),
  );
}

Widget _buildContentCard(MPCardContentData data) {
  return Builder(
    builder: (context) =>
        _MPCardContentBuilders.buildContentCardContent(data, context),
  );
}

Widget _buildProductContent(MPCardProductData data) {
  return Builder(
    builder: (context) =>
        _MPCardContentBuilders.buildProductContent(data, context),
  );
}

Widget _buildProfileContent(MPCardProfileData data) {
  return Builder(
    builder: (context) =>
        _MPCardContentBuilders.buildProfileContent(data, context),
  );
}

Widget _buildNotificationContent(MPCardNotificationData data) {
  return Builder(
    builder: (context) =>
        _MPCardContentBuilders.buildNotificationContent(data, context),
  );
}

Widget _buildDashboardContent(MPCardDashboardData data) {
  return Builder(
    builder: (context) =>
        _MPCardContentBuilders.buildDashboardContent(data, context),
  );
}

class _MPCardState extends State<MPCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;
  bool _isExpanded = false;
  bool _isSwiped = false;
  late final FocusNode _focusNode;
  late final AnimationController _animationController;
  late final Animation<double> _expandAnimation;
  late final Animation<double> _swipeAnimation;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);

    // Initialize interactive features
    _isExpanded = widget.interactiveConfig?.initiallyExpanded ?? false;
    _animationController = AnimationController(
      duration: widget.interactiveConfig?.animationDuration ??
          const Duration(milliseconds: 200),
      vsync: this,
    );

    _expandAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _swipeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.removeListener(_handleFocusChange);
      _focusNode.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_isFocused != _focusNode.hasFocus) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardContent = Semantics(
      label: widget.semanticLabel ?? _buildSemanticLabel(),
      hint: widget.semanticHint,
      button: widget.onTap != null,
      selected: widget.selected,
      enabled: widget.enabled,
      child: Container(
        margin: widget.margin ?? _getDefaultMargin(),
        child: Material(
          color: Colors.transparent,
          child: _buildCard(context),
        ),
      ),
    );

    // Apply interactive features if configured
    if (widget.interactiveConfig != null) {
      return _buildInteractiveCard(context, cardContent);
    }

    return cardContent;
  }

  Widget _buildCard(BuildContext context) {
    return MouseRegion(
      onEnter: widget.enabled ? (_) => _handleHoverChange(true) : null,
      onExit: widget.enabled ? (_) => _handleHoverChange(false) : null,
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        onLongPress: widget.enabled ? widget.onLongPress : null,
        onTapDown: widget.enabled ? (_) => _handlePressedChange(true) : null,
        onTapUp: widget.enabled ? (_) => _handlePressedChange(false) : null,
        onTapCancel: widget.enabled ? () => _handlePressedChange(false) : null,
        child: Focus(
          focusNode: _focusNode,
          autofocus: widget.autofocus,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: widget.padding ?? _getDefaultPadding(),
            decoration: BoxDecoration(
              color: _getBackgroundColor(context),
              borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? _getDefaultBorderRadius()),
              border: _getBorder(),
              boxShadow: _getBoxShadow(context),
            ),
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    // If single child is provided, use it directly
    if (widget.child != null) {
      return widget.child!;
    }

    // Build content based on layout
    switch (_getEffectiveLayout()) {
      case MPCardLayout.vertical:
        return _buildVerticalLayout();
      case MPCardLayout.horizontal:
        return _buildHorizontalLayout();
      case MPCardLayout.grid:
        return _buildGridLayout();
      case MPCardLayout.adaptive:
        return _buildAdaptiveLayout();
    }
  }

  Widget _buildVerticalLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: _buildContentChildren(),
    );
  }

  Widget _buildHorizontalLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: _buildHorizontalContentChildren(),
    );
  }

  List<Widget> _buildHorizontalContentChildren() {
    final children = <Widget>[];
    final hasMultipleSections = (_hasHeaderContent() && _hasBodyContent()) ||
        (_hasBodyContent() && _hasFooterContent()) ||
        (_hasHeaderContent() && _hasFooterContent());

    if (!hasMultipleSections) {
      // Simple case: just one section, use regular content children
      return _buildContentChildren();
    }

    // Complex case: multiple sections in horizontal layout
    final headerWidget = _buildHeaderSection();
    final bodyWidget = _buildBodySection();
    final footerWidget = _buildFooterSection();

    if (headerWidget != null) {
      children.add(Expanded(
        flex: 2,
        child: headerWidget,
      ));
    }

    if (bodyWidget != null) {
      if (children.isNotEmpty) {
        children.add(SizedBox(width: _getContentSpacing()));
      }
      children.add(Expanded(
        flex: 3,
        child: widget.enableOverflowHandling
            ? _buildScrollableContent(bodyWidget)
            : bodyWidget,
      ));
    }

    if (footerWidget != null) {
      if (children.isNotEmpty) {
        children.add(SizedBox(width: _getContentSpacing()));
      }
      children.add(Expanded(
        flex: 1,
        child: footerWidget,
      ));
    }

    return children;
  }

  Widget _buildGridLayout() {
    // For now, fall back to vertical layout
    // Grid layout will be implemented in future enhancements
    return _buildVerticalLayout();
  }

  Widget _buildAdaptiveLayout() {
    final screenWidth = MediaQuery.of(context).size.width;
    final config = widget.responsive;

    if (config != null) {
      if (screenWidth <= (config.mobileMaxWidth ?? MPCardBreakpoints.mobile)) {
        return _buildVerticalLayout();
      } else if (screenWidth <=
          (config.tabletMaxWidth ?? MPCardBreakpoints.tablet)) {
        return config.tabletLayout == MPCardLayout.horizontal
            ? _buildHorizontalLayout()
            : _buildVerticalLayout();
      } else {
        return config.desktopLayout == MPCardLayout.horizontal
            ? _buildHorizontalLayout()
            : _buildVerticalLayout();
      }
    }

    return _buildVerticalLayout();
  }

  List<Widget> _buildContentChildren() {
    final children = <Widget>[];

    // Build header section
    final headerWidget = _buildHeaderSection();
    if (headerWidget != null) {
      children.add(headerWidget);
      if (_hasBodyContent() || _hasFooterContent()) {
        children.add(SizedBox(height: _getContentSpacing()));
      }
    }

    // Build body section
    final bodyWidget = _buildBodySection();
    if (bodyWidget != null) {
      children.add(Expanded(child: bodyWidget));
      if (_hasFooterContent()) {
        children.add(SizedBox(height: _getContentSpacing()));
      }
    }

    // Build footer section
    final footerWidget = _buildFooterSection();
    if (footerWidget != null) {
      children.add(footerWidget);
    }

    return children;
  }

  Widget? _buildHeaderSection() {
    // Use custom header widget if provided
    if (widget.header != null) {
      return widget.header!;
    }

    // Build structured header from headerData
    if (widget.headerData != null) {
      return _buildStructuredHeader();
    }

    return null;
  }

  Widget _buildStructuredHeader() {
    final headerData = widget.headerData!;
    final defaultPadding = _getHeaderPadding();

    return Padding(
      padding: headerData.padding ?? defaultPadding,
      child: Row(
        crossAxisAlignment:
            headerData.crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment:
            headerData.mainAxisAlignment ?? MainAxisAlignment.start,
        children: [
          // Leading widget
          if (headerData.leading != null) ...[
            headerData.leading!,
            const SizedBox(width: 12),
          ],

          // Title and subtitle column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                if (headerData.titleWidget != null)
                  headerData.titleWidget!
                else if (headerData.title != null)
                  MPText.subhead(
                    headerData.title!,
                    color: context.mp.textColor,
                    fontWeight: FontWeight.w600,
                  ),

                // Subtitle
                if (headerData.subtitleWidget != null ||
                    headerData.subtitle != null) ...[
                  const SizedBox(height: 4),
                  if (headerData.subtitleWidget != null)
                    headerData.subtitleWidget!
                  else if (headerData.subtitle != null)
                    MPText.small(
                      headerData.subtitle!,
                      color: context.mp.subtitleColor,
                    ),
                ],
              ],
            ),
          ),

          // Actions
          if (headerData.actions != null && headerData.actions!.isNotEmpty) ...[
            const SizedBox(width: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: headerData.actions!,
            ),
          ],
        ],
      ),
    );
  }

  Widget? _buildBodySection() {
    if (widget.body != null) {
      return widget.enableOverflowHandling
          ? _buildScrollableContent(widget.body!)
          : widget.body!;
    }

    if (widget.child != null) {
      return widget.enableOverflowHandling
          ? _buildScrollableContent(widget.child!)
          : widget.child!;
    }

    return null;
  }

  Widget _buildScrollableContent(Widget content) {
    return SingleChildScrollView(
      clipBehavior: widget.clipBehavior,
      child: content,
    );
  }

  Widget? _buildFooterSection() {
    // Use custom footer widget if provided
    if (widget.footer != null) {
      return widget.footer!;
    }

    // Build structured footer from footerData
    if (widget.footerData != null) {
      return _buildStructuredFooter();
    }

    return null;
  }

  Widget _buildStructuredFooter() {
    final footerData = widget.footerData!;
    final defaultPadding = _getFooterPadding();

    return Padding(
      padding: footerData.padding ?? defaultPadding,
      child: Row(
        crossAxisAlignment:
            footerData.crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment:
            footerData.mainAxisAlignment ?? MainAxisAlignment.end,
        children: [
          // Custom content
          if (footerData.content != null) ...[
            Expanded(
              child: footerData.content!,
            ),
            const SizedBox(width: 12),
          ],

          // Actions
          if (footerData.actions != null && footerData.actions!.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: footerData.actions!,
            ),
        ],
      ),
    );
  }

  bool _hasHeaderContent() {
    return widget.header != null || widget.headerData != null;
  }

  bool _hasBodyContent() {
    return widget.body != null || widget.child != null;
  }

  bool _hasFooterContent() {
    return widget.footer != null || widget.footerData != null;
  }

  EdgeInsets _getHeaderPadding() {
    switch (widget.size) {
      case MPCardSize.small:
        return const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);
      case MPCardSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
      case MPCardSize.large:
        return const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);
      case MPCardSize.xlarge:
        return const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0);
      case MPCardSize.fluid:
        return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
    }
  }

  EdgeInsets _getFooterPadding() {
    switch (widget.size) {
      case MPCardSize.small:
        return const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);
      case MPCardSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
      case MPCardSize.large:
        return const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);
      case MPCardSize.xlarge:
        return const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0);
      case MPCardSize.fluid:
        return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
    }
  }

  MPCardLayout _getEffectiveLayout() {
    if (widget.layout == MPCardLayout.adaptive) {
      final screenWidth = MediaQuery.of(context).size.width;
      final config = widget.responsive;

      if (config != null) {
        if (screenWidth <=
            (config.mobileMaxWidth ?? MPCardBreakpoints.mobile)) {
          return config.mobileLayout ?? MPCardLayout.vertical;
        } else if (screenWidth <=
            (config.tabletMaxWidth ?? MPCardBreakpoints.tablet)) {
          return config.tabletLayout ?? MPCardLayout.horizontal;
        } else {
          return config.desktopLayout ?? MPCardLayout.horizontal;
        }
      }
    }

    return widget.layout;
  }

  Color _getBackgroundColor(BuildContext context) {
    // Priority: custom > theme > variant-based
    if (widget.backgroundColor != null) return widget.backgroundColor!;
    if (widget.themeData?.backgroundColor != null)
      return widget.themeData!.backgroundColor!;

    switch (widget.variant) {
      case MPCardVariant.primary:
        return context.mp.primary.withValues(alpha: 0.1);
      case MPCardVariant.secondary:
        return context.mp.neutral20;
      case MPCardVariant.surface:
        return context.mp.adaptiveBackgroundColor;
      case MPCardVariant.elevated:
        return context.mp.adaptiveBackgroundColor;
      case MPCardVariant.outlined:
        return context.mp.adaptiveBackgroundColor;
      case MPCardVariant.filled:
        return context.mp.neutral20;
      case MPCardVariant.interactive:
        return context.mp.primarySurface;
      case MPCardVariant.display:
        return context.mp.adaptiveBackgroundColor;
      case MPCardVariant.glass:
        return context.mp.neutral100.withValues(alpha: 0.1);
      case MPCardVariant.media:
        return context.mp.adaptiveBackgroundColor;
      case MPCardVariant.content:
        return context.mp.adaptiveBackgroundColor;
      case MPCardVariant.product:
        return context.mp.adaptiveBackgroundColor;
      case MPCardVariant.profile:
        return context.mp.adaptiveBackgroundColor;
      case MPCardVariant.notification:
        return _isPressed || _isHovered
            ? context.mp.neutral10
            : context.mp.adaptiveBackgroundColor;
      case MPCardVariant.dashboard:
        return context.mp.adaptiveBackgroundColor;
    }
  }

  Border? _getBorder() {
    if (widget.variant == MPCardVariant.outlined ||
        widget.borderWidth != null) {
      return Border.all(
        color: widget.borderColor ?? context.mp.adaptiveBorderColor,
        width: widget.borderWidth ?? 1.0,
      );
    }
    return null;
  }

  List<BoxShadow> _getBoxShadow(BuildContext context) {
    final elevation = _getResponsiveElevation();

    // Only apply shadow if elevation is greater than 0
    if (elevation > 0) {
      final shadowColor =
          widget.themeData?.shadowColor ?? context.mp.adaptiveShadowColor;
      final blurRadius = _isHovered ? elevation * 1.5 : elevation;
      final offset = Offset(0, _isHovered ? elevation * 0.5 : elevation * 0.25);

      // For higher elevations, add multiple shadows for better depth
      if (elevation >= MPCardElevationConstants.level8) {
        return [
          // Primary shadow
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.3),
            blurRadius: blurRadius * 0.5,
            offset: Offset(0, elevation * 0.1),
          ),
          // Secondary shadow
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.2),
            blurRadius: blurRadius * 0.8,
            offset: Offset(0, elevation * 0.2),
          ),
          // Main shadow
          BoxShadow(
            color: shadowColor,
            blurRadius: blurRadius,
            offset: offset,
          ),
        ];
      } else {
        return [
          BoxShadow(
            color: shadowColor,
            blurRadius: blurRadius,
            offset: offset,
          ),
        ];
      }
    }
    return [];
  }

  Color _getInteractionColor(BuildContext context) {
    if (!widget.enabled) return context.mp.disabledColor;
    if (widget.selected) return _getSelectedColor(context);
    if (_isPressed) return _getPressedColor(context);
    if (_isHovered) return _getHoverColor(context);
    if (_isFocused) return _getFocusColor(context);
    return _getBackgroundColor(context);
  }

  Color _getHoverColor(BuildContext context) {
    if (widget.themeData?.hoverColor != null)
      return widget.themeData!.hoverColor!;

    switch (widget.variant) {
      case MPCardVariant.primary:
        return context.mp.primaryHover.withValues(alpha: 0.1);
      case MPCardVariant.interactive:
        return context.mp.primaryHover.withValues(alpha: 0.1);
      default:
        return context.mp.neutral30;
    }
  }

  Color _getPressedColor(BuildContext context) {
    if (widget.themeData?.pressedColor != null)
      return widget.themeData!.pressedColor!;

    switch (widget.variant) {
      case MPCardVariant.primary:
        return context.mp.primaryPressed.withValues(alpha: 0.1);
      case MPCardVariant.interactive:
        return context.mp.primaryPressed.withValues(alpha: 0.1);
      default:
        return context.mp.neutral40;
    }
  }

  Color _getFocusColor(BuildContext context) {
    if (widget.themeData?.focusColor != null)
      return widget.themeData!.focusColor!;

    switch (widget.variant) {
      case MPCardVariant.primary:
        return context.mp.primaryFocus.withValues(alpha: 0.1);
      case MPCardVariant.interactive:
        return context.mp.primaryFocus.withValues(alpha: 0.1);
      default:
        return context.mp.neutral20;
    }
  }

  Color _getSelectedColor(BuildContext context) {
    if (widget.themeData?.selectedColor != null)
      return widget.themeData!.selectedColor!;

    switch (widget.variant) {
      case MPCardVariant.primary:
      case MPCardVariant.interactive:
        return context.mp.primary.withValues(alpha: 0.2);
      default:
        return context.mp.neutral20;
    }
  }

  double _getDefaultBorderRadius() {
    switch (widget.size) {
      case MPCardSize.small:
        return 8.0;
      case MPCardSize.medium:
        return 12.0;
      case MPCardSize.large:
        return 16.0;
      case MPCardSize.xlarge:
        return 20.0;
      case MPCardSize.fluid:
        return 12.0;
    }
  }

  EdgeInsets _getDefaultPadding() {
    switch (widget.size) {
      case MPCardSize.small:
        return const EdgeInsets.all(12.0);
      case MPCardSize.medium:
        return const EdgeInsets.all(16.0);
      case MPCardSize.large:
        return const EdgeInsets.all(20.0);
      case MPCardSize.xlarge:
        return const EdgeInsets.all(24.0);
      case MPCardSize.fluid:
        return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0);
    }
  }

  EdgeInsets _getDefaultMargin() {
    switch (widget.size) {
      case MPCardSize.small:
        return const EdgeInsets.all(4.0);
      case MPCardSize.medium:
        return const EdgeInsets.all(8.0);
      case MPCardSize.large:
        return const EdgeInsets.all(12.0);
      case MPCardSize.xlarge:
        return const EdgeInsets.all(16.0);
      case MPCardSize.fluid:
        return EdgeInsets.zero;
    }
  }

  double _getContentSpacing() {
    switch (widget.size) {
      case MPCardSize.small:
        return 8.0;
      case MPCardSize.medium:
        return 12.0;
      case MPCardSize.large:
        return 16.0;
      case MPCardSize.xlarge:
        return 20.0;
      case MPCardSize.fluid:
        return 12.0;
    }
  }

  String _buildSemanticLabel() {
    final parts = <String>[];
    if (_hasHeaderContent()) parts.add('Card with header');
    if (_hasBodyContent()) parts.add('and content');
    if (_hasFooterContent()) parts.add('and footer');
    if (widget.onTap != null) parts.add('Interactive card');
    return parts.join(', ');
  }

  void _handleHoverChange(bool isHovered) {
    if (_isHovered != isHovered) {
      setState(() {
        _isHovered = isHovered;
      });
      widget.onHover?.call(isHovered);
    }
  }

  void _handlePressedChange(bool isPressed) {
    if (_isPressed != isPressed) {
      setState(() {
        _isPressed = isPressed;
      });
    }
  }

  /// Gets the current elevation value for the card
  double get _getElevation {
    // Priority: custom elevation > elevation level > variant-based default
    if (widget.elevation != null) return widget.elevation!;
    if (widget.elevationLevel != null)
      return MPCardElevationConstants.getValue(widget.elevationLevel!);

    // Default elevation based on variant
    return _getDefaultElevationForVariant();
  }

  /// Gets the default elevation for each card variant
  double _getDefaultElevationForVariant() {
    switch (widget.variant) {
      case MPCardVariant.elevated:
        return MPCardElevationConstants.level4;
      case MPCardVariant.outlined:
        return MPCardElevationConstants.level0;
      case MPCardVariant.filled:
        return MPCardElevationConstants.level2;
      case MPCardVariant.primary:
        return MPCardElevationConstants.level2;
      case MPCardVariant.secondary:
        return MPCardElevationConstants.level1;
      case MPCardVariant.surface:
        return MPCardElevationConstants.level1;
      case MPCardVariant.interactive:
        return MPCardElevationConstants.level3;
      case MPCardVariant.display:
        return MPCardElevationConstants.level8;
      case MPCardVariant.glass:
        return MPCardElevationConstants.level4;
      case MPCardVariant.media:
        return MPCardElevationConstants.level2;
      case MPCardVariant.content:
        return MPCardElevationConstants.level1;
      case MPCardVariant.product:
        return MPCardElevationConstants.level3;
      case MPCardVariant.profile:
        return MPCardElevationConstants.level2;
      case MPCardVariant.notification:
        return MPCardElevationConstants.level1;
      case MPCardVariant.dashboard:
        return MPCardElevationConstants.level2;
    }
  }

  /// Gets responsive elevation based on card size
  double _getResponsiveElevation() {
    double baseElevation = _getElevation;

    // Adjust elevation based on card size
    switch (widget.size) {
      case MPCardSize.small:
        return baseElevation * 0.75; // Reduce elevation for small cards
      case MPCardSize.medium:
        return baseElevation; // Keep base elevation for medium cards
      case MPCardSize.large:
        return baseElevation * 1.25; // Increase elevation for large cards
      case MPCardSize.xlarge:
        return baseElevation * 1.5; // Further increase for extra large cards
      case MPCardSize.fluid:
        return baseElevation; // Keep base elevation for fluid cards
    }
  }

  /// Gets the current elevation value (public getter)
  /// Builds interactive card with gesture handling
  Widget _buildInteractiveCard(BuildContext context, Widget cardContent) {
    final config = widget.interactiveConfig;

    // If no interactive config, return regular card
    if (config == null) {
      return cardContent;
    }

    // Handle swipe-to-dismiss functionality
    if (config.enableSwipeToDismiss) {
      return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            config.onSwipeRight?.call();
          } else {
            config.onSwipeLeft?.call();
          }
          config.onDismiss?.call();
        },
        child: _buildInteractiveContent(context, cardContent, config),
      );
    }

    return _buildInteractiveContent(context, cardContent, config);
  }

  /// Builds interactive content with quick actions and expandable features
  Widget _buildInteractiveContent(BuildContext context, Widget cardContent,
      MPCardInteractiveConfig config) {
    // Handle expandable content
    if (config.enableExpandable) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main content with animation
          AnimatedSize(
            duration: config.animationDuration,
            curve: Curves.easeInOut,
            child:
                _isExpanded ? cardContent : _buildCollapsedContent(cardContent),
          ),

          // Expand/collapse toggle
          if (config.onExpand != null || config.onCollapse != null) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _toggleExpanded,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: context.mp.neutral20,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MPText.small(
                      _isExpanded ? 'Collapse' : 'Expand',
                      color: context.mp.primary,
                    ),
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0.0,
                      duration: config.animationDuration,
                      child: Icon(
                        Icons.expand_more,
                        color: context.mp.primary,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      );
    }

    // Handle quick actions on hover
    if (config.enableQuickActions && config.quickActions != null) {
      return Stack(
        children: [
          cardContent,
          AnimatedOpacity(
            opacity: _isHovered ? 1.0 : 0.0,
            duration: config.animationDuration,
            child: Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: context.mp.adaptiveBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: context.mp.adaptiveShadowColor,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: config.quickActions!,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return cardContent;
  }

  /// Builds collapsed content for expandable cards
  Widget _buildCollapsedContent(Widget fullContent) {
    // For now, we'll use a simple height constraint
    // In a more sophisticated implementation, you might want to
    // selectively show/hide specific content sections
    return SizedBox(
      height: 100, // Fixed height when collapsed
      child: ClipRect(
        child: fullContent,
      ),
    );
  }

  /// Handles swipe gesture updates
  void _handleSwipeUpdate(DragUpdateDetails details) {
    final config = widget.interactiveConfig;
    if (config == null || !config.enableSwipeToDismiss) return;

    setState(() {
      _isSwiped =
          details.primaryDelta != null && details.primaryDelta!.abs() > 50;
    });
  }

  /// Handles swipe gesture end
  void _handleSwipeEnd(DragEndDetails details) {
    final config = widget.interactiveConfig;
    if (config == null || !config.enableSwipeToDismiss) return;

    if (_isSwiped) {
      if (details.primaryVelocity! > 0) {
        config.onSwipeRight?.call();
      } else {
        config.onSwipeLeft?.call();
      }
    }

    setState(() {
      _isSwiped = false;
    });
  }

  /// Toggles expanded state
  void _toggleExpanded() {
    final config = widget.interactiveConfig;
    if (config == null || !config.enableExpandable) return;

    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
        config.onExpand?.call();
      } else {
        _animationController.reverse();
        config.onCollapse?.call();
      }
    });
  }

  double get currentElevation => _getResponsiveElevation();
}
