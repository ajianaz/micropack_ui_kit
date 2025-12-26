import 'dart:async';
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_toast_enums.dart';

/// MPToast - Theme-aware toast notification component
///
/// This component provides quick, non-intrusive notifications that can be
/// dismissed automatically or manually. Supports multiple positions,
/// variants, and animation effects.
///
/// Example:
/// ```dart
/// MPToast.show(
///   context,
///   message: 'Action completed successfully',
///   variant: MPToastVariant.success,
///   position: MPToastPosition.top,
/// );
/// ```
class MPToast extends StatefulWidget {
  const MPToast({
    super.key,
    required this.message,
    this.variant = MPToastVariant.primary,
    this.position = MPToastPosition.bottom,
    this.duration = MPToastDuration.medium,
    this.onDismiss,
    this.dismissible = true,
    this.leading,
    this.trailing,
    this.icon,
  });

  /// The message text to display in the toast.
  final String message;

  /// The visual style variant of the toast.
  final MPToastVariant variant;

  /// The position where the toast appears.
  final MPToastPosition position;

  /// How long the toast stays visible before auto-dismissing.
  final MPToastDuration duration;

  /// Callback when toast is dismissed (manually or automatically).
  final VoidCallback? onDismiss;

  /// Whether the toast can be dismissed by tapping.
  final bool dismissible;

  /// Optional widget to display before the message.
  final Widget? leading;

  /// Optional widget to display after the message.
  final Widget? trailing;

  /// Optional icon to display (overrides variant default icon).
  final IconData? icon;

  /// Show a toast notification.
  ///
  /// [context] - BuildContext for showing the toast
  /// [message] - The message text to display
  /// [variant] - Visual style variant (default: primary)
  /// [position] - Screen position (default: bottom)
  /// [duration] - Auto-dismiss duration (default: medium)
  /// [onDismiss] - Callback when toast is dismissed
  /// [dismissible] - Whether tap to dismiss (default: true)
  /// [leading] - Optional leading widget
  /// [trailing] - Optional trailing widget
  /// [icon] - Custom icon (overrides default)
  static void show(
    BuildContext context, {
    required String message,
    MPToastVariant variant = MPToastVariant.primary,
    MPToastPosition position = MPToastPosition.bottom,
    MPToastDuration duration = MPToastDuration.medium,
    VoidCallback? onDismiss,
    bool dismissible = true,
    Widget? leading,
    Widget? trailing,
    IconData? icon,
  }) {
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastOverlay(
        entry: overlayEntry,
        overlayState: overlayState,
        message: message,
        variant: variant,
        position: position,
        duration: duration,
        onDismiss: onDismiss,
        dismissible: dismissible,
        leading: leading,
        trailing: trailing,
        icon: icon,
      ),
    );

    overlayState.insert(overlayEntry);
  }

  /// Show a success toast.
  static void success(
    BuildContext context, {
    required String message,
    MPToastPosition position = MPToastPosition.top,
    MPToastDuration duration = MPToastDuration.medium,
    VoidCallback? onDismiss,
  }) {
    show(
      context,
      message: message,
      variant: MPToastVariant.success,
      position: position,
      duration: duration,
      onDismiss: onDismiss,
      icon: Icons.check_circle,
    );
  }

  /// Show an error toast.
  static void error(
    BuildContext context, {
    required String message,
    MPToastPosition position = MPToastPosition.top,
    MPToastDuration duration = MPToastDuration.long,
    VoidCallback? onDismiss,
  }) {
    show(
      context,
      message: message,
      variant: MPToastVariant.error,
      position: position,
      duration: duration,
      onDismiss: onDismiss,
      icon: Icons.error,
    );
  }

  /// Show a warning toast.
  static void warning(
    BuildContext context, {
    required String message,
    MPToastPosition position = MPToastPosition.top,
    MPToastDuration duration = MPToastDuration.medium,
    VoidCallback? onDismiss,
  }) {
    show(
      context,
      message: message,
      variant: MPToastVariant.warning,
      position: position,
      duration: duration,
      onDismiss: onDismiss,
      icon: Icons.warning,
    );
  }

  /// Show an info toast.
  static void info(
    BuildContext context, {
    required String message,
    MPToastPosition position = MPToastPosition.top,
    MPToastDuration duration = MPToastDuration.medium,
    VoidCallback? onDismiss,
  }) {
    show(
      context,
      message: message,
      variant: MPToastVariant.info,
      position: position,
      duration: duration,
      onDismiss: onDismiss,
      icon: Icons.info,
    );
  }

  @override
  State<MPToast> createState() => _MPToastState();
}

