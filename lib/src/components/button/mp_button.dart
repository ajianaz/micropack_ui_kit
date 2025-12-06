import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/performance/mp_performance_profiler.dart';

/// A customizable button component with theme support.
///
/// This button component supports multiple variants, sizes, and states
/// with built-in loading indicators and icon support.
class MPButton extends StatefulWidget {
  /// Creates a new [MPButton] widget.
  const MPButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.size = MPButtonSize.small,
    this.variant = MPButtonVariant.primary,
    this.enabled = true,
    this.background,
    this.padding,
    this.radius,
    this.strokeWidth = 0,
    this.strokeColor,
    this.widthInfinity = false,
    this.child,
    this.textStyle,
    this.textColor = Colors.white,
    this.textSize,
    this.fontWeight,
    this.loading = false,
    this.loadingWidget,
    this.icon,
    this.iconPosition = MPButtonIconPosition.left,
    this.iconSize,
    this.iconColor,
    this.shadowColor,
    this.elevation,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.onLongPress,
    this.onHover,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.accessibilityProperties,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.respectReducedMotion = true,
    this.enableHighContrast = true,
    this.animationDuration,
    this.borderRadius,
    this.minimumSize,
    this.maximumSize,
    this.keyboardShortcut,
    this.enableKeyboardNavigation = true,
    this.focusOrder,
  });

  /// The text to display on the button.
  final String? text;

  /// Callback when the button is pressed.
  final void Function()? onPressed;

  /// The size of the button.
  final MPButtonSize size;

  /// The visual style variant of the button.
  final MPButtonVariant variant;

  /// Whether the button is enabled.
  final bool enabled;

  /// Custom background color for the button.
  final Color? background;

  /// Custom padding for the button.
  final EdgeInsets? padding;

  /// Border radius for the button.
  final double? radius;

  /// Stroke width for the button border.
  final double? strokeWidth;

  /// Stroke color for the button border.
  final Color? strokeColor;

  /// Whether the button should take full width.
  final bool? widthInfinity;

  /// Custom child widget to display instead of text.
  final Widget? child;

  /// Text style for the button text.
  /// If child is not null then textStyle is ignored.
  /// If textStyle is not null then textColor, textSize, fontWeight are ignored.
  final TextStyle? textStyle;

  /// Text color for the button.
  /// If [child] != null or [textStyle] != null then [textColor] is ignored.
  final Color? textColor;

  /// Font size for the button text.
  /// If [child] != null or [textStyle] != null then [textSize] is ignored.
  final double? textSize;

  /// Font weight for the button text.
  /// If [child] != null or [textStyle] != null then [fontWeight] is ignored.
  final FontWeight? fontWeight;

  /// Whether the button is in a loading state.
  final bool loading;

  /// Custom widget to show when loading.
  final Widget? loadingWidget;

  /// Icon to display on the button.
  final IconData? icon;

  /// Position of the icon relative to the text.
  final MPButtonIconPosition iconPosition;

  /// Size of the icon.
  final double? iconSize;

  /// Color of the icon.
  final Color? iconColor;

  /// Shadow color for the button.
  final Color? shadowColor;

  /// Elevation of the button.
  final double? elevation;

  /// Color when the button is hovered.
  final Color? hoverColor;

  /// Splash color for ripple effect.
  final Color? splashColor;

  /// Focus node for the button.
  final FocusNode? focusNode;

  /// Callback when the button is long pressed.
  final VoidCallback? onLongPress;

  /// Callback when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Semantic hint for accessibility.
  final String? semanticHint;

  /// Whether to exclude semantics for accessibility.
  final bool excludeSemantics;

  /// Additional accessibility properties.
  final Map<String, dynamic>? accessibilityProperties;

  /// Custom accessibility actions.
  final List<SemanticsAction>? customAccessibilityActions;

  /// Callback for accessibility actions.
  final void Function(SemanticsAction)? onAccessibilityAction;

  /// Whether to respect reduced motion settings.
  final bool respectReducedMotion;

  /// Whether to enable high contrast mode.
  final bool enableHighContrast;

  /// Animation duration for state changes.
  final Duration? animationDuration;

  /// Keyboard shortcut for the button.
  final SingleActivator? keyboardShortcut;

  /// Whether to enable keyboard navigation.
  final bool enableKeyboardNavigation;

  /// Focus order for keyboard navigation.
  final int? focusOrder;

  /// Border radius for the button.
  final BorderRadius? borderRadius;

  /// Minimum size of the button.
  final Size? minimumSize;

  /// Maximum size of the button.
  final Size? maximumSize;

  @override
  State<MPButton> createState() => _MPButtonState();

  // Const constructors for common variants
  const MPButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = MPButtonSize.medium,
    this.enabled = true,
    this.background,
    this.padding,
    this.radius,
    this.strokeWidth = 0,
    this.strokeColor,
    this.widthInfinity = false,
    this.child,
    this.textStyle,
    this.textColor = Colors.white,
    this.textSize,
    this.fontWeight,
    this.loading = false,
    this.loadingWidget,
    this.icon,
    this.iconPosition = MPButtonIconPosition.left,
    this.iconSize,
    this.iconColor,
    this.shadowColor,
    this.elevation,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.onLongPress,
    this.onHover,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.accessibilityProperties,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.respectReducedMotion = true,
    this.enableHighContrast = true,
    this.animationDuration,
    this.borderRadius,
    this.minimumSize,
    this.maximumSize,
    this.keyboardShortcut,
    this.enableKeyboardNavigation = true,
    this.focusOrder,
  }) : variant = MPButtonVariant.primary;

  const MPButton.outlined({
    super.key,
    required this.text,
    this.onPressed,
    this.size = MPButtonSize.medium,
    this.enabled = true,
    this.background,
    this.padding,
    this.radius,
    this.strokeWidth = 1.5,
    this.strokeColor,
    this.widthInfinity = false,
    this.child,
    this.textStyle,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.loading = false,
    this.loadingWidget,
    this.icon,
    this.iconPosition = MPButtonIconPosition.left,
    this.iconSize,
    this.iconColor,
    this.shadowColor,
    this.elevation,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.onLongPress,
    this.onHover,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.accessibilityProperties,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.respectReducedMotion = true,
    this.enableHighContrast = true,
    this.animationDuration,
    this.borderRadius,
    this.minimumSize,
    this.maximumSize,
    this.keyboardShortcut,
    this.enableKeyboardNavigation = true,
    this.focusOrder,
  }) : variant = MPButtonVariant.outlined;

  const MPButton.ghost({
    super.key,
    required this.text,
    this.onPressed,
    this.size = MPButtonSize.medium,
    this.enabled = true,
    this.background,
    this.padding,
    this.radius,
    this.strokeWidth = 0,
    this.strokeColor,
    this.widthInfinity = false,
    this.child,
    this.textStyle,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.loading = false,
    this.loadingWidget,
    this.icon,
    this.iconPosition = MPButtonIconPosition.left,
    this.iconSize,
    this.iconColor,
    this.shadowColor,
    this.elevation,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.onLongPress,
    this.onHover,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.accessibilityProperties,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.respectReducedMotion = true,
    this.enableHighContrast = true,
    this.animationDuration,
    this.borderRadius,
    this.minimumSize,
    this.maximumSize,
    this.keyboardShortcut,
    this.enableKeyboardNavigation = true,
    this.focusOrder,
  }) : variant = MPButtonVariant.ghost;

  const MPButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.size = MPButtonSize.medium,
    this.enabled = true,
    this.background,
    this.padding,
    this.radius,
    this.strokeWidth = 0,
    this.strokeColor,
    this.widthInfinity = false,
    this.child,
    this.textStyle,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.loading = false,
    this.loadingWidget,
    this.icon,
    this.iconPosition = MPButtonIconPosition.left,
    this.iconSize,
    this.iconColor,
    this.shadowColor,
    this.elevation,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.onLongPress,
    this.onHover,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.accessibilityProperties,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.respectReducedMotion = true,
    this.enableHighContrast = true,
    this.animationDuration,
    this.borderRadius,
    this.minimumSize,
    this.maximumSize,
    this.keyboardShortcut,
    this.enableKeyboardNavigation = true,
    this.focusOrder,
  }) : variant = MPButtonVariant.text;

  const MPButton.danger({
    super.key,
    required this.text,
    this.onPressed,
    this.size = MPButtonSize.medium,
    this.enabled = true,
    this.background,
    this.padding,
    this.radius,
    this.strokeWidth = 0,
    this.strokeColor,
    this.widthInfinity = false,
    this.child,
    this.textStyle,
    this.textColor = Colors.white,
    this.textSize,
    this.fontWeight,
    this.loading = false,
    this.loadingWidget,
    this.icon,
    this.iconPosition = MPButtonIconPosition.left,
    this.iconSize,
    this.iconColor,
    this.shadowColor,
    this.elevation,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.onLongPress,
    this.onHover,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.accessibilityProperties,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.respectReducedMotion = true,
    this.enableHighContrast = true,
    this.animationDuration,
    this.borderRadius,
    this.minimumSize,
    this.maximumSize,
    this.keyboardShortcut,
    this.enableKeyboardNavigation = true,
    this.focusOrder,
  }) : variant = MPButtonVariant.danger;

  const MPButton.success({
    super.key,
    required this.text,
    this.onPressed,
    this.size = MPButtonSize.medium,
    this.enabled = true,
    this.background,
    this.padding,
    this.radius,
    this.strokeWidth = 0,
    this.strokeColor,
    this.widthInfinity = false,
    this.child,
    this.textStyle,
    this.textColor = Colors.white,
    this.textSize,
    this.fontWeight,
    this.loading = false,
    this.loadingWidget,
    this.icon,
    this.iconPosition = MPButtonIconPosition.left,
    this.iconSize,
    this.iconColor,
    this.shadowColor,
    this.elevation,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.onLongPress,
    this.onHover,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.accessibilityProperties,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.respectReducedMotion = true,
    this.enableHighContrast = true,
    this.animationDuration,
    this.borderRadius,
    this.minimumSize,
    this.maximumSize,
    this.keyboardShortcut,
    this.enableKeyboardNavigation = true,
    this.focusOrder,
  }) : variant = MPButtonVariant.success;

  const MPButton.warning({
    super.key,
    required this.text,
    this.onPressed,
    this.size = MPButtonSize.medium,
    this.enabled = true,
    this.background,
    this.padding,
    this.radius,
    this.strokeWidth = 0,
    this.strokeColor,
    this.widthInfinity = false,
    this.child,
    this.textStyle,
    this.textColor = Colors.white,
    this.textSize,
    this.fontWeight,
    this.loading = false,
    this.loadingWidget,
    this.icon,
    this.iconPosition = MPButtonIconPosition.left,
    this.iconSize,
    this.iconColor,
    this.shadowColor,
    this.elevation,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.onLongPress,
    this.onHover,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.accessibilityProperties,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.respectReducedMotion = true,
    this.enableHighContrast = true,
    this.animationDuration,
    this.borderRadius,
    this.minimumSize,
    this.maximumSize,
    this.keyboardShortcut,
    this.enableKeyboardNavigation = true,
    this.focusOrder,
  }) : variant = MPButtonVariant.warning;

  const MPButton.info({
    super.key,
    required this.text,
    this.onPressed,
    this.size = MPButtonSize.medium,
    this.enabled = true,
    this.background,
    this.padding,
    this.radius,
    this.strokeWidth = 0,
    this.strokeColor,
    this.widthInfinity = false,
    this.child,
    this.textStyle,
    this.textColor = Colors.white,
    this.textSize,
    this.fontWeight,
    this.loading = false,
    this.loadingWidget,
    this.icon,
    this.iconPosition = MPButtonIconPosition.left,
    this.iconSize,
    this.iconColor,
    this.shadowColor,
    this.elevation,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.onLongPress,
    this.onHover,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.accessibilityProperties,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.respectReducedMotion = true,
    this.enableHighContrast = true,
    this.animationDuration,
    this.borderRadius,
    this.minimumSize,
    this.maximumSize,
    this.keyboardShortcut,
    this.enableKeyboardNavigation = true,
    this.focusOrder,
  }) : variant = MPButtonVariant.info;
}

