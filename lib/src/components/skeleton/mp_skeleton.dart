import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

/// A skeleton widget for loading states with customizable appearance
///
/// This widget provides skeleton loading animations that match the
/// expected content layout, improving perceived performance.
class MPSkeleton extends StatefulWidget {
  /// Creates a skeleton widget with default appearance
  const MPSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.isCircle = false,
    this.semanticLabel,
    this.semanticHint,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.focusNode,
    this.enableKeyboardNavigation = true,
  });

  /// Creates a skeleton for text content
  const MPSkeleton.text({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.semanticLabel,
    this.semanticHint,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.focusNode,
    this.enableKeyboardNavigation = true,
  }) : isCircle = false;

  /// Creates a skeleton for avatar or circular content
  const MPSkeleton.avatar({
    super.key,
    this.width = 48,
    this.height = 48,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.semanticLabel,
    this.semanticHint,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.focusNode,
    this.enableKeyboardNavigation = true,
  }) : isCircle = true;

  /// Creates a skeleton for button content
  const MPSkeleton.button({
    super.key,
    this.width,
    this.height = 40,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.semanticLabel,
    this.semanticHint,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.focusNode,
    this.enableKeyboardNavigation = true,
  }) : isCircle = false;

  /// Width of skeleton
  final double? width;

  /// Height of skeleton
  final double? height;

  /// Border radius of skeleton
  final BorderRadius? borderRadius;

  /// Base color of skeleton
  final Color? baseColor;

  /// Highlight color for shimmer effect
  final Color? highlightColor;

  /// Whether to render as circular skeleton
  final bool isCircle;

  /// Semantic label for screen readers
  final String? semanticLabel;

  /// Semantic hint for screen readers
  final String? semanticHint;

  /// Custom accessibility actions
  final List<SemanticsAction>? customAccessibilityActions;

  /// Callback for accessibility actions
  final void Function(SemanticsAction)? onAccessibilityAction;

  /// Focus node for keyboard navigation
  final FocusNode? focusNode;

  /// Whether to enable keyboard navigation
  final bool enableKeyboardNavigation;

  @override
  State<MPSkeleton> createState() => _MPSkeletonState();
}

