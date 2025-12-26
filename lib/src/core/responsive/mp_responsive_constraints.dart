import 'package:flutter/material.dart';
import 'mp_responsive_breakpoints.dart';
import 'mp_responsive_padding.dart';

/// MPResponsiveConstraints - Responsive constraints for maximum/minimum sizes
///
/// Provides flexible size constraints that adapt to different screen sizes
/// Following mobile-first responsive design principles
class MPResponsiveConstraints extends StatelessWidget {
  /// Creates a responsive constraints widget
  const MPResponsiveConstraints({
    super.key,
    required this.child,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.minSize,
    this.maxSize,
    this.mobileConstraints,
    this.tabletConstraints,
    this.desktopConstraints,
    this.customConstraints,
    this.aspectRatio,
    this.alignment = Alignment.center,
    this.padding,
    this.margin,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOut,
  });

  /// Child widget
  final Widget child;

  /// Minimum width
  final double? minWidth;

  /// Maximum width
  final double? maxWidth;

  /// Minimum height
  final double? minHeight;

  /// Maximum height
  final double? maxHeight;

  /// Minimum size for both width and height
  final double? minSize;

  /// Maximum size for both width and height
  final double? maxSize;

  /// Custom constraints for mobile devices
  final BoxConstraints? mobileConstraints;

  /// Custom constraints for tablet devices
  final BoxConstraints? tabletConstraints;

  /// Custom constraints for desktop devices
  final BoxConstraints? desktopConstraints;

  /// Custom constraints function based on device size
  final BoxConstraints Function(MPDeviceSize deviceSize, BoxConstraints constraints)? customConstraints;

  /// Aspect ratio for the child
  final double? aspectRatio;

  /// Alignment of the child within constraints
  final Alignment alignment;

  /// Padding around the child
  final EdgeInsets? padding;

  /// Margin outside the container
  final EdgeInsets? margin;

  /// Duration for constraint transition animations
  final Duration transitionDuration;

  /// Curve for constraint transition animations
  final Curve transitionCurve;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(screenWidth);
        
        final responsiveConstraints = _calculateConstraints(deviceSize, constraints);
        
        return AnimatedContainer(
          duration: transitionDuration,
          curve: transitionCurve,
          constraints: responsiveConstraints,
          alignment: alignment,
          padding: padding,
          margin: margin,
          child: aspectRatio != null
              ? AspectRatio(
                  aspectRatio: aspectRatio!,
                  child: child,
                )
              : child,
        );
      },
    );
  }

  /// Calculate constraints based on device size
  BoxConstraints _calculateConstraints(
    MPDeviceSize deviceSize,
    BoxConstraints parentConstraints,
  ) {
    // Start with custom device-specific constraints
    BoxConstraints? constraints;
    
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
      case MPDeviceSize.mobile:
      case MPDeviceSize.largeMobile:
        constraints = mobileConstraints;
        break;
      case MPDeviceSize.smallTablet:
      case MPDeviceSize.tablet:
      case MPDeviceSize.largeTablet:
        constraints = tabletConstraints;
        break;
      case MPDeviceSize.smallDesktop:
      case MPDeviceSize.desktop:
      case MPDeviceSize.largeDesktop:
      case MPDeviceSize.ultraWide:
        constraints = desktopConstraints;
        break;
    }

    // Apply custom constraints function if provided
    if (customConstraints != null) {
      constraints = customConstraints!(deviceSize, parentConstraints);
    }

    // Apply individual constraints
    if (constraints != null) {
      return constraints.copyWith(
        minWidth: minWidth ?? minSize ?? constraints.minWidth,
        maxWidth: maxWidth ?? maxSize ?? constraints.maxWidth,
        minHeight: minHeight ?? minSize ?? constraints.minHeight,
        maxHeight: maxHeight ?? maxSize ?? constraints.maxHeight,
      );
    }

    // Create constraints from individual values
    return BoxConstraints(
      minWidth: minWidth ?? minSize ?? 0,
      maxWidth: maxWidth ?? maxSize ?? double.infinity,
      minHeight: minHeight ?? minSize ?? 0,
      maxHeight: maxHeight ?? maxSize ?? double.infinity,
    );
  }
}

