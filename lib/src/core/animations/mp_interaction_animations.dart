import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/gestures.dart';

/// Enhanced interaction animations for UI components
/// 
/// This widget provides hover, press, and focus animations with
/// configurable properties and accessibility support.
class MPInteractionAnimator extends StatefulWidget {
  const MPInteractionAnimator({
    super.key,
    required this.child,
    this.enabled = true,
    this.hoverEnabled = true,
    this.pressEnabled = true,
    this.focusEnabled = true,
    this.hoverScale = 0.98,
    this.pressScale = 0.95,
    this.focusScale = 1.02,
    this.hoverDuration = const Duration(milliseconds: 150),
    this.pressDuration = const Duration(milliseconds: 80),
    this.focusDuration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.onHover,
    this.onTap,
    this.onLongPress,
    this.onFocusChange,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeFromSemantics = false,
    this.allowInteraction = true,
  });

  final Widget child;
  final bool enabled;
  final bool hoverEnabled;
  final bool pressEnabled;
  final bool focusEnabled;
  
  final double hoverScale;
  final double pressScale;
  final double focusScale;
  
  final Duration hoverDuration;
  final Duration pressDuration;
  final Duration focusDuration;
  
  final Curve curve;
  final ValueChanged<bool>? onHover;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onFocusChange;
  
  final String? semanticsLabel;
  final String? semanticsHint;
  final bool excludeFromSemantics;
  final bool allowInteraction;

  @override
  State<MPInteractionAnimator> createState() => _MPInteractionAnimatorState();
}

class _MPInteractionAnimatorState extends State<MPInteractionAnimator>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _pressController;
  late AnimationController _focusController;
  
  late Animation<double> _hoverAnimation;
  late Animation<double> _pressAnimation;
  late Animation<double> _focusAnimation;
  
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _pressController.dispose();
    _focusController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _hoverController = AnimationController(
      duration: widget.hoverDuration,
      vsync: this,
    );
    
    _pressController = AnimationController(
      duration: widget.pressDuration,
      vsync: this,
    );
    
    _focusController = AnimationController(
      duration: widget.focusDuration,
      vsync: this,
    );
    
    _hoverAnimation = Tween<double>(
      begin: 1.0,
      end: widget.hoverScale,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: widget.curve,
    ));
    
    _pressAnimation = Tween<double>(
      begin: 1.0,
      end: widget.pressScale,
    ).animate(CurvedAnimation(
      parent: _pressController,
      curve: widget.curve,
    ));
    
    _focusAnimation = Tween<double>(
      begin: 1.0,
      end: widget.focusScale,
    ).animate(CurvedAnimation(
      parent: _focusController,
      curve: widget.curve,
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    Widget animatedChild = AnimatedBuilder(
      animation: Listenable.merge([
        _hoverController,
        _pressController,
        _focusController,
      ]),
      builder: (context, child) {
        final scale = _calculateScale();
        
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: widget.child,
    );

    // Add interaction handling
    if (widget.allowInteraction) {
      animatedChild = _wrapWithInteractionHandlers(animatedChild);
    }

    // Add semantics
    if (!widget.excludeFromSemantics) {
      animatedChild = _wrapWithSemantics(animatedChild);
    }

    return animatedChild;
  }

  Widget _wrapWithInteractionHandlers(Widget child) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _handleMouseEnter,
      onExit: _handleMouseExit,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: Focus(
          onFocusChange: _handleFocusChange,
          child: child,
        ),
      ),
    );
  }

  Widget _wrapWithSemantics(Widget child) {
    return Semantics(
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      button: widget.onTap != null,
      link: widget.onTap != null,
      excludeSemantics: widget.excludeFromSemantics,
      child: child,
    );
  }

  double _calculateScale() {
    double scale = 1.0;
    
    if (_isPressed && widget.pressEnabled) {
      scale *= _pressAnimation.value;
    } else if (_isHovered && widget.hoverEnabled) {
      scale *= _hoverAnimation.value;
    } else if (_isFocused && widget.focusEnabled) {
      scale *= _focusAnimation.value;
    }
    
    return scale;
  }

  void _handleMouseEnter(PointerEnterEvent event) {
    if (!widget.hoverEnabled) return;
    
    setState(() {
      _isHovered = true;
    });
    
    _hoverController.forward();
    widget.onHover?.call(true);
  }

  void _handleMouseExit(PointerExitEvent event) {
    if (!widget.hoverEnabled) return;
    
    setState(() {
      _isHovered = false;
    });
    
    _hoverController.reverse();
    widget.onHover?.call(false);
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.pressEnabled) return;
    
    setState(() {
      _isPressed = true;
    });
    
    _pressController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.pressEnabled) return;
    
    setState(() {
      _isPressed = false;
    });
    
    _pressController.reverse();
  }

  void _handleTapCancel() {
    if (!widget.pressEnabled) return;
    
    setState(() {
      _isPressed = false;
    });
    
    _pressController.reverse();
  }

  void _handleFocusChange(bool hasFocus) {
    if (!widget.focusEnabled) return;
    
    setState(() {
      _isFocused = hasFocus;
    });
    
    if (hasFocus) {
      _focusController.forward();
    } else {
      _focusController.reverse();
    }
    
    widget.onFocusChange?.call(hasFocus);
  }
}

