import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Builder pattern implementation for optimized MPCard rendering
///
/// This class provides a fluent API for building cards with conditional
/// rendering to avoid unnecessary widget creation and improve performance.
class MPCardBuilder {
  // Card configuration
  MPCardVariant _variant = MPCardVariant.surface;
  MPCardSize _size = MPCardSize.medium;
  MPCardLayout _layout = MPCardLayout.vertical;
  MPCardResponsiveConfig? _responsive;
  Color? _backgroundColor;
  Color? _borderColor;
  double? _borderWidth;
  double? _borderRadius;
  double? _elevation;
  MPCardElevation? _elevationLevel;
  EdgeInsets? _padding;
  EdgeInsets? _margin;

  // Content
  Widget? _header;
  MPCardHeaderData? _headerData;
  Widget? _body;
  Widget? _footer;
  MPCardFooterData? _footerData;

  // Interaction
  VoidCallback? _onTap;
  VoidCallback? _onLongPress;
  ValueChanged<bool>? _onHover;
  bool _enabled = true;
  bool _selectable = false;
  bool _selected = false;

  // Advanced features
  bool _enableOverflowHandling = true;
  Clip _clipBehavior = Clip.antiAlias;
  MPCardInteractiveConfig? _interactiveConfig;
  MPCardInteractionConfig? _interactionConfig;
  MPCardAccessibilityConfig? _accessibilityConfig;

  // Performance optimization flags
  bool _useLazyRendering = true;
  bool _useConditionalRendering = true;

  /// Creates a new MPCardBuilder instance
  MPCardBuilder();

  /// Creates a builder from existing card configuration
  MPCardBuilder.fromCard(MPCard card) {
    _variant = card.variant;
    _size = card.size;
    _layout = card.layout;
    _responsive = card.responsive;
    _backgroundColor = card.backgroundColor;
    _borderColor = card.borderColor;
    _borderWidth = card.borderWidth;
    _borderRadius = card.borderRadius;
    _elevation = card.elevation;
    _elevationLevel = card.elevationLevel;
    _padding = card.padding;
    _margin = card.margin;

    _header = card.header;
    _headerData = card.headerData;
    _body = card.body;
    _footer = card.footer;
    _footerData = card.footerData;

    _onTap = card.onTap;
    _onLongPress = card.onLongPress;
    _onHover = card.onHover;
    _enabled = card.enabled;
    _selectable = card.selectable;
    _selected = card.selected;

    _enableOverflowHandling = card.enableOverflowHandling;
    _clipBehavior = card.clipBehavior;
    _interactiveConfig = card.interactiveConfig;
    _interactionConfig = card.interactionConfig;
    _accessibilityConfig = card.accessibilityConfig;
  }

  // Configuration setters with fluent interface
  MPCardBuilder variant(MPCardVariant variant) {
    _variant = variant;
    return this;
  }

  MPCardBuilder size(MPCardSize size) {
    _size = size;
    return this;
  }

  MPCardBuilder layout(MPCardLayout layout) {
    _layout = layout;
    return this;
  }

  MPCardBuilder responsive(MPCardResponsiveConfig responsive) {
    _responsive = responsive;
    return this;
  }

  MPCardBuilder backgroundColor(Color color) {
    _backgroundColor = color;
    return this;
  }

  MPCardBuilder borderColor(Color color) {
    _borderColor = color;
    return this;
  }

  MPCardBuilder borderWidth(double width) {
    _borderWidth = width;
    return this;
  }

  MPCardBuilder borderRadius(double radius) {
    _borderRadius = radius;
    return this;
  }

  MPCardBuilder elevation(double elevation) {
    _elevation = elevation;
    return this;
  }

  MPCardBuilder elevationLevel(MPCardElevation level) {
    _elevationLevel = level;
    return this;
  }

  MPCardBuilder padding(EdgeInsets padding) {
    _padding = padding;
    return this;
  }

  MPCardBuilder margin(EdgeInsets margin) {
    _margin = margin;
    return this;
  }

  // Content setters
  MPCardBuilder header(Widget header) {
    _header = header;
    return this;
  }