/// MPResponsiveContainerWithConstraintsWithConstraints - Container with responsive constraints and styling
class MPResponsiveContainerWithConstraintsWithConstraints extends StatelessWidget {
  /// Creates a responsive container
  const MPResponsiveContainerWithConstraintsWithConstraints({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.alignment,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    this.constraints,
    this.responsiveConstraints,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOut,
  });

  /// Child widget
  final Widget child;

  /// Fixed width
  final double? width;

  /// Fixed height
  final double? height;

  /// Minimum width
  final double? minWidth;

  /// Maximum width
  final double? maxWidth;

  /// Minimum height
  final double? minHeight;

  /// Maximum height
  final double? maxHeight;

  /// Responsive width for mobile
  final double? mobileWidth;

  /// Responsive width for tablet
  final double? tabletWidth;

  /// Responsive width for desktop
  final double? desktopWidth;

  /// Responsive height for mobile
  final double? mobileHeight;

  /// Responsive height for tablet
  final double? tabletHeight;

  /// Responsive height for desktop
  final double? desktopHeight;

  /// Padding
  final EdgeInsets? padding;

  /// Margin
  final EdgeInsets? margin;

  /// Background color
  final Color? color;

  /// Decoration
  final Decoration? decoration;

  /// Foreground decoration
  final Decoration? foregroundDecoration;

  /// Alignment
  final Alignment? alignment;

  /// Transform
  final Matrix4? transform;

  /// Transform alignment
  final Alignment? transformAlignment;

  /// Clip behavior
  final Clip clipBehavior;

  /// Additional constraints
  final BoxConstraints? constraints;

  /// Responsive constraints
  final BoxConstraints? responsiveConstraints;

  /// Duration for animations
  final Duration transitionDuration;

  /// Curve for animations
  final Curve transitionCurve;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(screenWidth);
        
        // Calculate responsive dimensions
        final responsiveWidth = _getResponsiveWidth(deviceSize);
        final responsiveHeight = _getResponsiveHeight(deviceSize);
        
        // Calculate responsive padding
        final responsivePadding = _getResponsivePadding(context);
        
        return AnimatedContainer(
          duration: transitionDuration,
          curve: transitionCurve,
          width: responsiveWidth,
          height: responsiveHeight,
          padding: responsivePadding,
          margin: margin,
          color: color,
          decoration: decoration,
          foregroundDecoration: foregroundDecoration,
          alignment: alignment,
          transform: transform,
          transformAlignment: transformAlignment,
          clipBehavior: clipBehavior,
          constraints: constraints ?? responsiveConstraints,
          child: child,
        );
      },
    );
  }

  /// Get responsive width based on device size
  double? _getResponsiveWidth(MPDeviceSize deviceSize) {
    if (width != null) return width;
    
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
      case MPDeviceSize.mobile:
      case MPDeviceSize.largeMobile:
        return mobileWidth;
      case MPDeviceSize.smallTablet:
      case MPDeviceSize.tablet:
      case MPDeviceSize.largeTablet:
        return tabletWidth;
      case MPDeviceSize.smallDesktop:
      case MPDeviceSize.desktop:
      case MPDeviceSize.largeDesktop:
      case MPDeviceSize.ultraWide:
        return desktopWidth;
    }
  }

  /// Get responsive height based on device size
  double? _getResponsiveHeight(MPDeviceSize deviceSize) {
    if (height != null) return height;
    
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
      case MPDeviceSize.mobile:
      case MPDeviceSize.largeMobile:
        return mobileHeight;
      case MPDeviceSize.smallTablet:
      case MPDeviceSize.tablet:
      case MPDeviceSize.largeTablet:
        return tabletHeight;
      case MPDeviceSize.smallDesktop:
      case MPDeviceSize.desktop:
      case MPDeviceSize.largeDesktop:
      case MPDeviceSize.ultraWide:
        return desktopHeight;
    }
  }

  /// Get responsive padding based on device size
  EdgeInsets? _getResponsivePadding(BuildContext context) {
    if (padding != null) return padding;
    
    final screenWidth = MediaQuery.of(context).size.width;
    return MPResponsivePadding.standard(context);
  }
}

