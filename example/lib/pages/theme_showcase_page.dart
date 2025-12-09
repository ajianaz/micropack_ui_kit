import 'package:flutter/material.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ThemeShowcasePage extends StatefulWidget {
  const ThemeShowcasePage({super.key});

  @override
  State<ThemeShowcasePage> createState() => _ThemeShowcasePageState();
}

class _ThemeShowcasePageState extends State<ThemeShowcasePage> {
  @override
  void initState() {
    super.initState();
    // Add listener for theme changes
    try {
      MPThemeManager.instance.addListener(_onThemeChanged);
    } catch (e) {
      // Manager might not be initialized yet, ignore
      debugPrint('Failed to add theme listener: $e');
    }
  }

  @override
  void dispose() {
    // Remove theme listener
    try {
      MPThemeManager.instance.removeListener(_onThemeChanged);
    } catch (e) {
      // Manager might not be initialized, ignore
      debugPrint('Failed to remove theme listener: $e');
    }
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {
        // Rebuild UI when theme changes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Theme Showcase',
          style: TextStyle(color: context.mp.textColor),
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText.head('Theme System Overview'),
            SizedBox(height: MPResponsivePadding.getSm(context)),

            // Theme Info Card
            Container(
              margin:
                  EdgeInsets.only(bottom: MPResponsivePadding.getLg(context)),
              padding: MPResponsivePadding.card(context),
              decoration: BoxDecoration(
                color: context.mp.cardColor, // ✅ Adaptive card background
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.mp.primaryBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getThemeIcon(),
                        color: context.mp.primary,
                        size: 24,
                      ),
                      SizedBox(width: MPResponsivePadding.getSm(context)),
                      MPText(
                        'Current Theme: ${_getThemeName()}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: context.mp.textColor,
                        ),
                        fontSize: 18,
                      ),
                    ],
                  ),
                  SizedBox(height: MPResponsivePadding.getSm(context)),
                  MPText(
                    'Brightness: ${context.mp.isDarkMode ? 'Dark' : 'Light'}',
                    style: TextStyle(
                      color: context.mp.subtitleColor,
                    ),
                    fontSize: 14,
                  ),
                  SizedBox(height: MPResponsivePadding.getXs(context)),
                  MPText(
                    'Theme persistence is ${_getThemeName() == 'System' ? 'following system settings' : 'manually selected'}',
                    style: TextStyle(
                      color: context.mp.captionColor,
                    ),
                    fontSize: 12,
                  ),
                ],
              ),
            ),

            SizedBox(height: MPResponsivePadding.getLg(context)),
            MPText.head('Color Palette'),
            SizedBox(height: MPResponsivePadding.getSm(context)),

            // Color Palette Grid
            _buildColorPalette(context),

            SizedBox(height: MPResponsivePadding.getLg(context)),
            MPText.head('Theme Switching Demo'),
            SizedBox(height: MPResponsivePadding.getSm(context)),

            // Theme Switching Demo
            _buildThemeSwitchingDemo(context),

            SizedBox(height: MPResponsivePadding.getLg(context)),
            MPText.head('Component Examples'),
            SizedBox(height: MPResponsivePadding.getSm(context)),

            // Component Examples
            _buildComponentExamples(context),
          ],
        ),
      ),
    );
  }

  /// Get current theme icon from MPThemeManager
  IconData _getThemeIcon() {
    try {
      return MPThemeManager.instance.getThemeIcon();
    } catch (e) {
      debugPrint('Failed to get theme icon: $e');
      return Icons.settings_brightness; // Fallback
    }
  }

  /// Get current theme name from MPThemeManager
  String _getThemeName() {
    try {
      return MPThemeManager.instance.getThemeName();
    } catch (e) {
      debugPrint('Failed to get theme name: $e');
      return 'System'; // Fallback
    }
  }

  Widget _buildColorPalette(BuildContext context) {
    return Container(
      padding: MPResponsivePadding.card(context),
      decoration: BoxDecoration(
        color: context.mp.adaptiveBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mp.adaptiveBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText(
            'Primary Colors',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: context.mp.textColor,
            ),
            fontSize: 16,
          ),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          Wrap(
            spacing: MPResponsivePadding.getXs(context),
            runSpacing: MPResponsivePadding.getXs(context),
            children: [
              _buildColorSwatch(context, 'Primary', context.mp.primary),
              _buildColorSwatch(context, 'Surface', context.mp.primarySurface),
              _buildColorSwatch(context, 'Focus', context.mp.primaryFocus),
              _buildColorSwatch(context, 'Border', context.mp.primaryBorder),
              _buildColorSwatch(context, 'Hover', context.mp.primaryHover),
              _buildColorSwatch(context, 'Pressed', context.mp.primaryPressed),
            ],
          ),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          MPText(
            'Neutral Colors',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: context.mp.textColor,
            ),
            fontSize: 16,
          ),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          Wrap(
            spacing: MPResponsivePadding.getXs(context),
            runSpacing: MPResponsivePadding.getXs(context),
            children: [
              _buildColorSwatch(context, 'N10', context.mp.neutral10),
              _buildColorSwatch(context, 'N20', context.mp.neutral20),
              _buildColorSwatch(context, 'N30', context.mp.neutral30),
              _buildColorSwatch(context, 'N40', context.mp.neutral40),
              _buildColorSwatch(context, 'N50', context.mp.neutral50),
              _buildColorSwatch(context, 'N60', context.mp.neutral60),
              _buildColorSwatch(context, 'N70', context.mp.neutral70),
              _buildColorSwatch(context, 'N80', context.mp.neutral80),
              _buildColorSwatch(context, 'N90', context.mp.neutral90),
              _buildColorSwatch(context, 'N100', context.mp.neutral100),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorSwatch(BuildContext context, String label, Color color) {
    return Container(
      width: 80, // Fixed width for consistency
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.mp.adaptiveBorderColor),
      ),
      child: Center(
        child: MPText(
          label,
          style: TextStyle(
            color: _getContrastColor(color),
            fontWeight: FontWeight.w600,
          ),
          fontSize: 10,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildThemeSwitchingDemo(BuildContext context) {
    final currentThemeMode = _getCurrentThemeMode();

    return Container(
      padding: MPResponsivePadding.card(context),
      decoration: BoxDecoration(
        color: context.mp.adaptiveBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mp.adaptiveBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText(
            'Theme Switching Controls',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: context.mp.textColor,
            ),
            fontSize: 16,
          ),
          SizedBox(height: MPResponsivePadding.getSm(context)),

          // Theme Mode Buttons
          Wrap(
            spacing: MPResponsivePadding.getXs(context),
            runSpacing: MPResponsivePadding.getXs(context),
            alignment: WrapAlignment.spaceEvenly,
            children: [
              _buildThemeButton(
                context,
                'Light',
                Icons.light_mode,
                ThemeMode.light,
                currentThemeMode == ThemeMode.light,
                () => _setThemeMode(ThemeMode.light),
              ),
              _buildThemeButton(
                context,
                'Dark',
                Icons.dark_mode,
                ThemeMode.dark,
                currentThemeMode == ThemeMode.dark,
                () => _setThemeMode(ThemeMode.dark),
              ),
              _buildThemeButton(
                context,
                'System',
                Icons.settings_brightness,
                ThemeMode.system,
                currentThemeMode == ThemeMode.system,
                () => _setThemeMode(ThemeMode.system),
              ),
            ],
          ),

          SizedBox(height: MPResponsivePadding.getSm(context)),

          // Theme Preview
          Container(
            decoration: BoxDecoration(
              color: context.mp.adaptiveBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.mp.adaptiveBorderColor),
            ),
            child: IntrinsicHeight(
              // Use IntrinsicHeight for equal height
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Light Theme Preview
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.all(MPResponsivePadding.getXs(context)),
                      padding:
                          EdgeInsets.all(MPResponsivePadding.getSm(context)),
                      decoration: BoxDecoration(
                        color: MPColorTheme.light.neutral100 ??
                            const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: MPColorTheme.light.neutral40 ??
                                const Color(0xFFC9C9C9)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.light_mode,
                              color: MPColorTheme.light.primary ??
                                  const Color(0xFF303F9F)),
                          SizedBox(height: MPResponsivePadding.getXs(context)),
                          Text(
                            'Light',
                            style: TextStyle(
                              color: MPColorTheme.light
                                      .neutral10 ?? // Dark text on light background
                                  const Color(0xFF111827),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: MPResponsivePadding.getXs(context)),
                          MPButton(
                            text: 'Sample',
                            onPressed: () {},
                            size: MPButtonSize.small,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: MPResponsivePadding.getXs(context)),

                  // Dark Theme Preview
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.all(MPResponsivePadding.getXs(context)),
                      padding:
                          EdgeInsets.all(MPResponsivePadding.getSm(context)),
                      decoration: BoxDecoration(
                        color: MPColorTheme.dark.neutral20 ??
                            const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: MPColorTheme.dark.neutral40 ??
                                const Color(0xFF404040)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.dark_mode,
                              color: MPColorTheme.dark.neutral80 ??
                                  const Color(0xFFB8B8B8)),
                          SizedBox(height: MPResponsivePadding.getXs(context)),
                          Text(
                            'Dark',
                            style: TextStyle(
                              color: MPColorTheme.dark.neutral80 ??
                                  const Color(0xFFB8B8B8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: MPResponsivePadding.getXs(context)),
                          MPButton(
                            text: 'Sample',
                            onPressed: () {},
                            size: MPButtonSize.small,
                            variant: MPButtonVariant.outlined,
                            textColor: MPColorTheme.dark.neutral90 ??
                                const Color(
                                    0xFFE5E5E5), // Explicit color for static preview
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Get current theme mode from MPThemeManager
  ThemeMode _getCurrentThemeMode() {
    try {
      return MPThemeManager.instance.themeMode;
    } catch (e) {
      debugPrint('Failed to get theme mode: $e');
      return ThemeMode.system; // Fallback
    }
  }

  /// Set theme mode using MPThemeManager
  Future<void> _setThemeMode(ThemeMode mode) async {
    try {
      await MPThemeManager.instance.setThemeMode(mode);
    } catch (e) {
      debugPrint('Failed to set theme mode: $e');
    }
  }

  Widget _buildThemeButton(
    BuildContext context,
    String label,
    IconData icon,
    ThemeMode mode,
    bool isSelected,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? context.mp.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              isSelected ? context.mp.primary : context.mp.adaptiveBorderColor,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MPResponsivePadding.getMd(context),
                vertical: MPResponsivePadding.getSm(context)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? Colors.white // ✅ White on primary
                      : context.mp.textColor,
                  size: 18,
                ),
                SizedBox(width: MPResponsivePadding.getXs(context)),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white // ✅ White on primary
                        : context.mp.textColor,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComponentExamples(BuildContext context) {
    return Container(
      padding: MPResponsivePadding.card(context),
      decoration: BoxDecoration(
        color: context.mp.adaptiveBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mp.adaptiveBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText(
            'Component Examples',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: context.mp.textColor,
            ),
            fontSize: 16,
          ),
          SizedBox(height: MPResponsivePadding.getSm(context)),

          // Button Examples
          Row(
            children: [
              Expanded(
                child: MPButton(
                  text: 'Primary',
                  onPressed: () {},
                ),
              ),
              SizedBox(width: MPResponsivePadding.getXs(context)),
              Expanded(
                child: MPButton(
                  text: 'Outlined',
                  onPressed: () {},
                  variant: MPButtonVariant.outlined,
                ),
              ),
              SizedBox(width: MPResponsivePadding.getXs(context)),
              Expanded(
                child: MPButton(
                  text: 'Ghost',
                  onPressed: () {},
                  variant: MPButtonVariant.ghost,
                ),
              ),
            ],
          ),

          SizedBox(height: MPResponsivePadding.getSm(context)),

          // Text Field Examples
          MPTextField(
            TextEditingController(),
            label: 'Sample Text Field',
            hint: 'Enter text here...',
          ),

          SizedBox(height: MPResponsivePadding.getSm(context)),

          // Tab Examples
          Row(
            children: [
              Expanded(
                child: MPTabRounded(
                  title: 'Tab 1',
                  isActiveTab: true,
                  onTab: () {},
                ),
              ),
              SizedBox(width: MPResponsivePadding.getXs(context)),
              Expanded(
                child: MPTabRounded(
                  title: 'Tab 2',
                  isActiveTab: false,
                  onTab: () {},
                ),
              ),
              SizedBox(width: MPResponsivePadding.getXs(context)),
              Expanded(
                child: MPTabRounded(
                  title: 'Tab 3',
                  isActiveTab: false,
                  onTab: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
