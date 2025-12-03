import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Enhanced rounded tab with smooth slide animations
/// 
/// This tab component provides smooth slide transitions when switching
/// between tabs, with configurable animations and rich interaction support.
class MPTabRoundedAnimated extends StatefulWidget {
  const MPTabRoundedAnimated({
    super.key,
    required this.title,
    required this.isSelected,
    this.onTap,
    this.onLongPress,
    this.tabLocation = 'center',
    this.variant = MPTabRoundedVariant.standard,
    this.size = MPTabRoundedSize.medium,
    this.tabColor,
    this.tabColorActive,
    this.textColor,
    this.textColorActive,
    this.height,
    this.icon,
    this.iconSize,
    this.badge,
    this.badgeColor,
    this.badgeTextColor,
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeOutCubic,
    this.borderRadius,
    this.padding,
    this.showIndicator = true,
    this.indicatorColor,
    this.indicatorHeight,
    this.indicatorWidth,
    this.flex = 1,
    this.slideDirection = Axis.horizontal,
    this.semanticLabel,
    this.semanticHint,
    this.isDisabled = false,
    this.enableSlideAnimation = true,
    this.enableScaleAnimation = true,
    this.hoverScale = 1.05,
    this.pressScale = 0.95,
  });

  final String? title;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String? tabLocation;
  final MPTabRoundedVariant variant;
  final MPTabRoundedSize size;
  final Color? tabColor;
  final Color? tabColorActive;
  final Color? textColor;
  final Color? textColorActive;
  final double? height;
  final IconData? icon;
  final double? iconSize;
  final String? badge;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final Duration animationDuration;
  final Curve animationCurve;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final bool showIndicator;
  final Color? indicatorColor;
  final double? indicatorHeight;
  final double? indicatorWidth;
  final int flex;
  final Axis slideDirection;
  final String? semanticLabel;
  final String? semanticHint;
  final bool isDisabled;
  final bool enableSlideAnimation;
  final bool enableScaleAnimation;
  final double hoverScale;
  final double pressScale;

  @override
  State<MPTabRoundedAnimated> createState() => _MPTabRoundedAnimatedState();
}

