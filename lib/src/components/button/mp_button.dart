import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

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
    this.animationDuration,
    this.borderRadius,
    this.minimumSize,
    this.maximumSize,
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

  /// Animation duration for state changes.
  final Duration? animationDuration;

  /// Border radius for the button.
  final BorderRadius? borderRadius;

  /// Minimum size of the button.
  final Size? minimumSize;

  /// Maximum size of the button.
  final Size? maximumSize;

  @override
  State<MPButton> createState() => _MPButtonState();
}

class _MPButtonState extends State<MPButton> with TickerProviderStateMixin {
  // Performance optimization: Cache expensive calculations
  late Color _cachedBackgroundColor;
  late Color _cachedTextColor;
  late EdgeInsets _cachedPadding;
  late BorderSide _cachedBorderSide;
  bool _isInitialized = false;

  // Animation controllers for micro-interactions
  late AnimationController _hoverController;
  late AnimationController _pressController;
  late Animation<double> _hoverAnimation;
  late Animation<double> _pressAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _pressController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    
    // Initialize animations
    _hoverAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
    
    _pressAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _pressController.dispose();
    super.dispose();
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
  }

  void _initializeCache(BuildContext context) {
    if (_isInitialized) return;

    _cachedBackgroundColor = _getBackgroundColor();
    _cachedTextColor = widget.textColor ?? _getTextColor();
    _cachedPadding = widget.padding ?? _getPadding();
    _cachedBorderSide = _getBorderSide();
    _isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    _initializeCache(context);

    final buttonContent = widget.loading
        ? _buildLoadingContent()
        : (widget.child ?? _buildButtonContent());

    // Performance optimization: Use RepaintBoundary for complex button animations
    final elevatedButton = ElevatedButton(
      onPressed:
          widget.loading ? null : (widget.enabled ? widget.onPressed : null),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_cachedBackgroundColor),
        foregroundColor: WidgetStateProperty.all(_cachedTextColor),
        padding: WidgetStateProperty.all(_cachedPadding),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: widget.borderRadius ??
                BorderRadius.circular(widget.radius ?? 8),
            side: _cachedBorderSide,
          ),
        ),
        elevation: WidgetStateProperty.all(
          widget.elevation ??
              (widget.variant == MPButtonVariant.primary ? 4 : 0),
        ),
        shadowColor: WidgetStateProperty.all(widget.shadowColor),
        splashFactory:
            widget.splashColor != null ? InkSplash.splashFactory : null,
        animationDuration: widget.animationDuration,
        minimumSize: WidgetStateProperty.all(widget.minimumSize),
        maximumSize: WidgetStateProperty.all(widget.maximumSize),
        // Theme-aware state colors
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return context.mp.disabledColor;
          }
          if (states.contains(WidgetState.hovered)) {
            return _getHoverColor();
          }
          if (states.contains(WidgetState.pressed)) {
            return _getPressedColor();
          }
          if (states.contains(WidgetState.focused)) {
            return _getFocusColor();
          }
          return null;
        }),
      ),
      focusNode: widget.focusNode,
      onLongPress: widget.onLongPress,
      child: (widget.widthInfinity ?? false)
          ? Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: buttonContent,
            )
          : buttonContent,
    );

    // Wrap with MouseRegion and GestureDetector for custom animations
    final button = MouseRegion(
      onEnter: (_) => _hoverController.forward(),
      onExit: (_) => _hoverController.reverse(),
      child: GestureDetector(
        onTapDown: (_) => _pressController.forward(),
        onTapUp: (_) => _pressController.reverse(),
        onTapCancel: () => _pressController.reverse(),
        child: elevatedButton,
      ),
    );

    // Wrap with RepaintBoundary for performance
    final Widget buttonWithSemantics;
    if (widget.semanticLabel != null) {
      buttonWithSemantics = Semantics(
        label: widget.semanticLabel,
        child: button,
      );
    } else {
      buttonWithSemantics = button;
    }

    // Add smooth transitions with scale animations
    return AnimatedBuilder(
      animation: Listenable.merge([_hoverAnimation, _pressAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: widget.enabled 
              ? _pressAnimation.value * _hoverAnimation.value
              : _hoverAnimation.value,
          child: AnimatedContainer(
            duration: widget.animationDuration ?? const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: RepaintBoundary(child: buttonWithSemantics),
          ),
        );
      },
      child: const SizedBox.shrink(), // Placeholder child
    );
  }

  /// Builds loading content with theme-aware spinner color
  /// Uses the appropriate text color for the spinner based on button variant
  Widget _buildLoadingContent() {
    if (widget.loadingWidget != null) {
      return widget.loadingWidget!;
    }

    return SizedBox(
      height: _getLoadingSize(),
      width: _getLoadingSize(),
      child: Center(
        child: SpinKitThreeBounce(
          color: widget.textColor ?? _getTextColor(),
          size: _getLoadingSize() * 0.6,
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
  /// - primary/danger/success/warning/info: uses neutral100 (light text on colored background)
  /// - outlined/ghost/text: uses primary color for transparent buttons
  Color _getTextColor() {
    if (widget.textColor != null) return widget.textColor!;

    switch (widget.variant) {
      case MPButtonVariant.primary:
      case MPButtonVariant.danger:
      case MPButtonVariant.success:
      case MPButtonVariant.warning:
      case MPButtonVariant.info:
        return context.mp.neutral100; // Light text on colored background
      case MPButtonVariant.outlined:
        return context.mp.isDarkMode
            ? context.mp.neutral10
            : context.mp.primary; // Use same color as border for light mode
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        return context.mp.isDarkMode
            ? context.mp.neutral10
            : context.mp.primary; // Use same color as border for light mode
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
  /// - primary/danger/success/warning/info: uses neutral100 (light icon on colored background)
  /// - outlined/ghost/text: uses primary color for transparent buttons
  Color _getIconColor() {
    if (widget.iconColor != null) return widget.iconColor!;

    switch (widget.variant) {
      case MPButtonVariant.primary:
      case MPButtonVariant.danger:
      case MPButtonVariant.success:
      case MPButtonVariant.warning:
      case MPButtonVariant.info:
        return context.mp.neutral100; // Light icon on colored background
      case MPButtonVariant.outlined:
      case MPButtonVariant.ghost:
      case MPButtonVariant.text:
        return widget.textColor ??
            (context.mp.isDarkMode
                ? context.mp.neutral10
                : context
                    .mp.neutral90); // Theme-aware text for transparent buttons
    }
  }

  /// Gets padding based on button size
  EdgeInsets _getPadding() {
    switch (widget.size) {
      case MPButtonSize.small:
        return widget.padding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case MPButtonSize.regular:
        return widget.padding ??
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case MPButtonSize.medium:
        return widget.padding ??
            const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
      case MPButtonSize.large:
        return widget.padding ??
            const EdgeInsets.symmetric(horizontal: 40, vertical: 20);
    }
  }

  /// Gets loading spinner size based on button size
  double _getLoadingSize() {
    switch (widget.size) {
      case MPButtonSize.small:
        return 16;
      case MPButtonSize.regular:
        return 20;
      case MPButtonSize.medium:
        return 24;
      case MPButtonSize.large:
        return 28;
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
}
