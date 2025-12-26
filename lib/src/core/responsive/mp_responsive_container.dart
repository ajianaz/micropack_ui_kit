import 'package:flutter/material.dart';
import 'mp_responsive_breakpoints.dart';

/// MPResponsiveContainer - Container that adapts to screen size and orientation
///
/// Provides responsive dimensions, padding, and layout behavior
/// Following mobile-first responsive design principles
class MPResponsiveContainer extends StatelessWidget {
  /// Creates a responsive container
  const MPResponsiveContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.margin,
    this.mobileMargin,
    this.tabletMargin,
    this.desktopMargin,
    this.alignment,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.clipBehavior,
    this.transform,
    this.transformAlignment,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOut,
    this.animated = true,
  });

  /// Child widget to contain
  final Widget child;

  /// Fixed width (overrides responsive calculation)
  final double? width;

  /// Fixed height (overrides responsive calculation)
  final double? height;

  /// Responsive width for mobile screens
  final double? mobileWidth;

  /// Responsive width for tablet screens
  final double? tabletWidth;

  /// Responsive width for desktop screens
  final double? desktopWidth;

  /// Responsive height for mobile screens
  final double? mobileHeight;

  /// Responsive height for tablet screens
  final double? tabletHeight;

  /// Responsive height for desktop screens
  final double? desktopHeight;

  /// Minimum width constraint
  final double? minWidth;

  /// Maximum width constraint
  final double? maxWidth;

  /// Minimum height constraint
  final double? minHeight;

  /// Maximum height constraint
  final double? maxHeight;

  /// Fixed padding (overrides responsive calculation)
  final EdgeInsets? padding;

  /// Responsive padding for mobile screens
  final EdgeInsets? mobilePadding;

  /// Responsive padding for tablet screens
  final EdgeInsets? tabletPadding;

  /// Responsive padding for desktop screens
  final EdgeInsets? desktopPadding;

  /// Fixed margin (overrides responsive calculation)
  final EdgeInsets? margin;

  /// Responsive margin for mobile screens
  final EdgeInsets? mobileMargin;

  /// Responsive margin for tablet screens
  final EdgeInsets? tabletMargin;

  /// Responsive margin for desktop screens
  final EdgeInsets? desktopMargin;

  /// Alignment of child within container
  final Alignment? alignment;

  /// Background color
  final Color? color;

  /// Background decoration
  final BoxDecoration? decoration;

  /// Foreground decoration
  final BoxDecoration? foregroundDecoration;

  /// Additional size constraints
  final BoxConstraints? constraints;

  /// Clip behavior
  final Clip? clipBehavior;

  /// Transform matrix
  final Matrix4? transform;

  /// Alignment of transform origin
  final AlignmentGeometry? transformAlignment;

  /// Duration for responsive animations
  final Duration transitionDuration;

  /// Curve for responsive animations
  final Curve transitionCurve;

  /// Whether to animate size changes
  final bool animated;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildResponsiveContainer(context, constraints);
      },
    );
  }

  Widget _buildResponsiveContainer(
      BuildContext context, BoxConstraints constraints) {
    final screenWidth = MediaQuery.of(context).size.width;
    final deviceSize = MPResponsiveBreakpoints.getDeviceSize(screenWidth);

    // Calculate responsive dimensions
    final responsiveWidth = _getResponsiveWidth(screenWidth, deviceSize);
    final responsiveHeight = _getResponsiveHeight(screenWidth, deviceSize);
    final responsivePadding = _getResponsivePadding(screenWidth, deviceSize);
    final responsiveMargin = _getResponsiveMargin(screenWidth, deviceSize);

    // Calculate final constraints
    final containerConstraints = _calculateConstraints(
      constraints,
      responsiveWidth,
      responsiveHeight,
    );

    final container = Container(
      width: width ?? responsiveWidth,
      height: height ?? responsiveHeight,
      padding: padding ?? responsivePadding,
      margin: margin ?? responsiveMargin,
      alignment: alignment,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      constraints: containerConstraints,
      clipBehavior: clipBehavior ?? Clip.none,
      transform: transform,
      transformAlignment: transformAlignment,
      child: child,
    );

    if (animated) {
      return AnimatedContainer(
        duration: transitionDuration,
        curve: transitionCurve,
        width: width ?? responsiveWidth,
        height: height ?? responsiveHeight,
        padding: padding ?? responsivePadding,
        margin: margin ?? responsiveMargin,
        alignment: alignment,
        decoration: decoration,
        foregroundDecoration: foregroundDecoration,
        constraints: containerConstraints,
        clipBehavior: clipBehavior ?? Clip.none,
        transform: transform,
        transformAlignment: transformAlignment,
        child: child,
      );
    }

    return container;
  }

  /// Get responsive width based on screen size
  double? _getResponsiveWidth(double screenWidth, MPDeviceSize deviceSize) {
    if (width != null) return null;

    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
        return mobileWidth;
      case MPDeviceSize.mobile:
        return mobileWidth;
      case MPDeviceSize.largeMobile:
        return mobileWidth;
      case MPDeviceSize.smallTablet:
        return tabletWidth ?? mobileWidth;
      case MPDeviceSize.tablet:
        return tabletWidth ?? mobileWidth;
      case MPDeviceSize.largeTablet:
        return tabletWidth ?? mobileWidth;
      case MPDeviceSize.smallDesktop:
        return desktopWidth ?? tabletWidth ?? mobileWidth;
      case MPDeviceSize.desktop:
        return desktopWidth ?? tabletWidth ?? mobileWidth;
      case MPDeviceSize.largeDesktop:
        return desktopWidth ?? tabletWidth ?? mobileWidth;
      case MPDeviceSize.ultraWide:
        return desktopWidth ?? tabletWidth ?? mobileWidth;
    }
  }

  /// Get responsive height based on screen size
  double? _getResponsiveHeight(double screenWidth, MPDeviceSize deviceSize) {
    if (height != null) return null;

    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
        return mobileHeight;
      case MPDeviceSize.mobile:
        return mobileHeight;
      case MPDeviceSize.largeMobile:
        return mobileHeight;
      case MPDeviceSize.smallTablet:
        return tabletHeight ?? mobileHeight;
      case MPDeviceSize.tablet:
        return tabletHeight ?? mobileHeight;
      case MPDeviceSize.largeTablet:
        return tabletHeight ?? mobileHeight;
      case MPDeviceSize.smallDesktop:
        return desktopHeight ?? tabletHeight ?? mobileHeight;
      case MPDeviceSize.desktop:
        return desktopHeight ?? tabletHeight ?? mobileHeight;
      case MPDeviceSize.largeDesktop:
        return desktopHeight ?? tabletHeight ?? mobileHeight;
      case MPDeviceSize.ultraWide:
        return desktopHeight ?? tabletHeight ?? mobileHeight;
    }
  }

  /// Get responsive padding based on screen size
  EdgeInsets _getResponsivePadding(
      double screenWidth, MPDeviceSize deviceSize) {
    if (padding != null) return EdgeInsets.zero;

    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
        return mobilePadding ?? const EdgeInsets.all(12);
      case MPDeviceSize.mobile:
        return mobilePadding ?? const EdgeInsets.all(16);
      case MPDeviceSize.largeMobile:
        return mobilePadding ?? const EdgeInsets.all(16);
      case MPDeviceSize.smallTablet:
        return tabletPadding ?? mobilePadding ?? const EdgeInsets.all(20);
      case MPDeviceSize.tablet:
        return tabletPadding ?? mobilePadding ?? const EdgeInsets.all(24);
      case MPDeviceSize.largeTablet:
        return tabletPadding ?? mobilePadding ?? const EdgeInsets.all(24);
      case MPDeviceSize.smallDesktop:
        return desktopPadding ??
            tabletPadding ??
            mobilePadding ??
            const EdgeInsets.all(32);
      case MPDeviceSize.desktop:
        return desktopPadding ??
            tabletPadding ??
            mobilePadding ??
            const EdgeInsets.all(32);
      case MPDeviceSize.largeDesktop:
        return desktopPadding ??
            tabletPadding ??
            mobilePadding ??
            const EdgeInsets.all(32);
      case MPDeviceSize.ultraWide:
        return desktopPadding ??
            tabletPadding ??
            mobilePadding ??
            const EdgeInsets.all(40);
    }
  }

  /// Get responsive margin based on screen size
  EdgeInsets _getResponsiveMargin(double screenWidth, MPDeviceSize deviceSize) {
    if (margin != null) return EdgeInsets.zero;

    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
        return mobileMargin ?? const EdgeInsets.all(8);
      case MPDeviceSize.mobile:
        return mobileMargin ?? const EdgeInsets.all(12);
      case MPDeviceSize.largeMobile:
        return mobileMargin ?? const EdgeInsets.all(12);
      case MPDeviceSize.smallTablet:
        return tabletMargin ?? mobileMargin ?? const EdgeInsets.all(16);
      case MPDeviceSize.tablet:
        return tabletMargin ?? mobileMargin ?? const EdgeInsets.all(20);
      case MPDeviceSize.largeTablet:
        return tabletMargin ?? mobileMargin ?? const EdgeInsets.all(20);
      case MPDeviceSize.smallDesktop:
        return desktopMargin ??
            tabletMargin ??
            mobileMargin ??
            const EdgeInsets.all(24);
      case MPDeviceSize.desktop:
        return desktopMargin ??
            tabletMargin ??
            mobileMargin ??
            const EdgeInsets.all(24);
      case MPDeviceSize.largeDesktop:
        return desktopMargin ??
            tabletMargin ??
            mobileMargin ??
            const EdgeInsets.all(24);
      case MPDeviceSize.ultraWide:
        return desktopMargin ??
            tabletMargin ??
            mobileMargin ??
            const EdgeInsets.all(32);
    }
  }

  /// Calculate final constraints
  BoxConstraints? _calculateConstraints(
    BoxConstraints layoutConstraints,
    double? responsiveWidth,
    double? responsiveHeight,
  ) {
    final finalConstraints = <BoxConstraints>[];

    // Add width constraints
    if (minWidth != null) {
      finalConstraints.add(BoxConstraints(minWidth: minWidth!));
    }
    if (maxWidth != null) {
      finalConstraints.add(BoxConstraints(maxWidth: maxWidth!));
    }
    if (responsiveWidth != null) {
      finalConstraints.add(BoxConstraints(
        minWidth: responsiveWidth!,
        maxWidth: responsiveWidth!,
      ));
    }

    // Add height constraints
    if (minHeight != null) {
      finalConstraints.add(BoxConstraints(minHeight: minHeight!));
    }
    if (maxHeight != null) {
      finalConstraints.add(BoxConstraints(maxHeight: maxHeight!));
    }
    if (responsiveHeight != null) {
      finalConstraints.add(BoxConstraints(
        minHeight: responsiveHeight!,
        maxHeight: responsiveHeight!,
      ));
    }

    // Merge with layout constraints
    finalConstraints.add(layoutConstraints);

    if (finalConstraints.isEmpty) return null;

    // Combine all constraints
    double? finalMinWidth, finalMaxWidth, finalMinHeight, finalMaxHeight;

    for (final constraint in finalConstraints) {
      if (constraint.minWidth != null) {
        final minWidth = constraint.minWidth!;
        finalMinWidth = finalMinWidth != null
            ? (finalMinWidth > minWidth ? finalMinWidth : minWidth)
            : minWidth;
      }
      if (constraint.maxWidth != null) {
        final maxWidth = constraint.maxWidth!;
        finalMaxWidth = finalMaxWidth != null
            ? (finalMaxWidth < maxWidth ? finalMaxWidth : maxWidth)
            : maxWidth;
      }
      if (constraint.minHeight != null) {
        final minHeight = constraint.minHeight!;
        finalMinHeight = finalMinHeight != null
            ? (finalMinHeight > minHeight ? finalMinHeight : minHeight)
            : minHeight;
      }
      if (constraint.maxHeight != null) {
        final maxHeight = constraint.maxHeight!;
        finalMaxHeight = finalMaxHeight != null
            ? (finalMaxHeight < maxHeight ? finalMaxHeight : maxHeight)
            : maxHeight;
      }
    }

    return BoxConstraints(
      minWidth: finalMinWidth ?? 0.0,
      maxWidth: finalMaxWidth ?? double.infinity,
      minHeight: finalMinHeight ?? 0.0,
      maxHeight: finalMaxHeight ?? double.infinity,
    );
  }
}

