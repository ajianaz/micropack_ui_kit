import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_skeleton_theme.dart';

/// Skeleton text field with loading animation
///
/// This widget provides a skeleton loading state for text fields,
/// matching the expected layout and styling of MPTextField.
class MPTextFieldSkeleton extends StatefulWidget {
  const MPTextFieldSkeleton({
    super.key,
    this.type = MPTextFieldSkeletonType.standard,
    this.size = MPTextFieldSkeletonSize.medium,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.helperText,
    this.errorText,
    this.counterText,
    this.borderRadius,
    this.height,
    this.width,
    this.animationType = MPSkeletonAnimationType.shimmer,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.baseColor,
    this.highlightColor,
    this.isAnimating = true,
  });

  final MPTextFieldSkeletonType type;
  final MPTextFieldSkeletonSize size;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? helperText;
  final String? errorText;
  final String? counterText;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;
  final MPSkeletonAnimationType animationType;
  final Duration animationDuration;
  final Color? baseColor;
  final Color? highlightColor;
  final bool isAnimating;

  @override
  State<MPTextFieldSkeleton> createState() => _MPTextFieldSkeletonState();
}

class _MPTextFieldSkeletonState extends State<MPTextFieldSkeleton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shimmerAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    if (widget.isAnimating) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    // Shimmer animation
    _shimmerAnimation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Pulse animation
    _colorAnimation = ColorTween(
      begin: widget.baseColor ?? context.mp.neutral20,
      end: widget.highlightColor ?? context.mp.neutral30,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimation() {
    if (widget.animationType == MPSkeletonAnimationType.shimmer) {
      _animationController.repeat();
    } else {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) _buildLabel(),
          _buildTextFieldSkeleton(),
          if (widget.helperText != null || widget.errorText != null) ...[
            const SizedBox(height: 4),
            _buildHelperText(),
          ],
        ],
      ),
    );
  }

  Widget _buildLabel() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: _buildAnimatedSkeleton(
        width: _getLabelWidth(),
        height: _getLabelHeight(),
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  Widget _buildTextFieldSkeleton() {
    return Container(
      height: widget.height ?? _getHeight(),
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? _getBorderRadius(),
        border: widget.type == MPTextFieldSkeletonType.outlined
            ? Border.all(color: _getBorderColor())
            : null,
      ),
      child: Stack(
        children: [
          // Background skeleton
          Positioned.fill(
            child: _buildAnimatedSkeleton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: widget.borderRadius ?? _getBorderRadius(),
              showContent: true,
            ),
          ),

          // Prefix icon
          if (widget.prefixIcon != null) ...[
            Positioned(
              left: 12.0,
              top: 0,
              bottom: 0,
              child: Center(
                child: Icon(
                  widget.prefixIcon!,
                  size: _getIconSize(),
                  color: _getSkeletonColor(),
                ),
              ),
            ),
          ],

          // Hint text placeholder
          if (widget.hint != null) ...[
            Positioned(
              left: widget.prefixIcon != null ? 48.0 : 16.0,
              right: widget.suffixIcon != null ? 48.0 : 16.0,
              top: 0,
              bottom: 0,
              child: Center(
                child: _buildAnimatedSkeleton(
                  width: _getHintWidth(),
                  height: _getHintHeight(),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
          ],

          // Suffix icon
          if (widget.suffixIcon != null) ...[
            Positioned(
              right: 12.0,
              top: 0,
              bottom: 0,
              child: Center(
                child: Icon(
                  widget.suffixIcon!,
                  size: _getIconSize(),
                  color: _getSkeletonColor(),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHelperText() {
    return Row(
      children: [
        // Helper/error text skeleton
        Expanded(
          child: _buildAnimatedSkeleton(
            width: _getHelperTextWidth(),
            height: _getHelperTextHeight(),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),

        // Counter text skeleton
        if (widget.counterText != null) ...[
          const SizedBox(width: 8.0),
          _buildAnimatedSkeleton(
            width: _getCounterTextWidth(),
            height: _getHelperTextHeight(),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ],
      ],
    );
  }

  Widget _buildAnimatedSkeleton({
    required double width,
    required double height,
    required BorderRadius borderRadius,
    bool showContent = false,
  }) {
    Widget skeleton = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: _getSkeletonColor(),
      ),
    );

    // Add shimmer effect
    if (widget.animationType == MPSkeletonAnimationType.shimmer &&
        widget.isAnimating) {
      skeleton = AnimatedBuilder(
        animation: _shimmerAnimation,
        builder: (context, child) {
          return Stack(
            children: [
              if (child != null) child,
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: Transform.translate(
                    offset: Offset(_shimmerAnimation.value * width, 0),
                    child: Container(
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.transparent,
                            widget.highlightColor ??
                                // Theme-aware shimmer for proper visibility in both modes
                                (context.mp.isDarkMode
                                    ? context.mp.neutral10.withValues(alpha: 0.25)
                                    : context.mp.neutral100.withValues(alpha: 0.15)),
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

    // Add pulse effect
    if (widget.animationType == MPSkeletonAnimationType.pulse &&
        widget.isAnimating) {
      skeleton = AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: _colorAnimation.value,
            ),
          );
        },
        child: skeleton,
      );
    }

    return skeleton;
  }

  Color _getSkeletonColor() {
    return widget.baseColor ?? context.mp.neutral20;
  }

  Color _getBorderColor() {
    return context.mp.neutral30;
  }

  double _getHeight() {
    switch (widget.size) {
      case MPTextFieldSkeletonSize.small:
        return 36.0;
      case MPTextFieldSkeletonSize.medium:
        return 48.0;
      case MPTextFieldSkeletonSize.large:
        return 56.0;
    }
  }

  BorderRadius _getBorderRadius() {
    switch (widget.size) {
      case MPTextFieldSkeletonSize.small:
        return BorderRadius.circular(6.0);
      case MPTextFieldSkeletonSize.medium:
        return BorderRadius.circular(8.0);
      case MPTextFieldSkeletonSize.large:
        return BorderRadius.circular(10.0);
    }
  }

  double _getLabelWidth() {
    final labelLength = widget.label?.length ?? 0;
    return (labelLength * 8.0).clamp(40.0, 200.0);
  }

  double _getLabelHeight() {
    return 16.0;
  }

  double _getHintWidth() {
    final hintLength = widget.hint?.length ?? 0;
    return (hintLength * 7.0).clamp(60.0, 200.0);
  }

  double _getHintHeight() {
    return 16.0;
  }

  double _getHelperTextWidth() {
    final helperLength = (widget.helperText ?? widget.errorText)?.length ?? 0;
    return (helperLength * 6.0).clamp(40.0, 150.0);
  }

  double _getHelperTextHeight() {
    return 12.0;
  }

  double _getCounterTextWidth() {
    final counterLength = widget.counterText?.length ?? 0;
    return (counterLength * 6.0).clamp(20.0, 40.0);
  }

  double _getIconSize() {
    switch (widget.size) {
      case MPTextFieldSkeletonSize.small:
        return 16.0;
      case MPTextFieldSkeletonSize.medium:
        return 20.0;
      case MPTextFieldSkeletonSize.large:
        return 24.0;
    }
  }
}

/// Skeleton text field types
enum MPTextFieldSkeletonType {
  standard,
  outlined,
  filled,
}

/// Skeleton text field sizes
enum MPTextFieldSkeletonSize {
  small,
  medium,
  large,
}

/// Form skeleton loader for complete forms
///
/// This widget provides skeleton loading states for entire forms
/// with multiple text fields and consistent styling.
class MPFormSkeleton extends StatelessWidget {
  const MPFormSkeleton({
    super.key,
    required this.fields,
    this.spacing = 16.0,
    this.animationType = MPSkeletonAnimationType.shimmer,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.baseColor,
    this.highlightColor,
    this.isAnimating = true,
  });

  final List<MPFormSkeletonField> fields;
  final double spacing;
  final MPSkeletonAnimationType animationType;
  final Duration animationDuration;
  final Color? baseColor;
  final Color? highlightColor;
  final bool isAnimating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields.map((field) {
        return Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: MPTextFieldSkeleton(
            type: field.type,
            size: field.size,
            label: field.label,
            hint: field.hint,
            prefixIcon: field.prefixIcon,
            suffixIcon: field.suffixIcon,
            helperText: field.helperText,
            errorText: field.errorText,
            counterText: field.counterText,
            borderRadius: field.borderRadius,
            height: field.height,
            width: field.width,
            animationType: animationType,
            animationDuration: animationDuration,
            baseColor: baseColor,
            highlightColor: highlightColor,
            isAnimating: isAnimating,
          ),
        );
      }).toList(),
    );
  }
}

/// Form skeleton field configuration
class MPFormSkeletonField {
  const MPFormSkeletonField({
    this.type = MPTextFieldSkeletonType.standard,
    this.size = MPTextFieldSkeletonSize.medium,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.helperText,
    this.errorText,
    this.counterText,
    this.borderRadius,
    this.height,
    this.width,
  });

  final MPTextFieldSkeletonType type;
  final MPTextFieldSkeletonSize size;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? helperText;
  final String? errorText;
  final String? counterText;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;
}

/// Enhanced skeleton with theme configuration
class MPSkeletonTextField extends StatelessWidget {
  const MPSkeletonTextField({
    super.key,
    this.isLoading = false,
    this.child,
    this.skeletonBuilder,
    this.animationType = MPSkeletonAnimationType.shimmer,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.transitionDuration = const Duration(milliseconds: 300),
  });

  final bool isLoading;
  final Widget? child;
  final Widget Function(BuildContext context)? skeletonBuilder;
  final MPSkeletonAnimationType animationType;
  final Duration animationDuration;
  final Duration transitionDuration;

  @override
  Widget build(BuildContext context) {
    if (!isLoading && child != null) {
      return AnimatedSwitcher(
        duration: transitionDuration,
        child: child!,
      );
    }

    if (skeletonBuilder != null) {
      return AnimatedSwitcher(
        duration: transitionDuration,
        child: KeyedSubtree(
          key: const ValueKey('skeleton'),
          child: skeletonBuilder!(context),
        ),
      );
    }

    return AnimatedSwitcher(
      duration: transitionDuration,
      child: KeyedSubtree(
        key: const ValueKey('default_skeleton'),
        child: MPTextFieldSkeleton(
          animationType: animationType,
          animationDuration: animationDuration,
        ),
      ),
    );
  }
}

/// Skeleton configurations for common form patterns
class MPSkeletonTextFieldConfigs {
  /// Login form skeleton configuration
  static List<MPFormSkeletonField> loginForm() {
    return [
      const MPFormSkeletonField(
        label: 'Email',
        hint: 'Enter your email',
        prefixIcon: Icons.email_outlined,
      ),
      const MPFormSkeletonField(
        label: 'Password',
        hint: 'Enter your password',
        prefixIcon: Icons.lock_outline,
        suffixIcon: Icons.visibility_off_outlined,
      ),
    ];
  }

  /// Registration form skeleton configuration
  static List<MPFormSkeletonField> registrationForm() {
    return [
      const MPFormSkeletonField(
        label: 'Full Name',
        hint: 'Enter your full name',
        prefixIcon: Icons.person_outline,
      ),
      const MPFormSkeletonField(
        label: 'Email',
        hint: 'Enter your email',
        prefixIcon: Icons.email_outlined,
      ),
      const MPFormSkeletonField(
        label: 'Password',
        hint: 'Enter your password',
        prefixIcon: Icons.lock_outline,
      ),
      const MPFormSkeletonField(
        label: 'Confirm Password',
        hint: 'Confirm your password',
        prefixIcon: Icons.lock_outline,
      ),
    ];
  }

  /// Search form skeleton configuration
  static List<MPFormSkeletonField> searchForm() {
    return [
      const MPFormSkeletonField(
        hint: 'Search...',
        prefixIcon: Icons.search,
        suffixIcon: Icons.clear,
        type: MPTextFieldSkeletonType.outlined,
      ),
    ];
  }

  /// Contact form skeleton configuration
  static List<MPFormSkeletonField> contactForm() {
    return [
      const MPFormSkeletonField(
        label: 'Name',
        hint: 'Enter your name',
        prefixIcon: Icons.person_outline,
      ),
      const MPFormSkeletonField(
        label: 'Email',
        hint: 'Enter your email',
        prefixIcon: Icons.email_outlined,
      ),
      const MPFormSkeletonField(
        label: 'Subject',
        hint: 'Enter subject',
        prefixIcon: Icons.subject,
      ),
      const MPFormSkeletonField(
        label: 'Message',
        hint: 'Enter your message',
        prefixIcon: Icons.message_outlined,
        height: 120.0,
        size: MPTextFieldSkeletonSize.large,
      ),
    ];
  }
}