class _MPTabRoundedAnimatedState extends State<MPTabRoundedAnimated>
    with TickerProviderStateMixin {
  late AnimationController _selectionController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  
  late Animation<double> _selectionAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setInitialState();
  }

  @override
  void dispose() {
    _selectionController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MPTabRoundedAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected) {
        _playSelectAnimation();
      } else {
        _playDeselectAnimation();
      }
    }
  }

  void _initializeAnimations() {
    // Selection animation for color/content changes
    _selectionController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    
    _selectionAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _selectionController,
      curve: widget.animationCurve,
    ));

    // Slide animation for smooth transitions
    if (widget.enableSlideAnimation) {
      _slideController = AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      );
      
      _slideAnimation = Tween<Offset>(
        begin: _getSlideOffset(false),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _slideController,
        curve: widget.animationCurve,
      ));
    }

    // Scale animation for hover/press effects
    if (widget.enableScaleAnimation) {
      _scaleController = AnimationController(
        duration: const Duration(milliseconds: 150),
        vsync: this,
      );
      
      _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ));
    }
  }

  void _setInitialState() {
    if (widget.isSelected) {
      _selectionController.value = 1.0;
      _slideController.value = 1.0;
    } else {
      _selectionController.value = 0.0;
      _slideController.value = 0.0;
    }
  }

  void _playSelectAnimation() {
    if (widget.enableSlideAnimation) {
      _slideAnimation = Tween<Offset>(
        begin: _getSlideOffset(false),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _slideController,
        curve: widget.animationCurve,
      ));
      _slideController.forward();
    }
    
    _selectionController.forward();
  }

  void _playDeselectAnimation() {
    if (widget.enableSlideAnimation) {
      _slideAnimation = Tween<Offset>(
        begin: Offset.zero,
        end: _getSlideOffset(false),
      ).animate(CurvedAnimation(
        parent: _slideController,
        curve: widget.animationCurve,
      ));
      _slideController.forward();
    }
    
    _selectionController.reverse();
  }

  void _playHoverAnimation() {
    if (widget.enableScaleAnimation) {
      _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: widget.hoverScale,
      ).animate(CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeOut,
      ));
      _scaleController.forward();
    }
  }

  void _playNormalAnimation() {
    if (widget.enableScaleAnimation) {
      _scaleAnimation = Tween<double>(
        begin: _scaleAnimation.value,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeOut,
      ));
      _scaleController.forward();
    }
  }

  void _playPressAnimation() {
    if (widget.enableScaleAnimation) {
      _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: widget.pressScale,
      ).animate(CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeIn,
      ));
      _scaleController.forward();
    }
  }

  Offset _getSlideOffset(bool isSelected) {
    switch (widget.slideDirection) {
      case Axis.horizontal:
        return isSelected ? const Offset(-0.1, 0.0) : const Offset(0.1, 0.0);
      case Axis.vertical:
        return isSelected ? const Offset(0.0, -0.1) : const Offset(0.0, 0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget tabContent = _buildTabContent();
    
    // Apply scale animation if enabled
    if (widget.enableScaleAnimation) {
      tabContent = AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: tabContent,
      );
    }
    
    // Apply slide animation if enabled
    if (widget.enableSlideAnimation) {
      tabContent = AnimatedBuilder(
        animation: _slideAnimation,
        builder: (context, child) {
          return SlideTransition(
            position: _slideAnimation,
            child: child,
          );
        },
        child: tabContent,
      );
    }
    
    // Apply selection animation
    tabContent = AnimatedBuilder(
      animation: _selectionAnimation,
      builder: (context, child) {
        return _buildAnimatedContainer(child);
      },
      child: tabContent,
    );
    
    // Wrap with interaction handlers
    return MouseRegion(
      onEnter: (_) => _handleMouseEnter(),
      onExit: (_) => _handleMouseExit(),
      child: GestureDetector(
        onTap: widget.isDisabled ? null : widget.onTap,
        onLongPress: widget.isDisabled ? null : widget.onLongPress,
        onTapDown: widget.isDisabled ? null : _handleTapDown,
        onTapUp: widget.isDisabled ? null : _handleTapUp,
        onTapCancel: widget.isDisabled ? null : _handleTapCancel,
        child: Semantics(
          label: widget.semanticLabel ?? widget.title,
          hint: widget.semanticHint,
          button: true,
          selected: widget.isSelected,
          child: tabContent,
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return Flex(
      direction: widget.slideDirection == Axis.horizontal 
          ? Axis.horizontal 
          : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.icon != null) ...[
          Icon(
            widget.icon,
            size: widget.iconSize ?? _getIconSize(),
            color: _getIconColor(),
          ),
          if (widget.title != null) _getIconSpacing(),
        ],
        if (widget.title != null)
          Flexible(
            child: Text(
              widget.title!,
              style: _getTextStyle(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: widget.slideDirection == Axis.vertical ? 2 : 1,
            ),
          ),
        if (widget.badge != null) _getBadgeSpacing(),
        if (widget.badge != null) _buildBadge(),
      ],
    );
  }

  Widget _buildAnimatedContainer(Widget child) {
    return Container(
      height: widget.height ?? _getHeight(),
      padding: widget.padding ?? _getPadding(),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: widget.borderRadius ?? _getBorderRadius(),
        border: _getBorder(),
      ),
      child: Stack(
        children: [
          child,
          if (widget.showIndicator) _buildIndicator(),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: widget.animationCurve,
        height: widget.indicatorHeight ?? 3.0,
        margin: EdgeInsets.symmetric(
          horizontal: widget.indicatorWidth != null 
              ? (MediaQuery.of(context).size.width - widget.indicatorWidth!) / 2
              : 8.0,
        ),
        decoration: BoxDecoration(
          color: widget.indicatorColor ?? _getIndicatorColor(),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(3.0)),
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: widget.badgeColor ?? context.mp.errorColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        widget.badge!,
        style: TextStyle(
          color: widget.badgeTextColor ?? context.mp.neutral100,
          fontSize: 10.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _getIconSpacing() {
    final spacing = widget.slideDirection == Axis.horizontal ? 6.0 : 0.0;
    return SizedBox(width: spacing);
  }

  Widget _getBadgeSpacing() {
    final spacing = widget.slideDirection == Axis.horizontal ? 6.0 : 4.0;
    return widget.slideDirection == Axis.horizontal 
        ? SizedBox(width: spacing)
        : SizedBox(height: spacing);
  }

  Color _getBackgroundColor() {
    if (widget.isDisabled) {
      return context.mp.neutral20;
    }
    
    if (widget.isSelected) {
      return widget.tabColorActive ?? _getVariantActiveColor();
    }
    
    return widget.tabColor ?? _getVariantColor();
  }

  Color _getVariantColor() {
    switch (widget.variant) {
      case MPTabRoundedVariant.standard:
        return Colors.transparent;
      case MPTabRoundedVariant.outlined:
        return Colors.transparent;
      case MPTabRoundedVariant.filled:
        return context.mp.neutral10;
    }
  }

  Color _getVariantActiveColor() {
    switch (widget.variant) {
      case MPTabRoundedVariant.standard:
        return context.mp.primary;
      case MPTabRoundedVariant.outlined:
        return context.mp.primary.withValues(alpha: 0.1);
      case MPTabRoundedVariant.filled:
        return context.mp.primary;
    }
  }

  Color _getTextColor() {
    if (widget.isDisabled) {
      return context.mp.neutral60;
    }
    
    if (widget.isSelected) {
      return widget.textColorActive ?? 
             (widget.variant == MPTabRoundedVariant.standard 
                 ? context.mp.neutral100 
                 : context.mp.primary);
    }
    
    return widget.textColor ?? context.mp.neutral80;
  }

  Color _getIconColor() {
    return _getTextColor();
  }

  Color _getIndicatorColor() {
    return widget.indicatorColor ?? context.mp.primary;
  }

  Border? _getBorder() {
    switch (widget.variant) {
      case MPTabRoundedVariant.outlined:
        return Border.all(
          color: widget.isSelected 
              ? (widget.tabColorActive ?? context.mp.primary)
              : context.mp.neutral40,
          width: 1.0,
        );
      case MPTabRoundedVariant.standard:
      case MPTabRoundedVariant.filled:
        return null;
    }
  }

  BorderRadius _getBorderRadius() {
    if (widget.borderRadius != null) return widget.borderRadius!;
    
    switch (widget.size) {
      case MPTabRoundedSize.small:
        return BorderRadius.circular(8.0);
      case MPTabRoundedSize.medium:
        return BorderRadius.circular(12.0);
      case MPTabRoundedSize.large:
        return BorderRadius.circular(16.0);
    }
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case MPTabRoundedSize.small:
        return widget.slideDirection == Axis.horizontal
            ? const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0)
            : const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0);
      case MPTabRoundedSize.medium:
        return widget.slideDirection == Axis.horizontal
            ? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)
            : const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0);
      case MPTabRoundedSize.large:
        return widget.slideDirection == Axis.horizontal
            ? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)
            : const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0);
    }
  }

  double _getHeight() {
    switch (widget.size) {
      case MPTabRoundedSize.small:
        return 32.0;
      case MPTabRoundedSize.medium:
        return 40.0;
      case MPTabRoundedSize.large:
        return 48.0;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case MPTabRoundedSize.small:
        return 16.0;
      case MPTabRoundedSize.medium:
        return 18.0;
      case MPTabRoundedSize.large:
        return 20.0;
    }
  }

  TextStyle _getTextStyle() {
    final fontSize = widget.slideDirection == Axis.horizontal ? 14.0 : 12.0;
    final fontWeight = widget.isSelected ? FontWeight.w600 : FontWeight.w500;
    
    return TextStyle(
      color: _getTextColor(),
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  void _handleMouseEnter() {
    if (!widget.isDisabled && mounted) {
      setState(() {
        _isHovered = true;
      });
      _playHoverAnimation();
    }
  }

  void _handleMouseExit() {
    if (!widget.isDisabled && mounted) {
      setState(() {
        _isHovered = false;
      });
      _playNormalAnimation();
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isDisabled && widget.enableScaleAnimation) {
      _playPressAnimation();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isDisabled && widget.enableScaleAnimation) {
      if (_isHovered) {
        _playHoverAnimation();
      } else {
        _playNormalAnimation();
      }
    }
  }

  void _handleTapCancel() {
    if (!widget.isDisabled && widget.enableScaleAnimation) {
      if (_isHovered) {
        _playHoverAnimation();
      } else {
        _playNormalAnimation();
      }
    }
  }
}

/// Tab bar with smooth slide animations
/// 
/// This widget provides a container for multiple animated tabs
/// with smooth switching animations and consistent styling.
class MPTabBarAnimated extends StatefulWidget {
  const MPTabBarAnimated({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    this.onTabChanged,
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeOutCubic,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.spacing = 0.0,
    this.direction = Axis.horizontal,
    this.alignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final List<MPTabRoundedAnimated> tabs;
  final int selectedIndex;
  final ValueChanged<int>? onTabChanged;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double spacing;
  final Axis direction;
  final MainAxisAlignment alignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  State<MPTabBarAnimated> createState() => _MPTabBarAnimatedState();
}

class _MPTabBarAnimatedState extends State<MPTabBarAnimated> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? context.mp.neutral10,
        borderRadius: widget.borderRadius,
      ),
      child: Flex(
        direction: widget.direction,
        mainAxisAlignment: widget.alignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        children: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          
          return Flexible(
            flex: tab.flex,
            child: Padding(
              padding: widget.direction == Axis.horizontal
                  ? EdgeInsets.only(right: index < widget.tabs.length - 1 ? widget.spacing : 0)
                  : EdgeInsets.only(bottom: index < widget.tabs.length - 1 ? widget.spacing : 0),
              child: MPTabRoundedAnimated(
                title: tab.title,
                isSelected: index == widget.selectedIndex,
                onTap: () => widget.onTabChanged?.call(index),
                onLongPress: tab.onLongPress,
                variant: tab.variant,
                size: tab.size,
                tabColor: tab.tabColor,
                tabColorActive: tab.tabColorActive,
                textColor: tab.textColor,
                textColorActive: tab.textColorActive,
                height: tab.height,
                icon: tab.icon,
                iconSize: tab.iconSize,
                badge: tab.badge,
                badgeColor: tab.badgeColor,
                badgeTextColor: tab.badgeTextColor,
                animationDuration: widget.animationDuration,
                animationCurve: widget.animationCurve,
                borderRadius: tab.borderRadius,
                padding: tab.padding,
                showIndicator: tab.showIndicator,
                indicatorColor: tab.indicatorColor,
                indicatorHeight: tab.indicatorHeight,
                indicatorWidth: tab.indicatorWidth,
                flex: tab.flex,
                slideDirection: widget.direction,
                semanticLabel: tab.semanticLabel,
                semanticHint: tab.semanticHint,
                isDisabled: tab.isDisabled,
                enableSlideAnimation: tab.enableSlideAnimation,
                enableScaleAnimation: tab.enableScaleAnimation,
                hoverScale: tab.hoverScale,
                pressScale: tab.pressScale,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
