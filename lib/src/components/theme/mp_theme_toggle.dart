import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_manager.dart';

/// MPThemeToggle - A comprehensive theme switching component
///
/// Features:
/// - Animated theme switching with smooth transitions
/// - Integration with MPThemeManager for persistence
/// - Support for light, dark, and system themes
/// - Customizable appearance and behavior
/// - Accessibility support with proper labels
/// - Visual feedback for current theme mode
class MPThemeToggle extends StatefulWidget {
  const MPThemeToggle({
    super.key,
    this.variant = MPThemeToggleVariant.iconButton,
    this.showLabel = false,
    this.customIcon,
    this.customLabels,
    this.onChanged,
    this.animationDuration = const Duration(milliseconds: 300),
    this.iconSize = 24.0,
    this.padding = const EdgeInsets.all(8.0),
    this.semanticLabel,
    this.semanticHint,
    this.customAccessibilityActions,
    this.onAccessibilityAction,
    this.focusNode,
    this.enableKeyboardNavigation = true,
  });

  /// The visual variant of the theme toggle
  final MPThemeToggleVariant variant;

  /// Whether to show text labels alongside icons
  final bool showLabel;

  /// Custom icon widget to override default icons
  final Widget? customIcon;

  /// Custom labels for theme modes
  final Map<ThemeMode, String>? customLabels;

  /// Callback when theme changes
  final Function(ThemeMode)? onChanged;

  /// Duration of theme switching animation
  final Duration animationDuration;

  /// Size of theme icons
  final double iconSize;

  /// Padding around the toggle
  final EdgeInsets padding;

  /// Semantic label for screen readers
  final String? semanticLabel;

  /// Semantic hint for screen readers
  final String? semanticHint;

  /// Custom accessibility actions
  final List<SemanticsAction>? customAccessibilityActions;

  /// Callback for accessibility actions
  final void Function(SemanticsAction)? onAccessibilityAction;

  /// Focus node for keyboard navigation
  final FocusNode? focusNode;

  /// Whether to enable keyboard navigation
  final bool enableKeyboardNavigation;

  @override
  State<MPThemeToggle> createState() => _MPThemeToggleState();
}

