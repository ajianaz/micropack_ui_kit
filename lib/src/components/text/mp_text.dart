// ignore_for_file: public_member_api_docs, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/styles/mp_font_sizes.dart';
import 'package:micropack_ui_kit/src/core/error/mp_error_handler.dart';
import 'package:micropack_ui_kit/src/core/performance/mp_performance_profiler.dart';

enum MPTextType { HEAD, SUBHEAD, TITLE, BODY, CAPTION, LABEL, SMALL }

/// Text overflow behavior options
enum MPTextOverflowBehavior {
  /// Show ellipsis when text overflows
  ellipsis,

  /// Clip text without ellipsis
  clip,

  /// Fade text at the edges
  fade,

  /// Expandable text with "Show more" option
  expandable,

  /// Responsive truncation based on screen size
  responsive,
}

class MPText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final bool? softWrap;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? fontSize;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final Color? color;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  final double? decorationThickness;

  /// Enhanced overflow behavior for better text handling
  final MPTextOverflowBehavior? overflowBehavior;

  /// Whether to enable responsive text truncation
  final bool enableResponsiveTruncation;

  /// Custom "Show more" text for expandable overflow
  final String? expandText;

  /// Custom "Show less" text for expandable overflow
  final String? collapseText;

  /// Callback when expand/collapse is triggered
  final VoidCallback? onExpandChanged;

  // Accessibility properties
  /// Semantic label for screen readers
  final String? semanticLabel;

  /// Semantic hint for screen readers
  final String? semanticHint;

  /// Whether to exclude semantics for accessibility
  final bool excludeSemantics;

  /// Additional accessibility properties
  final Map<String, dynamic>? accessibilityProperties;

  /// Custom accessibility actions
  final List<SemanticsAction>? customAccessibilityActions;

  /// Callback for accessibility actions
  final void Function(SemanticsAction)? onAccessibilityAction;

  /// Whether to respect reduced motion settings
  final bool respectReducedMotion;

  /// Whether to enable high contrast mode
  final bool enableHighContrast;

  /// Focus node for keyboard navigation
  final FocusNode? focusNode;

  /// Whether to enable keyboard navigation
  final bool enableKeyboardNavigation;

  /// Focus order for keyboard navigation
  final int? focusOrder;

  /// Creates a text widget with optional styling parameters.
  ///
  /// When no color is explicitly provided, automatically uses context.mp.textColor
  /// for optimal contrast and theme consistency. This makes MPText consistent with
  /// other components in the library that automatically use theme-aware colors.
  ///
  /// The [color] parameter always takes precedence over the theme color.
  const MPText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.textOverflow,
    this.softWrap,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.letterSpacing,
    this.color,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
    this.overflowBehavior,
    this.enableResponsiveTruncation = false,
    this.expandText,
    this.collapseText,
    this.onExpandChanged,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.accessibilityProperties,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.respectReducedMotion = true,
    this.enableHighContrast = true,
    this.focusNode,
    this.enableKeyboardNavigation = true,
    this.focusOrder,
  });

  // 🔒 Internal constructor (for named constructors only)
  const MPText._internal(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.textOverflow,
    this.softWrap,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.letterSpacing,
    this.color,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
    this.overflowBehavior,
    this.enableResponsiveTruncation = false,
    this.expandText,
    this.collapseText,
    this.onExpandChanged,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.accessibilityProperties,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.respectReducedMotion = true,
    this.enableHighContrast = true,
    this.focusNode,
    this.enableKeyboardNavigation = true,
    this.focusOrder,
  });

  // ==== Named constructors ====

  /// Creates a heading text with default styling.
  /// Uses theme-aware text color when no color is explicitly provided.
  factory MPText.head(
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w800,
    double fontSize = MPFontSizes.title,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
    MPTextOverflowBehavior? overflowBehavior,
    bool enableResponsiveTruncation = false,
    String? expandText,
    String? collapseText,
    VoidCallback? onExpandChanged,
  }) {
    return MPText._internal(
      text,
      key: key,
      style: style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      overflowBehavior: overflowBehavior,
      enableResponsiveTruncation: enableResponsiveTruncation,
      expandText: expandText,
      collapseText: collapseText,
      onExpandChanged: onExpandChanged,
    );
  }

  /// Creates a subheading text with default styling.
  /// Uses theme-aware text color when no color is explicitly provided.
  factory MPText.subhead(
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = MPFontSizes.subhead,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
    MPTextOverflowBehavior? overflowBehavior,
    bool enableResponsiveTruncation = false,
    String? expandText,
    String? collapseText,
    VoidCallback? onExpandChanged,
  }) {
    return MPText._internal(
      text,
      key: key,
      style: style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      overflowBehavior: overflowBehavior,
      enableResponsiveTruncation: enableResponsiveTruncation,
      expandText: expandText,
      collapseText: collapseText,
      onExpandChanged: onExpandChanged,
    );
  }

  /// Creates a body text with default styling.
  /// Uses theme-aware text color when no color is explicitly provided.
  factory MPText.body(
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.normal,
    double fontSize = MPFontSizes.body,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
    MPTextOverflowBehavior? overflowBehavior,
    bool enableResponsiveTruncation = false,
    String? expandText,
    String? collapseText,
    VoidCallback? onExpandChanged,
  }) {
    return MPText._internal(
      text,
      key: key,
      style: style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      overflowBehavior: overflowBehavior,
      enableResponsiveTruncation: enableResponsiveTruncation,
      expandText: expandText,
      collapseText: collapseText,
      onExpandChanged: onExpandChanged,
    );
  }

  /// Creates a label text with default styling.
  /// Uses theme-aware text color when no color is explicitly provided.
  factory MPText.label(
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = MPFontSizes.label,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
    MPTextOverflowBehavior? overflowBehavior,
    bool enableResponsiveTruncation = false,
    String? expandText,
    String? collapseText,
    VoidCallback? onExpandChanged,
  }) {
    return MPText._internal(
      text,
      key: key,
      style: style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      overflowBehavior: overflowBehavior,
      enableResponsiveTruncation: enableResponsiveTruncation,
      expandText: expandText,
      collapseText: collapseText,
      onExpandChanged: onExpandChanged,
    );
  }

  /// Creates a small text with default styling.
  /// Uses theme-aware text color when no color is explicitly provided.
  factory MPText.small(
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLines,
    TextOverflow? textOverflow,
    bool? softWrap,
    TextAlign? textAlign,
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = MPFontSizes.small,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
    MPTextOverflowBehavior? overflowBehavior,
    bool enableResponsiveTruncation = false,
    String? expandText,
    String? collapseText,
    VoidCallback? onExpandChanged,
  }) {
    return MPText._internal(
      text,
      key: key,
      style: style,
      maxLines: maxLines,
      textOverflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      overflowBehavior: overflowBehavior,
      enableResponsiveTruncation: enableResponsiveTruncation,
      expandText: expandText,
      collapseText: collapseText,
      onExpandChanged: onExpandChanged,
    );
  }

  /// Composes the text style with theme-aware color as default.
  ///
  /// Uses context.mp.textColor when no color is explicitly provided,
  /// ensuring optimal contrast and theme consistency across the application.
  /// Explicit color parameter always takes precedence over theme color.
  TextStyle composeTextStyle(BuildContext context) {
    TextStyle baseStyle = style ?? const TextStyle();

    double? effectiveFontSize = fontSize;
    if (effectiveFontSize != null) {
      effectiveFontSize = ResponsiveFontHelper.getResponsiveFontSize(
          effectiveFontSize, context);
    }

    // Use theme-aware text color as default when no color is explicitly provided
    // Priority: color parameter > baseStyle.color > theme textColor
    Color effectiveColor = color ?? baseStyle.color ?? context.mp.textColor;

    return baseStyle.copyWith(
      fontWeight: fontWeight,
      fontSize: effectiveFontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: effectiveColor,
      overflow: textOverflow,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MPPerformanceProfilerWidget(
      name: 'MPText',
      metadata: {
        'textLength': text.length,
        'maxLines': maxLines,
        'overflowBehavior': overflowBehavior?.name,
        'enableResponsiveTruncation': enableResponsiveTruncation,
        'hasCustomStyle': style != null,
      },
      child: MPErrorBoundary(
        errorCategory: MPErrorCategory.component,
        errorSeverity: MPErrorSeverity.medium,
        onError: (error) {
          // Log text-specific error
          MPErrorHandler.instance.handleComponentError(
            code: 'TEXT_RENDER_ERROR',
            message: 'Text rendering failed: ${error.message}',
            technicalDetails: error.technicalDetails,
            context: {
              'text': text,
              'textType': style?.toString(),
              'fontSize': fontSize?.toString(),
              'fontWeight': fontWeight?.toString(),
              'overflowBehavior': overflowBehavior?.name,
              'maxLines': maxLines?.toString(),
            },
          );
        },
        child: Builder(
          builder: (context) {
            return _buildTextContentWithErrorHandling(context);
          },
        ),
      ),
    );
  }

  Widget _buildTextContentWithErrorHandling(BuildContext context) {
    // Handle different overflow behaviors
    switch (overflowBehavior) {
      case MPTextOverflowBehavior.expandable:
        return _buildExpandableText(context);
      case MPTextOverflowBehavior.responsive:
        return _buildResponsiveText(context);
      case MPTextOverflowBehavior.fade:
        return _buildFadeText(context);
      default:
        return _buildStandardText(context);
    }
  }

  /// Build standard text with basic overflow handling
  Widget _buildStandardText(BuildContext context) {
    final textWidget = Text(
      text,
      maxLines: enableResponsiveTruncation
          ? _getResponsiveMaxLines(context)
          : maxLines,
      overflow:
          textOverflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
      softWrap: softWrap ?? true,
      textAlign: textAlign,
      style: _getCachedStyle(context),
    );

    // Wrap with accessibility features
    if (excludeSemantics) {
      return ExcludeSemantics(
        child: textWidget,
      );
    }

    return Semantics(
      label: semanticLabel ?? text,
      hint: semanticHint,
      textDirection: TextDirection.ltr,
      // Add enhanced semantic properties for better accessibility
      container: true,
      // Add live region for dynamic content updates
      liveRegion: false, // Text is typically static content
      // Add semantic properties for better screen reader support
      readOnly: true,
      // Add header properties for text type
      header: _isHeaderType(),
      // Add text style properties for screen readers
      attributedValue: _getAttributedValue(),
      // Add custom accessibility actions if provided
      customSemanticsActions: _getCustomSemanticsActions(),
      child: enableKeyboardNavigation && focusNode != null
          ? Focus(
              focusNode: focusNode,
              autofocus: focusOrder == 0,
              // Add keyboard navigation callbacks
              onKey: (node, event) {
                return _handleKeyPress(event);
              },
              child: textWidget,
            )
          : textWidget,
    );
  }

  /// Build expandable text with show more/less functionality
  Widget _buildExpandableText(BuildContext context) {
    return _MPExpandableText(
      text: text,
      style: _getCachedStyle(context),
      maxLines: enableResponsiveTruncation
          ? _getResponsiveMaxLines(context)
          : maxLines ?? 3,
      textAlign: textAlign,
      softWrap: softWrap ?? true,
      expandText: expandText ?? 'Show more',
      collapseText: collapseText ?? 'Show less',
      onExpandChanged: onExpandChanged,
    );
  }

  /// Build responsive text that adapts to screen size
  Widget _buildResponsiveText(BuildContext context) {
    return Text(
      text,
      maxLines: _getResponsiveMaxLines(context),
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap ?? true,
      textAlign: textAlign,
      style: _getCachedStyle(context),
    );
  }

  /// Build text with fade overflow effect
  Widget _buildFadeText(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            _getCachedStyle(context).color ?? Colors.black,
            Colors.transparent,
          ],
          stops: const [0.8, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: Text(
        text,
        maxLines: _getResponsiveMaxLines(context),
        overflow: TextOverflow.clip,
        softWrap: softWrap ?? true,
        textAlign: textAlign,
        style: _getCachedStyle(context),
      ),
    );
  }

  /// Get responsive max lines based on screen size and text type
  int _getResponsiveMaxLines(BuildContext context) {
    if (!enableResponsiveTruncation) return maxLines ?? 999;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Base max lines on text size and screen dimensions
    int baseMaxLines;
    if (fontSize != null) {
      if (fontSize! > 24) {
        // Large text
        baseMaxLines = isPortrait ? 2 : 3;
      } else if (fontSize! > 16) {
        // Medium text
        baseMaxLines = isPortrait ? 3 : 4;
      } else {
        // Small text
        baseMaxLines = isPortrait ? 4 : 6;
      }
    } else {
      // Default based on text type
      baseMaxLines = isPortrait ? 3 : 4;
    }

    // Adjust for screen size
    if (screenWidth < 360) {
      // Small screens
      baseMaxLines = (baseMaxLines * 0.7).round();
    } else if (screenWidth > 768) {
      // Large screens
      baseMaxLines = (baseMaxLines * 1.3).round();
    }

    // Adjust for very wide screens in landscape
    if (!isPortrait && screenWidth > screenHeight * 1.5) {
      baseMaxLines = (baseMaxLines * 1.2).round();
    }

    return maxLines != null ? maxLines! : baseMaxLines.clamp(1, 10);
  }

  // Performance optimization: Cache composed style to avoid recalculations
  static final Map<String, TextStyle> _styleCache = {};

  TextStyle _getCachedStyle(BuildContext context) {
    // Create cache key from style parameters
    final params = [
      style?.hashCode ?? 0,
      fontSize?.hashCode ?? 0,
      fontWeight?.hashCode ?? 0,
      color?.hashCode ?? 0,
      fontStyle?.hashCode ?? 0,
      letterSpacing?.hashCode ?? 0,
    ];
    final cacheKey = params.join('_');

    if (_styleCache.containsKey(cacheKey)) {
      return _styleCache[cacheKey]!;
    }

    final composedStyle = composeTextStyle(context);
    _styleCache[cacheKey] = composedStyle;

    // Limit cache size to prevent memory leaks
    if (_styleCache.length > 50) {
      _styleCache.remove(_styleCache.keys.first);
    }

    return composedStyle;
  }

  /// Clear style cache (useful for testing or memory management)
  static void clearStyleCache() {
    _styleCache.clear();
  }

  /// Determines if this text should be treated as a header for screen readers
  bool _isHeaderType() {
    // Check if style indicates header type
    final effectiveFontSize = fontSize ?? style?.fontSize;
    final effectiveFontWeight = fontWeight ?? style?.fontWeight;

    // Consider large text or bold text as headers
    if (effectiveFontSize != null && effectiveFontSize >= 20) {
      return true;
    }

    if (effectiveFontWeight != null &&
        (effectiveFontWeight == FontWeight.bold ||
            effectiveFontWeight == FontWeight.w600 ||
            effectiveFontWeight == FontWeight.w700 ||
            effectiveFontWeight == FontWeight.w800 ||
            effectiveFontWeight == FontWeight.w900)) {
      return true;
    }

    return false;
  }

  /// Creates attributed value for screen readers with text style information
  AttributedString? _getAttributedValue() {
    final effectiveFontSize = fontSize ?? style?.fontSize;
    final effectiveFontWeight = fontWeight ?? style?.fontWeight;

    String styleInfo = '';

    if (effectiveFontSize != null && effectiveFontSize >= 20) {
      styleInfo += 'Large text';
    }

    if (effectiveFontWeight != null &&
        (effectiveFontWeight == FontWeight.bold ||
            effectiveFontWeight == FontWeight.w600 ||
            effectiveFontWeight == FontWeight.w700 ||
            effectiveFontWeight == FontWeight.w800 ||
            effectiveFontWeight == FontWeight.w900)) {
      styleInfo += styleInfo.isEmpty ? 'Bold text' : ', bold';
    }

    if (styleInfo.isEmpty) {
      return null;
    }

    // Create a simple AttributedString without complex attributes
    return AttributedString(text);
  }

  /// Creates custom semantics actions for accessibility
  Map<CustomSemanticsAction, VoidCallback>? _getCustomSemanticsActions() {
    if (customAccessibilityActions == null || onAccessibilityAction == null) {
      return null;
    }

    final Map<CustomSemanticsAction, VoidCallback> actions = {};

    for (final action in customAccessibilityActions!) {
      actions[CustomSemanticsAction(
        label: _getActionLabel(action),
      )] = () => onAccessibilityAction!(action);
    }

    return actions;
  }

  /// Gets a user-friendly label for a semantics action
  String _getActionLabel(SemanticsAction action) {
    switch (action) {
      case SemanticsAction.tap:
        return 'Tap';
      case SemanticsAction.longPress:
        return 'Long press';
      case SemanticsAction.scrollLeft:
        return 'Scroll left';
      case SemanticsAction.scrollRight:
        return 'Scroll right';
      case SemanticsAction.scrollUp:
        return 'Scroll up';
      case SemanticsAction.scrollDown:
        return 'Scroll down';
      case SemanticsAction.increase:
        return 'Increase';
      case SemanticsAction.decrease:
        return 'Decrease';
      case SemanticsAction.showOnScreen:
        return 'Show on screen';
      case SemanticsAction.moveCursorForwardByCharacter:
        return 'Move cursor forward';
      case SemanticsAction.moveCursorBackwardByCharacter:
        return 'Move cursor backward';
      case SemanticsAction.setSelection:
        return 'Set selection';
      case SemanticsAction.copy:
        return 'Copy';
      case SemanticsAction.cut:
        return 'Cut';
      case SemanticsAction.paste:
        return 'Paste';
      case SemanticsAction.didGainAccessibilityFocus:
        return 'Gained focus';
      case SemanticsAction.didLoseAccessibilityFocus:
        return 'Lost focus';
      case SemanticsAction.focus:
        return 'Focus';
      default:
        return 'Action';
    }
  }

  /// Gets a hint for a semantics action
  String _getActionHint(SemanticsAction action) {
    switch (action) {
      case SemanticsAction.tap:
        return 'Activate this text';
      case SemanticsAction.longPress:
        return 'Long press this text';
      case SemanticsAction.scrollLeft:
        return 'Scroll content left';
      case SemanticsAction.scrollRight:
        return 'Scroll content right';
      case SemanticsAction.scrollUp:
        return 'Scroll content up';
      case SemanticsAction.scrollDown:
        return 'Scroll content down';
      case SemanticsAction.increase:
        return 'Increase value';
      case SemanticsAction.decrease:
        return 'Decrease value';
      case SemanticsAction.showOnScreen:
        return 'Show this text on screen';
      case SemanticsAction.moveCursorForwardByCharacter:
        return 'Move cursor forward by character';
      case SemanticsAction.moveCursorBackwardByCharacter:
        return 'Move cursor backward by character';
      case SemanticsAction.setSelection:
        return 'Set text selection';
      case SemanticsAction.copy:
        return 'Copy text';
      case SemanticsAction.cut:
        return 'Cut text';
      case SemanticsAction.paste:
        return 'Paste text';
      case SemanticsAction.didGainAccessibilityFocus:
        return 'Text gained focus';
      case SemanticsAction.didLoseAccessibilityFocus:
        return 'Text lost focus';
      case SemanticsAction.focus:
        return 'Focus this text';
      default:
        return 'Perform action';
    }
  }

  /// Handles keyboard events for text navigation
  KeyEventResult _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      switch (event.logicalKey.keyLabel) {
        case 'Arrow Right':
          // Handle right arrow key
          if (onAccessibilityAction != null) {
            onAccessibilityAction!(
                SemanticsAction.moveCursorForwardByCharacter);
            return KeyEventResult.handled;
          }
          break;
        case 'Arrow Left':
          // Handle left arrow key
          if (onAccessibilityAction != null) {
            onAccessibilityAction!(
                SemanticsAction.moveCursorBackwardByCharacter);
            return KeyEventResult.handled;
          }
          break;
        case 'Enter':
        case 'Space':
          // Handle activation
          if (onAccessibilityAction != null) {
            onAccessibilityAction!(SemanticsAction.tap);
            return KeyEventResult.handled;
          }
          break;
      }
    }
    return KeyEventResult.ignored;
  }
}

