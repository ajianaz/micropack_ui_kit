import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Skeleton theme data for consistent skeleton styling
/// 
/// This class provides configuration options for skeleton
/// loading states with customizable colors, animations, and variants.
class MPSkeletonThemeData {
  const MPSkeletonThemeData({
    this.baseColor,
    this.highlightColor,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.animationType = MPSkeletonAnimationType.shimmer,
    this.borderRadius = 8.0,
    this.textBorderRadius = 4.0,
    this.avatarBorderRadius = 24.0,
    this.buttonBorderRadius = 8.0,
    this.textFieldBorderRadius = 8.0,
    this.cardBorderRadius = 12.0,
    this.enableShimmer = true,
    this.shimmerGradient,
    this.pulseCurve = Curves.easeInOut,
    this.shimmerCurve = Curves.linear,
  });

  /// Base color for skeleton elements
  final Color? baseColor;

  /// Highlight color for shimmer effect
  final Color? highlightColor;

  /// Animation duration
  final Duration animationDuration;

  /// Animation type
  final MPSkeletonAnimationType animationType;

  /// Default border radius
  final double borderRadius;

  /// Text border radius
  final double textBorderRadius;

  /// Avatar border radius
  final double avatarBorderRadius;

  /// Button border radius
  final double buttonBorderRadius;

  /// Text field border radius
  final double textFieldBorderRadius;

  /// Card border radius
  final double cardBorderRadius;

  /// Whether to enable shimmer effect
  final bool enableShimmer;

  /// Custom shimmer gradient
  final Gradient? shimmerGradient;

  /// Pulse animation curve
  final Curve pulseCurve;

  /// Shimmer animation curve
  final Curve shimmerCurve;

  /// Creates a copy with updated values
  MPSkeletonThemeData copyWith({
    Color? baseColor,
    Color? highlightColor,
    Duration? animationDuration,
    MPSkeletonAnimationType? animationType,
    double? borderRadius,
    double? textBorderRadius,
    double? avatarBorderRadius,
    double? buttonBorderRadius,
    double? textFieldBorderRadius,
    double? cardBorderRadius,
    bool? enableShimmer,
    Gradient? shimmerGradient,
    Curve? pulseCurve,
    Curve? shimmerCurve,
  }) {
    return MPSkeletonThemeData(
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      animationDuration: animationDuration ?? this.animationDuration,
      animationType: animationType ?? this.animationType,
      borderRadius: borderRadius ?? this.borderRadius,
      textBorderRadius: textBorderRadius ?? this.textBorderRadius,
      avatarBorderRadius: avatarBorderRadius ?? this.avatarBorderRadius,
      buttonBorderRadius: buttonBorderRadius ?? this.buttonBorderRadius,
      textFieldBorderRadius: textFieldBorderRadius ?? this.textFieldBorderRadius,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
      enableShimmer: enableShimmer ?? this.enableShimmer,
      shimmerGradient: shimmerGradient ?? this.shimmerGradient,
      pulseCurve: pulseCurve ?? this.pulseCurve,
      shimmerCurve: shimmerCurve ?? this.shimmerCurve,
    );
  }

  /// Linear interpolation for theme transitions
  static MPSkeletonThemeData lerp(
    MPSkeletonThemeData a,
    MPSkeletonThemeData b,
    double t,
  ) {
    if (t == 0.0) return a;
    if (t == 1.0) return b;

    return MPSkeletonThemeData(
      baseColor: Color.lerp(a.baseColor, b.baseColor, t),
      highlightColor: Color.lerp(a.highlightColor, b.highlightColor, t),
      animationDuration: lerpDuration(a.animationDuration, b.animationDuration, t),
      animationType: t < 0.5 ? a.animationType : b.animationType,
      borderRadius: lerpDouble(a.borderRadius, b.borderRadius, t),
      textBorderRadius: lerpDouble(a.textBorderRadius, b.textBorderRadius, t),
      avatarBorderRadius: lerpDouble(a.avatarBorderRadius, b.avatarBorderRadius, t),
      buttonBorderRadius: lerpDouble(a.buttonBorderRadius, b.buttonBorderRadius, t),
      textFieldBorderRadius: lerpDouble(a.textFieldBorderRadius, b.textFieldBorderRadius, t),
      cardBorderRadius: lerpDouble(a.cardBorderRadius, b.cardBorderRadius, t),
      enableShimmer: t < 0.5 ? a.enableShimmer : b.enableShimmer,
      shimmerGradient: t < 0.5 ? a.shimmerGradient : b.shimmerGradient,
      pulseCurve: t < 0.5 ? a.pulseCurve : b.pulseCurve,
      shimmerCurve: t < 0.5 ? a.shimmerCurve : b.shimmerCurve,
    );
  }

