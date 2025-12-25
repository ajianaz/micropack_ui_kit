import 'package:flutter/material.dart';

/// Page transition types for navigation animations
///
/// Defines various transition patterns for page navigation
/// with smooth animations and platform-adaptive behavior.
enum MPPageTransitionType {
  /// Fade in/out transition
  fade,

  /// Slide from right to left (iOS default)
  slideRight,

  /// Slide from left to right
  slideLeft,

  /// Slide from bottom to top
  slideUp,

  /// Slide from top to bottom
  slideDown,

  /// Scale from center
  scale,

  /// Rotate with fade
  rotate,

  /// Size transition (expand/contract)
  size,

  /// No animation
  none,
}

/// Custom page transition widget with various animation types
///
/// Provides a unified interface for page transitions with
/// configurable duration, curve, and transition type.
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   MPPageTransition(
///     type: MPPageTransitionType.slideRight,
///     child: NextPage(),
///   ),
/// )
/// ```
class MPPageTransition extends PageRouteBuilder<void> {
  /// Creates a page transition with the specified type
  MPPageTransition({
    required this.child,
    this.type = MPPageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration,
    this.curve = Curves.easeInOut,
    this.alignment = Alignment.center,
    Offset? slideOffset,
    this.scaleBegin = 0.8,
    this.scaleEnd = 1.0,
    this.rotationBegin = 0.0,
    this.rotationEnd = 0.0,
    super.barrierColor,
    super.barrierLabel,
    super.maintainState = true,
    super.fullscreenDialog = false,
  })  : slideOffset = slideOffset ?? const Offset(1, 0),
        super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration ?? duration,
        );

  final Widget child;
  final MPPageTransitionType type;
  final Duration duration;
  final Duration? reverseDuration;
  final Curve curve;
  final Alignment alignment;
  final Offset slideOffset;
  final double scaleBegin;
  final double scaleEnd;
  final double rotationBegin;
  final double rotationEnd;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );

    switch (type) {
      case MPPageTransitionType.fade:
        return FadeTransition(
          opacity: curvedAnimation,
          child: child,
        );

      case MPPageTransitionType.slideRight:
        return SlideTransition(
          position: Tween<Offset>(
            begin: slideOffset,
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );

      case MPPageTransitionType.slideLeft:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );

      case MPPageTransitionType.slideUp:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );

      case MPPageTransitionType.slideDown:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );

      case MPPageTransitionType.scale:
        return ScaleTransition(
          scale: Tween<double>(
            begin: scaleBegin,
            end: scaleEnd,
          ).animate(curvedAnimation),
          alignment: alignment,
          child: FadeTransition(
            opacity: curvedAnimation,
            child: child,
          ),
        );

      case MPPageTransitionType.rotate:
        return RotationTransition(
          turns: Tween<double>(
            begin: rotationBegin,
            end: rotationEnd,
          ).animate(curvedAnimation),
          child: FadeTransition(
            opacity: curvedAnimation,
            child: child,
          ),
        );

      case MPPageTransitionType.size:
        return Align(
          alignment: alignment,
          child: SizeTransition(
            sizeFactor: curvedAnimation,
            child: child,
          ),
        );

      case MPPageTransitionType.none:
        return child;
    }
  }
}

/// Shared axis transition types
///
/// Defines the type of shared axis transformation for
/// Material Design 3 style transitions.
enum MPSharedAxisTransitionType {
  /// Forward transition (z-axis forward)
  forward,

  /// Backward transition (z-axis backward)
  backward,

  /// Scaled transition
  scaled,
}