class _MPButtonState extends State<MPButton> with TickerProviderStateMixin {
  // Performance optimization: Cache expensive calculations
  late Color _cachedBackgroundColor;
  late Color _cachedTextColor;
  late EdgeInsets _cachedPadding;
  late BorderSide _cachedBorderSide;
  bool _isInitialized = false;

  // Performance optimization: Cache theme values
  static Color? _cachedPrimaryColor;
  static Color? _cachedThemeTextColor;
  static Color? _cachedDisabledColor;
  static MPThemeUtilities? _lastTheme;

  // Animation controllers for micro-interactions
  late AnimationController _hoverController;
  late AnimationController _pressController;
  late AnimationController _focusController;
  late Animation<double> _hoverAnimation;
  late Animation<double> _pressAnimation;
  late Animation<double> _focusAnimation;
  late Animation<double> _disabledAnimation;

  // State tracking
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;
  bool _wasEnabled = true;

  // Accessibility state
  bool _isHighContrastMode = false;
  bool _isReducedMotion = false;
  bool _isScreenReaderActive = false;
  late final Map<SingleActivator, VoidCallback> _keyboardShortcuts;

  @override
  void initState() {
    super.initState();

    // Initialize with error handling
    MPErrorHandler.instance.executeWithErrorHandling(
      () {
        _initializeAccessibilityState();

        // Initialize animation controllers
        final animationDuration =
            widget.respectReducedMotion && _isReducedMotion
                ? const Duration(milliseconds: 50)
                : const Duration(milliseconds: 200);

        _hoverController = AnimationController(
          duration: animationDuration,
          vsync: this,
        );

        _pressController = AnimationController(
          duration: widget.respectReducedMotion && _isReducedMotion
              ? const Duration(milliseconds: 25)
              : const Duration(milliseconds: 100),
          vsync: this,
        );

        _focusController = AnimationController(
          duration: animationDuration,
          vsync: this,
        );

        // Initialize animations
        _hoverAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
        );

        _pressAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
          CurvedAnimation(parent: _pressController, curve: Curves.easeInCubic),
        );

        _focusAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _focusController, curve: Curves.easeInOut),
        );

        _disabledAnimation = Tween<double>(begin: 1.0, end: 0.6).animate(
          CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
        );

        _wasEnabled = widget.enabled;

        // Initialize keyboard shortcuts
        _initializeKeyboardShortcuts();
      },
      category: MPErrorCategory.component,
      code: 'BUTTON_INIT_FAILED',
      message: 'Button initialization failed',
      context: {'buttonType': widget.variant.name},
    );
  }

  /// Initializes accessibility state based on system preferences
  void _initializeAccessibilityState() {
    // These will be updated in didChangeDependencies
    _isHighContrastMode = false;
    _isReducedMotion = false;
    _isScreenReaderActive = false;
  }

  /// Initializes keyboard shortcuts for accessibility
  void _initializeKeyboardShortcuts() {
    _keyboardShortcuts = <SingleActivator, VoidCallback>{
      if (widget.keyboardShortcut != null)
        widget.keyboardShortcut!: () => _handleActivation(),
      const SingleActivator(LogicalKeyboardKey.enter): () =>
          _handleActivation(),
      const SingleActivator(LogicalKeyboardKey.space): () =>
          _handleActivation(),
      // Add additional keyboard navigation for better accessibility
      const SingleActivator(LogicalKeyboardKey.select): () =>
          _handleActivation(),
      // Support for numeric keypad enter key
      const SingleActivator(LogicalKeyboardKey.numpadEnter): () =>
          _handleActivation(),
    };
  }

  /// Handles button activation (keyboard or tap)
  void _handleActivation() {
    if (widget.enabled && !widget.loading && widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  /// Handles accessibility actions for screen readers
  void _handleAccessibilityAction(SemanticsAction action) {
    switch (action) {
      case SemanticsAction.tap:
      case SemanticsAction.focus:
        _handleActivation();
        break;
      case SemanticsAction.longPress:
        if (widget.onLongPress != null) {
          widget.onLongPress!();
        }
        break;
      default:
        if (widget.onAccessibilityAction != null) {
          widget.onAccessibilityAction!(action);
        }
        break;
    }
  }

  /// Gets default accessibility actions for buttons
  List<SemanticsAction> _getDefaultAccessibilityActions() {
    final actions = <SemanticsAction>[];

    if (widget.enabled && !widget.loading && widget.onPressed != null) {
      actions.add(SemanticsAction.tap);
    }

    if (widget.enabled && !widget.loading && widget.onLongPress != null) {
      actions.add(SemanticsAction.longPress);
    }

    return actions;
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _pressController.dispose();
    _focusController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Update accessibility state based on system preferences
    _updateAccessibilityState();
  }

  @override
  void didUpdateWidget(MPButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset cache when relevant properties change
    if (oldWidget.variant != widget.variant ||
        oldWidget.size != widget.size ||
        oldWidget.background != widget.background ||
        oldWidget.textColor != widget.textColor ||
        oldWidget.padding != widget.padding) {
      _isInitialized = false;
    }

    // Handle enabled state changes
    if (oldWidget.enabled != widget.enabled) {
      _wasEnabled = oldWidget.enabled;
      if (!widget.enabled) {
        _hoverController.reverse();
        _pressController.reverse();
        _focusController.reverse();
      }
    }
  }

  /// Updates accessibility state based on system preferences
  void _updateAccessibilityState() {
    final mediaQuery = MediaQuery.of(context);

    setState(() {
      _isHighContrastMode =
          widget.enableHighContrast && (mediaQuery.highContrast ?? false);
      _isReducedMotion = widget.respectReducedMotion &&
          (mediaQuery.accessibleNavigation ?? false);
      _isScreenReaderActive = mediaQuery.accessibleNavigation ?? false;
    });
  }

  void _initializeCache(BuildContext context) {
    if (_isInitialized) return;

    // Cache theme values for performance
    final currentTheme = context.mp;
    if (_lastTheme != currentTheme) {
      _cachedPrimaryColor = currentTheme.primary;
      _cachedThemeTextColor = currentTheme.textColor;
      _cachedDisabledColor = currentTheme.disabledColor;
      _lastTheme = currentTheme;
    }

    _cachedBackgroundColor = _getBackgroundColor();
    _cachedTextColor = widget.textColor ?? _getTextColor();
    _cachedPadding = widget.padding ?? _getPadding();
    _cachedBorderSide = _getBorderSide();
    _isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    // Performance optimization: Use RepaintBoundary to isolate repaints
    return RepaintBoundary(
      child: MPPerformanceProfilerWidget(
        name: 'MPButton',
        metadata: {
          'variant': widget.variant.name,
          'size': widget.size.name,
          'enabled': widget.enabled,
          'loading': widget.loading,
          'hasIcon': widget.icon != null,
          'hasText': widget.text != null,
        },
        child: MPErrorBoundary(
          errorCategory: MPErrorCategory.component,
          errorSeverity: MPErrorSeverity.medium,
          onError: (error) {
            // Log button-specific error
            MPErrorHandler.instance.handleComponentError(
              code: 'BUTTON_RENDER_ERROR',
              message: 'Button rendering failed: ${error.message}',
              technicalDetails: error.technicalDetails,
              context: {
                'buttonText': widget.text,
                'buttonVariant': widget.variant.name,
                'buttonSize': widget.size.name,
                'enabled': widget.enabled,
                'loading': widget.loading,
              },
            );
          },
          child: Builder(
            builder: (context) {
              return _buildButtonContentWithErrorHandling(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildButtonContentWithErrorHandling(BuildContext context) {
    _initializeCache(context);

    final buttonContent = widget.loading
        ? _buildLoadingContent()
        : (widget.child ?? _buildButtonContent());

    // Enhanced button with improved state handling
    final button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap:
            widget.loading ? null : (widget.enabled ? widget.onPressed : null),
        onLongPress: widget.loading
            ? null
            : (widget.enabled ? widget.onLongPress : null),
        onHover: widget.enabled ? _handleHoverChange : null,
        onFocusChange: widget.enabled ? _handleFocusChange : null,
        borderRadius:
            widget.borderRadius ?? BorderRadius.circular(widget.radius ?? 8),
        splashColor: widget.splashColor ?? _getSplashColor(),
        highlightColor: _getHighlightColor(),
        focusColor: _getFocusColor(),
        hoverColor: _getHoverColor(),
        child: AnimatedContainer(
          duration:
              widget.animationDuration ?? const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: _cachedPadding,
          decoration: BoxDecoration(
            color: widget.enabled
                ? _cachedBackgroundColor
                : context.mp.disabledColor,
            borderRadius: widget.borderRadius ??
                BorderRadius.circular(widget.radius ?? 8),
            border: _cachedBorderSide.width > 0
                ? Border.fromBorderSide(_cachedBorderSide)
                : null,
            boxShadow: _getBoxShadow(),
          ),
          child: buttonContent,
        ),
      ),
    );

    // Wrap with MouseRegion and GestureDetector for custom animations
    final interactiveButton = MouseRegion(
      onEnter: widget.enabled ? (_) => _handleHoverChange(true) : null,
      onExit: widget.enabled ? (_) => _handleHoverChange(false) : null,
      child: GestureDetector(
        onTapDown: widget.enabled ? (_) => _handlePressedChange(true) : null,
        onTapUp: widget.enabled ? (_) => _handlePressedChange(false) : null,
        onTapCancel: widget.enabled ? () => _handlePressedChange(false) : null,
        child: button,
      ),
    );

    // Wrap with RepaintBoundary for performance
    final Widget buttonWithSemantics = Semantics(
      label: widget.semanticLabel ?? widget.text ?? 'Button',
      hint: widget.semanticHint ??
          (widget.onPressed != null ? 'Double tap to activate' : null),
      button: true,
      excludeSemantics: widget.excludeSemantics,
      enabled: widget.enabled && !widget.loading,
      selected: false,
      focusable: widget.enabled && !widget.loading,
      onTap: widget.enabled && !widget.loading && widget.onPressed != null
          ? () {
              MPErrorHandler.instance.executeWithErrorHandling(
                () {
                  if (widget.onPressed != null) {
                    widget.onPressed!();
                  }
                },
                category: MPErrorCategory.component,
                code: 'BUTTON_PRESS_ERROR',
                message: 'Button press failed',
                context: {
                  'buttonText': widget.text,
                  'buttonVariant': widget.variant.name,
                },
              );
            }
          : null,
      onLongPress:
          widget.enabled && !widget.loading && widget.onLongPress != null
              ? () {
                  MPErrorHandler.instance.executeWithErrorHandling(
                    () => widget.onLongPress!(),
                    category: MPErrorCategory.component,
                    code: 'BUTTON_LONG_PRESS_ERROR',
                    message: 'Button long press failed',
                    context: {
                      'buttonText': widget.text,
                      'buttonVariant': widget.variant.name,
                    },
                  );
                }
              : null,
      // Add enhanced semantic properties for better accessibility
      textDirection: Directionality.of(context),
      // Add live region for dynamic content updates
      liveRegion: widget.loading,
      // Add custom accessibility actions
      onIncrease: widget.enabled && !widget.loading && widget.onPressed != null
          ? () => _handleAccessibilityAction(SemanticsAction.increase)
          : null,
      onDecrease: widget.enabled && !widget.loading && widget.onPressed != null
          ? () => _handleAccessibilityAction(SemanticsAction.decrease)
          : null,

      child: widget.enableKeyboardNavigation
          ? Focus(
              focusNode: widget.focusNode,
              autofocus: widget.focusOrder == 0,
              child: CallbackShortcuts(
                bindings: _keyboardShortcuts,
                child: interactiveButton,
              ),
            )
          : interactiveButton,
    );

    // Add smooth transitions with improved animations
    return AnimatedBuilder(
      animation: Listenable.merge([
        _hoverAnimation,
        _pressAnimation,
        _focusAnimation,
        _disabledAnimation
      ]),
      builder: (context, child) {
        // Get orientation information
        final mediaQuery = MediaQuery.of(context);
        final orientation = mediaQuery.orientation;
        final isLandscape = orientation == Orientation.landscape;

        // Respect reduced motion preferences for accessibility
        final animationDuration = widget.respectReducedMotion &&
                _isReducedMotion
            ? const Duration(milliseconds: 50)
            : (widget.animationDuration ?? const Duration(milliseconds: 200));

        return Transform.scale(
          scale: _getOrientationAwareAnimationScale(orientation, isLandscape),
          child: AnimatedOpacity(
            duration: animationDuration,
            opacity: widget.enabled ? 1.0 : _disabledAnimation.value,
            child: Container(
              width: (widget.widthInfinity ?? false)
                  ? MediaQuery.of(context).size.width
                  : null,
              // Add semantic container for better grouping
              child: Semantics(
                container: true,
                child: RepaintBoundary(child: buttonWithSemantics),
              ),
            ),
          ),
        );
      },
      child: const SizedBox.shrink(), // Placeholder child
    );
  }

  /// Builds loading content with theme-aware spinner color
  /// Uses the appropriate text color for the spinner based on button variant
  /// Enhanced with consistent loading animation and theme integration
  Widget _buildLoadingContent() {
    if (widget.loadingWidget != null) {
      return widget.loadingWidget!;
    }

    return SizedBox(
      height: _getLoadingSize(),
      width: _getLoadingSize(),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: SpinKitThreeBounce(
            color: widget.textColor ?? _getTextColor(),
            size: _getLoadingSize() * 0.6,
          ),
        ),
      ),
    );
  }

  /// Gets theme-aware background color based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary: uses theme primary color
  /// - outlined/ghost/text: transparent background
  /// - danger/success/warning/info: uses respective theme colors
  Color _getBackgroundColor() {
    switch (widget.variant) {
      case MPButtonVariant.primary:
        return widget.background ?? context.mp.primary;
      case MPButtonVariant.outlined:
        return Colors.transparent;
      case MPButtonVariant.ghost:
        return Colors.transparent;
      case MPButtonVariant.text:
        return Colors.transparent;
      case MPButtonVariant.danger:
        return widget.background ?? context.mp.errorColor;
      case MPButtonVariant.success:
        return widget.background ?? context.mp.successColor;
      case MPButtonVariant.warning:
        return widget.background ?? context.mp.warningColor;
      case MPButtonVariant.info:
        return widget.background ?? context.mp.infoColor;
    }
  }

  /// Gets theme-aware border side based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary/danger/success/warning/info: uses primaryBorder or respective color borders
  /// - outlined/ghost: uses primary color for border
  /// - text: transparent border
  BorderSide _getBorderSide() {
    if (widget.variant == MPButtonVariant.primary ||
        widget.variant == MPButtonVariant.danger ||
        widget.variant == MPButtonVariant.success ||
        widget.variant == MPButtonVariant.warning ||
        widget.variant == MPButtonVariant.info) {
      return widget.strokeWidth == 0
          ? BorderSide.none
          : BorderSide(
              color: widget.strokeColor ?? context.mp.primaryBorder,
              width: widget.strokeWidth ?? 1.5,
            );
    } else {
      Color borderColor;
      switch (widget.variant) {
        case MPButtonVariant.primary:
          borderColor = widget.strokeColor ?? context.mp.primaryBorder;
          break;
        case MPButtonVariant.outlined:
          borderColor = widget.strokeColor ?? context.mp.primary;
          break;
        case MPButtonVariant.ghost:
          borderColor = widget.strokeColor ?? context.mp.primary;
          break;
        case MPButtonVariant.text:
          borderColor = Colors.transparent;
          break;
        case MPButtonVariant.danger:
          borderColor = widget.strokeColor ?? context.mp.errorColor;
          break;
        case MPButtonVariant.success:
          borderColor = widget.strokeColor ?? context.mp.successColor;
          break;
        case MPButtonVariant.warning:
          borderColor = widget.strokeColor ?? context.mp.warningColor;
          break;
        case MPButtonVariant.info:
          borderColor = widget.strokeColor ?? context.mp.infoColor;
          break;
      }

      return BorderSide(
        color: borderColor,
        width: widget.strokeWidth ?? 1.5,
      );
    }
  }

  /// Gets theme-aware text color based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary/danger/success/warning/info: uses neutral10 (light text on colored background)
  /// - outlined/ghost/text: uses primary color for transparent buttons with proper contrast
  Color _getTextColor() {
    if (widget.textColor != null) return widget.textColor!;

    switch (widget.variant) {
      case MPButtonVariant.primary:
      case MPButtonVariant.danger:
      case MPButtonVariant.success:
      case MPButtonVariant.warning:
      case MPButtonVariant.info:
        // Use neutral10 (white) for light text on colored backgrounds for better contrast
        return context.mp.neutral10;
      case MPButtonVariant.outlined:
        // For outlined buttons, ensure good contrast in both modes
        return context.mp.isDarkMode
            ? context.mp.neutral10 // White text on dark background
            : context.mp
                .neutral90; // Dark text on light background for better contrast
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        // For ghost/text buttons, ensure good contrast in both modes
        return context.mp.isDarkMode
            ? context.mp.neutral10 // White text on dark background
            : context.mp
                .neutral90; // Dark text on light background for better contrast
    }
  }

  Widget _buildButtonContent() {
    // If custom child is provided, use it
    if (widget.child != null) {
      return widget.child!;
    }

    // Build text with icon if provided
    if (widget.icon != null) {
      final icon = Icon(
        widget.icon,
        size: widget.iconSize ?? _getIconSize(),
        color: widget.iconColor ?? _getIconColor(),
      );

      final text = MPText(
        widget.text ?? '',
        style: widget.textStyle,
        color: widget.textColor,
        fontSize: widget.textSize,
        fontWeight: widget.fontWeight,
      );

      switch (widget.iconPosition) {
        case MPButtonIconPosition.left:
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [icon, const SizedBox(width: 8), text],
          );
        case MPButtonIconPosition.right:
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [text, const SizedBox(width: 8), icon],
          );
        case MPButtonIconPosition.top:
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [icon, const SizedBox(height: 4), text],
          );
        case MPButtonIconPosition.bottom:
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [text, const SizedBox(height: 4), icon],
          );
      }
    }

    // Default text only
    return MPText(
      widget.text ?? '',
      style: widget.textStyle,
      color: widget.textColor,
      fontSize: widget.textSize,
      fontWeight: widget.fontWeight,
    );
  }

  double _getIconSize() {
    switch (widget.size) {
      case MPButtonSize.small:
        return 16;
      case MPButtonSize.regular:
        return 18;
      case MPButtonSize.medium:
        return 20;
      case MPButtonSize.large:
        return 22;
    }
  }

  /// Gets theme-aware icon color based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary/danger/success/warning/info: uses neutral10 (light icon on colored background)
  /// - outlined/ghost/text: uses primary color for transparent buttons with proper contrast
  Color _getIconColor() {
    if (widget.iconColor != null) return widget.iconColor!;

    switch (widget.variant) {
      case MPButtonVariant.primary:
      case MPButtonVariant.danger:
      case MPButtonVariant.success:
      case MPButtonVariant.warning:
      case MPButtonVariant.info:
        // Use neutral10 (white) for light icons on colored backgrounds for better contrast
        return context.mp.neutral10;
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        // For outlined/ghost/text buttons, ensure good contrast in both modes
        return widget.textColor ??
            (context.mp.isDarkMode
                ? context.mp.neutral10 // White icon on dark background
                : context.mp
                    .neutral90); // Dark icon on light background for better contrast
    }
  }

  /// Gets padding based on button size and orientation
  EdgeInsets _getPadding() {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;
    final screenWidth = mediaQuery.size.width;

    final basePadding = widget.padding ?? _getDefaultPadding();

    // Use orientation-aware padding if available
    return _getOrientationAwarePadding(orientation, screenWidth);
  }

  /// Gets default padding based on button size
  EdgeInsets _getDefaultPadding() {
    switch (widget.size) {
      case MPButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case MPButtonSize.regular:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case MPButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
      case MPButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 40, vertical: 20);
    }
  }

  /// Gets orientation-aware animation scale based on button state and orientation
  double _getOrientationAwareAnimationScale(
      Orientation orientation, bool isLandscape) {
    if (!widget.enabled) {
      return _disabledAnimation.value;
    }

    if (_isPressed) {
      return _pressAnimation.value;
    }

    if (_isHovered) {
      return _hoverAnimation.value;
    }

    // Adjust scale based on orientation for better visual feedback
    if (isLandscape) {
      // In landscape mode, slightly reduce scale for better proportions
      return 0.95;
    }

    return 1.0;
  }

  /// Gets orientation-aware box shadow based on orientation
  List<BoxShadow> _getOrientationAwareBoxShadow(
      Orientation orientation, bool isLandscape) {
    final baseShadow = _getBoxShadow();

    if (baseShadow.isEmpty) return baseShadow;

    // In landscape mode, adjust shadow for better visibility
    if (isLandscape) {
      return baseShadow
          .map((shadow) => shadow.copyWith(
                offset: Offset(
                  shadow.offset.dx,
                  shadow.offset.dy * 0.5, // Reduce vertical offset in landscape
                ),
                blurRadius: shadow.blurRadius *
                    0.8, // Slightly reduce blur in landscape
              ))
          .toList();
    }

    return baseShadow;
  }

  /// Gets orientation-aware padding with adjustments for landscape mode
  EdgeInsets _getOrientationAwarePadding(
      Orientation orientation, double screenWidth) {
    final basePadding = _getDefaultPadding();

    // In landscape mode, reduce vertical padding and increase horizontal for better touch targets
    if (orientation == Orientation.landscape) {
      final horizontalMultiplier = screenWidth > 768 ? 1.2 : 1.1;
      final verticalMultiplier = 0.8;

      return EdgeInsets.symmetric(
        horizontal: basePadding.horizontal * horizontalMultiplier,
        vertical: basePadding.vertical * verticalMultiplier,
      );
    }

    return basePadding;
  }

  /// Gets loading spinner size based on button size
  /// Enhanced with responsive sizing for better visual consistency
  double _getLoadingSize() {
    switch (widget.size) {
      case MPButtonSize.small:
        return 18; // Slightly larger for better visibility
      case MPButtonSize.regular:
        return 22; // Increased for better visibility
      case MPButtonSize.medium:
        return 26; // Increased for better visibility
      case MPButtonSize.large:
        return 30; // Increased for better visibility
    }
  }

  /// Gets theme-aware hover color based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary: uses primaryHover
  /// - danger/success/warning/info: uses respective color with 0.8 opacity
  /// - outlined/ghost/text: uses primaryHover with 0.1 opacity
  Color _getHoverColor() {
    switch (widget.variant) {
      case MPButtonVariant.primary:
        return context.mp.primaryHover;
      case MPButtonVariant.danger:
        return context.mp.errorColor.withValues(alpha: 0.8);
      case MPButtonVariant.success:
        return context.mp.successColor.withValues(alpha: 0.8);
      case MPButtonVariant.warning:
        return context.mp.warningColor.withValues(alpha: 0.8);
      case MPButtonVariant.info:
        return context.mp.infoColor.withValues(alpha: 0.8);
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        return context.mp.primaryHover.withValues(alpha: 0.1);
    }
  }

  /// Gets theme-aware pressed color based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary: uses primaryPressed
  /// - danger/success/warning/info: uses respective color with 0.6 opacity
  /// - outlined/ghost/text: uses primaryPressed with 0.2 opacity
  Color _getPressedColor() {
    switch (widget.variant) {
      case MPButtonVariant.primary:
        return context.mp.primaryPressed;
      case MPButtonVariant.danger:
        return context.mp.errorColor.withValues(alpha: 0.6);
      case MPButtonVariant.success:
        return context.mp.successColor.withValues(alpha: 0.6);
      case MPButtonVariant.warning:
        return context.mp.warningColor.withValues(alpha: 0.6);
      case MPButtonVariant.info:
        return context.mp.infoColor.withValues(alpha: 0.6);
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        return context.mp.primaryPressed.withValues(alpha: 0.2);
    }
  }

  /// Gets theme-aware focus color based on button variant
  /// Uses appropriate theme colors for each variant:
  /// - primary: uses primaryFocus
  /// - danger/success/warning/info: uses respective color with 0.3 opacity
  /// - outlined/ghost/text: uses primaryFocus with 0.1 opacity
  Color _getFocusColor() {
    switch (widget.variant) {
      case MPButtonVariant.primary:
        return context.mp.primaryFocus;
      case MPButtonVariant.danger:
        return context.mp.errorColor.withValues(alpha: 0.3);
      case MPButtonVariant.success:
        return context.mp.successColor.withValues(alpha: 0.3);
      case MPButtonVariant.warning:
        return context.mp.warningColor.withValues(alpha: 0.3);
      case MPButtonVariant.info:
        return context.mp.infoColor.withValues(alpha: 0.3);
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        return context.mp.primaryFocus.withValues(alpha: 0.1);
    }
  }

  /// Handles hover state changes with proper animation
  void _handleHoverChange(bool isHovered) {
    if (_isHovered != isHovered && widget.enabled) {
      setState(() {
        _isHovered = isHovered;
      });

      if (isHovered) {
        _hoverController.forward();
        widget.onHover?.call(true);
      } else {
        _hoverController.reverse();
        widget.onHover?.call(false);
      }
    }
  }

  /// Handles focus state changes with proper animation
  void _handleFocusChange(bool isFocused) {
    if (_isFocused != isFocused && widget.enabled) {
      setState(() {
        _isFocused = isFocused;
      });

      if (isFocused) {
        _focusController.forward();
      } else {
        _focusController.reverse();
      }
    }
  }

  /// Handles pressed state changes with proper animation
  void _handlePressedChange(bool isPressed) {
    if (_isPressed != isPressed && widget.enabled) {
      setState(() {
        _isPressed = isPressed;
      });

      if (isPressed) {
        _pressController.forward();
      } else {
        _pressController.reverse();
      }
    }
  }

  /// Gets splash color based on button variant
  Color _getSplashColor() {
    switch (widget.variant) {
      case MPButtonVariant.primary:
        return context.mp.primary.withValues(alpha: 0.2);
      case MPButtonVariant.danger:
        return context.mp.errorColor.withValues(alpha: 0.2);
      case MPButtonVariant.success:
        return context.mp.successColor.withValues(alpha: 0.2);
      case MPButtonVariant.warning:
        return context.mp.warningColor.withValues(alpha: 0.2);
      case MPButtonVariant.info:
        return context.mp.infoColor.withValues(alpha: 0.2);
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        return context.mp.primary.withValues(alpha: 0.1);
    }
  }

  /// Gets highlight color based on button variant
  Color _getHighlightColor() {
    switch (widget.variant) {
      case MPButtonVariant.primary:
        return context.mp.primary.withValues(alpha: 0.1);
      case MPButtonVariant.danger:
        return context.mp.errorColor.withValues(alpha: 0.1);
      case MPButtonVariant.success:
        return context.mp.successColor.withValues(alpha: 0.1);
      case MPButtonVariant.warning:
        return context.mp.warningColor.withValues(alpha: 0.1);
      case MPButtonVariant.info:
        return context.mp.infoColor.withValues(alpha: 0.1);
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        return context.mp.primary.withValues(alpha: 0.05);
    }
  }

  /// Gets box shadow based on button variant and state
  List<BoxShadow> _getBoxShadow() {
    if (widget.variant == MPButtonVariant.primary && widget.enabled) {
      return [
        BoxShadow(
          color:
              widget.shadowColor ?? context.mp.primary.withValues(alpha: 0.3),
          blurRadius: _isHovered ? 8 : 4,
          offset: Offset(0, _isHovered ? 4 : 2),
        ),
      ];
    }

    if (widget.elevation != null && widget.elevation! > 0 && widget.enabled) {
      return [
        BoxShadow(
          color: widget.shadowColor ?? Colors.black.withValues(alpha: 0.2),
          blurRadius: widget.elevation!,
          offset: Offset(0, widget.elevation! / 2),
        ),
      ];
    }

    return [];
  }
}
