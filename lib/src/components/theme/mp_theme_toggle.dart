import 'package:flutter/material.dart';
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

  @override
  State<MPThemeToggle> createState() => _MPThemeToggleState();
}

class _MPThemeToggleState extends State<MPThemeToggle>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  ThemeMode? _currentThemeMode;

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

    try {
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
    } catch (e) {
      debugPrint('Error switching theme: $e');
    }

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
              padding: widget.padding,
              icon: widget.customIcon ??
                  Icon(
                    _getThemeIcon(_currentThemeMode ?? ThemeMode.system),
                    size: widget.iconSize,
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
            padding: widget.padding,
          ),
          icon: Transform.rotate(
            angle: _rotationAnimation.value * 2 * 3.14159,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: widget.customIcon ??
                  Icon(
                    _getThemeIcon(_currentThemeMode ?? ThemeMode.system),
                    size: widget.iconSize,
                    color: _getIconColor(context),
                  ),
            ),
          ),
          label: Text(
            _getThemeLabel(_currentThemeMode ?? ThemeMode.system),
            style: TextStyle(
              color: _getIconColor(context),
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
            borderRadius: BorderRadius.circular(8),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getThemeIcon(mode),
                          size: widget.iconSize * 0.8,
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : _getIconColor(context),
                        ),
                        if (widget.showLabel) ...[
                          const SizedBox(width: 6),
                          Text(
                            _getThemeLabel(mode),
                            style: TextStyle(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : _getIconColor(context),
                              fontSize: 12,
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
    switch (widget.variant) {
      case MPThemeToggleVariant.iconButton:
        return _buildIconButton();
      case MPThemeToggleVariant.textButton:
        return _buildTextButton();
      case MPThemeToggleVariant.segmented:
        return _buildSegmentedButton();
    }
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