  MPCardBuilder headerData(MPCardHeaderData headerData) {
    _headerData = headerData;
    return this;
  }

  MPCardBuilder body(Widget body) {
    _body = body;
    return this;
  }

  MPCardBuilder footer(Widget footer) {
    _footer = footer;
    return this;
  }

  MPCardBuilder footerData(MPCardFooterData footerData) {
    _footerData = footerData;
    return this;
  }

  // Interaction setters
  MPCardBuilder onTap(VoidCallback onTap) {
    _onTap = onTap;
    return this;
  }

  MPCardBuilder onLongPress(VoidCallback onLongPress) {
    _onLongPress = onLongPress;
    return this;
  }

  MPCardBuilder onHover(ValueChanged<bool> onHover) {
    _onHover = onHover;
    return this;
  }

  MPCardBuilder enabled(bool enabled) {
    _enabled = enabled;
    return this;
  }

  MPCardBuilder selectable(bool selectable) {
    _selectable = selectable;
    return this;
  }

  MPCardBuilder selected(bool selected) {
    _selected = selected;
    return this;
  }

  // Advanced feature setters
  MPCardBuilder overflowHandling(bool enabled) {
    _enableOverflowHandling = enabled;
    return this;
  }

  MPCardBuilder clipBehavior(Clip behavior) {
    _clipBehavior = behavior;
    return this;
  }

  MPCardBuilder interactiveConfig(MPCardInteractiveConfig config) {
    _interactiveConfig = config;
    return this;
  }

  MPCardBuilder interactionConfig(MPCardInteractionConfig config) {
    _interactionConfig = config;
    return this;
  }

  MPCardBuilder accessibilityConfig(MPCardAccessibilityConfig config) {
    _accessibilityConfig = config;
    return this;
  }

  // Performance optimization setters
  MPCardBuilder lazyRendering(bool enabled) {
    _useLazyRendering = enabled;
    return this;
  }

  MPCardBuilder conditionalRendering(bool enabled) {
    _useConditionalRendering = enabled;
    return this;
  }

  // Convenience factory methods
  MPCardBuilder primary() => variant(MPCardVariant.primary);
  MPCardBuilder secondary() => variant(MPCardVariant.secondary);
  MPCardBuilder elevated() => variant(MPCardVariant.elevated);
  MPCardBuilder outlined() => variant(MPCardVariant.outlined);
  MPCardBuilder filled() => variant(MPCardVariant.filled);
  MPCardBuilder interactive() => variant(MPCardVariant.interactive);

  MPCardBuilder small() => size(MPCardSize.small);
  MPCardBuilder medium() => size(MPCardSize.medium);
  MPCardBuilder large() => size(MPCardSize.large);
  MPCardBuilder xlarge() => size(MPCardSize.xlarge);

  MPCardBuilder vertical() => layout(MPCardLayout.vertical);
  MPCardBuilder horizontal() => layout(MPCardLayout.horizontal);
  MPCardBuilder adaptive() => layout(MPCardLayout.adaptive);

  // Content convenience methods
  MPCardBuilder title(String title) {
    _headerData ??= MPCardHeaderData();
    _headerData = MPCardHeaderData(
      title: title,
      subtitle: _headerData!.subtitle,
      actions: _headerData!.actions,
      leading: _headerData!.leading,
      padding: _headerData!.padding,
    );
    return this;
  }

  MPCardBuilder subtitle(String subtitle) {
    _headerData ??= MPCardHeaderData();
    _headerData = MPCardHeaderData(
      title: _headerData!.title,
      subtitle: subtitle,
      actions: _headerData!.actions,
      leading: _headerData!.leading,
      padding: _headerData!.padding,
    );
    return this;
  }

  MPCardBuilder content(Widget content) {
    _body = content;
    return this;
  }

  MPCardBuilder actions(List<Widget> actions) {
    _footerData = MPCardFooterData(actions: actions);
    return this;
  }

  MPCardBuilder action(Widget action) {
    final currentActions = _footerData?.actions ?? <Widget>[];
    _footerData = MPCardFooterData(actions: [...currentActions, action]);
    return this;
  }