class _MPSkeletonState extends State<MPSkeleton> {
  bool _isLandscape = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateOrientation();
  }

  void _updateOrientation() {
    final newOrientation = MediaQuery.of(context).orientation;
    final newIsLandscape = newOrientation == Orientation.landscape;

    if (_isLandscape != newIsLandscape) {
      setState(() {
        _isLandscape = newIsLandscape;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Enhanced skeleton with theme-aware colors and shimmer effect
    Widget skeletonContent = _buildEnhancedSkeleton(theme);

    // Wrap with Semantics widget for accessibility
    return Semantics(
      label: widget.semanticLabel ?? 'Loading content',
      hint: widget.semanticHint ?? 'Content is currently loading',
      // Mark as hidden for screen readers since it's just a loading indicator
      hidden: true,
      // Add custom accessibility actions if provided
      customSemanticsActions: _getCustomSemanticsActions(),
      child: widget.enableKeyboardNavigation && widget.focusNode != null
          ? Focus(
              focusNode: widget.focusNode,
              // Add keyboard navigation callbacks
              onKey: (node, event) {
                return _handleKeyPress(event);
              },
              child: skeletonContent,
            )
          : skeletonContent,
    );
  }

  Widget _buildEnhancedSkeleton(ThemeData theme) {
    final effectiveBaseColor =
        widget.baseColor ?? theme.colorScheme.surfaceContainerHighest;
    final effectiveHighlightColor = widget.highlightColor ??
        theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);

    // Get orientation-aware dimensions
    final orientationAwareWidth = _getOrientationAwareWidth();
    final orientationAwareHeight = _getOrientationAwareHeight();
    final orientationAwareBorderRadius = _getOrientationAwareBorderRadius();

    if (widget.isCircle) {
      return Container(
        width: orientationAwareWidth,
        height: orientationAwareHeight,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: effectiveBaseColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: _isLandscape ? 2 : 4,
              offset: Offset(0, _isLandscape ? 1 : 2),
            ),
          ],
        ),
        child: _buildShimmerEffect(),
      );
    }

    return Container(
      width: orientationAwareWidth,
      height: orientationAwareHeight,
      decoration: BoxDecoration(
        borderRadius: orientationAwareBorderRadius,
        color: effectiveBaseColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: _isLandscape ? 2 : 4,
            offset: Offset(0, _isLandscape ? 1 : 2),
          ),
        ],
      ),
      child: _buildShimmerEffect(),
    );
  }

  /// Get orientation-aware width
  double? _getOrientationAwareWidth() {
    if (widget.width != null && _isLandscape) {
      return widget.width! * 0.95; // Slightly smaller in landscape
    }
    return widget.width;
  }

  /// Get orientation-aware height
  double? _getOrientationAwareHeight() {
    if (widget.height != null && _isLandscape) {
      return widget.height! * 0.9; // Smaller in landscape
    }
    return widget.height;
  }

  /// Get orientation-aware border radius
  BorderRadius? _getOrientationAwareBorderRadius() {
    if (widget.borderRadius != null && _isLandscape) {
      // Reduce border radius in landscape mode
      return BorderRadius.lerp(
        widget.borderRadius!,
        BorderRadius.circular(4),
        0.3,
      );
    }
    return widget.borderRadius;
  }

  /// Builds shimmer effect for enhanced loading states
  Widget _buildShimmerEffect() {
    final orientationAwareBorderRadius = _getOrientationAwareBorderRadius();

    return Stack(
      children: [
        // Base skeleton
        Container(
          decoration: BoxDecoration(
            borderRadius: widget.isCircle
                ? null
                : (orientationAwareBorderRadius ??
                    BorderRadius.circular(_isLandscape ? 6 : 8)),
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
        // Shimmer overlay
        ClipRRect(
          borderRadius: widget.isCircle
              ? BorderRadius.circular((widget.width ?? 48) / 2)
              : (orientationAwareBorderRadius ??
                  BorderRadius.circular(_isLandscape ? 6 : 8)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.isCircle
                  ? BorderRadius.circular((widget.width ?? 48) / 2)
                  : (orientationAwareBorderRadius ??
                      BorderRadius.circular(_isLandscape ? 6 : 8)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.transparent,
                  Colors.white.withValues(alpha: _isLandscape ? 0.3 : 0.4),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Creates custom semantics actions for accessibility
  Map<CustomSemanticsAction, VoidCallback>? _getCustomSemanticsActions() {
    if (widget.customAccessibilityActions == null ||
        widget.onAccessibilityAction == null) {
      return null;
    }

    final Map<CustomSemanticsAction, VoidCallback> actions = {};

    for (final action in widget.customAccessibilityActions!) {
      actions[CustomSemanticsAction(
        label: _getActionLabel(action),
      )] = () => widget.onAccessibilityAction!(action);
    }

    return actions;
  }

  /// Gets a user-friendly label for a semantics action
  String _getActionLabel(SemanticsAction action) {
    switch (action) {
      case SemanticsAction.tap:
        return 'Loading indicator';
      case SemanticsAction.longPress:
        return 'Long press';
      case SemanticsAction.showOnScreen:
        return 'Show loading indicator';
      default:
        return 'Action';
    }
  }

  /// Handles keyboard events for skeleton
  KeyEventResult _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      switch (event.logicalKey.keyLabel) {
        case 'Enter':
        case 'Space':
          // Handle activation
          if (widget.onAccessibilityAction != null) {
            widget.onAccessibilityAction!(SemanticsAction.tap);
            return KeyEventResult.handled;
          }
          break;
      }
    }
    return KeyEventResult.ignored;
  }
}

/// A skeleton loader for complex layouts with multiple elements
class MPSkeletonLoader extends StatefulWidget {
  const MPSkeletonLoader({
    super.key,
    required this.child,
    this.isLoading = false,
    this.loadingChild,
  });

  /// The child to show when not loading
  final Widget child;

  /// Whether to show skeleton loading state
  final bool isLoading;

  /// Optional custom skeleton widget to show while loading
  final Widget? loadingChild;

  @override
  State<MPSkeletonLoader> createState() => _MPSkeletonLoaderState();
}

class _MPSkeletonLoaderState extends State<MPSkeletonLoader> {
  bool _isLandscape = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateOrientation();
  }

  void _updateOrientation() {
    final newOrientation = MediaQuery.of(context).orientation;
    final newIsLandscape = newOrientation == Orientation.landscape;

    if (_isLandscape != newIsLandscape) {
      setState(() {
        _isLandscape = newIsLandscape;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return widget.loadingChild ?? _buildDefaultLoadingChild();
  }

  Widget _buildDefaultLoadingChild() {
    return SizedBox(
      height: _isLandscape ? 40 : 60, // Smaller in landscape
      child: const Center(
        child: MPSkeleton(width: 100, height: 20),
      ),
    );
  }
}

/// Skeleton variants for different component types
class MPSkeletonVariants {
  /// Skeleton for article card layout
  static Widget articleCard(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Padding(
      padding: EdgeInsets.all(isLandscape ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MPSkeleton.avatar(
                  width: isLandscape ? 40 : 48, height: isLandscape ? 40 : 48),
              SizedBox(width: isLandscape ? 8 : 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPSkeleton.text(
                        height: isLandscape ? 14 : 16, width: double.infinity),
                    SizedBox(height: isLandscape ? 6 : 8),
                    MPSkeleton.text(
                        height: isLandscape ? 10 : 12, width: double.infinity),
                    SizedBox(height: isLandscape ? 3 : 4),
                    MPSkeleton.text(
                        height: isLandscape ? 10 : 12,
                        width: isLandscape ? 80 : 100),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isLandscape ? 12 : 16),
          MPSkeleton.text(
              height: isLandscape ? 10 : 12, width: double.infinity),
          SizedBox(height: isLandscape ? 6 : 8),
          MPSkeleton.text(
              height: isLandscape ? 10 : 12, width: double.infinity),
          SizedBox(height: isLandscape ? 6 : 8),
          MPSkeleton.text(
              height: isLandscape ? 10 : 12, width: isLandscape ? 80 : 100),
        ],
      ),
    );
  }

  /// Skeleton for button layout
  static Widget button(BuildContext context, {double? width}) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return MPSkeleton.button(
      width: width ?? (isLandscape ? 100 : 120),
      height: isLandscape ? 32 : 40,
      borderRadius: BorderRadius.circular(isLandscape ? 6 : 8),
    );
  }

  /// Skeleton for text field layout
  static Widget textField(BuildContext context, {String? label}) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          MPSkeleton.text(
              height: isLandscape ? 10 : 12, width: isLandscape ? 60 : 80),
          SizedBox(height: isLandscape ? 6 : 8),
        ],
        MPSkeleton(height: isLandscape ? 36 : 48, width: double.infinity),
        SizedBox(height: isLandscape ? 6 : 8),
        MPSkeleton.text(height: isLandscape ? 10 : 12, width: double.infinity),
        SizedBox(height: isLandscape ? 6 : 8),
        MPSkeleton.text(
            height: isLandscape ? 10 : 12, width: isLandscape ? 80 : 100),
      ],
    );
  }

  /// Skeleton for list items
  static Widget listItem(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: isLandscape ? 6 : 8, horizontal: isLandscape ? 12 : 16),
      child: Row(
        children: [
          MPSkeleton.avatar(
              width: isLandscape ? 32 : 40, height: isLandscape ? 32 : 40),
          SizedBox(width: isLandscape ? 8 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPSkeleton.text(
                    height: isLandscape ? 12 : 14, width: double.infinity),
                SizedBox(height: isLandscape ? 4 : 6),
                MPSkeleton.text(
                    height: isLandscape ? 10 : 12, width: double.infinity),
                SizedBox(height: isLandscape ? 3 : 4),
                MPSkeleton.text(
                    height: isLandscape ? 10 : 12,
                    width: isLandscape ? 60 : 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