/// MPResponsiveSizedBox - SizedBox with responsive dimensions
class MPResponsiveSizedBox extends StatelessWidget {
  /// Creates a responsive sized box
  const MPResponsiveSizedBox({
    super.key,
    this.child,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
    this.width,
    this.height,
    this.aspectRatio,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOut,
  });

  /// Child widget
  final Widget? child;

  /// Width for mobile devices
  final double? mobileWidth;

  /// Width for tablet devices
  final double? tabletWidth;

  /// Width for desktop devices
  final double? desktopWidth;

  /// Height for mobile devices
  final double? mobileHeight;

  /// Height for tablet devices
  final double? tabletHeight;

  /// Height for desktop devices
  final double? desktopHeight;

  /// Fixed width (overrides responsive)
  final double? width;

  /// Fixed height (overrides responsive)
  final double? height;

  /// Aspect ratio
  final double? aspectRatio;

  /// Duration for animations
  final Duration transitionDuration;

  /// Curve for animations
  final Curve transitionCurve;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final deviceSize = MPResponsiveBreakpoints.getDeviceSize(screenWidth);
        
        final responsiveWidth = _getResponsiveWidth(deviceSize);
        final responsiveHeight = _getResponsiveHeight(deviceSize);
        
        return AnimatedSizedBox(
          duration: transitionDuration,
          curve: transitionCurve,
          width: width ?? responsiveWidth,
          height: height ?? responsiveHeight,
          child: aspectRatio != null
              ? AspectRatio(
                  aspectRatio: aspectRatio!,
                  child: child,
                )
              : child,
        );
      },
    );
  }

  /// Get responsive width based on device size
  double? _getResponsiveWidth(MPDeviceSize deviceSize) {
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
      case MPDeviceSize.mobile:
      case MPDeviceSize.largeMobile:
        return mobileWidth;
      case MPDeviceSize.smallTablet:
      case MPDeviceSize.tablet:
      case MPDeviceSize.largeTablet:
        return tabletWidth;
      case MPDeviceSize.smallDesktop:
      case MPDeviceSize.desktop:
      case MPDeviceSize.largeDesktop:
      case MPDeviceSize.ultraWide:
        return desktopWidth;
    }
  }

  /// Get responsive height based on device size
  double? _getResponsiveHeight(MPDeviceSize deviceSize) {
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
      case MPDeviceSize.mobile:
      case MPDeviceSize.largeMobile:
        return mobileHeight;
      case MPDeviceSize.smallTablet:
      case MPDeviceSize.tablet:
      case MPDeviceSize.largeTablet:
        return tabletHeight;
      case MPDeviceSize.smallDesktop:
      case MPDeviceSize.desktop:
      case MPDeviceSize.largeDesktop:
      case MPDeviceSize.ultraWide:
        return desktopHeight;
    }
  }
}

/// AnimatedSizedBox for smooth transitions
class AnimatedSizedBox extends StatelessWidget {
  const AnimatedSizedBox({
    super.key,
    this.width,
    this.height,
    this.child,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.alignment,
    this.clipBehavior = Clip.none,
  });

  final double? width;
  final double? height;
  final Widget? child;
  final Duration duration;
  final Curve curve;
  final Alignment? alignment;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return SizedBox(
          width: width != null ? width! * value : null,
          height: height != null ? height! * value : null,
          child: child,
        );
      },
      child: child,
    );
  }
}
