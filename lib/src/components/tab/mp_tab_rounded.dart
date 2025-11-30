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
    this.textColorActive = Colors.white,
    this.height = 50,
    this.isActiveTab = false,
    this.onTab,
    this.deviderColor = Colors.white,
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
  final void Function()? onTab;
  final Color deviderColor;
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
    return Expanded(
      flex: widget.flex,
      child: GestureDetector(
        onTap: widget.onTab ?? () {},
        onLongPress: widget.onLongPress,
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
                      ? BorderSide(color: widget.deviderColor)
                      : BorderSide.none,
                  right: widget.tabLocation?.toLowerCase() == 'center'
                      ? BorderSide(color: widget.deviderColor)
                      : BorderSide.none,
                ),
                color: _getBackgroundColor(),
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
                  _buildTabContent(),
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
                              color:
                                  widget.indicatorColor ?? MpUiKit.colorBrand,
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

  Widget _buildTabContent() {
    final List<Widget> children = [];

    // Add icon if provided
    if (widget.icon != null) {
      children.add(
        Icon(
          widget.icon,
          size: widget.iconSize ?? _getIconSize(),
          color: widget.isActiveTab == true
              ? widget.textColorActive ?? Colors.white
              : widget.textColor ?? MpUiKit.colorText,
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
              color: widget.isActiveTab == true
                  ? widget.textColorActive ?? Colors.white
                  : widget.textColor ?? MpUiKit.colorText,
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
            color: widget.badgeColor ?? Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          constraints: const BoxConstraints(
            minWidth: 16,
            minHeight: 16,
          ),
          child: MPText.label(
            widget.badge!,
            style: MPTextStyle.caption(
              color: widget.badgeTextColor ?? Colors.white,
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
            color: widget.isActiveTab == true
                ? widget.textColorActive ?? Colors.white
                : widget.textColor ?? MpUiKit.colorText,
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

  Color _getBackgroundColor() {
    switch (widget.variant) {
      case MPTabRoundedVariant.standard:
        return widget.isActiveTab == true
            ? (widget.tabColorActive ?? MpUiKit.colorBrand)
            : widget.tabColor ?? Colors.grey;
      case MPTabRoundedVariant.outlined:
        return widget.isActiveTab == true
            ? (widget.tabColorActive ?? MpUiKit.colorBrand)
            : Colors.transparent;
      case MPTabRoundedVariant.filled:
        return widget.isActiveTab == true
            ? (widget.tabColorActive ?? MpUiKit.colorBrand)
            : (widget.tabColor ?? Colors.grey).withValues(alpha: 0.1);
    }
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
