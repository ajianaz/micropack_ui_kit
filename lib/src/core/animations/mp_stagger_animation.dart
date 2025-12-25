import 'package:flutter/material.dart';

/// Stagger animation direction
///
/// Defines the direction in which stagger animations propagate.
enum MPStaggerDirection {
  /// Animate from first to last
  forward,

  /// Animate from last to first
  backward,

  /// Animate from center outward
  centerOut,

  /// Animate from edges to center
  centerIn,
}

/// Stagger animation builder for creating complex staggered animations
///
/// Provides a flexible way to create staggered animations with
/// customizable delays, durations, and directions.
///
/// Example:
/// ```dart
/// MPStaggerAnimation(
///   itemCount: children.length,
///   direction: MPStaggerDirection.forward,
///   delay: Duration(milliseconds: 50),
///   builder: (context, index, child) {
///     return children[index];
///   },
/// )
/// ```
class MPStaggerAnimation extends StatelessWidget {
  const MPStaggerAnimation({
    super.key,
    required this.itemCount,
    required this.builder,
    this.direction = MPStaggerDirection.forward,
    this.delay = const Duration(milliseconds: 100),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
    this.animationType = MPStaggerAnimationType.fade,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index, Widget? child) builder;
  final MPStaggerDirection direction;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final MPStaggerAnimationType animationType;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return const SizedBox.shrink();
    }

    return _StaggerContainer(
      itemCount: itemCount,
      builder: builder,
      direction: direction,
      delay: delay,
      duration: duration,
      curve: curve,
      animationType: animationType,
    );
  }
}

/// Stagger animation types
///
/// Defines the type of animation applied to each item.
enum MPStaggerAnimationType {
  /// Fade in only
  fade,

  /// Slide and fade
  slideFade,

  /// Scale and fade
  scaleFade,

  /// Slide, scale, and fade
  slideScaleFade,

  /// No animation
  none,
}

class _StaggerContainer extends StatefulWidget {
  const _StaggerContainer({
    required this.itemCount,
    required this.builder,
    required this.direction,
    required this.delay,
    required this.duration,
    required this.curve,
    required this.animationType,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index, Widget? child) builder;
  final MPStaggerDirection direction;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final MPStaggerAnimationType animationType;

  @override
  State<_StaggerContainer> createState() => _StaggerContainerState();
}

class _StaggerContainerState extends State<_StaggerContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.itemCount, (index) {
        final staggerIndex = _getStaggerIndex(index);
        return _StaggerItem(
          index: staggerIndex,
          direction: widget.direction,
          delay: widget.delay,
          duration: widget.duration,
          curve: widget.curve,
          animationType: widget.animationType,
          child: widget.builder(context, index, null),
        );
      }),
    );
  }

  int _getStaggerIndex(int index) {
    switch (widget.direction) {
      case MPStaggerDirection.forward:
        return index;
      case MPStaggerDirection.backward:
        return widget.itemCount - 1 - index;
      case MPStaggerDirection.centerOut:
        final center = (widget.itemCount / 2).floor();
        return (index - center).abs();
      case MPStaggerDirection.centerIn:
        final center = (widget.itemCount / 2).floor();
        return center - (index - center).abs();
    }
  }
}

class _StaggerItem extends StatefulWidget {
  const _StaggerItem({
    required this.index,
    required this.direction,
    required this.delay,
    required this.duration,
    required this.curve,
    required this.animationType,
    required this.child,
  });

  final int index;
  final MPStaggerDirection direction;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final MPStaggerAnimationType animationType;
  final Widget child;

  @override
  State<_StaggerItem> createState() => _StaggerItemState();
}

class _StaggerItemState extends State<_StaggerItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasStarted = false;

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

    _startAnimation();
  }

  void _startAnimation() {
    if (_hasStarted) return;
    _hasStarted = true;

    final itemDelay = widget.delay * widget.index;

    Future.delayed(itemDelay, () {
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
    if (widget.animationType == MPStaggerAnimationType.none) {
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
      case MPStaggerAnimationType.fade:
        return Opacity(
          opacity: value,
          child: child,
        );

      case MPStaggerAnimationType.slideFade:
        return Transform.translate(
          offset: Offset(0, (1 - value) * 30),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPStaggerAnimationType.scaleFade:
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );

      case MPStaggerAnimationType.slideScaleFade:
        return Transform.translate(
          offset: Offset(0, (1 - value) * 30),
          child: Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          ),
        );

      case MPStaggerAnimationType.none:
        return child;
    }
  }
}

/// Staggered list view with custom animations
///
/// A more advanced version of MPListAnimator with more control
/// over stagger patterns and animations.
///
/// Example:
/// ```dart
/// MPStaggerListView(
///   itemCount: items.length,
///   staggerDirection: MPStaggerDirection.centerOut,
///   itemBuilder: (context, index) {
///     return ListTile(title: Text(items[index]));
///   },
/// )
/// ```
class MPStaggerListView extends StatelessWidget {
  const MPStaggerListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.staggerDirection = MPStaggerDirection.forward,
    this.delay = const Duration(milliseconds: 100),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
    this.animationType = MPStaggerAnimationType.fade,
    this.shrinkWrap = false,
    this.padding,
    this.physics,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final MPStaggerDirection staggerDirection;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final MPStaggerAnimationType animationType;
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
        final staggerIndex = _getStaggerIndex(index);
        return _StaggerItem(
          index: staggerIndex,
          direction: staggerDirection,
          delay: delay,
          duration: duration,
          curve: curve,
          animationType: animationType,
          child: itemBuilder(context, index),
        );
      },
    );
  }

  int _getStaggerIndex(int index) {
    switch (staggerDirection) {
      case MPStaggerDirection.forward:
        return index;
      case MPStaggerDirection.backward:
        return itemCount - 1 - index;
      case MPStaggerDirection.centerOut:
        final center = (itemCount / 2).floor();
        return (index - center).abs();
      case MPStaggerDirection.centerIn:
        final center = (itemCount / 2).floor();
        return center - (index - center).abs();
    }
  }
}

/// Staggered grid view with custom animations
///
/// Similar to MPStaggerListView but for grid layouts.
///
/// Example:
/// ```dart
/// MPStaggerGridView(
///   crossAxisCount: 2,
///   itemCount: items.length,
///   staggerDirection: MPStaggerDirection.forward,
///   itemBuilder: (context, index) {
///     return Card(child: Text(items[index]));
///   },
/// )
/// ```
class MPStaggerGridView extends StatelessWidget {
  const MPStaggerGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.staggerDirection = MPStaggerDirection.forward,
    this.delay = const Duration(milliseconds: 100),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
    this.animationType = MPStaggerAnimationType.fade,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int crossAxisCount;
  final MPStaggerDirection staggerDirection;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final MPStaggerAnimationType animationType;
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
        final staggerIndex = _getStaggerIndex(index);
        return _StaggerItem(
          index: staggerIndex,
          direction: staggerDirection,
          delay: delay,
          duration: duration,
          curve: curve,
          animationType: animationType,
          child: itemBuilder(context, index),
        );
      },
    );
  }

  int _getStaggerIndex(int index) {
    switch (staggerDirection) {
      case MPStaggerDirection.forward:
        return index;
      case MPStaggerDirection.backward:
        return itemCount - 1 - index;
      case MPStaggerDirection.centerOut:
        final center = (itemCount / 2).floor();
        return (index - center).abs();
      case MPStaggerDirection.centerIn:
        final center = (itemCount / 2).floor();
        return center - (index - center).abs();
    }
  }
}