/// Expandable text widget with show more/less functionality
class _MPExpandableText extends StatefulWidget {
  const _MPExpandableText({
    required this.text,
    required this.style,
    required this.maxLines,
    this.textAlign,
    this.softWrap = true,
    required this.expandText,
    required this.collapseText,
    this.onExpandChanged,
  });

  final String text;
  final TextStyle style;
  final int maxLines;
  final TextAlign? textAlign;
  final bool softWrap;
  final String expandText;
  final String collapseText;
  final VoidCallback? onExpandChanged;

  @override
  State<_MPExpandableText> createState() => _MPExpandableTextState();
}

class _MPExpandableTextState extends State<_MPExpandableText>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
      widget.onExpandChanged?.call();
    });
  }

  bool _isTextOverflowing() {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: double.infinity);
    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    // Check if text overflows
    if (!_isTextOverflowing() && !_isExpanded) {
      return Text(
        widget.text,
        style: widget.style,
        textAlign: widget.textAlign,
        softWrap: widget.softWrap,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _expandAnimation,
          builder: (context, child) {
            return AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Text(
                widget.text,
                style: widget.style,
                textAlign: widget.textAlign,
                softWrap: widget.softWrap,
                maxLines: _isExpanded ? null : widget.maxLines,
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: _toggleExpand,
          child: Text(
            _isExpanded ? widget.collapseText : widget.expandText,
            style: widget.style.copyWith(
              color: context.mp.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