/// Color transition animator for smooth color changes
/// 
/// This widget provides smooth color transitions when hover, press,
/// or focus states change, useful for buttons and interactive elements.
class MPColorTransitionAnimator extends StatefulWidget {
  const MPColorTransitionAnimator({
    super.key,
    required this.child,
    required this.normalColor,
    this.hoverColor,
    this.pressedColor,
    this.focusedColor,
    this.disabledColor,
    this.enabled = true,
    this.hoverDuration = const Duration(milliseconds: 150),
    this.pressDuration = const Duration(milliseconds: 80),
    this.focusDuration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.onHover,
    this.onFocusChange,
  });

  final Widget child;
  final Color normalColor;
  final Color? hoverColor;
  final Color? pressedColor;
  final Color? focusedColor;
  final Color? disabledColor;
  final bool enabled;
  
  final Duration hoverDuration;
  final Duration pressDuration;
  final Duration focusDuration;
  final Curve curve;
  
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;

  @override
  State<MPColorTransitionAnimator> createState() => _MPColorTransitionAnimatorState();
}

class _MPColorTransitionAnimatorState extends State<MPColorTransitionAnimator>
    with TickerProviderStateMixin {
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;
  
  Color _currentColor = Colors.transparent;
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _colorAnimation = ColorTween(
      begin: widget.normalColor,
      end: widget.normalColor,
    ).animate(CurvedAnimation(
      parent: _colorController,
      curve: widget.curve,
    ));
    
    _currentColor = widget.normalColor;
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _handleMouseEnter,
      onExit: _handleMouseExit,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: Focus(
          onFocusChange: _handleFocusChange,
          child: AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, child) {
              return ColoredBox(
                color: _colorAnimation.value ?? widget.normalColor,
                child: child,
              );
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }

  void _updateColor() {
    Color targetColor;
    
    if (!widget.enabled) {
      targetColor = widget.disabledColor ?? widget.normalColor;
    } else if (_isPressed) {
      targetColor = widget.pressedColor ?? widget.hoverColor ?? widget.normalColor;
    } else if (_isHovered) {
      targetColor = widget.hoverColor ?? widget.normalColor;
    } else if (_isFocused) {
      targetColor = widget.focusedColor ?? widget.normalColor;
    } else {
      targetColor = widget.normalColor;
    }
    
    if (targetColor != _currentColor) {
      _currentColor = targetColor;
      _colorController.reset();
      _colorAnimation = ColorTween(
        begin: _colorAnimation.value,
        end: targetColor,
      ).animate(CurvedAnimation(
        parent: _colorController,
        curve: widget.curve,
      ));
      _colorController.forward();
    }
  }

  void _handleMouseEnter(PointerEnterEvent event) {
    if (!widget.enabled) return;
    
    setState(() {
      _isHovered = true;
    });
    
    _updateColor();
    widget.onHover?.call(true);
  }

  void _handleMouseExit(PointerExitEvent event) {
    if (!widget.enabled) return;
    
    setState(() {
      _isHovered = false;
    });
    
    _updateColor();
    widget.onHover?.call(false);
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.enabled) return;
    
    setState(() {
      _isPressed = true;
    });
    
    _updateColor();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.enabled) return;
    
    setState(() {
      _isPressed = false;
    });
    
    _updateColor();
  }

  void _handleTapCancel() {
    if (!widget.enabled) return;
    
    setState(() {
      _isPressed = false;
    });
    
    _updateColor();
  }

  void _handleFocusChange(bool hasFocus) {
    if (!widget.enabled) return;
    
    setState(() {
      _isFocused = hasFocus;
    });
    
    _updateColor();
    widget.onFocusChange?.call(hasFocus);
  }
}