/// MPResponsiveContainerBuilder - Builder pattern for responsive containers
class MPResponsiveContainerBuilder extends StatelessWidget {
  /// Creates a responsive container builder
  const MPResponsiveContainerBuilder({
    super.key,
    required this.builder,
    this.width,
    this.height,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.margin,
    this.mobileMargin,
    this.tabletMargin,
    this.desktopMargin,
    this.alignment,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.clipBehavior,
    this.transform,
    this.transformAlignment,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOut,
    this.animated = true,
  });

  /// Builder function
  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
    MPDeviceSize deviceSize,
    double screenWidth,
  ) builder;

  /// Fixed width (overrides responsive calculation)
  final double? width;

  /// Fixed height (overrides responsive calculation)
  final double? height;

  /// Responsive width for mobile screens
  final double? mobileWidth;

  /// Responsive width for tablet screens
  final double? tabletWidth;

  /// Responsive width for desktop screens
  final double? desktopWidth;

  /// Responsive height for mobile screens
  final double? mobileHeight;

  /// Responsive height for tablet screens
  final double? tabletHeight;

  /// Responsive height for desktop screens
  final double? desktopHeight;

  /// Minimum width constraint
  final double? minWidth;

  /// Maximum width constraint
  final double? maxWidth;

  /// Minimum height constraint
  final double? minHeight;

  /// Maximum height constraint
  final double? maxHeight;

  /// Fixed padding (overrides responsive calculation)
  final EdgeInsets? padding;

  /// Responsive padding for mobile screens
  final EdgeInsets? mobilePadding;

  /// Responsive padding for tablet screens
  final EdgeInsets? tabletPadding;

  /// Responsive padding for desktop screens
  final EdgeInsets? desktopPadding;

  /// Fixed margin (overrides responsive calculation)
  final EdgeInsets? margin;

  /// Responsive margin for mobile screens
  final EdgeInsets? mobileMargin;

  /// Responsive margin for tablet screens
  final EdgeInsets? tabletMargin;

  /// Responsive margin for desktop screens
  final EdgeInsets? desktopMargin;

  /// Alignment of child within container
  final Alignment? alignment;

  /// Background color
  final Color? color;

  /// Background decoration
  final BoxDecoration? decoration;

  /// Foreground decoration
  final BoxDecoration? foregroundDecoration;

  /// Additional size constraints
  final BoxConstraints? constraints;

  /// Clip behavior
  final Clip? clipBehavior;

  /// Transform matrix
  final Matrix4? transform;

  /// Alignment of transform origin
  final AlignmentGeometry? transformAlignment;

  /// Duration for responsive animations
  final Duration transitionDuration;

  /// Curve for responsive animations
  final Curve transitionCurve;

  /// Whether to animate size changes
  final bool animated;

  @override
  Widget build(BuildContext context) {
    return MPResponsiveContainer(
      width: width,
      height: height,
      mobileWidth: mobileWidth,
      tabletWidth: tabletWidth,
      desktopWidth: desktopWidth,
      mobileHeight: mobileHeight,
      tabletHeight: tabletHeight,
      desktopHeight: desktopHeight,
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
      padding: padding,
      mobilePadding: mobilePadding,
      tabletPadding: tabletPadding,
      desktopPadding: desktopPadding,
      margin: margin,
      mobileMargin: mobileMargin,
      tabletMargin: tabletMargin,
      desktopMargin: desktopMargin,
      alignment: alignment,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      constraints: constraints,
      clipBehavior: clipBehavior,
      transform: transform,
      transformAlignment: transformAlignment,
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      animated: animated,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final deviceSize = MPResponsiveBreakpoints.getDeviceSize(screenWidth);
          return builder(context, constraints, deviceSize, screenWidth);
        },
      ),
    );
  }
}