class _MPToastState extends State<MPToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    final config = _MPToastConfig();
    final (begin, end) = config.getSlideValues(widget.position);

    _slideAnimation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
    _scheduleDismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    _dismissTimer?.cancel();
    super.dispose();
  }

  void _scheduleDismiss() {
    final durationMap = {
      MPToastDuration.short: const Duration(seconds: 2),
      MPToastDuration.medium: const Duration(seconds: 3),
      MPToastDuration.long: const Duration(seconds: 5),
    };

    _dismissTimer = Timer(durationMap[widget.duration]!, () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  void _dismiss() {
    _controller.reverse().then((_) {
      widget.onDismiss?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = _MPToastConfig();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          top: widget.position == MPToastPosition.top
              ? MediaQuery.of(context).padding.top + 16
              : null,
          bottom: widget.position == MPToastPosition.bottom
              ? MediaQuery.of(context).padding.bottom + 16
              : null,
          left: 16,
          right: 16,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: child,
            ),
          ),
        );
      },
      child: _buildContent(config),
    );
  }

  Widget _buildContent(_MPToastConfig config) {
    final backgroundColor = config.getBackgroundColor(widget.variant, context);
    final textColor = config.getTextColor(widget.variant, context);
    final displayIcon = widget.icon ?? config.getDefaultIcon(widget.variant);

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: widget.dismissible ? _dismiss : null,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: config.getPadding(),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.leading != null) ...[
                widget.leading!,
                const SizedBox(width: 8),
              ] else ...[
                Icon(
                  displayIcon,
                  color: textColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: MPText(
                  widget.message,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (widget.trailing != null) ...[
                const SizedBox(width: 8),
                widget.trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Configuration class for MPToast
class _MPToastConfig {
  static const Duration _animationDuration = Duration(milliseconds: 250);

  Duration getAnimationDuration() => _animationDuration;

  EdgeInsets getPadding() {
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  }

  (double, double) getSlideValues(MPToastPosition position) {
    switch (position) {
      case MPToastPosition.top:
        return (-50.0, 0.0);
      case MPToastPosition.bottom:
        return (50.0, 0.0);
      case MPToastPosition.center:
        return (0.0, 0.0);
    }
  }

  Color getBackgroundColor(MPToastVariant variant, BuildContext context) {
    switch (variant) {
      case MPToastVariant.primary:
        return context.mp.primary;
      case MPToastVariant.success:
        return context.mp.successColor;
      case MPToastVariant.warning:
        return context.mp.warningColor;
      case MPToastVariant.error:
        return context.mp.errorColor;
      case MPToastVariant.info:
        return context.mp.infoColor;
    }
  }

  Color getTextColor(MPToastVariant variant, BuildContext context) {
    return Colors.white;
  }

  IconData getDefaultIcon(MPToastVariant variant) {
    switch (variant) {
      case MPToastVariant.primary:
        return Icons.info;
      case MPToastVariant.success:
        return Icons.check_circle;
      case MPToastVariant.warning:
        return Icons.warning;
      case MPToastVariant.error:
        return Icons.error;
      case MPToastVariant.info:
        return Icons.info_outline;
    }
  }
}

/// Internal overlay widget for managing toast lifecycle
class _ToastOverlay extends StatefulWidget {
  const _ToastOverlay({
    required this.entry,
    required this.overlayState,
    required this.message,
    this.variant = MPToastVariant.primary,
    this.position = MPToastPosition.bottom,
    this.duration = MPToastDuration.medium,
    this.onDismiss,
    this.dismissible = true,
    this.leading,
    this.trailing,
    this.icon,
  });

  final OverlayEntry entry;
  final OverlayState overlayState;
  final String message;
  final MPToastVariant variant;
  final MPToastPosition position;
  final MPToastDuration duration;
  final VoidCallback? onDismiss;
  final bool dismissible;
  final Widget? leading;
  final Widget? trailing;
  final IconData? icon;

  @override
  State<_ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay> {
  @override
  Widget build(BuildContext context) {
    return MPToast(
      message: widget.message,
      variant: widget.variant,
      position: widget.position,
      duration: widget.duration,
      onDismiss: () {
        widget.onDismiss?.call();
        widget.entry.remove();
      },
      dismissible: widget.dismissible,
      leading: widget.leading,
      trailing: widget.trailing,
      icon: widget.icon,
    );
  }
}
