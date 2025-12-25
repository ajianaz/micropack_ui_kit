import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Animation types for list items
///
/// Defines how list items are animated when they appear.
enum MPListAnimationType {
  /// Fade in animation
  fade,

  /// Slide from left
  slideLeft,

  /// Slide from right
  slideRight,

  /// Slide from top
  slideUp,

  /// Slide from bottom
  slideDown,

  /// Scale from center
  scale,

  /// Fade and scale combined
  fadeScale,

  /// No animation
  none,
}

/// Stagger animation modes for list items
///
/// Defines how list item animations are sequenced.
enum MPStaggerMode {
  /// Animate all items simultaneously
  simultaneous,

  /// Animate items one after another
  sequential,

  /// Animate items with a delay between each
  staggered,
}

/// Animated list item widget
///
/// Provides animation for individual list items with
/// configurable type, delay, and duration.
///
/// Example:
/// ```dart
/// MPListItemAnimator(
///   index: index,
///   animationType: MPListAnimationType.fadeScale,
///   child: ListTile(title: Text('Item $index')),
/// )
/// ```
class MPListItemAnimator extends StatelessWidget {
  const MPListItemAnimator({
    super.key,
    required this.index,
    required this.child,
    this.animationType = MPListAnimationType.fadeScale,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
    this.slideOffset,
  });

  final int index;
  final Widget child;
  final MPListAnimationType animationType;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final Offset? slideOffset;

  @override
  Widget build(BuildContext context) {
    if (animationType == MPListAnimationType.none) {
      return child;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return _buildAnimation(value, child!);
      },
      child: child,
    );
  }

  Widget _buildAnimation(double value, Widget child) {
    switch (animationType) {
      case MPListAnimationType.fade:
        return Opacity(
          opacity: value,
          child: child,
        );

      case MPListAnimationType.slideLeft:
        return Transform.translate(
          offset: Offset((1 - value) * 50, 0),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPListAnimationType.slideRight:
        return Transform.translate(
          offset: Offset((value - 1) * 50, 0),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPListAnimationType.slideUp:
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPListAnimationType.slideDown:
        return Transform.translate(
          offset: Offset(0, (value - 1) * 50),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPListAnimationType.scale:
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPListAnimationType.fadeScale:
        return Transform.scale(
          scale: value,
          alignment: Alignment.center,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPListAnimationType.none:
        return child;
    }
  }
}

/// List animator for animating multiple list items
///
/// Provides a convenient way to animate list items with
/// stagger effects and automatic delay calculation.
///
/// Example:
/// ```dart
/// MPListAnimator(
///   staggerMode: MPStaggerMode.staggered,
///   staggerDelay: Duration(milliseconds: 50),
///   itemCount: items.length,
///   itemBuilder: (context, index) {
///     return ListTile(title: Text(items[index]));
///   },
/// )
/// ```
class MPListAnimator extends StatelessWidget {
  const MPListAnimator({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.animationType = MPListAnimationType.fadeScale,
    this.staggerMode = MPStaggerMode.staggered,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
    this.slideOffset,
    this.shrinkWrap = false,
    this.padding,
    this.physics,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final MPListAnimationType animationType;
  final MPStaggerMode staggerMode;
  final Duration staggerDelay;
  final Duration duration;
  final Curve curve;
  final Offset? slideOffset;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      shrinkWrap: shrinkWrap,
      padding: padding,
      physics: physics,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return _ListItem(
          index: index,
          staggerMode: staggerMode,
          staggerDelay: staggerDelay,
          animationType: animationType,
          duration: duration,
          curve: curve,
          slideOffset: slideOffset,
          child: itemBuilder(context, index),
        );
      },
    );
  }
}

class _ListItem extends StatefulWidget {
  const _ListItem({
    required this.index,
    required this.staggerMode,
    required this.staggerDelay,
    required this.animationType,
    required this.duration,
    required this.curve,
    required this.child,
    this.slideOffset,
  });

  final int index;
  final MPStaggerMode staggerMode;
  final Duration staggerDelay;
  final MPListAnimationType animationType;
  final Duration duration;
  final Curve curve;
  final Widget child;
  final Offset? slideOffset;

  @override
  State<_ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<_ListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    // Schedule animation start
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _startAnimation();
    });
  }

  void _startAnimation() {
    if (_hasAnimated) return;
    _hasAnimated = true;

    final delay = widget.staggerMode == MPStaggerMode.sequential
        ? widget.staggerDelay * widget.index
        : widget.staggerMode == MPStaggerMode.staggered
            ? widget.staggerDelay * widget.index
            : Duration.zero;

    Future.delayed(delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animationType == MPListAnimationType.none) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return _buildAnimation(_animation.value, child!);
      },
      child: widget.child,
    );
  }

  Widget _buildAnimation(double value, Widget child) {
    switch (widget.animationType) {
      case MPListAnimationType.fade:
        return Opacity(
          opacity: value,
          child: child,
        );

      case MPListAnimationType.slideLeft:
        return Transform.translate(
          offset: Offset((1 - value) * 50, 0),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPListAnimationType.slideRight:
        return Transform.translate(
          offset: Offset((value - 1) * 50, 0),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPListAnimationType.slideUp:
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPListAnimationType.slideDown:
        return Transform.translate(
          offset: Offset(0, (value - 1) * 50),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPListAnimationType.scale:
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPListAnimationType.fadeScale:
        return Transform.scale(
          scale: value,
          alignment: Alignment.center,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPListAnimationType.none:
        return child;
    }
  }
}

/// Grid animator for animated grid items
///
/// Similar to MPListAnimator but for GridView layouts.
///
/// Example:
/// ```dart
/// MPGridAnimator(
///   staggerMode: MPStaggerMode.staggered,
///   crossAxisCount: 2,
///   itemCount: items.length,
///   itemBuilder: (context, index) {
///     return Card(child: Text(items[index]));
///   },
/// )
/// ```
class MPGridAnimator extends StatelessWidget {
  const MPGridAnimator({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.animationType = MPListAnimationType.fadeScale,
    this.staggerMode = MPStaggerMode.staggered,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int crossAxisCount;
  final MPListAnimationType animationType;
  final MPStaggerMode staggerMode;
  final Duration staggerDelay;
  final Duration duration;
  final Curve curve;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: shrinkWrap,
      padding: padding,
      physics: physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return _ListItem(
          index: index,
          staggerMode: staggerMode,
          staggerDelay: staggerDelay,
          animationType: animationType,
          duration: duration,
          curve: curve,
          child: itemBuilder(context, index),
        );
      },
    );
  }
}