  static Duration lerpDuration(Duration a, Duration b, double t) {
    return Duration(
      milliseconds: lerpDouble(a.inMilliseconds.toDouble(), b.inMilliseconds.toDouble(), t).toInt(),
    );
  }

  static double lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}

/// Skeleton theme extension for easy access
extension MPSkeletonTheme on BuildContext {
  MPSkeletonThemeData get skeletonTheme {
    final theme = Theme.of(this);
    return theme.extension<MPSkeletonThemeData>() ??
        const MPSkeletonThemeData();
  }
}

/// Skeleton theme configuration widget
class MPSkeletonTheme extends StatelessWidget {
  const MPSkeletonTheme({
    super.key,
    required this.data,
    required this.child,
  });

  final MPSkeletonThemeData data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Theme(
      data: theme.copyWith(
        extensions: [
          ...theme.extensions.values,
          data,
        ],
      ),
      child: child,
    );
  }
}

/// Skeleton theme manager for global configuration
class MPSkeletonThemeManager {
  static MPSkeletonThemeData _defaultTheme = const MPSkeletonThemeData();
  static final Map<String, MPSkeletonThemeData> _namedThemes = {};

  /// Set default skeleton theme
  static void setDefaultTheme(MPSkeletonThemeData theme) {
    _defaultTheme = theme;
  }

  /// Get default skeleton theme
  static MPSkeletonThemeData getDefaultTheme() {
    return _defaultTheme;
  }

  /// Register a named theme
  static void registerTheme(String name, MPSkeletonThemeData theme) {
    _namedThemes[name] = theme;
  }

  /// Get a named theme
  static MPSkeletonThemeData? getTheme(String name) {
    return _namedThemes[name];
  }

  /// Get all registered theme names
  static List<String> getThemeNames() {
    return _namedThemes.keys.toList();
  }

  /// Remove a named theme
  static void removeTheme(String name) {
    _namedThemes.remove(name);
  }

  /// Clear all named themes
  static void clearThemes() {
    _namedThemes.clear();
  }

  /// Initialize default themes
  static void initializeDefaultThemes() {
    // Light theme
    registerTheme('light', const MPSkeletonThemeData(
      baseColor: Color(0xFFE0E0E0),
      highlightColor: Color(0xFFF5F5F5),
      animationDuration: Duration(milliseconds: 1500),
      animationType: MPSkeletonAnimationType.shimmer,
      enableShimmer: true,
    ));

    // Dark theme
    registerTheme('dark', const MPSkeletonThemeData(
      baseColor: Color(0xFF424242),
      highlightColor: Color(0xFF616161),
      animationDuration: Duration(milliseconds: 1500),
      animationType: MPSkeletonAnimationType.shimmer,
      enableShimmer: true,
    ));

    // Minimal theme
    registerTheme('minimal', const MPSkeletonThemeData(
      baseColor: Color(0xFFF5F5F5),
      highlightColor: Color(0xFFE0E0E0),
      animationDuration: Duration(milliseconds: 2000),
      animationType: MPSkeletonAnimationType.pulse,
      enableShimmer: false,
    ));

    // Colorful theme
    registerTheme('colorful', const MPSkeletonThemeData(
      baseColor: Color(0xFFE8EAF6),
      highlightColor: Color(0xFFC5CAE9),
      animationDuration: Duration(milliseconds: 1200),
      animationType: MPSkeletonAnimationType.shimmer,
      enableShimmer: true,
    ));
  }
}

