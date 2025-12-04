import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Spinner types for MPLoadingOverlay
enum MPSpinKitType {
  circle,
  fadingCircle,
  pulse,
  rotatingCircle,
  doubleBounce,
  wave,
  threeBounce,
}

/// Loading overlay widget for async operations
///
/// This widget provides a customizable loading overlay with
/// spinners, progress indicators, and optional content.
class MPLoadingOverlay extends StatefulWidget {
  const MPLoadingOverlay({
    super.key,
    required this.child,
    this.isLoading = false,
    this.loadingText,
    this.loadingType = MPLoadingType.spinner,
    this.spinnerType = MPSpinKitType.circle,
    this.spinnerColor,
    this.spinnerSize = 48.0,
    this.progress = 0.0,
    this.backgroundColor,
    this.overlayColor,
    this.showProgress = false,
    this.isDismissible = false,
    this.onDismissed,
    this.customLoadingWidget,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.blurBackground = false,
    this.blurSigma = 4.0,
    this.padding,
    this.alignment = Alignment.center,
  });

  final Widget child;
  final bool isLoading;
  final String? loadingText;
  final MPLoadingType loadingType;
  final MPSpinKitType? spinnerType;
  final Color? spinnerColor;
  final double? spinnerSize;
  final double progress; // 0.0 to 1.0
  final Color? backgroundColor;
  final Color? overlayColor;
  final bool showProgress;
  final bool isDismissible;
  final VoidCallback? onDismissed;
  final Widget? customLoadingWidget;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool blurBackground;
  final double blurSigma;
  final EdgeInsets? padding;
  final Alignment alignment;

  @override
  State<MPLoadingOverlay> createState() => _MPLoadingOverlayState();
}

