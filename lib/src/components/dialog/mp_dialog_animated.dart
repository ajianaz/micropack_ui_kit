import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Animated dialog with smooth show/hide transitions
///
/// This enhanced dialog component provides smooth fade, scale,
/// and slide animations for show/hide transitions with configurable
/// animations and comprehensive accessibility support.
class MPDialogAnimated extends StatefulWidget {
  const MPDialogAnimated({
    super.key,
    required this.child,
    this.title,
    this.content,
    this.actions,
    this.maxHeight,
    this.maxWidth,
    this.background,
    this.elevation = 8.0,
    this.padding,
    this.cornerRadius = 16.0,
    this.animationType = MPDialogAnimationType.fadeScale,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutCubic,
    this.barrierColor,
    this.barrierDismissible = true,
    this.isDismissible = true,
    this.semanticLabel,
    this.semanticHint,
    this.onDismissed,
    this.onShow,
    this.onHide,
  });

  /// Main dialog content
  final Widget child;

  /// Optional title widget
  final Widget? title;

  /// Optional content widget (alternative to child)
  final Widget? content;

  /// Optional action buttons
  final List<Widget>? actions;

  /// Maximum height of dialog
  final double? maxHeight;

  /// Maximum width of dialog
  final double? maxWidth;

  /// Custom background color
  final Color? background;

  /// Dialog elevation
  final double elevation;

  /// Dialog padding
  final double? padding;

  /// Dialog corner radius
  final double cornerRadius;

  /// Animation type for show/hide transitions
  final MPDialogAnimationType animationType;

  /// Animation duration
  final Duration animationDuration;

  /// Animation curve
  final Curve animationCurve;

  /// Barrier color (background overlay)
  final Color? barrierColor;

  /// Whether clicking outside dismisses the dialog
  final bool barrierDismissible;

  /// Whether the dialog can be dismissed
  final bool isDismissible;

  /// Semantic label for accessibility
  final String? semanticLabel;

  /// Semantic hint for accessibility
  final String? semanticHint;

  /// Callback when dialog is dismissed
  final VoidCallback? onDismissed;

  /// Callback when dialog is shown
  final VoidCallback? onShow;

  /// Callback when dialog is hidden
  final VoidCallback? onHide;

  @override
  State<MPDialogAnimated> createState() => _MPDialogAnimatedState();
}

