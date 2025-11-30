import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

enum MPTabRoundedVariant {
  standard,
  outlined,
  filled,
}

enum MPTabRoundedSize {
  small,
  medium,
  large,
}

class MPTabRounded extends StatefulWidget {
  const MPTabRounded({
    super.key,
    required this.title,
    this.tabLocation = 'center',
    this.tabColor,
    this.tabColorActive,
    this.textColor,
    // Removed hardcoded white color, will use theme-aware color in implementation
    this.textColorActive,
    this.height = 50,
    this.isActiveTab = false,
    this.isDisabled = false,
    this.onTab,
    // Removed hardcoded white color, will use theme-aware color in implementation
    this.deviderColor,
    this.dimen = 32.0,
    this.variant = MPTabRoundedVariant.standard,
    this.size = MPTabRoundedSize.medium,
    this.icon,
    this.iconSize,
    this.badge,
    this.badgeColor,
    this.badgeTextColor,
    this.animationDuration = const Duration(milliseconds: 200),
    this.borderRadius,
    this.padding,
    this.showIndicator = true,
    this.indicatorColor,
    this.indicatorHeight,
    this.indicatorWidth,
    this.flex = 1,
    this.onLongPress,
    this.semanticLabel,
  });

  final String? title;
  final String? tabLocation;
  final Color? tabColorActive;
  final Color? tabColor;
  final Color? textColorActive;
  final Color? textColor;
  final double? height;
  final bool? isActiveTab;
  final bool isDisabled;
  final void Function()? onTab;
  final Color? deviderColor;
  final double dimen;
  final MPTabRoundedVariant variant;
  final MPTabRoundedSize size;
  final IconData? icon;
  final double? iconSize;
  final String? badge;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final Duration animationDuration;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final bool showIndicator;
  final Color? indicatorColor;
  final double? indicatorHeight;
  final double? indicatorWidth;
  final int flex;
  final VoidCallback? onLongPress;
  final String? semanticLabel;

  @override
  State<MPTabRounded> createState() => _MPTabRoundedState();
}