  // Layout convenience methods
  MPCardBuilder spacing(double spacing) {
    _padding = EdgeInsets.all(spacing);
    return this;
  }

  MPCardBuilder spacingSymmetric(
      {double horizontal = 16.0, double vertical = 12.0}) {
    _padding = EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
    return this;
  }

  MPCardBuilder spacingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    _padding =
        EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
    return this;
  }

  // Conditional rendering methods
  MPCardBuilder when(bool condition, MPCardBuilder Function() builder) {
    if (_useConditionalRendering && condition) {
      return builder();
    }
    return this;
  }

  MPCardBuilder whenNotNull<T>(
      T? value, MPCardBuilder Function(T value) builder) {
    if (_useConditionalRendering && value != null) {
      return builder(value);
    }
    return this;
  }

  MPCardBuilder whenNotEmpty(
      String? value, MPCardBuilder Function(String value) builder) {
    if (_useConditionalRendering && value != null && value.isNotEmpty) {
      return builder(value);
    }
    return this;
  }

  MPCardBuilder whenListNotEmpty<T>(
      List<T>? list, MPCardBuilder Function(List<T> list) builder) {
    if (_useConditionalRendering && list != null && list.isNotEmpty) {
      return builder(list);
    }
    return this;
  }

  /// Builds the optimized MPCard widget
  Widget build() {
    if (_useLazyRendering) {
      return _buildOptimized();
    } else {
      return _buildBasicCard();
    }
  }

  /// Builds the optimized card with lazy rendering
  Widget _buildOptimized() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _conditionalBuild(context, constraints);
      },
    );
  }

  /// Builds with conditional rendering based on content availability
  Widget _conditionalBuild(BuildContext context, BoxConstraints constraints) {
    // Early return for empty content
    if (!_hasAnyContent()) {
      return const SizedBox.shrink();
    }

    // Use different build strategies based on content complexity
    if (_isSimpleContent()) {
      return _buildSimpleCard(context);
    } else if (_isComplexContent()) {
      return _buildComplexCard(context);
    } else {
      return _buildStandardCard(context);
    }
  }

  /// Build simple card with minimal overhead
  Widget _buildSimpleCard(BuildContext context) {
    return Container(
      margin: _margin,
      decoration: _buildBoxDecoration(context),
      child: _buildSimpleContent(context),
    );
  }

  /// Build standard card with all features
  Widget _buildStandardCard(BuildContext context) {
    return MPCard(
      variant: _variant,
      size: _size,
      layout: _layout,
      responsive: _responsive,
      backgroundColor: _backgroundColor,
      borderColor: _borderColor,
      borderWidth: _borderWidth,
      borderRadius: _borderRadius,
      elevation: _elevation,
      elevationLevel: _elevationLevel,
      padding: _padding,
      margin: _margin,
      header: _header,
      headerData: _headerData,
      body: _body,
      footer: _footer,
      footerData: _footerData,
      onTap: _onTap,
      onLongPress: _onLongPress,
      onHover: _onHover,
      enabled: _enabled,
      selectable: _selectable,
      selected: _selected,
      enableOverflowHandling: _enableOverflowHandling,
      clipBehavior: _clipBehavior,
      interactiveConfig: _interactiveConfig,
      interactionConfig: _interactionConfig,
      accessibilityConfig: _accessibilityConfig,
    );
  }

  /// Build complex card with advanced optimizations
  Widget _buildComplexCard(BuildContext context) {
    return RepaintBoundary(
      child: _buildStandardCard(context),
    );
  }

  BoxDecoration _buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: _getBackgroundColor(context),
      borderRadius: BorderRadius.circular(_borderRadius ?? 8.0),
      border: _buildBorder(),
      boxShadow: _buildBoxShadow(context),
    );
  }

  Widget _buildSimpleContent(BuildContext context) {
    return Padding(
      padding: _padding ?? const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_headerData?.title != null) ...[
            _buildSimpleHeader(context),
            const SizedBox(height: 8),
          ],
          if (_body != null) ...[
            _body!,
            const SizedBox(height: 8),
          ],
          if (_footerData?.actions != null) _buildSimpleFooter(context),
        ],
      ),
    );
  }

  Widget _buildSimpleHeader(BuildContext context) {
    return Text(
      _headerData!.title!,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }

  Widget _buildSimpleFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _footerData!.actions!,
    );
  }

  bool _hasAnyContent() {
    return _header != null ||
        _headerData != null ||
        _body != null ||
        _footer != null ||
        _footerData != null;
  }

  bool _isSimpleContent() {
    return (_headerData?.title != null || _header != null) &&
        _body != null &&
        _footerData?.actions == null &&
        _variant == MPCardVariant.surface;
  }

  bool _isComplexContent() {
    return _responsive != null ||
        _interactiveConfig != null ||
        _interactionConfig != null ||
        _accessibilityConfig != null ||
        _enableOverflowHandling;
  }

  Color _getBackgroundColor(BuildContext context) {
    if (_backgroundColor != null) return _backgroundColor!;

    switch (_variant) {
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
        return context.mp.adaptiveBackgroundColor;
      case MPCardVariant.dashboard:
        return context.mp.adaptiveBackgroundColor;
    }
  }

  Border? _buildBorder() {
    if (_variant == MPCardVariant.outlined || _borderWidth != null) {
      return Border.all(
        color: _borderColor ?? Colors.grey.shade300,
        width: _borderWidth ?? 1.0,
      );
    }
    return null;
  }

  List<BoxShadow> _buildBoxShadow(BuildContext context) {
    final elevation = _elevation ?? 0.0;

    if (elevation > 0) {
      return [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: elevation,
          offset: Offset(0, elevation * 0.25),
        ),
      ];
    }
    return [];
  }

  /// Builds a basic card without optimizations
  Widget _buildBasicCard() {
    return Builder(
      builder: (context) {
        return MPCard(
          variant: _variant,
          size: _size,
          layout: _layout,
          responsive: _responsive,
          backgroundColor: _backgroundColor,
          borderColor: _borderColor,
          borderWidth: _borderWidth,
          borderRadius: _borderRadius,
          elevation: _elevation,
          elevationLevel: _elevationLevel,
          padding: _padding,
          margin: _margin,
          header: _header,
          headerData: _headerData,
          body: _body,
          footer: _footer,
          footerData: _footerData,
          onTap: _onTap,
          onLongPress: _onLongPress,
          onHover: _onHover,
          enabled: _enabled,
          selectable: _selectable,
          selected: _selected,
          enableOverflowHandling: _enableOverflowHandling,
          clipBehavior: _clipBehavior,
          interactiveConfig: _interactiveConfig,
          interactionConfig: _interactionConfig,
          accessibilityConfig: _accessibilityConfig,
        );
      },
    );
  }
}

/// Extension methods for easier MPCardBuilder usage
extension MPCardBuilderExtensions on MPCardBuilder {
  /// Convert builder to standard MPCard
  MPCard toCard() {
    final built = build();
    if (built is MPCard) {
      return built;
    }

    // Extract the configuration and create MPCard
    return MPCard(
      variant: _variant,
      size: _size,
      layout: _layout,
      responsive: _responsive,
      backgroundColor: _backgroundColor,
      borderColor: _borderColor,
      borderWidth: _borderWidth,
      borderRadius: _borderRadius,
      elevation: _elevation,
      elevationLevel: _elevationLevel,
      padding: _padding,
      margin: _margin,
      header: _header,
      headerData: _headerData,
      body: _body,
      footer: _footer,
      footerData: _footerData,
      onTap: _onTap,
      onLongPress: _onLongPress,
      onHover: _onHover,
      enabled: _enabled,
      selectable: _selectable,
      selected: _selected,
      enableOverflowHandling: _enableOverflowHandling,
      clipBehavior: _clipBehavior,
      interactiveConfig: _interactiveConfig,
      interactionConfig: _interactionConfig,
      accessibilityConfig: _accessibilityConfig,
    );
  }
}
