import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Enhanced snackbar with smooth scale animations
///
/// This snackbar component provides smooth scale and fade animations
/// for entrance/exit transitions with customizable animations and themes.
class MPSnackbarAnimated extends StatefulWidget {
  const MPSnackbarAnimated({
    super.key,
    required this.message,
    this.type = MPSnackbarType.info,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.duration = const Duration(seconds: 3),
    this.action,
    this.icon,
    this.elevation = 4.0,
    this.borderRadius = 8.0,
    this.padding,
    this.margin,
    this.animationType = MPSnackbarAnimationType.scaleFade,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.elasticOut,
    this.dismissDirection = DismissDirection.horizontal,
    this.showCloseButton = false,
    this.onDismissed,
    this.onActionPressed,
  });

  final String message;
  final MPSnackbarType type;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final Duration duration;
  final SnackBarAction? action;
  final IconData? icon;
  final double elevation;
  final double borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final MPSnackbarAnimationType animationType;
  final Duration animationDuration;
  final Curve animationCurve;
  final DismissDirection dismissDirection;
  final bool showCloseButton;
  final VoidCallback? onDismissed;
  final VoidCallback? onActionPressed;

  @override
  State<MPSnackbarAnimated> createState() => _MPSnackbarAnimatedState();
}

class _MPSnackbarAnimatedState extends State<MPSnackbarAnimated>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _exitController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startEntranceAnimation();

    // Auto-dismiss after duration
    Future.delayed(widget.duration, () {
      if (mounted) {
        _startExitAnimation();
      }
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _entranceController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _exitController = AnimationController(
      duration: widget.animationDuration ~/ 2,
      vsync: this,
    );

    // Scale animation
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: widget.animationCurve,
    ));

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    // Slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutBack,
    ));
  }

  void _startEntranceAnimation() {
    _entranceController.forward();
  }

  void _startExitAnimation() {
    _exitController.forward().then((_) {
      widget.onDismissed?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget snackbarContent = _buildSnackbarContent();

    // Apply animations based on type
    switch (widget.animationType) {
      case MPSnackbarAnimationType.scale:
        snackbarContent = AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: snackbarContent,
        );
      case MPSnackbarAnimationType.fade:
        snackbarContent = FadeTransition(
          opacity: _fadeAnimation,
          child: snackbarContent,
        );
      case MPSnackbarAnimationType.slide:
        snackbarContent = SlideTransition(
          position: _slideAnimation,
          child: snackbarContent,
        );
      case MPSnackbarAnimationType.scaleFade:
        snackbarContent = AnimatedBuilder(
          animation: Listenable.merge([_scaleAnimation, _fadeAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: child,
              ),
            );
          },
          child: snackbarContent,
        );
      case MPSnackbarAnimationType.slideScale:
        snackbarContent = AnimatedBuilder(
          animation: Listenable.merge([_scaleAnimation, _slideAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: SlideTransition(
                position: _slideAnimation,
                child: child,
              ),
            );
          },
          child: snackbarContent,
        );
    }

    // Wrap with dismissible container
    return Dismissible(
      key: UniqueKey(),
      direction: widget.dismissDirection,
      onDismissed: (direction) {
        _startExitAnimation();
      },
      child: snackbarContent,
    );
  }

  Widget _buildSnackbarContent() {
    final backgroundColor = widget.backgroundColor ?? _getBackgroundColor();
    final textColor = widget.textColor ?? _getTextColor();
    final padding = widget.padding ?? _getPadding();

    return Container(
      margin: widget.margin ?? _getMargin(),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: widget.elevation,
            offset: Offset(0, widget.elevation * 0.5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          onTap: () {
            _startExitAnimation();
          },
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                // Icon
                if (widget.icon != null || _getDefaultIcon() != null) ...[
                  Icon(
                    widget.icon ?? _getDefaultIcon()!,
                    color: textColor,
                    size: 20.0,
                  ),
                  const SizedBox(width: 12.0),
                ],

                // Message
                Expanded(
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      color: textColor,
                      fontSize: widget.fontSize ?? _getFontSize(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Action button
                if (widget.action != null) ...[
                  const SizedBox(width: 12.0),
                  TextButton(
                    onPressed: () {
                      widget.onActionPressed?.call();
                      widget.action!.onPressed.call();
                      _startExitAnimation();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: textColor,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(widget.action!.label),
                  ),
                ],

                // Close button
                if (widget.showCloseButton) ...[
                  const SizedBox(width: 12.0),
                  IconButton(
                    onPressed: _startExitAnimation,
                    icon: Icon(
                      Icons.close,
                      color: textColor,
                      size: 18.0,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32.0,
                      minHeight: 32.0,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (widget.type) {
      case MPSnackbarType.success:
        return context.mp.successColor;
      case MPSnackbarType.error:
        return context.mp.errorColor;
      case MPSnackbarType.warning:
        return context.mp.warningColor;
      case MPSnackbarType.info:
        return context.mp.infoColor;
    }
  }

  Color _getTextColor() {
    // For all snackbar types, use adaptive text color for consistency
    return context.mp.textColor;
  }

  IconData? _getDefaultIcon() {
    switch (widget.type) {
      case MPSnackbarType.success:
        return Icons.check_circle;
      case MPSnackbarType.error:
        return Icons.error;
      case MPSnackbarType.warning:
        return Icons.warning;
      case MPSnackbarType.info:
        return Icons.info;
    }
  }

  double _getFontSize() {
    return 14.0;
  }

  EdgeInsets _getPadding() {
    return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
  }

  EdgeInsets _getMargin() {
    return const EdgeInsets.all(8.0);
  }
}

/// Snackbar animation types
enum MPSnackbarAnimationType {
  /// Scale in from center
  scale,

  /// Fade in
  fade,

  /// Slide up from bottom
  slide,

  /// Combined scale and fade
  scaleFade,

  /// Combined slide and scale
  slideScale,
}

/// Snackbar types for consistent styling
enum MPSnackbarType {
  success,
  error,
  warning,
  info,
}

/// Helper class for showing animated snackbars
class MPSnackbarAnimatedHelper {
  /// Show animated snackbar with standard configuration
  static void show(
    BuildContext context, {
    required String message,
    MPSnackbarType type = MPSnackbarType.info,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
    Duration? duration,
    SnackBarAction? action,
    IconData? icon,
    double elevation = 4.0,
    double borderRadius = 8.0,
    EdgeInsets? padding,
    EdgeInsets? margin,
    MPSnackbarAnimationType animationType = MPSnackbarAnimationType.scaleFade,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.elasticOut,
    DismissDirection dismissDirection = DismissDirection.horizontal,
    bool showCloseButton = false,
    VoidCallback? onDismissed,
    VoidCallback? onActionPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        content: MPSnackbarAnimated(
          message: message,
          type: type,
          backgroundColor: backgroundColor,
          textColor: textColor,
          fontSize: fontSize,
          duration: duration ?? const Duration(seconds: 3),
          action: action,
          icon: icon,
          elevation: elevation,
          borderRadius: borderRadius,
          padding: padding,
          margin: margin,
          animationType: animationType,
          animationDuration: animationDuration,
          animationCurve: animationCurve,
          dismissDirection: dismissDirection,
          showCloseButton: showCloseButton,
          onDismissed: onDismissed,
          onActionPressed: onActionPressed,
        ),
      ),
    );
  }

  /// Show success animated snackbar
  static void success(
    BuildContext context, {
    required String message,
    double? fontSize,
    Duration? duration,
    SnackBarAction? action,
    MPSnackbarAnimationType animationType = MPSnackbarAnimationType.scaleFade,
    VoidCallback? onDismissed,
  }) {
    show(
      context,
      message: message,
      type: MPSnackbarType.success,
      fontSize: fontSize,
      duration: duration,
      action: action,
      animationType: animationType,
      onDismissed: onDismissed,
    );
  }

  /// Show error animated snackbar
  static void error(
    BuildContext context, {
    required String message,
    double? fontSize,
    Duration? duration,
    SnackBarAction? action,
    MPSnackbarAnimationType animationType = MPSnackbarAnimationType.scaleFade,
    VoidCallback? onDismissed,
  }) {
    show(
      context,
      message: message,
      type: MPSnackbarType.error,
      fontSize: fontSize,
      duration: duration,
      action: action,
      animationType: animationType,
      onDismissed: onDismissed,
    );
  }

  /// Show warning animated snackbar
  static void warning(
    BuildContext context, {
    required String message,
    double? fontSize,
    Duration? duration,
    SnackBarAction? action,
    MPSnackbarAnimationType animationType = MPSnackbarAnimationType.scaleFade,
    VoidCallback? onDismissed,
  }) {
    show(
      context,
      message: message,
      type: MPSnackbarType.warning,
      fontSize: fontSize,
      duration: duration,
      action: action,
      animationType: animationType,
      onDismissed: onDismissed,
    );
  }

  /// Show info animated snackbar
  static void info(
    BuildContext context, {
    required String message,
    double? fontSize,
    Duration? duration,
    SnackBarAction? action,
    MPSnackbarAnimationType animationType = MPSnackbarAnimationType.scaleFade,
    VoidCallback? onDismissed,
  }) {
    show(
      context,
      message: message,
      type: MPSnackbarType.info,
      fontSize: fontSize,
      duration: duration,
      action: action,
      animationType: animationType,
      onDismissed: onDismissed,
    );
  }

  /// Show animated snackbar with custom styling
  static void custom(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required Color textColor,
    double? fontSize,
    Duration? duration,
    SnackBarAction? action,
    IconData? icon,
    double elevation = 4.0,
    double borderRadius = 8.0,
    EdgeInsets? padding,
    EdgeInsets? margin,
    MPSnackbarAnimationType animationType = MPSnackbarAnimationType.scaleFade,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.elasticOut,
    DismissDirection dismissDirection = DismissDirection.horizontal,
    bool showCloseButton = false,
    VoidCallback? onDismissed,
    VoidCallback? onActionPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        content: MPSnackbarAnimated(
          message: message,
          type: MPSnackbarType.info, // Use info for custom styling
          backgroundColor: backgroundColor,
          textColor: textColor,
          fontSize: fontSize,
          duration: duration ?? const Duration(seconds: 3),
          action: action,
          icon: icon,
          elevation: elevation,
          borderRadius: borderRadius,
          padding: padding,
          margin: margin,
          animationType: animationType,
          animationDuration: animationDuration,
          animationCurve: animationCurve,
          dismissDirection: dismissDirection,
          showCloseButton: showCloseButton,
          onDismissed: onDismissed,
          onActionPressed: onActionPressed,
        ),
      ),
    );
  }

  /// Clear all active snackbars
  static void clear(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