class _MPLoadingOverlayState extends State<MPLoadingOverlay>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();

    if (widget.isLoading) {
      _startShowAnimation();
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MPLoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isLoading != widget.isLoading) {
      if (widget.isLoading) {
        _startShowAnimation();
      } else {
        _startHideAnimation();
      }
    }
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: widget.animationCurve,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: widget.animationCurve,
    ));
  }

  void _startShowAnimation() {
    _fadeController.forward();
    _scaleController.forward();
  }

  void _startHideAnimation() {
    _fadeController.reverse();
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = widget.child;

    if (widget.isLoading) {
      content = Stack(
        children: [
          // Background content (slightly dimmed)
          widget.child,

          // Loading overlay
          _buildLoadingOverlay(),
        ],
      );
    }

    return content;
  }

  Widget _buildLoadingOverlay() {
    Widget overlay = Container(
      color: widget.overlayColor ?? Colors.black.withValues(alpha: 0.3),
      child: Center(
        child: _buildLoadingContent(),
      ),
    );

    // Apply blur effect if requested
    if (widget.blurBackground) {
      overlay = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blurSigma,
            sigmaY: widget.blurSigma,
          ),
          child: overlay,
        ),
      );
    }

    // Apply fade animation
    overlay = FadeTransition(
      opacity: _fadeAnimation,
      child: overlay,
    );

    // Apply dismissible handler
    if (widget.isDismissible) {
      overlay = GestureDetector(
        onTap: widget.onDismissed,
        child: overlay,
      );
    }

    return overlay;
  }

  Widget _buildLoadingContent() {
    Widget loadingWidget;

    switch (widget.loadingType) {
      case MPLoadingType.spinner:
        loadingWidget = _buildSpinner();
      case MPLoadingType.progress:
        loadingWidget = _buildProgressBar();
      case MPLoadingType.custom:
        loadingWidget = widget.customLoadingWidget ?? _buildDefaultCustom();
    }

    // Add loading text if provided
    if (widget.loadingText != null) {
      loadingWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          loadingWidget,
          const SizedBox(height: 16),
          _buildLoadingText(),
        ],
      );
    }

    // Apply scale animation
    loadingWidget = ScaleTransition(
      scale: _scaleAnimation,
      child: loadingWidget,
    );

    // Apply padding if provided
    if (widget.padding != null) {
      loadingWidget = Padding(
        padding: widget.padding!,
        child: loadingWidget,
      );
    }

    return loadingWidget;
  }

  Widget _buildSpinner() {
    final color = widget.spinnerColor ?? context.mp.primary;
    final size = widget.spinnerSize ?? 24.0;

    switch (widget.spinnerType) {
      case MPSpinKitType.circle:
        return SpinKitCircle(color: color, size: size);
      case MPSpinKitType.fadingCircle:
        return SpinKitFadingCircle(color: color, size: size);
      case MPSpinKitType.pulse:
        return SpinKitPulse(color: color, size: size);
      case MPSpinKitType.rotatingCircle:
        return SpinKitRotatingCircle(color: color, size: size);
      case MPSpinKitType.doubleBounce:
        return SpinKitDoubleBounce(color: color, size: size);
      case MPSpinKitType.wave:
        return SpinKitWave(color: color, size: size);
      case MPSpinKitType.threeBounce:
        return SpinKitThreeBounce(color: color, size: size);
      case null:
        return SpinKitCircle(color: color, size: size);
    }
  }

  Widget _buildProgressBar() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress bar
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: context.mp.neutral20,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.mp.neutral20,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity * widget.progress.clamp(0.0, 1.0),
                  decoration: BoxDecoration(
                    color: widget.spinnerColor ?? context.mp.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),

          // Progress percentage
          if (widget.showProgress) ...[
            const SizedBox(height: 12),
            Text(
              '${(widget.progress * 100).round()}%',
              style: TextStyle(
                color: context.mp.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLoadingText() {
    return Text(
      widget.loadingText!,
      style: TextStyle(
        color: context.mp.textColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDefaultCustom() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? context.mp.adaptiveBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.hourglass_empty,
            color: widget.spinnerColor ?? context.mp.primary,
            size: widget.spinnerSize ?? 24.0,
          ),
          if (widget.loadingText != null) ...[
            const SizedBox(height: 12),
            Text(
              widget.loadingText!,
              style: TextStyle(
                color: context.mp.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Loading types for different loading scenarios
enum MPLoadingType {
  spinner,
  progress,
  custom,
}

/// Enhanced loading overlay with predefined styles
class MPLoadingOverlayStyles {
  /// Full screen loading overlay
  static Widget fullScreen({
    required Widget child,
    required bool isLoading,
    String? loadingText,
    MPLoadingType type = MPLoadingType.spinner,
    MPSpinKitType spinnerType = MPSpinKitType.circle,
  }) {
    return MPLoadingOverlay(
      isLoading: isLoading,
      loadingText: loadingText,
      loadingType: type,
      spinnerType: spinnerType,
      spinnerSize: 56.0,
      overlayColor: Colors.black.withValues(alpha: 0.5),
      animationDuration: const Duration(milliseconds: 200),
      blurBackground: true,
      child: child,
    );
  }

  /// Card loading overlay
  static Widget card({
    required Widget child,
    required bool isLoading,
    String? loadingText,
    MPLoadingType type = MPLoadingType.spinner,
    MPSpinKitType spinnerType = MPSpinKitType.circle,
  }) {
    return MPLoadingOverlay(
      isLoading: isLoading,
      loadingText: loadingText,
      loadingType: type,
      spinnerType: spinnerType,
      spinnerSize: 32.0,
      overlayColor: Colors.black.withValues(alpha: 0.1),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  /// Button loading overlay
  static Widget button({
    required Widget child,
    required bool isLoading,
    double spinnerSize = 16.0,
    Color? spinnerColor,
  }) {
    return MPLoadingOverlay(
      isLoading: isLoading,
      loadingType: MPLoadingType.spinner,
      spinnerType: MPSpinKitType.circle,
      spinnerSize: spinnerSize,
      spinnerColor: spinnerColor,
      overlayColor: Colors.transparent,
      animationDuration: const Duration(milliseconds: 150),
      child: child,
    );
  }

  /// Form loading overlay
  static Widget form({
    required Widget child,
    required bool isLoading,
    String? loadingText = 'Submitting...',
    bool isDismissible = false,
  }) {
    return MPLoadingOverlay(
      isLoading: isLoading,
      loadingText: loadingText,
      loadingType: MPLoadingType.spinner,
      spinnerType: MPSpinKitType.fadingCircle,
      spinnerSize: 48.0,
      overlayColor: Colors.black.withValues(alpha: 0.3),
      animationDuration: const Duration(milliseconds: 250),
      blurBackground: true,
      blurSigma: 2.0,
      isDismissible: isDismissible,
      child: child,
    );
  }

  /// Image loading overlay
  static Widget image({
    required Widget child,
    required bool isLoading,
    String? loadingText,
    double? size,
  }) {
    return MPLoadingOverlay(
      isLoading: isLoading,
      loadingText: loadingText,
      loadingType: MPLoadingType.spinner,
      spinnerType: MPSpinKitType.circle,
      spinnerSize: size ?? 32.0,
      overlayColor: Colors.black.withValues(alpha: 0.05),
      animationDuration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }

  /// List loading overlay
  static Widget list({
    required Widget child,
    required bool isLoading,
    String? loadingText = 'Loading...',
    bool showProgress = false,
    double progress = 0.0,
  }) {
    return MPLoadingOverlay(
      isLoading: isLoading,
      loadingText: loadingText,
      loadingType:
          showProgress ? MPLoadingType.progress : MPLoadingType.spinner,
      spinnerType: MPSpinKitType.threeBounce,
      spinnerSize: 40.0,
      showProgress: showProgress,
      progress: progress,
      overlayColor: Colors.black.withValues(alpha: 0.1),
      animationDuration: const Duration(milliseconds: 300),
      child: child,
    );
  }

  /// Custom loading overlay with theme
  static Widget themed({
    required Widget child,
    required bool isLoading,
    String? loadingText,
    Widget? customLoadingWidget,
    Color? backgroundColor,
    Color? overlayColor,
    Color? spinnerColor,
  }) {
    return MPLoadingOverlay(
      isLoading: isLoading,
      loadingText: loadingText,
      loadingType: MPLoadingType.custom,
      customLoadingWidget: customLoadingWidget,
      backgroundColor: backgroundColor,
      overlayColor: overlayColor,
      spinnerColor: spinnerColor,
      spinnerSize: 48.0,
      animationDuration: const Duration(milliseconds: 300),
      blurBackground: true,
      blurSigma: 3.0,
      child: child,
    );
  }
}

/// Loading overlay manager for global loading states
class MPLoadingOverlayManager {
  static final Map<String, GlobalKey<_MPLoadingOverlayState>> _overlays = {};

  /// Register a loading overlay
  static void register(String key, GlobalKey<_MPLoadingOverlayState> overlay) {
    _overlays[key] = overlay;
  }

  /// Unregister a loading overlay
  static void unregister(String key) {
    _overlays.remove(key);
  }

  /// Show loading overlay by key
  static void show(String key, {String? loadingText}) {
    final overlay = _overlays[key];
    if (overlay?.currentState != null) {
      // This would need to be implemented in the actual overlay
      // For now, it's just a placeholder for the concept
    }
  }

  /// Hide loading overlay by key
  static void hide(String key) {
    final overlay = _overlays[key];
    if (overlay?.currentState != null) {
      // This would need to be implemented in the actual overlay
      // For now, it's just a placeholder for the concept
    }
  }

  /// Check if overlay is loading
  static bool isLoading(String key) {
    final overlay = _overlays[key];
    return overlay?.currentState != null;
  }

  /// Clear all overlays
  static void clear() {
    _overlays.clear();
  }
}
