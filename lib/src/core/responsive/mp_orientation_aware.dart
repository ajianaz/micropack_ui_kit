import 'package:flutter/material.dart';
import 'mp_responsive_padding.dart';

/// MPOrientationAware - Orientation-aware layout system
///
/// Provides widgets that adapt to both screen size and orientation
/// Following mobile-first responsive design principles
class MPOrientationAware extends StatelessWidget {
  /// Creates an orientation-aware widget
  const MPOrientationAware({
    super.key,
    required this.builder,
    this.portrait,
    this.landscape,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOut,
  });

  /// Builder function that receives context, orientation, and constraints
  final Widget Function(
    BuildContext context,
    Orientation orientation,
    BoxConstraints constraints,
  ) builder;

  /// Widget to show in portrait orientation (overrides builder if provided)
  final Widget? portrait;

  /// Widget to show in landscape orientation (overrides builder if provided)
  final Widget? landscape;

  /// Duration for orientation transition animations
  final Duration transitionDuration;

  /// Curve for orientation transition animations
  final Curve transitionCurve;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return AnimatedContainer(
          duration: transitionDuration,
          child: LayoutBuilder(
            key: ValueKey(orientation),
            builder: (context, constraints) {
              if (orientation == Orientation.portrait && portrait != null) {
                return portrait!;
              }
              if (orientation == Orientation.landscape && landscape != null) {
                return landscape!;
              }
              return builder(context, orientation, constraints);
            },
          ),
        );
      },
    );
  }
}

/// MPOrientationBuilder - Builder widget with orientation awareness
class MPOrientationBuilder extends StatelessWidget {
  /// Creates an orientation builder
  const MPOrientationBuilder({
    super.key,
    required this.portrait,
    required this.landscape,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOut,
  });

  /// Widget to build in portrait mode
  final Widget Function(BuildContext context, BoxConstraints constraints)
      portrait;

  /// Widget to build in landscape mode
  final Widget Function(BuildContext context, BoxConstraints constraints)
      landscape;

  /// Duration for orientation transition animations
  final Duration transitionDuration;

  /// Curve for orientation transition animations
  final Curve transitionCurve;

  @override
  Widget build(BuildContext context) {
    return MPOrientationAware(
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      builder: (context, orientation, constraints) {
        if (orientation == Orientation.portrait) {
          return portrait(context, constraints);
        } else {
          return landscape(context, constraints);
        }
      },
    );
  }
}

/// MPOrientationLayout - Layout that adapts to orientation with predefined patterns
class MPOrientationLayout extends StatelessWidget {
  /// Creates an orientation-adaptive layout
  const MPOrientationLayout({
    super.key,
    this.child,
    this.children,
    this.portraitLayout = MPOrientationLayoutType.vertical,
    this.landscapeLayout = MPOrientationLayoutType.horizontal,
    this.spacing = 16.0,
    this.padding,
    this.alignment,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOut,
  });

  /// Single child to layout
  final Widget? child;

  /// Multiple children to layout
  final List<Widget>? children;

  /// Layout type for portrait mode
  final MPOrientationLayoutType portraitLayout;

  /// Layout type for landscape mode
  final MPOrientationLayoutType landscapeLayout;

  /// Spacing between children
  final double spacing;

  /// Padding around the layout
  final EdgeInsets? padding;

  /// Alignment of children
  final Alignment? alignment;

  /// Cross axis alignment
  final CrossAxisAlignment? crossAxisAlignment;

  /// Main axis alignment
  final MainAxisAlignment? mainAxisAlignment;

  /// Duration for orientation transition animations
  final Duration transitionDuration;

  /// Curve for orientation transition animations
  final Curve transitionCurve;

  @override
  Widget build(BuildContext context) {
    return MPOrientationBuilder(
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      portrait: (context, constraints) => _buildLayout(
        context,
        constraints,
        portraitLayout,
        Orientation.portrait,
      ),
      landscape: (context, constraints) => _buildLayout(
        context,
        constraints,
        landscapeLayout,
        Orientation.landscape,
      ),
    );
  }

  Widget _buildLayout(
    BuildContext context,
    BoxConstraints constraints,
    MPOrientationLayoutType layoutType,
    Orientation orientation,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveSpacing =
        MPResponsivePadding.getPadding(spacing, screenWidth);
    final responsivePadding = padding ?? EdgeInsets.zero;

    final content = child ??
        (children != null
            ? _buildChildren(layoutType, responsiveSpacing)
            : Container());

    return Padding(
      padding: responsivePadding,
      child: Container(
        alignment: alignment,
        child:
            _wrapInLayout(content, layoutType, responsiveSpacing, orientation),
      ),
    );
  }

  Widget _buildChildren(MPOrientationLayoutType layoutType, double spacing) {
    if (children == null || children!.isEmpty) return Container();

    switch (layoutType) {
      case MPOrientationLayoutType.vertical:
        return Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          children: _addSpacing(children!, spacing, true),
        );
      case MPOrientationLayoutType.horizontal:
        return Row(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          children: _addSpacing(children!, spacing, false),
        );
      case MPOrientationLayoutType.grid:
        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          children: children!,
        );
      case MPOrientationLayoutType.wrap:
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.start,
          children: children!,
        );
    }
  }

  List<Widget> _addSpacing(
      List<Widget> children, double spacing, bool isVertical) {
    if (children.isEmpty) return children;

    final spacedChildren = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(
          isVertical ? SizedBox(height: spacing) : SizedBox(width: spacing),
        );
      }
    }
    return spacedChildren;
  }

  Widget _wrapInLayout(Widget child, MPOrientationLayoutType layoutType,
      double spacing, Orientation orientation) {
    switch (layoutType) {
      case MPOrientationLayoutType.vertical:
        return SingleChildScrollView(
          child: child,
        );
      case MPOrientationLayoutType.horizontal:
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: child,
        );
      case MPOrientationLayoutType.grid:
        return child; // Grid already handles scrolling
      case MPOrientationLayoutType.wrap:
        return SingleChildScrollView(
          child: child,
        );
    }
  }
}

