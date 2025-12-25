import 'package:flutter/material.dart';

/// Hero animation types
///
/// Defines different hero animation styles.
enum MPHheroAnimationType {
  /// Standard hero animation
  standard,

  /// Fade hero animation
  fade,

  /// Scale and fade hero animation
  scaleFade,

  /// Slide and fade hero animation
  slideFade,

  /// Custom hero animation with placeholder
  placeholder,
}

/// Hero animator wrapper for simplified hero animations
///
/// Provides a convenient wrapper around Flutter's Hero widget
/// with predefined animation styles and easier configuration.
///
/// Example:
/// ```dart
/// MPHheroAnimator(
///   tag: 'hero-tag',
///   child: MyWidget(),
/// )
/// ```
class MPHheroAnimator extends StatelessWidget {
  const MPHheroAnimator({
    super.key,
    required this.tag,
    required this.child,
    this.animationType = MPHheroAnimationType.standard,
    this.flightShuttleBuilder,
    this.placeholderBuilder,
    this.transitionOnUserGestures = false,
    this.enabled = true,
  });

  final Object tag;
  final Widget child;
  final MPHheroAnimationType animationType;
  final HeroFlightShuttleBuilder? flightShuttleBuilder;
  final HeroPlaceholderBuilder? placeholderBuilder;
  final bool transitionOnUserGestures;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return Hero(
      tag: tag,
      createRectTween: _createRectTween,
      flightShuttleBuilder: flightShuttleBuilder ?? _defaultFlightShuttleBuilder,
      placeholderBuilder: placeholderBuilder,
      transitionOnUserGestures: transitionOnUserGestures,
      child: child,
    );
  }

  RectTween _createRectTween(Rect? begin, Rect? end) {
    switch (animationType) {
      case MPHheroAnimationType.standard:
      case MPHheroAnimationType.fade:
        return RectTween(begin: begin, end: end);

      case MPHheroAnimationType.scaleFade:
      case MPHheroAnimationType.slideFade:
        return MaterialRectCenterArcTween(begin: begin, end: end);

      case MPHheroAnimationType.placeholder:
        return RectTween(begin: begin, end: end);
    }
  }

  Widget _defaultFlightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    final fromHero = fromHeroContext.findAncestorWidgetOfExactType<Hero>();
    final fromChild = fromHero?.child ?? const SizedBox.shrink();

    switch (animationType) {
      case MPHheroAnimationType.standard:
        return fromChild;

      case MPHheroAnimationType.fade:
        return Opacity(
          opacity: animation.value,
          child: fromChild,
        );

      case MPHheroAnimationType.scaleFade:
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: fromChild,
          ),
        );

      case MPHheroAnimationType.slideFade:
        return SlideTransition(
          position: Tween<Offset>(
            begin: flightDirection == HeroFlightDirection.push
                ? const Offset(0, 0.1)
                : Offset.zero,
            end: flightDirection == HeroFlightDirection.push
                ? Offset.zero
                : const Offset(0, 0.1),
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: FadeTransition(
            opacity: animation,
            child: fromChild,
          ),
        );

      case MPHheroAnimationType.placeholder:
        return fromChild;
    }
  }
}

/// Material-style rect tween with arc animation
///
/// Creates a curved path for hero animations.
class MaterialRectCenterArcTween extends RectTween {
  MaterialRectCenterArcTween({Rect? begin, Rect? end})
      : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final beginRect = begin;
    final endRect = end;

    if (beginRect == null || endRect == null) {
      return super.lerp(t)!;
    }

    final center = Offset(
      beginRect.left + (endRect.left - beginRect.left) * t,
      beginRect.top + (endRect.top - beginRect.top) * t,
    );

    final width = beginRect.width + (endRect.width - beginRect.width) * t;
    final height = beginRect.height + (endRect.height - beginRect.height) * t;

    return Rect.fromCenter(center: center, width: width, height: height);
  }
}