/// Shared axis transition (Material Design 3 style)
///
/// Provides a transition where elements share a spatial relationship
/// with a Z-axis transformation.
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   MPSharedAxisTransition(
///     type: MPSharedAxisTransitionType.forward,
///     child: NextPage(),
///   ),
/// )
/// ```
class MPSharedAxisTransition extends PageRouteBuilder<void> {
  /// Creates a shared axis transition
  MPSharedAxisTransition({
    required this.child,
    this.type = MPSharedAxisTransitionType.forward,
    this.fillColor,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutCubic,
    super.barrierColor,
    super.barrierLabel,
    super.maintainState = true,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
        );

  final Widget child;
  final MPSharedAxisTransitionType type;
  final Color? fillColor;
  final Duration duration;
  final Curve curve;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return _SharedAxisPage(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      type: type,
      fillColor: fillColor,
      child: child,
    );
  }
}

class _SharedAxisPage extends StatelessWidget {
  const _SharedAxisPage({
    required this.animation,
    required this.secondaryAnimation,
    required this.type,
    required this.child,
    this.fillColor,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final MPSharedAxisTransitionType type;
  final Color? fillColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const fadeInCurve = Interval(0, 0.2, curve: Curves.easeOut);
    const fadeOutCurve = Interval(0.8, 1, curve: Curves.easeIn);
    const scaleCurve = Interval(0, 1, curve: Curves.easeOutCubic);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final isForward = type == MPSharedAxisTransitionType.forward;
        final isScaled = type == MPSharedAxisTransitionType.scaled;

        double opacity;
        double scale;
        Offset translation;

        if (isForward) {
          opacity = fadeInCurve.transform(animation.value);
          scale = scaleCurve.transform(animation.value);
          translation = Offset(0, 30 * (1 - scale));
        } else if (isScaled) {
          opacity = fadeInCurve.transform(animation.value);
          scale = 0.9 + 0.1 * animation.value;
          translation = Offset.zero;
        } else {
          opacity = fadeOutCurve.transform(1 - animation.value);
          scale = scaleCurve.transform(1 - animation.value);
          translation = Offset(0, -30 * (1 - scale));
        }

        return Transform.translate(
          offset: translation,
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: Container(
                color: fillColor,
                child: child,
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}

/// Zoom page transition (hero-style expand)
///
/// Creates a transition where the new page zooms in from
/// a specific point or expands to fill the screen.
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   MPZoomPageTransition(
///     child: NextPage(),
///   ),
/// )
/// ```
class MPZoomPageTransition extends PageRouteBuilder<void> {
  /// Creates a zoom page transition
  MPZoomPageTransition({
    required this.child,
    Offset? begin,
    this.beginScale = 0.5,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
    super.barrierColor,
    super.barrierLabel,
  })  : begin = begin ?? Offset.zero,
        super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
        );

  final Widget child;
  final Offset begin;
  final double beginScale;
  final Duration duration;
  final Curve curve;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRect(
          child: AnimatedBuilder(
            animation: curvedAnimation,
            builder: (context, child) {
              return Align(
                alignment: Alignment(
                  begin.dx * 2 - 1,
                  begin.dy * 2 - 1,
                ),
                child: FractionalTranslation(
                  translation: Offset(
                    (1 - curvedAnimation.value) * begin.dx,
                    (1 - curvedAnimation.value) * begin.dy,
                  ),
                  child: Transform.scale(
                    scale: beginScale +
                        (1.0 - beginScale) * curvedAnimation.value,
                    child: Opacity(
                      opacity: curvedAnimation.value,
                      child: child,
                    ),
                  ),
                ),
              );
            },
            child: child,
          ),
        );
      },
    );
  }
}

/// Fade through transition (Material Design 3)
///
/// Provides a smooth fade transition where elements fade out
/// and new elements fade in without spatial movement.
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   MPFadeThroughTransition(
///     child: NextPage(),
///   ),
/// )
/// ```
class MPFadeThroughTransition extends PageRouteBuilder<void> {
  /// Creates a fade through transition
  MPFadeThroughTransition({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linearToEaseOut,
    super.barrierColor,
    super.barrierLabel,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
        );

  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return _FadeThrough(
      animation: animation,
      child: child,
    );
  }
}

class _FadeThrough extends StatelessWidget {
  const _FadeThrough({
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const fadeOutCurve = Interval(0, 0.35, curve: Curves.easeIn);
    const fadeInCurve = Interval(0.35, 1, curve: Curves.easeOut);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final opacity = animation.value < 0.35
            ? fadeOutCurve.transform(1 - animation.value)
            : fadeInCurve.transform(animation.value);

        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: child,
    );
  }
}
