import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Theme Toggle Demo Page
///
/// This page demonstrates various theme toggle variants and theme switching functionality
/// with proper integration with MPThemeManager and persistence.
class ThemeToggleDemoPage extends StatefulWidget {
  const ThemeToggleDemoPage({super.key});

  @override
  State<ThemeToggleDemoPage> createState() => _ThemeToggleDemoPageState();
}

class _ThemeToggleDemoPageState extends State<ThemeToggleDemoPage> {
  ThemeMode? _currentThemeMode;
  String _themeInfo = '';

  @override
  void initState() {
    super.initState();

    // Add theme listener
    if (MPThemeManager.instance.isInitialized) {
      MPThemeManager.instance.addListener(_onThemeChanged);

      // Initialize theme without accessing context
      setState(() {
        _currentThemeMode = MPThemeManager.instance.themeMode;
        _themeInfo = 'Theme initialized. Waiting for build context...';
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Now we can safely access context
    if (MPThemeManager.instance.isInitialized && _currentThemeMode != null) {
      _updateThemeInfo();
    }
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {
        _currentThemeMode = MPThemeManager.instance.themeMode;
        _updateThemeInfo();
      });
    }
  }

  void _updateThemeInfo() {
    if (_currentThemeMode == null) return;

    final brightness = MPThemeManager.instance.getCurrentBrightness(context);
    final brightnessName =
        MPThemeManager.instance.getCurrentBrightnessName(context);
    final themeName = MPThemeManager.instance.getThemeName();

    setState(() {
      _themeInfo =
          'Current: $themeName • Active: $brightnessName • Brightness: ${brightness.name}';
    });
  }

  void _onThemeChangedExternally(ThemeMode mode) {
    debugPrint('Theme changed via toggle: $mode');
    // Theme change is already handled by MPThemeManager
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = MPThemeManager.instance.getCurrentColorTheme(context);

    return Scaffold(
      appBar: AppBar(
        title: MPText(
          'Theme Toggle Demo',
          style: MPTextStyle.heading2(
            color: colorTheme?.neutral90 ?? context.mp.neutral90,
          ),
        ),
        backgroundColor:
            colorTheme?.primarySurface ?? context.mp.backgroundColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: MPCompactThemeToggle(
              onChanged: _onThemeChangedExternally,
            ),
          ),
        ],
      ),
      backgroundColor: colorTheme?.primarySurface ?? context.mp.backgroundColor,
      body: SingleChildScrollView(
        padding: MPResponsivePadding.page(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // Theme Information Card
            _buildThemeInfoCard(colorTheme),

            const SizedBox(height: 32),

            // Theme Toggle Variants Section
            _buildSectionHeader('Theme Toggle Variants', colorTheme),
            const SizedBox(height: 16),

            // Icon Button Toggle
            _buildToggleCard(
              'Icon Button Toggle',
              'Compact icon button with rotation animation',
              MPThemeToggle(
                variant: MPThemeToggleVariant.iconButton,
                onChanged: _onThemeChangedExternally,
              ),
              colorTheme,
            ),

            const SizedBox(height: 16),

            // Text Button Toggle
            _buildToggleCard(
              'Text Button Toggle',
              'Button with icon and label',
              MPThemeToggle(
                variant: MPThemeToggleVariant.textButton,
                showLabel: true,
                onChanged: _onThemeChangedExternally,
              ),
              colorTheme,
            ),

            const SizedBox(height: 16),

            // Segmented Toggle
            _buildToggleCard(
              'Segmented Toggle',
              'Show all theme options in a segmented control',
              MPThemeToggle(
                variant: MPThemeToggleVariant.segmented,
                showLabel: true,
                onChanged: _onThemeChangedExternally,
              ),
              colorTheme,
            ),

            const SizedBox(height: 32),

            // Custom Theme Toggles Section
            _buildSectionHeader('Custom Theme Toggles', colorTheme),
            const SizedBox(height: 16),

            // Custom Labels Toggle
            _buildToggleCard(
              'Custom Labels',
              'Toggle with custom theme labels',
              MPThemeToggle(
                variant: MPThemeToggleVariant.segmented,
                showLabel: true,
                customLabels: {
                  ThemeMode.light: '☀️ Light',
                  ThemeMode.dark: '🌙 Dark',
                  ThemeMode.system: '🔄 Auto',
                },
                onChanged: _onThemeChangedExternally,
              ),
              colorTheme,
            ),

            const SizedBox(height: 16),

            // Custom Animation Toggle
            _buildToggleCard(
              'Slow Animation',
              'Toggle with slower animation for testing',
              MPThemeToggle(
                variant: MPThemeToggleVariant.iconButton,
                animationDuration: const Duration(milliseconds: 800),
                onChanged: _onThemeChangedExternally,
              ),
              colorTheme,
            ),

            const SizedBox(height: 32),

            // Theme Persistence Section
            _buildSectionHeader('Theme Persistence', colorTheme),
            const SizedBox(height: 16),

            _buildPersistenceCard(colorTheme),

            const SizedBox(height: 32),

            // Theme Validation Section
            _buildSectionHeader('Theme Validation', colorTheme),
            const SizedBox(height: 16),

            _buildValidationCard(colorTheme),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, MPColorTheme? colorTheme) {
    return MPText(
      title,
      style: MPTextStyle.heading2(
        color: colorTheme?.neutral90 ?? context.mp.neutral90,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildThemeInfoCard(MPColorTheme? colorTheme) {
    return MPCard(
      variant: MPCardVariant.filled,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText(
            'Current Theme Information',
            style: MPTextStyle.heading3(
              color: colorTheme?.neutral90 ?? context.mp.neutral90,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorTheme?.primary ?? context.mp.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: MPText(
              _themeInfo.isEmpty ? 'Loading theme info...' : _themeInfo,
              style: MPTextStyle.body1(
                color: colorTheme?.neutral10 ?? context.mp.neutral10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                MPThemeManager.instance.getThemeIcon(),
                size: 20,
                color: colorTheme?.neutral70 ?? context.mp.neutral70,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MPText(
                  'Theme Mode: ${MPThemeManager.instance.getThemeName()}',
                  style: MPTextStyle.body1(
                    color: colorTheme?.neutral70 ?? context.mp.neutral70,
                  ),
                  textOverflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleCard(
    String title,
    String description,
    Widget toggle,
    MPColorTheme? colorTheme,
  ) {
    return MPCard(
      variant: MPCardVariant.filled,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText(
            title,
            style: MPTextStyle.heading3(
              color: colorTheme?.neutral90 ?? context.mp.neutral90,
            ),
          ),
          const SizedBox(height: 4),
          MPText(
            description,
            style: MPTextStyle.body1(
              color: colorTheme?.neutral70 ?? context.mp.neutral70,
            ),
          ),
          const SizedBox(height: 16),
          Center(child: toggle),
        ],
      ),
    );
  }

  Widget _buildPersistenceCard(MPColorTheme? colorTheme) {
    return MPCard(
      variant: MPCardVariant.filled,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText(
            'Theme Persistence Status',
            style: MPTextStyle.heading3(
              color: colorTheme?.neutral90 ?? context.mp.neutral90,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: context.mp.successColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MPText(
                  'MPThemeManager is initialized',
                  style: MPTextStyle.body1(
                    color: colorTheme?.neutral70 ?? context.mp.neutral70,
                  ),
                  textOverflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: context.mp.successColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MPText(
                  'Theme preferences are persisted',
                  style: MPTextStyle.body1(
                    color: colorTheme?.neutral70 ?? context.mp.neutral70,
                  ),
                  textOverflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: context.mp.successColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MPText(
                  'Listeners are active',
                  style: MPTextStyle.body1(
                    color: colorTheme?.neutral70 ?? context.mp.neutral70,
                  ),
                  textOverflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          MPText(
            'Theme preferences are automatically saved to SharedPreferences and restored when the app restarts.',
            style: MPTextStyle.body2(
              color: colorTheme?.neutral60 ?? context.mp.neutral60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationCard(MPColorTheme? colorTheme) {
    final validation = MPThemeConfig.validateThemeContrast(
      isDarkMode: Theme.of(context).brightness == Brightness.dark,
    );

    return MPCard(
      variant: MPCardVariant.filled,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText(
            'Color Contrast Validation',
            style: MPTextStyle.heading3(
              color: colorTheme?.neutral90 ?? context.mp.neutral90,
            ),
          ),
          const SizedBox(height: 12),
          ...validation.entries.map((entry) {
            final isPass = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    isPass ? Icons.check_circle : Icons.error,
                    color: isPass
                        ? context.mp.successColor
                        : context.mp.errorColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MPText(
                      entry.key.replaceAll('_', ' ').toUpperCase(),
                      style: MPTextStyle.body2(
                        color: colorTheme?.neutral70 ?? context.mp.neutral70,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (validation.values.every((result) => result)
                      ? context.mp.successColor
                      : context.mp.warningColor)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: validation.values.every((result) => result)
                    ? context.mp.successColor
                    : context.mp.warningColor,
              ),
            ),
            child: MPText(
              validation.values.every((result) => result)
                  ? '✅ All contrast tests passed'
                  : '⚠️ Some contrast tests failed',
              style: MPTextStyle.body1(
                color: validation.values.every((result) => result)
                    ? context.mp.successColor
                    : context.mp.warningColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Remove theme listener
    if (MPThemeManager.instance.isInitialized) {
      MPThemeManager.instance.removeListener(_onThemeChanged);
    }
    super.dispose();
  }
}