/// Animated hero widget for page transitions
///
/// Combines hero animation with page transitions for
/// seamless navigation experiences.
///
/// Example:
/// ```dart
/// MPHheroPageTransition(
///   tag: 'hero-tag',
///   child: TargetPage(),
/// )
/// ```
class MPHheroPageTransition extends StatelessWidget {
  const MPHheroPageTransition({
    super.key,
    required this.tag,
    required this.child,
    this.animationType = MPHheroAnimationType.standard,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
  });

  final Object tag;
  final Widget child;
  final MPHheroAnimationType animationType;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return MPHheroAnimator(
      tag: tag,
      animationType: animationType,
      child: child,
    );
  }
}

/// Twin hero animator for coordinating two heroes
///
/// Animates two hero widgets together with synchronized
/// animations for complex transitions.
///
/// Example:
/// ```dart
/// MPTwinHeroAnimator(
///   tag1: 'hero-1',
///   tag2: 'hero-2',
///   child1: Widget1(),
///   child2: Widget2(),
/// )
/// ```
class MPTwinHeroAnimator extends StatelessWidget {
  const MPTwinHeroAnimator({
    super.key,
    required this.tag1,
    required this.tag2,
    required this.child1,
    required this.child2,
    this.animationType = MPHheroAnimationType.standard,
    this.enabled = true,
  });

  final Object tag1;
  final Object tag2;
  final Widget child1;
  final Widget child2;
  final MPHheroAnimationType animationType;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [child1, child2],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MPHheroAnimator(
          tag: tag1,
          animationType: animationType,
          child: child1,
        ),
        MPHheroAnimator(
          tag: tag2,
          animationType: animationType,
          child: child2,
        ),
      ],
    );
  }
}

/// Hero animation controller for programmatic control
///
/// Provides methods to trigger and control hero animations
/// programmatically.
class MPHheroController {
  MPHheroController();

  final Map<Object, GlobalKey> _heroKeys = {};

  /// Register a hero widget with the controller
  void registerHero(Object tag, GlobalKey key) {
    _heroKeys[tag] = key;
  }

  /// Unregister a hero widget from the controller
  void unregisterHero(Object tag) {
    _heroKeys.remove(tag);
  }

  /// Get the key for a registered hero
  GlobalKey? getHeroKey(Object tag) {
    return _heroKeys[tag];
  }

  /// Check if a hero is registered
  bool hasHero(Object tag) {
    return _heroKeys.containsKey(tag);
  }

  /// Clear all registered heroes
  void clear() {
    _heroKeys.clear();
  }
}

/// Hero group for coordinating multiple hero animations
///
/// Groups multiple hero widgets together for coordinated
/// animations and simplified management.
///
/// Example:
/// ```dart
/// MPHheroGroup(
///   tags: ['hero-1', 'hero-2', 'hero-3'],
///   children: [Widget1(), Widget2(), Widget3()],
/// )
/// ```
class MPHheroGroup extends StatelessWidget {
  const MPHheroGroup({
    super.key,
    required this.tags,
    required this.children,
    this.animationType = MPHheroAnimationType.standard,
    this.enabled = true,
    this.spacing = 0,
    this.direction = Axis.horizontal,
  });

  final List<Object> tags;
  final List<Widget> children;
  final MPHheroAnimationType animationType;
  final bool enabled;
  final double spacing;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return _buildWrapper(children);
    }

    final heroes = List.generate(
      children.length,
      (index) => MPHheroAnimator(
        tag: tags[index],
        animationType: animationType,
        child: children[index],
      ),
    );

    return _buildWrapper(_addSpacing(heroes));
  }

  List<Widget> _addSpacing(List<Widget> widgets) {
    if (spacing == 0) return widgets;

    return widgets
        .expand((widget) => [
              widget,
              SizedBox(width: spacing, height: spacing),
            ])
        .toList()
      ..removeLast();
  }

  Widget _buildWrapper(List<Widget> widgets) {
    if (direction == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      );
    }
  }
}