class _MPDialogAnimatedState extends State<MPDialogAnimated>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _barrierAnimation;

  bool _isShowing = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();

    // Start showing animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startShowAnimation();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    ));

    // Scale animation
    _scaleAnimation = Tween<double>(
      begin: _getInitialScale(),
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    ));

    // Slide animation
    _slideAnimation = Tween<Offset>(
      begin: _getInitialOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    ));

    // Barrier animation
    _barrierAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.5, curve: widget.animationCurve),
    ));
  }

  void _startShowAnimation() {
    setState(() {
      _isShowing = true;
    });
    _animationController.forward();
    widget.onShow?.call();
  }

  Future<void> _startHideAnimation() async {
    await _animationController.reverse();
    setState(() {
      _isShowing = false;
    });
    widget.onHide?.call();
    widget.onDismissed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Animated barrier
              GestureDetector(
                onTap: widget.barrierDismissible && widget.isDismissible
                    ? () async {
                        await _startHideAnimation();
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    : null,
                child: FadeTransition(
                  opacity: _barrierAnimation,
                  child: Container(
                    color: widget.barrierColor ??
                        Colors.black.withValues(alpha: 0.5),
                  ),
                ),
              ),

              // Animated dialog
              Center(
                child: _buildAnimatedDialog(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnimatedDialog() {
    Widget dialog = _buildDialogContent();

    // Apply animation based on type
    switch (widget.animationType) {
      case MPDialogAnimationType.fade:
        dialog = FadeTransition(
          opacity: _fadeAnimation,
          child: dialog,
        );
      case MPDialogAnimationType.scale:
        dialog = ScaleTransition(
          scale: _scaleAnimation,
          child: dialog,
        );
      case MPDialogAnimationType.slideUp:
        dialog = SlideTransition(
          position: _slideAnimation,
          child: dialog,
        );
      case MPDialogAnimationType.fadeScale:
        dialog = AnimatedBuilder(
          animation: Listenable.merge([_fadeAnimation, _scaleAnimation]),
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: child,
              ),
            );
          },
          child: dialog,
        );
      case MPDialogAnimationType.fadeSlide:
        dialog = AnimatedBuilder(
          animation: Listenable.merge([_fadeAnimation, _slideAnimation]),
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: child,
              ),
            );
          },
          child: dialog,
        );
    }

    // Add backdrop filter for glass effect
    if (widget.animationType == MPDialogAnimationType.fadeScale ||
        widget.animationType == MPDialogAnimationType.fadeSlide) {
      dialog = ClipRRect(
        borderRadius: BorderRadius.circular(widget.cornerRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: dialog,
        ),
      );
    }

    return dialog;
  }

  Widget _buildDialogContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceWidth = MediaQuery.of(context).size.width;
        var width = MediaQuery.of(context).size.width;

        // Responsive width
        if (deviceWidth > MpUiKit.limitMediumLargeScreen) {
          width = widget.maxWidth ?? 600;
        } else if (deviceWidth > MpUiKit.limitSmallMediumScreen) {
          width = widget.maxWidth ?? 500;
        } else {
          width = (width - 40).clamp(280.0, widget.maxWidth ?? 400);
        }

        final deviceHeight = MediaQuery.of(context).size.height;
        final maxHeight = widget.maxHeight ?? (deviceHeight - 100);

        return Container(
          constraints: BoxConstraints(
            maxWidth: width,
            minHeight: 10,
            maxHeight: maxHeight,
          ),
          decoration: BoxDecoration(
            color: widget.background ?? context.mp.adaptiveBackgroundColor,
            borderRadius: BorderRadius.circular(widget.cornerRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: widget.elevation * 2,
                offset: Offset(0, widget.elevation * 0.5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title != null) _buildTitleSection(),
              _buildContentSection(),
              if (widget.actions != null) _buildActionsSection(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitleSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        widget.padding ?? 16.0,
        widget.padding ?? 16.0,
        widget.padding ?? 16.0,
        (widget.padding ?? 16.0) * 0.5,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.mp.cardColor,
            width: 1.0,
          ),
        ),
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.mp.textColor,
                ) ??
            const TextStyle(),
        child: widget.title!,
      ),
    );
  }

  Widget _buildContentSection() {
    final content = widget.content ?? widget.child;

    return Flexible(
      fit: FlexFit.loose, // ✅ Allow natural sizing instead of forcing expansion
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(widget.padding ?? 16.0),
          child: content,
        ),
      ),
    );
  }

  Widget _buildActionsSection() {
    if (widget.actions == null || widget.actions!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        widget.padding ?? 16.0,
        (widget.padding ?? 16.0) * 0.5,
        widget.padding ?? 16.0,
        widget.padding ?? 16.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.mp.cardColor,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: widget.actions!
            .map((action) => Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: action,
                ))
            .toList(),
      ),
    );
  }

  double _getInitialScale() {
    switch (widget.animationType) {
      case MPDialogAnimationType.scale:
      case MPDialogAnimationType.fadeScale:
        return 0.8;
      case MPDialogAnimationType.fade:
      case MPDialogAnimationType.slideUp:
      case MPDialogAnimationType.fadeSlide:
        return 1.0;
    }
  }

  Offset _getInitialOffset() {
    switch (widget.animationType) {
      case MPDialogAnimationType.slideUp:
      case MPDialogAnimationType.fadeSlide:
        return const Offset(0.0, 0.3);
      case MPDialogAnimationType.fade:
      case MPDialogAnimationType.scale:
      case MPDialogAnimationType.fadeScale:
        return Offset.zero;
    }
  }
}

/// Dialog animation types
enum MPDialogAnimationType {
  /// Simple fade in/out
  fade,

  /// Scale in from center
  scale,

  /// Slide up from bottom
  slideUp,

  /// Combined fade and scale
  fadeScale,

  /// Combined fade and slide
  fadeSlide,
}

/// Helper class for showing animated dialogs
class MPDialogHelper {
  /// Show animated dialog with standard configuration
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    Widget? title,
    List<Widget>? actions,
    double? maxHeight,
    double? maxWidth,
    Color? background,
    double elevation = 8.0,
    double? padding,
    double cornerRadius = 16.0,
    MPDialogAnimationType animationType = MPDialogAnimationType.fadeScale,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeOutCubic,
    Color? barrierColor,
    bool barrierDismissible = true,
    bool isDismissible = true,
    String? semanticLabel,
    String? semanticHint,
    VoidCallback? onDismissed,
    VoidCallback? onShow,
    VoidCallback? onHide,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => MPDialogAnimated(
        child: child,
        title: title,
        actions: actions,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        background: background,
        elevation: elevation,
        padding: padding,
        cornerRadius: cornerRadius,
        animationType: animationType,
        animationDuration: animationDuration,
        animationCurve: animationCurve,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        isDismissible: isDismissible,
        semanticLabel: semanticLabel,
        semanticHint: semanticHint,
        onDismissed: onDismissed,
        onShow: onShow,
        onHide: onHide,
      ),
    );
  }

  /// Show confirmation dialog with animated transitions
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    MPDialogAnimationType animationType = MPDialogAnimationType.fadeScale,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show<bool>(
      context: context,
      child: Text(message),
      title: Text(title),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            onCancel?.call();
          },
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onConfirm?.call();
          },
          child: Text(confirmText),
        ),
      ],
      animationType: animationType,
    );
  }

  /// Show alert dialog with animated transitions
  static Future<void> showAlert({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    MPDialogAnimationType animationType = MPDialogAnimationType.fadeScale,
    VoidCallback? onDismissed,
  }) {
    return show<void>(
      context: context,
      child: Text(message),
      title: Text(title),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onDismissed?.call();
          },
          child: Text(buttonText),
        ),
      ],
      animationType: animationType,
    );
  }
}