/// Predefined skeleton themes
class MPSkeletonThemes {
  /// Default skeleton theme
  static const MPSkeletonThemeData defaultTheme = MPSkeletonThemeData();

  /// Light skeleton theme
  static const MPSkeletonThemeData light = MPSkeletonThemeData(
    baseColor: Color(0xFFE0E0E0),
    highlightColor: Color(0xFFF5F5F5),
    animationDuration: Duration(milliseconds: 1500),
    animationType: MPSkeletonAnimationType.shimmer,
    enableShimmer: true,
  );

  /// Dark skeleton theme
  static const MPSkeletonThemeData dark = MPSkeletonThemeData(
    baseColor: Color(0xFF424242),
    highlightColor: Color(0xFF616161),
    animationDuration: Duration(milliseconds: 1500),
    animationType: MPSkeletonAnimationType.shimmer,
    enableShimmer: true,
  );

  /// Minimal skeleton theme
  static const MPSkeletonThemeData minimal = MPSkeletonThemeData(
    baseColor: Color(0xFFF5F5F5),
    highlightColor: Color(0xFFE0E0E0),
    animationDuration: Duration(milliseconds: 2000),
    animationType: MPSkeletonAnimationType.pulse,
    enableShimmer: false,
  );

  /// Colorful skeleton theme
  static const MPSkeletonThemeData colorful = MPSkeletonThemeData(
    baseColor: Color(0xFFE8EAF6),
    highlightColor: Color(0xFFC5CAE9),
    animationDuration: Duration(milliseconds: 1200),
    animationType: MPSkeletonAnimationType.shimmer,
    enableShimmer: true,
  );

  /// Subtle skeleton theme
  static const MPSkeletonThemeData subtle = MPSkeletonThemeData(
    baseColor: Color(0xFFF8F8F8),
    highlightColor: Color(0xFFEEEEEE),
    animationDuration: Duration(milliseconds: 1800),
    animationType: MPSkeletonAnimationType.pulse,
    enableShimmer: false,
  );

  /// Bold skeleton theme
  static const MPSkeletonThemeData bold = MPSkeletonThemeData(
    baseColor: Color(0xFFD0D0D0),
    highlightColor: Color(0xFFB0B0B0),
    animationDuration: Duration(milliseconds: 1000),
    animationType: MPSkeletonAnimationType.shimmer,
    enableShimmer: true,
  );
}

/// Enhanced skeleton widget with theme support
class MPSkeletonThemed extends StatelessWidget {
  const MPSkeletonThemed({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.isCircle = false,
    this.animationType,
    this.animationDuration,
    this.enableShimmer,
    this.themeData,
    this.shimmerGradient,
    this.pulseCurve,
    this.shimmerCurve,
  });

  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final bool isCircle;
  final MPSkeletonAnimationType? animationType;
  final Duration? animationDuration;
  final bool? enableShimmer;
  final MPSkeletonThemeData? themeData;
  final Gradient? shimmerGradient;
  final Curve? pulseCurve;
  final Curve? shimmerCurve;

  @override
  Widget build(BuildContext context) {
    final theme = themeData ?? context.skeletonTheme;
    
    return MPSkeletonAdvanced(
      width: width,
      height: height,
      borderRadius: borderRadius ?? theme.borderRadius,
      baseColor: baseColor ?? _getBaseColor(theme),
      highlightColor: highlightColor ?? _getHighlightColor(theme),
      isCircle: isCircle,
      animationType: animationType ?? theme.animationType,
      animationDuration: animationDuration ?? theme.animationDuration,
      enableShimmer: enableShimmer ?? theme.enableShimmer,
      shimmerGradient: shimmerGradient ?? theme.shimmerGradient,
      pulseCurve: pulseCurve ?? theme.pulseCurve,
      shimmerCurve: shimmerCurve ?? theme.shimmerCurve,
    );
  }