class _MPThemeToggleState extends State<MPThemeToggle>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  ThemeMode? _currentThemeMode;
  bool _isLandscape = false;

  @override
  void initState() {
    super.initState();
    _setupAnimationController();
    _initializeTheme();

    // Add theme listener
    if (MPThemeManager.instance.isInitialized) {
      MPThemeManager.instance.addListener(_onThemeChanged);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateOrientation();
  }

  void _updateOrientation() {
    final newOrientation = MediaQuery.of(context).orientation;
    final newIsLandscape = newOrientation == Orientation.landscape;

    if (_isLandscape != newIsLandscape) {
      setState(() {
        _isLandscape = newIsLandscape;
      });
    }
  }

  void _setupAnimationController() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));

    _animationController.forward();
  }

  void _initializeTheme() {
    if (MPThemeManager.instance.isInitialized) {
      _currentThemeMode = MPThemeManager.instance.themeMode;
    }
  }

  void _onThemeChanged() {
    if (mounted) {
      final newThemeMode = MPThemeManager.instance.themeMode;
      if (_currentThemeMode != newThemeMode) {
        setState(() {
          _currentThemeMode = newThemeMode;
        });
        _playSwitchAnimation();
      }
    }
  }

  void _playSwitchAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  Future<void> _switchToNextTheme() async {
    if (!MPThemeManager.instance.isInitialized) return;

    final nextTheme = _getNextThemeMode(_currentThemeMode!);

    // Play animation before theme change
    await _animationController.reverse();

    MPErrorHandler.instance.executeWithErrorHandlingAsync(
      () async {
        switch (nextTheme) {
          case ThemeMode.light:
            await MPThemeManager.instance.setLightTheme();
            break;
          case ThemeMode.dark:
            await MPThemeManager.instance.setDarkTheme();
            break;
          case ThemeMode.system:
            await MPThemeManager.instance.setSystemTheme();
            break;
        }

        widget.onChanged?.call(nextTheme);
      },
      category: MPErrorCategory.theme,
      code: 'THEME_TOGGLE_SWITCH_ERROR',
      message: 'Theme toggle switch failed',
      context: {
        'fromTheme': _currentThemeMode?.toString(),
        'toTheme': nextTheme.toString(),
        'variant': widget.variant.name,
      },
    );

    // Complete animation after theme change
    _animationController.forward();
  }

  ThemeMode _getNextThemeMode(ThemeMode current) {
    switch (current) {
      case ThemeMode.light:
        return ThemeMode.dark;
      case ThemeMode.dark:
        return ThemeMode.system;
      case ThemeMode.system:
        return ThemeMode.light;
    }
  }

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings_brightness;
    }
  }

  String _getThemeLabel(ThemeMode mode) {
    if (widget.customLabels != null && widget.customLabels!.containsKey(mode)) {
      return widget.customLabels![mode]!;
    }

    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  Color _getIconColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white : Colors.black87;
  }

  double _getOrientationAwareIconSize() {
    if (_isLandscape) {
      return widget.iconSize * 0.9; // Slightly smaller in landscape
    }
    return widget.iconSize;
  }

  EdgeInsets _getOrientationAwarePadding() {
    if (_isLandscape) {
      // More compact padding in landscape mode
      return EdgeInsets.symmetric(
        horizontal: widget.padding.horizontal * 0.8,
        vertical: widget.padding.vertical * 0.7,
      );
    }
    return widget.padding;
  }

  Widget _buildIconButton() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value * 2 * 3.14159,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: IconButton(
              onPressed: _switchToNextTheme,
              padding: _getOrientationAwarePadding(),
              icon: widget.customIcon ??
                  Icon(
                    _getThemeIcon(_currentThemeMode ?? ThemeMode.system),
                    size: _getOrientationAwareIconSize(),
                    color: _getIconColor(context),
                  ),
              tooltip: _getThemeLabel(_currentThemeMode ?? ThemeMode.system),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextButton() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return TextButton.icon(
          onPressed: _switchToNextTheme,
          style: TextButton.styleFrom(
            padding: _getOrientationAwarePadding(),
          ),
          icon: Transform.rotate(
            angle: _rotationAnimation.value * 2 * 3.14159,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: widget.customIcon ??
                  Icon(
                    _getThemeIcon(_currentThemeMode ?? ThemeMode.system),
                    size: _getOrientationAwareIconSize(),
                    color: _getIconColor(context),
                  ),
            ),
          ),
          label: Text(
            _getThemeLabel(_currentThemeMode ?? ThemeMode.system),
            style: TextStyle(
              color: _getIconColor(context),
              fontSize: _isLandscape ? 12 : 14, // Smaller text in landscape
            ),
          ),
        );
      },
    );
  }

  Widget _buildSegmentedButton() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(_isLandscape ? 6 : 8),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: ThemeMode.values.map((mode) {
              final isSelected = _currentThemeMode == mode;
              return Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (isSelected) return;

                    await _animationController.reverse();

                    try {
                      switch (mode) {
                        case ThemeMode.light:
                          await MPThemeManager.instance.setLightTheme();
                          break;
                        case ThemeMode.dark:
                          await MPThemeManager.instance.setDarkTheme();
                          break;
                        case ThemeMode.system:
                          await MPThemeManager.instance.setSystemTheme();
                          break;
                      }

                      widget.onChanged?.call(mode);
                    } catch (e) {
                      debugPrint('Error switching theme: $e');
                    }

                    _animationController.forward();
                  },
                  child: AnimatedContainer(
                    duration: widget.animationDuration,
                    padding: EdgeInsets.symmetric(
                      horizontal: _isLandscape ? 8 : 12,
                      vertical: _isLandscape ? 6 : 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(_isLandscape ? 4 : 6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getThemeIcon(mode),
                          size: _getOrientationAwareIconSize() * 0.8,
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : _getIconColor(context),
                        ),
                        if (widget.showLabel && !_isLandscape) ...[
                          const SizedBox(width: 6),
                          Text(
                            _getThemeLabel(mode),
                            style: TextStyle(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : _getIconColor(context),
                              fontSize: _isLandscape ? 10 : 12,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget toggleWidget;

    switch (widget.variant) {
      case MPThemeToggleVariant.iconButton:
        toggleWidget = _buildIconButton();
        break;
      case MPThemeToggleVariant.textButton:
        toggleWidget = _buildTextButton();
        break;
      case MPThemeToggleVariant.segmented:
        toggleWidget = _buildSegmentedButton();
        break;
    }

    // Wrap with Semantics widget for accessibility
    return Semantics(
      label: widget.semanticLabel ?? 'Theme toggle',
      hint: widget.semanticHint ??
          'Toggle between light, dark, and system themes',
      button: true,
      // Add enhanced semantic properties
      toggled: _isDarkMode(context),
      // Add custom accessibility actions if provided
      customSemanticsActions: _getCustomSemanticsActions(),
      child: widget.enableKeyboardNavigation && widget.focusNode != null
          ? Focus(
              focusNode: widget.focusNode,
              // Add keyboard navigation callbacks
              onKey: (node, event) {
                return _handleKeyPress(event);
              },
              child: toggleWidget,
            )
          : toggleWidget,
    );
  }

  @override
  void dispose() {
    // Remove theme listener
    if (MPThemeManager.instance.isInitialized) {
      MPThemeManager.instance.removeListener(_onThemeChanged);
    }
    _animationController.dispose();
    super.dispose();
  }

  /// Determines if current theme is dark mode
  bool _isDarkMode(BuildContext context) {
    final theme = Theme.of(context);
    return theme.brightness == Brightness.dark;
  }

  /// Creates custom semantics actions for accessibility
  Map<CustomSemanticsAction, VoidCallback>? _getCustomSemanticsActions() {
    if (widget.customAccessibilityActions == null ||
        widget.onAccessibilityAction == null) {
      return null;
    }

    final Map<CustomSemanticsAction, VoidCallback> actions = {};

    for (final action in widget.customAccessibilityActions!) {
      actions[CustomSemanticsAction(
        label: _getActionLabel(action),
      )] = () => widget.onAccessibilityAction!(action);
    }

    return actions;
  }

  /// Gets a user-friendly label for a semantics action
  String _getActionLabel(SemanticsAction action) {
    switch (action) {
      case SemanticsAction.tap:
        return 'Toggle theme';
      case SemanticsAction.longPress:
        return 'Long press';
      case SemanticsAction.showOnScreen:
        return 'Show theme toggle';
      default:
        return 'Action';
    }
  }

  /// Handles keyboard events for theme toggle
  KeyEventResult _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      switch (event.logicalKey.keyLabel) {
        case 'Enter':
        case 'Space':
          // Handle theme toggle
          _switchToNextTheme();
          return KeyEventResult.handled;
        case 'Arrow Right':
        case 'Arrow Down':
          // Handle next theme
          _switchToNextTheme();
          return KeyEventResult.handled;
        case 'Arrow Left':
        case 'Arrow Up':
          // Handle previous theme
          _switchToPreviousTheme();
          return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  /// Switch to previous theme (for keyboard navigation)
  Future<void> _switchToPreviousTheme() async {
    if (!MPThemeManager.instance.isInitialized) return;

    final currentTheme = _currentThemeMode ?? ThemeMode.system;
    ThemeMode previousTheme;

    switch (currentTheme) {
      case ThemeMode.light:
        previousTheme = ThemeMode.system;
        break;
      case ThemeMode.dark:
        previousTheme = ThemeMode.light;
        break;
      case ThemeMode.system:
        previousTheme = ThemeMode.dark;
        break;
    }

    await _switchToTheme(previousTheme);
  }

  /// Switch to specific theme with animation
  Future<void> _switchToTheme(ThemeMode theme) async {
    if (!MPThemeManager.instance.isInitialized) return;

    // Play animation before theme change
    await _animationController.reverse();

    try {
      switch (theme) {
        case ThemeMode.light:
          await MPThemeManager.instance.setLightTheme();
          break;
        case ThemeMode.dark:
          await MPThemeManager.instance.setDarkTheme();
          break;
        case ThemeMode.system:
          await MPThemeManager.instance.setSystemTheme();
          break;
      }

      widget.onChanged?.call(theme);
    } catch (e) {
      debugPrint('Error switching theme: $e');
    }

    // Complete animation after theme change
    _animationController.forward();
  }
}

/// Variants for MPThemeToggle
enum MPThemeToggleVariant {
  /// Simple icon button with rotation animation
  iconButton,

  /// Text button with icon and label
  textButton,

  /// Segmented control showing all theme options
  segmented,
}

/// A compact theme toggle for use in app bars and toolbars
class MPCompactThemeToggle extends StatelessWidget {
  const MPCompactThemeToggle({
    super.key,
    this.onChanged,
    this.iconSize = 20.0,
  });

  final Function(ThemeMode)? onChanged;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return MPThemeToggle(
      variant: MPThemeToggleVariant.iconButton,
      iconSize: iconSize,
      padding: const EdgeInsets.all(4.0),
      onChanged: onChanged,
    );
  }
}

/// A full-featured theme toggle for settings pages
class MPFullThemeToggle extends StatelessWidget {
  const MPFullThemeToggle({
    super.key,
    this.onChanged,
    this.showLabel = true,
  });

  final Function(ThemeMode)? onChanged;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return MPThemeToggle(
      variant: MPThemeToggleVariant.segmented,
      showLabel: showLabel,
      onChanged: onChanged,
    );
  }
}
