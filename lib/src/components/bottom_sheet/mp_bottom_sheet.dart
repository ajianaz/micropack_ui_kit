import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_bottom_sheet_enums.dart';

/// MPBottomSheet - Theme-aware bottom sheet component
///
/// This component provides a flexible, theme-integrated bottom sheet with
/// multiple variants, animations, and platform-adaptive behavior.
///
/// Example:
/// ```dart
/// MPBottomSheet.show(
///   context,
///   title: 'Select Option',
///   size: MPBottomSheetSize.medium,
///   variant: MPBottomSheetVariant.rounded,
///   actions: [
///     MPBottomSheetAction(
///       label: 'Confirm',
///       style: MPBottomSheetActionStyle.primary,
///       onPressed: () {},
///     ),
///   ],
///   child: YourContentWidget(),
/// );
/// ```
class MPBottomSheet extends StatefulWidget {
  const MPBottomSheet({
    super.key,
    this.title,
    this.subtitle,
    this.size = MPBottomSheetSize.auto,
    this.variant = MPBottomSheetVariant.rounded,
    this.edgeBehavior = MPBottomSheetEdgeBehavior.both,
    this.dismissible = true,
    this.actions,
    this.child,
    this.semanticLabel,
    this.padding,
    this.headerPadding,
    this.contentPadding,
    this.actionsPadding,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
  });

  /// Optional title for bottom sheet
  final String? title;

  /// Optional subtitle for bottom sheet
  final String? subtitle;

  /// The size of bottom sheet
  final MPBottomSheetSize size;

  /// The visual variant of bottom sheet
  final MPBottomSheetVariant variant;

  /// How bottom sheet can be dismissed
  final MPBottomSheetEdgeBehavior edgeBehavior;

  /// Whether bottom sheet can be dismissed
  final bool dismissible;

  /// Optional action buttons to display at the bottom
  final List<MPBottomSheetAction>? actions;

  /// The content widget to display
  final Widget? child;

  /// Semantic label for accessibility
  final String? semanticLabel;

  /// Custom padding for entire bottom sheet
  final EdgeInsets? padding;

  /// Custom padding for the header (title/subtitle area)
  final EdgeInsets? headerPadding;

  /// Custom padding for the content area
  final EdgeInsets? contentPadding;

  /// Custom padding for the actions area
  final EdgeInsets? actionsPadding;

  /// Custom background color
  final Color? backgroundColor;

  /// Custom border radius (for rounded variant)
  final double? borderRadius;

  /// Custom elevation
  final double? elevation;

  /// Show a bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? subtitle,
    MPBottomSheetSize size = MPBottomSheetSize.auto,
    MPBottomSheetVariant variant = MPBottomSheetVariant.rounded,
    MPBottomSheetEdgeBehavior edgeBehavior = MPBottomSheetEdgeBehavior.both,
    bool dismissible = true,
    List<MPBottomSheetAction>? actions,
    Widget? child,
    String? semanticLabel,
    EdgeInsets? padding,
    EdgeInsets? headerPadding,
    EdgeInsets? contentPadding,
    EdgeInsets? actionsPadding,
    Color? backgroundColor,
    double? borderRadius,
    double? elevation,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: dismissible,
      enableDrag: edgeBehavior == MPBottomSheetEdgeBehavior.swipeToDismiss ||
          edgeBehavior == MPBottomSheetEdgeBehavior.both,
      builder: (context) {
        return MPBottomSheet(
          title: title,
          subtitle: subtitle,
          size: size,
          variant: variant,
          edgeBehavior: edgeBehavior,
          dismissible: dismissible,
          actions: actions,
          child: child,
          semanticLabel: semanticLabel,
          padding: padding,
          headerPadding: headerPadding,
          contentPadding: contentPadding,
          actionsPadding: actionsPadding,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          elevation: elevation,
        );
      },
    );
  }

  @override
  State<MPBottomSheet> createState() => _MPBottomSheetState();
}