  Color _getBaseColor(MPSkeletonThemeData theme) {
    if (theme.baseColor != null) return theme.baseColor!;
    
    // Use theme-aware color
    return context.mp.isDarkMode
        ? const Color(0xFF424242)
        : const Color(0xFFE0E0E0);
  }

  Color _getHighlightColor(MPSkeletonThemeData theme) {
    if (theme.highlightColor != null) return theme.highlightColor!;
    
    // Use theme-aware color
    return context.mp.isDarkMode
        ? const Color(0xFF616161)
        : const Color(0xFFF5F5F5);
  }
}

/// Advanced skeleton widget with enhanced animations
class MPSkeletonAdvanced extends StatefulWidget {
  const MPSkeletonAdvanced({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.baseColor,
    this.highlightColor,
    this.isCircle = false,
    this.animationType = MPSkeletonAnimationType.shimmer,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.enableShimmer = true,
    this.shimmerGradient,
    this.pulseCurve = Curves.easeInOut,
    this.shimmerCurve = Curves.linear,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final bool isCircle;
  final MPSkeletonAnimationType animationType;
  final Duration animationDuration;
  final bool enableShimmer;
  final Gradient? shimmerGradient;
  final Curve pulseCurve;
  final Curve shimmerCurve;

  @override
  State<MPSkeletonAdvanced> createState() => _MPSkeletonAdvancedState();
}

class _MPSkeletonAdvancedState extends State<MPSkeletonAdvanced>
    with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  late AnimationController _pulseController;
  late Animation<double> _shimmerAnimation;
  late Animation<Color?> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _shimmerController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _shimmerAnimation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: widget.shimmerCurve,
    ));

    _pulseAnimation = ColorTween(
      begin: widget.baseColor ?? const Color(0xFFE0E0E0),
      end: widget.highlightColor ?? const Color(0xFFF5F5F5),
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: widget.pulseCurve,
    ));

    // Start appropriate animation
    _startAnimation();
  }

  void _startAnimation() {
    switch (widget.animationType) {
      case MPSkeletonAnimationType.shimmer:
        if (widget.enableShimmer) {
          _shimmerController.repeat();
        }
      case MPSkeletonAnimationType.pulse:
        _pulseController.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget skeleton = Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.baseColor ?? const Color(0xFFE0E0E0),
        borderRadius: widget.isCircle
            ? null
            : BorderRadius.circular(widget.borderRadius),
        shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );

    // Apply shimmer effect
    if (widget.animationType == MPSkeletonAnimationType.shimmer && widget.enableShimmer) {
      skeleton = AnimatedBuilder(
        animation: _shimmerAnimation,
        builder: (context, child) {
          return Stack(
            children: [
              child,
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: widget.isCircle
                      ? null
                      : BorderRadius.circular(widget.borderRadius),
                  child: Transform.translate(
                    offset: Offset(_shimmerAnimation.value * (widget.width ?? 100), 0),
                    child: Container(
                      width: (widget.width ?? 100) * 0.3,
                      decoration: BoxDecoration(
                        gradient: widget.shimmerGradient ??
                            LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.transparent,
                                widget.highlightColor ?? Colors.white.withValues(alpha: 0.4),
                                Colors.transparent,
                              ],
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        child: skeleton,
      );
    }

    // Apply pulse effect
    if (widget.animationType == MPSkeletonAnimationType.pulse) {
      skeleton = AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: _pulseAnimation.value,
              borderRadius: widget.isCircle
                  ? null
                  : BorderRadius.circular(widget.borderRadius),
              shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
            ),
          );
        },
      );
    }

    return skeleton;
  }
}

/// Skeleton animation types
enum MPSkeletonAnimationType {
  shimmer,
  pulse,
  fade,
}
