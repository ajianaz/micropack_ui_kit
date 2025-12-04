import 'package:flutter/material.dart';
import 'mp_responsive_breakpoints.dart';
import 'mp_responsive_padding.dart';

/// MainAxis enum for grid flow direction
enum MainAxis {
  horizontal,
  vertical,
  normal,
}

/// MPResponsiveGrid - Responsive grid system for component arrangements
///
/// Provides flexible grid layouts that adapt to different screen sizes
/// Following Material Design grid principles with responsive breakpoints
class MPResponsiveGrid extends StatelessWidget {
  /// Creates a responsive grid widget
  const MPResponsiveGrid({
    super.key,
    required this.children,
    this.crossAxisCount,
    this.crossAxisSpacing = 8.0,
    this.mainAxisSpacing = 8.0,
    this.childAspectRatio = 1.0,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.maxColumns = 4,
    this.minColumns = 1,
    this.dynamicColumns = true,
    this.alignment = Alignment.center,
    this.runAlignment = Alignment.center,
    this.runSpacing = 0.0,
    this.flow = MainAxis.normal,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
  });

  /// List of child widgets to arrange in grid
  final List<Widget> children;

  /// Fixed cross axis count (overrides dynamic calculation)
  final int? crossAxisCount;

  /// Spacing between columns
  final double crossAxisSpacing;

  /// Spacing between rows
  final double mainAxisSpacing;

  /// Aspect ratio for each grid item
  final double childAspectRatio;

  /// Whether to shrink wrap the grid
  final bool shrinkWrap;

  /// Scroll physics for the grid
  final ScrollPhysics? physics;

  /// Padding around the grid
  final EdgeInsets? padding;

  /// Maximum number of columns
  final int maxColumns;

  /// Minimum number of columns
  final int minColumns;

  /// Whether to dynamically calculate columns based on screen size
  final bool dynamicColumns;

  /// Alignment of children within grid cells
  final Alignment alignment;

  /// Alignment of runs along the cross axis
  final Alignment runAlignment;

  /// Spacing between runs
  final double runSpacing;

  /// Flow direction of the grid
  final MainAxis flow;

  /// Text direction of the grid
  final TextDirection? textDirection;

  /// Vertical direction of the grid
  final VerticalDirection verticalDirection;

  /// Clip behavior for the grid
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final deviceSize = MPResponsiveBreakpoints.getDeviceSize(screenWidth);

    // Calculate responsive columns
    final columns = _calculateColumns(screenWidth, deviceSize);

    // Calculate responsive spacing
    final responsiveCrossAxisSpacing = MPResponsivePadding.getPadding(
      crossAxisSpacing,
      screenWidth,
    );
    final responsiveMainAxisSpacing = MPResponsivePadding.getPadding(
      mainAxisSpacing,
      screenWidth,
    );
    final responsiveRunSpacing = MPResponsivePadding.getPadding(
      runSpacing,
      screenWidth,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: padding ?? EdgeInsets.zero,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: responsiveCrossAxisSpacing,
              mainAxisSpacing: responsiveMainAxisSpacing,
              childAspectRatio: _getChildAspectRatio(screenWidth, deviceSize),
            ),
            itemCount: children.length,
            shrinkWrap: shrinkWrap,
            physics: physics ??
                (shrinkWrap ? const NeverScrollableScrollPhysics() : null),
            itemBuilder: (context, index) {
              return Container(
                alignment: alignment,
                child: children[index],
              );
            },
          ),
        );
      },
    );
  }

  /// Calculate number of columns based on screen size
  int _calculateColumns(double screenWidth, MPDeviceSize deviceSize) {
    if (!dynamicColumns && crossAxisCount != null) {
      return crossAxisCount!;
    }

    int calculatedColumns;
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
        calculatedColumns = 1;
        break;
      case MPDeviceSize.mobile:
        calculatedColumns = 2;
        break;
      case MPDeviceSize.largeMobile:
        calculatedColumns = 2;
        break;
      case MPDeviceSize.smallTablet:
        calculatedColumns = 2;
        break;
      case MPDeviceSize.tablet:
        calculatedColumns = 3;
        break;
      case MPDeviceSize.largeTablet:
        calculatedColumns = 3;
        break;
      case MPDeviceSize.smallDesktop:
        calculatedColumns = 4;
        break;
      case MPDeviceSize.desktop:
        calculatedColumns = 4;
        break;
      case MPDeviceSize.largeDesktop:
        calculatedColumns = 4;
        break;
      case MPDeviceSize.ultraWide:
        calculatedColumns = 5;
        break;
    }

    // Apply constraints
    calculatedColumns = calculatedColumns.clamp(minColumns, maxColumns);

    // Override with fixed crossAxisCount if provided
    return crossAxisCount ?? calculatedColumns;
  }

  /// Get child aspect ratio based on screen size
  double _getChildAspectRatio(double screenWidth, MPDeviceSize deviceSize) {
    // Adjust aspect ratio based on device size for better proportions
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
        return childAspectRatio * 0.8; // Taller items on small screens
      case MPDeviceSize.mobile:
        return childAspectRatio * 0.9;
      case MPDeviceSize.largeMobile:
        return childAspectRatio * 0.95;
      case MPDeviceSize.tablet:
        return childAspectRatio;
      case MPDeviceSize.desktop:
        return childAspectRatio * 1.1; // Wider items on desktop
      default:
        return childAspectRatio;
    }
  }
}