/// Combined animation wrapper for complete interaction support
/// 
/// This widget combines scale and color animations for rich
/// interactive experiences with minimal setup.
class MPIRichInteractionAnimator extends StatefulWidget {
  const MPIRichInteractionAnimator({
    super.key,
    required this.child,
    this.enabled = true,
    this.normalColor,
    this.hoverColor,
    this.pressedColor,
    this.focusedColor,
    this.disabledColor,
    this.hoverScale = 0.98,
    this.pressScale = 0.95,
    this.focusScale = 1.02,
    this.hoverDuration = const Duration(milliseconds: 150),
    this.pressDuration = const Duration(milliseconds: 80),
    this.focusDuration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.onHover,
    this.onTap,
    this.onLongPress,
    this.onFocusChange,
    this.semanticsLabel,
    this.semanticsHint,
  });

  final Widget child;
  final bool enabled;
  final Color? normalColor;
  final Color? hoverColor;
  final Color? pressedColor;
  final Color? focusedColor;
  final Color? disabledColor;
  final double hoverScale;
  final double pressScale;
  final double focusScale;
  final Duration hoverDuration;
  final Duration pressDuration;
  final Duration focusDuration;
  final Curve curve;
  final ValueChanged<bool>? onHover;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onFocusChange;
  final String? semanticsLabel;
  final String? semanticsHint;

  @override
  State<MPIRichInteractionAnimator> createState() => _MPIRichInteractionAnimatorState();
}

class _MPIRichInteractionAnimatorState extends State<MPIRichInteractionAnimator>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    
    // Wrap with color animation if colors are provided
    if (widget.normalColor != null) {
      child = MPColorTransitionAnimator(
        normalColor: widget.normalColor!,
        hoverColor: widget.hoverColor,
        pressedColor: widget.pressedColor,
        focusedColor: widget.focusedColor,
        disabledColor: widget.disabledColor,
        enabled: widget.enabled,
        hoverDuration: widget.hoverDuration,
        pressDuration: widget.pressDuration,
        focusDuration: widget.focusDuration,
        curve: widget.curve,
        onHover: widget.onHover,
        onFocusChange: widget.onFocusChange,
        child: child,
      );
    }
    
    // Wrap with scale animation
    child = MPInteractionAnimator(
      enabled: widget.enabled,
      hoverScale: widget.hoverScale,
      pressScale: widget.pressScale,
      focusScale: widget.focusScale,
      hoverDuration: widget.hoverDuration,
      pressDuration: widget.pressDuration,
      focusDuration: widget.focusDuration,
      curve: widget.curve,
      onHover: widget.onHover,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onFocusChange: widget.onFocusChange,
      semanticsLabel: widget.semanticsLabel,
      semanticsHint: widget.semanticsHint,
      child: child,
    );
    
    return child;
  }
}