class _MPTabRoundedState extends State<MPTabRounded>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _indicatorAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _indicatorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.isActiveTab == true) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MPTabRounded oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActiveTab != widget.isActiveTab) {
      if (widget.isActiveTab == true) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Remove the Expanded wrapper to avoid ParentDataWidget conflicts
    // The parent widget should handle the Expanded wrapper
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.isDisabled ? null : (widget.onTab ?? () {}),
        onLongPress: widget.isDisabled ? null : widget.onLongPress,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              height: widget.height ?? _getHeight(),
              alignment: Alignment.center,
              padding: widget.padding ?? _getPadding(),
              decoration: BoxDecoration(
                border: Border(
                  left: widget.tabLocation?.toLowerCase() == 'center'
                      ? BorderSide(
                          color: widget.deviderColor ??
                              context.mp.adaptiveBorderColor)
                      : BorderSide.none,
                  right: widget.tabLocation?.toLowerCase() == 'center'
                      ? BorderSide(
                          color: widget.deviderColor ??
                              context.mp.adaptiveBorderColor)
                      : BorderSide.none,
                ),
                color: _getBackgroundColor(context),
                borderRadius: widget.borderRadius ??
                    BorderRadius.only(
                      topLeft: widget.tabLocation?.toLowerCase() == 'left'
                          ? Radius.circular(widget.dimen)
                          : Radius.zero,
                      bottomLeft: widget.tabLocation?.toLowerCase() == 'left'
                          ? Radius.circular(widget.dimen)
                          : Radius.zero,
                      topRight: widget.tabLocation?.toLowerCase() == 'right'
                          ? Radius.circular(widget.dimen)
                          : Radius.zero,
                      bottomRight: widget.tabLocation?.toLowerCase() == 'right'
                          ? Radius.circular(widget.dimen)
                          : Radius.zero,
                    ),
              ),
              child: Stack(
                children: [
                  // Tab content
                  _buildTabContent(context),
                  // Indicator
                  if (widget.showIndicator && widget.isActiveTab == true)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: AnimatedBuilder(
                        animation: _indicatorAnimation,
                        builder: (context, child) {
                          return Container(
                            height: widget.indicatorHeight ?? 3,
                            width: _indicatorAnimation.value *
                                MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              // Use theme-aware primary color for indicator
                              color:
                                  widget.indicatorColor ?? context.mp.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    final List<Widget> children = [];

    // Add icon if provided
    if (widget.icon != null) {
      children.add(
        Icon(
          widget.icon,
          size: widget.iconSize ?? _getIconSize(),
          // Use theme-aware colors for icon with disabled state
          color: _getTextColor(context),
        ),
      );

      // Add spacing between icon and text
      if (widget.title != null) {
        children.add(SizedBox(width: 6));
      }
    }

    // Add text if provided
    if (widget.title != null) {
      children.add(
        Flexible(
          child: MPText.label(
            widget.title!,
            style: MPTextStyle.body2(
              // Use theme-aware colors for text with disabled state
              color: _getTextColor(context),
              fontWeight: widget.isActiveTab == true
                  ? FontWeight.w500
                  : FontWeight.w200,
            ).copyWith(fontSize: _getFontSize()),
          ),
        ),
      );
    }

    // Add badge if provided
    if (widget.badge != null) {
      children.add(
        Container(
          margin: const EdgeInsets.only(left: 4),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            // Use error color for badge (semantic color)
            color: widget.badgeColor ?? context.mp.errorColor,
            borderRadius: BorderRadius.circular(10),
          ),
          constraints: const BoxConstraints(
            minWidth: 16,
            minHeight: 16,
          ),
          child: MPText.label(
            widget.badge!,
            style: MPTextStyle.caption(
              // Use neutral100 (white) for badge text
              color: widget.badgeTextColor ?? context.mp.neutral100,
              fontWeight: FontWeight.w500,
            ).copyWith(fontSize: 10),
          ),
        ),
      );
    }

    // If only text, return text
    if (widget.icon == null && widget.title != null && widget.badge == null) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: MPText.label(
          widget.title!,
          style: MPTextStyle.body2(
            // Use theme-aware colors for text with disabled state
            color: _getTextColor(context),
            fontWeight:
                widget.isActiveTab == true ? FontWeight.w500 : FontWeight.w200,
          ).copyWith(fontSize: _getFontSize()),
        ),
      );
    }

    // Return row with multiple items
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    // Handle disabled state first
    if (widget.isDisabled) {
      return context.mp.disabledColor.withValues(alpha: 0.1);
    }

    switch (widget.variant) {
      case MPTabRoundedVariant.standard:
        // Use theme-aware colors for standard variant with hover state
        if (widget.isActiveTab == true) {
          return widget.tabColorActive ?? context.mp.primary;
        } else if (_isHovered) {
          return widget.tabColor ?? context.mp.primaryHover;
        } else {
          return widget.tabColor ?? context.mp.adaptiveBackgroundColor;
        }
      case MPTabRoundedVariant.outlined:
        // Use theme-aware colors for outlined variant with hover state
        if (widget.isActiveTab == true) {
          return widget.tabColorActive ?? context.mp.primary;
        } else if (_isHovered) {
          return context.mp.primarySurface;
        } else {
          return Colors.transparent;
        }
      case MPTabRoundedVariant.filled:
        // Use theme-aware colors for filled variant with opacity and hover state
        if (widget.isActiveTab == true) {
          return widget.tabColorActive ?? context.mp.primary;
        } else if (_isHovered) {
          return (widget.tabColor ?? context.mp.subtitleColor)
              .withValues(alpha: 0.2);
        } else {
          return (widget.tabColor ?? context.mp.subtitleColor)
              .withValues(alpha: 0.1);
        }
    }
  }

  // Helper method to get text color with disabled state
  Color _getTextColor(BuildContext context) {
    if (widget.isDisabled) {
      return context.mp.disabledColor;
    }

    return widget.isActiveTab == true
        ? widget.textColorActive ?? context.mp.neutral100
        : widget.textColor ?? context.mp.subtitleColor;
  }

  double _getHeight() {
    switch (widget.size) {
      case MPTabRoundedSize.small:
        return 40;
      case MPTabRoundedSize.medium:
        return 50;
      case MPTabRoundedSize.large:
        return 60;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case MPTabRoundedSize.small:
        return 16;
      case MPTabRoundedSize.medium:
        return 18;
      case MPTabRoundedSize.large:
        return 20;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case MPTabRoundedSize.small:
        return 12;
      case MPTabRoundedSize.medium:
        return 14;
      case MPTabRoundedSize.large:
        return 16;
    }
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case MPTabRoundedSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case MPTabRoundedSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case MPTabRoundedSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    }
  }
}
