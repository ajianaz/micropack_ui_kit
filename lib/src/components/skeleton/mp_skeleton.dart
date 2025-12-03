import 'package:flutter/material.dart';

/// A skeleton widget for loading states with customizable appearance
/// 
/// This widget provides skeleton loading animations that match the
/// expected content layout, improving perceived performance.
class MPSkeleton extends StatelessWidget {
  /// Creates a skeleton widget with default appearance
  const MPSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.isCircle = false,
  });

  /// Creates a skeleton for text content
  const MPSkeleton.text({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  }) : isCircle = false;

  /// Creates a skeleton for avatar or circular content
  const MPSkeleton.avatar({
    super.key,
    this.width = 48,
    this.height = 48,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  }) : isCircle = true;

  /// Creates a skeleton for button content
  const MPSkeleton.button({
    super.key,
    this.width,
    this.height = 40,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  }) : isCircle = false;

  /// Width of the skeleton
  final double? width;

  /// Height of the skeleton
  final double? height;

  /// Border radius of the skeleton
  final BorderRadius? borderRadius;

  /// Base color of the skeleton
  final Color? baseColor;

  /// Highlight color for shimmer effect
  final Color? highlightColor;

  /// Whether to render as circular skeleton
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Simple skeleton with optional animation
    return _buildSkeleton(theme);
  }

  Widget _buildSkeleton(ThemeData theme) {
    final effectiveBaseColor = baseColor ?? theme.colorScheme.surfaceContainerHighest;
    
    if (isCircle) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: effectiveBaseColor,
        ),
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        color: effectiveBaseColor,
      ),
    );
  }


}

/// A skeleton loader for complex layouts with multiple elements
class MPSkeletonLoader extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (!isLoading) {
      return child;
    }

    return loadingChild ?? const SizedBox.shrink();
  }
}

/// Skeleton variants for different component types
class MPSkeletonVariants {
  /// Skeleton for article card layout
  static Widget articleCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const MPSkeleton.avatar(width: 48, height: 48),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MPSkeleton.text(height: 16, width: double.infinity),
                    const SizedBox(height: 8),
                    const MPSkeleton.text(height: 12, width: 200),
                    const SizedBox(height: 4),
                    const MPSkeleton.text(height: 12, width: 150),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const MPSkeleton.text(height: 12, width: double.infinity),
          const SizedBox(height: 8),
          const MPSkeleton.text(height: 12, width: double.infinity),
          const SizedBox(height: 8),
          const MPSkeleton.text(height: 12, width: 100),
        ],
      ),
    );
  }

  /// Skeleton for button layout
  static Widget button(BuildContext context, {double? width}) {
    return MPSkeleton.button(
      width: width ?? 120,
      height: 40,
      borderRadius: BorderRadius.circular(8),
    );
  }

  /// Skeleton for text field layout
  static Widget textField(BuildContext context, {String? label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          const MPSkeleton.text(height: 12, width: 80),
          const SizedBox(height: 8),
        ],
        const MPSkeleton(height: 48, width: double.infinity),
      ],
    );
  }

  /// Skeleton for list items
  static Widget listItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          const MPSkeleton.avatar(width: 40, height: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MPSkeleton.text(height: 14, width: double.infinity),
                const SizedBox(height: 6),
                const MPSkeleton.text(height: 12, width: double.infinity),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