class _MPBottomSheetState extends State<MPBottomSheet> {
  late ScrollController _scrollController;
  final _MPBottomSheetConfig _config = _MPBottomSheetConfig();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _dismiss() {
    if (widget.dismissible) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.edgeBehavior == MPBottomSheetEdgeBehavior.tapToDismiss ||
              widget.edgeBehavior == MPBottomSheetEdgeBehavior.both
          ? _dismiss
          : null,
      child: Container(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onVerticalDragEnd: widget.edgeBehavior ==
                        MPBottomSheetEdgeBehavior.swipeToDismiss ||
                    widget.edgeBehavior == MPBottomSheetEdgeBehavior.both
                ? (details) {
                    if (details.primaryVelocity != null &&
                        details.primaryVelocity! > 0) {
                      _dismiss();
                    }
                  }
                : null,
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final bgColor = widget.backgroundColor ?? context.mp.cardColor;
    final borderRadius = _config.getBorderRadius(widget.variant, widget.borderRadius);
    final elevation = widget.elevation ?? _config.getElevation(widget.variant);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: elevation,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      constraints: BoxConstraints(
        maxHeight: _config.getMaxHeight(context, widget.size),
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.title != null || widget.subtitle != null)
              _buildHeader(context),
            if (widget.child != null) ...[
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: widget.contentPadding ?? _config.getContentPadding(),
                  child: widget.child,
                ),
              ),
              if (widget.actions != null) _buildActions(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: widget.headerPadding ?? _config.getHeaderPadding(),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.mp.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null) ...[
            Row(
              children: [
                Expanded(
                  child: MPText.head(
                    widget.title!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: context.mp.textColor,
                    ),
                  ),
                ),
                if (widget.dismissible)
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: context.mp.subtitleColor,
                    ),
                    onPressed: _dismiss,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            if (widget.subtitle != null) ...[
              SizedBox(height: 4),
              MPText.label(
                widget.subtitle!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: context.mp.subtitleColor,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final actions = widget.actions ?? [];

    return Container(
      padding: widget.actionsPadding ?? _config.getActionsPadding(),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.mp.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: actions.map((action) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                child: action,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Configuration class for MPBottomSheet
class _MPBottomSheetConfig {
  BorderRadiusGeometry? getBorderRadius(MPBottomSheetVariant variant, double? custom) {
    if (custom != null) return BorderRadius.circular(custom);

    switch (variant) {
      case MPBottomSheetVariant.standard:
        return null;
      case MPBottomSheetVariant.rounded:
        return const BorderRadius.vertical(top: Radius.circular(16));
      case MPBottomSheetVariant.fullscreen:
        return null;
    }
  }

  double getElevation(MPBottomSheetVariant variant) {
    switch (variant) {
      case MPBottomSheetVariant.standard:
        return 8;
      case MPBottomSheetVariant.rounded:
        return 16;
      case MPBottomSheetVariant.fullscreen:
        return 0;
    }
  }

  double getMaxHeight(BuildContext context, MPBottomSheetSize size) {
    final screenHeight = MediaQuery.of(context).size.height;

    switch (size) {
      case MPBottomSheetSize.compact:
        return screenHeight * 0.3;
      case MPBottomSheetSize.medium:
        return screenHeight * 0.5;
      case MPBottomSheetSize.large:
        return screenHeight * 0.7;
      case MPBottomSheetSize.auto:
        return screenHeight * 0.9;
    }
  }

  EdgeInsets getHeaderPadding() {
    return const EdgeInsets.fromLTRB(16, 16, 16, 8);
  }

  EdgeInsets getContentPadding() {
    return const EdgeInsets.all(16);
  }

  EdgeInsets getActionsPadding() {
    return const EdgeInsets.fromLTRB(16, 8, 16, 8);
  }
}

/// Action button for bottom sheets
class MPBottomSheetAction extends StatelessWidget {
  const MPBottomSheetAction({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = MPBottomSheetActionStyle.primary,
    this.disabled = false,
    this.semanticLabel,
  });

  /// The label text for the action button
  final String label;

  /// Callback when the action is pressed
  final VoidCallback onPressed;

  /// The style variant of the action
  final MPBottomSheetActionStyle style;

  /// Whether the action is disabled
  final bool disabled;

  /// Semantic label for accessibility
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel ?? label,
      child: MPButton(
        text: label,
        onPressed: disabled ? null : onPressed,
        variant: _getButtonVariant(style),
        size: MPButtonSize.regular,
      ),
    );
  }

  MPButtonVariant _getButtonVariant(MPBottomSheetActionStyle style) {
    switch (style) {
      case MPBottomSheetActionStyle.primary:
        return MPButtonVariant.primary;
      case MPBottomSheetActionStyle.secondary:
        return MPButtonVariant.outlined;
      case MPBottomSheetActionStyle.destructive:
        return MPButtonVariant.danger;
    }
  }
}