/// MPResponsiveGridBuilder - Builder pattern for responsive grids
class MPResponsiveGridBuilder extends StatelessWidget {
  /// Creates a responsive grid builder
  const MPResponsiveGridBuilder({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.crossAxisCount,
    this.crossAxisSpacing = 8.0,
    this.mainAxisSpacing = 8.0,
    this.childAspectRatio = 1.0,
    this.shrinkWrap = true,
    this.physics = const NeverScrollableScrollPhysics(),
    this.padding,
    this.maxColumns = 4,
    this.minColumns = 1,
    this.dynamicColumns = true,
    this.alignment = Alignment.center,
    this.runAlignment = Alignment.center,
    this.runSpacing = 0.0,
    this.flow = MainAxis.normal,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
  });

  /// Item builder function
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// Number of items
  final int itemCount;

  /// Fixed cross axis count (overrides dynamic calculation)
  final int? crossAxisCount;

  /// Spacing between columns
  final double crossAxisSpacing;

  /// Spacing between rows
  final double mainAxisSpacing;

  /// Aspect ratio for each grid item
  final double childAspectRatio;

  /// Whether to shrink wrap the grid
  final bool shrinkWrap;

  /// Scroll physics for the grid
  final ScrollPhysics? physics;

  /// Padding around the grid
  final EdgeInsets? padding;

  /// Maximum number of columns
  final int maxColumns;

  /// Minimum number of columns
  final int minColumns;

  /// Whether to dynamically calculate columns based on screen size
  final bool dynamicColumns;

  /// Alignment of children within grid cells
  final Alignment alignment;

  /// Alignment of runs along the cross axis
  final Alignment runAlignment;

  /// Spacing between runs
  final double runSpacing;

  /// Flow direction of the grid
  final MainAxis flow;

  /// Text direction of the grid
  final TextDirection? textDirection;

  /// Vertical direction of the grid
  final VerticalDirection verticalDirection;

  /// Clip behavior for the grid
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return MPResponsiveGrid(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      childAspectRatio: childAspectRatio,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      maxColumns: maxColumns,
      minColumns: minColumns,
      dynamicColumns: dynamicColumns,
      alignment: alignment,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      flow: flow,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      clipBehavior: clipBehavior,
      children: List.generate(
        itemCount,
        (index) => itemBuilder(context, index),
      ),
    );
  }
}

/// MPResponsiveList - Responsive list that adapts layout based on screen size
class MPResponsiveList extends StatelessWidget {
  /// Creates a responsive list widget
  const MPResponsiveList({
    super.key,
    required this.children,
    this.spacing = 8.0,
    this.padding,
    this.direction = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.clipBehavior = Clip.none,
    this.gridThreshold = 600, // Width at which to switch to grid layout
    this.gridColumns = 2,
    this.enableGrid = true,
  });

  /// List of child widgets
  final List<Widget> children;

  /// Spacing between items
  final double spacing;

  /// Padding around the list
  final EdgeInsets? padding;

  /// Direction of the list
  final Axis direction;

  /// Main axis alignment
  final MainAxisAlignment mainAxisAlignment;

  /// Cross axis alignment
  final CrossAxisAlignment crossAxisAlignment;

  /// Text direction
  final TextDirection? textDirection;

  /// Vertical direction
  final VerticalDirection verticalDirection;

  /// Text baseline alignment
  final TextBaseline? textBaseline;

  /// Clip behavior
  final Clip clipBehavior;

  /// Width threshold for switching to grid layout
  final double gridThreshold;

  /// Number of columns when in grid layout
  final int gridColumns;

  /// Whether to enable grid layout on larger screens
  final bool enableGrid;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final shouldUseGrid = enableGrid && screenWidth >= gridThreshold;

        if (shouldUseGrid) {
          return MPResponsiveGrid(
            crossAxisCount: gridColumns,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            padding: padding,
            children: children,
          );
        }

        final responsiveSpacing =
            MPResponsivePadding.getPadding(spacing, screenWidth);

        return Padding(
          padding: padding ?? EdgeInsets.zero,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: children.length,
            separatorBuilder: (context, index) => SizedBox(
              height: direction == Axis.vertical ? responsiveSpacing : 0,
              width: direction == Axis.horizontal ? responsiveSpacing : 0,
            ),
            itemBuilder: (context, index) => children[index],
          ),
        );
      },
    );
  }
}