/// Orientation layout types
enum MPOrientationLayoutType {
  vertical,
  horizontal,
  grid,
  wrap,
}

/// MPOrientationAwareCard - Card that adapts to orientation
class MPOrientationAwareCard extends StatelessWidget {
  /// Creates an orientation-aware card
  const MPOrientationAwareCard({
    super.key,
    this.header,
    this.body,
    this.footer,
    this.portraitLayout = MPOrientationCardLayout.vertical,
    this.landscapeLayout = MPOrientationCardLayout.horizontal,
    this.spacing = 16.0,
    this.padding,
    this.margin,
    this.elevation = 2.0,
    this.borderRadius,
    this.color,
    this.shadowColor,
    this.shape,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOut,
  });

  /// Header widget
  final Widget? header;

  /// Body widget
  final Widget? body;

  /// Footer widget
  final Widget? footer;

  /// Layout type for portrait mode
  final MPOrientationCardLayout portraitLayout;

  /// Layout type for landscape mode
  final MPOrientationCardLayout landscapeLayout;

  /// Spacing between sections
  final double spacing;

  /// Padding inside the card
  final EdgeInsets? padding;

  /// Margin outside the card
  final EdgeInsets? margin;

  /// Card elevation
  final double elevation;

  /// Border radius
  final BorderRadius? borderRadius;

  /// Card color
  final Color? color;

  /// Shadow color
  final Color? shadowColor;

  /// Card shape
  final ShapeBorder? shape;

  /// Duration for orientation transition animations
  final Duration transitionDuration;

  /// Curve for orientation transition animations
  final Curve transitionCurve;

  @override
  Widget build(BuildContext context) {
    return MPOrientationBuilder(
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      portrait: (context, constraints) => _buildCard(context, portraitLayout),
      landscape: (context, constraints) => _buildCard(context, landscapeLayout),
    );
  }

  Widget _buildCard(BuildContext context, MPOrientationCardLayout layout) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveSpacing =
        MPResponsivePadding.getPadding(spacing, screenWidth);

    return Card(
      elevation: elevation,
      color: color,
      shadowColor: shadowColor,
      shape: shape,
      margin: margin,
      child: Padding(
        padding: padding ?? MPResponsivePadding.card(context),
        child: _buildCardContent(layout, responsiveSpacing),
      ),
    );
  }

  Widget _buildCardContent(MPOrientationCardLayout layout, double spacing) {
    switch (layout) {
      case MPOrientationCardLayout.vertical:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildVerticalChildren(spacing),
        );
      case MPOrientationCardLayout.horizontal:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildHorizontalChildren(spacing),
        );
      case MPOrientationCardLayout.compact:
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildCompactChildren(spacing),
        );
      case MPOrientationCardLayout.expanded:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildExpandedChildren(spacing),
        );
    }
  }

  List<Widget> _buildVerticalChildren(double spacing) {
    final children = <Widget>[];

    if (header != null) {
      children.add(header!);
      if (body != null || footer != null) {
        children.add(SizedBox(height: spacing));
      }
    }

    if (body != null) {
      children.add(Expanded(child: body!));
      if (footer != null) {
        children.add(SizedBox(height: spacing));
      }
    }

    if (footer != null) {
      children.add(footer!);
    }

    return children;
  }

  List<Widget> _buildHorizontalChildren(double spacing) {
    final children = <Widget>[];

    if (header != null) {
      children.add(Expanded(flex: 2, child: header!));
      if (body != null) {
        children.add(SizedBox(width: spacing));
      }
    }

    if (body != null) {
      children.add(Expanded(flex: 3, child: body!));
      if (footer != null) {
        children.add(SizedBox(width: spacing));
      }
    }

    if (footer != null) {
      children.add(Expanded(flex: 1, child: footer!));
    }

    return children;
  }

  List<Widget> _buildCompactChildren(double spacing) {
    final children = <Widget>[];

    if (header != null && body != null) {
      children.add(Row(
        children: [
          Expanded(child: header!),
          SizedBox(width: spacing),
          Expanded(child: body!),
        ],
      ));
    } else {
      if (header != null) children.add(header!);
      if (body != null) children.add(body!);
    }

    if (footer != null) {
      if (children.isNotEmpty) {
        children.add(SizedBox(height: spacing));
      }
      children.add(footer!);
    }

    return children;
  }

  List<Widget> _buildExpandedChildren(double spacing) {
    final children = <Widget>[];

    if (header != null) {
      children.add(header!);
    }

    if (body != null) {
      if (children.isNotEmpty) {
        children.add(SizedBox(height: spacing));
      }
      children.add(Expanded(child: body!));
    }

    if (footer != null) {
      children.add(footer!);
    }

    return children;
  }
}

/// Orientation card layout types
enum MPOrientationCardLayout {
  vertical,
  horizontal,
  compact,
  expanded,
}
