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
        title: Text(
          'Theme Showcase',
          style: TextStyle(color: context.mp.textColor),
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText.head('Theme System Overview'),
            SizedBox(height: 16.h),

            // Theme Info Card
            Container(
              margin: EdgeInsets.only(bottom: 24.h),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: context.mp.primarySurface,
                borderRadius: BorderRadius.circular(12.r),
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
                      SizedBox(width: 12.w),
                      Text(
                        'Current Theme: ${_getThemeName()}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: context.mp.textColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Brightness: ${context.mp.isDarkMode ? 'Dark' : 'Light'}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.mp.subtitleColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Theme persistence is ${_getThemeName() == 'System' ? 'following system settings' : 'manually selected'}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.mp.captionColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            MPText.head('Color Palette'),
            SizedBox(height: 16.h),

            // Color Palette Grid
            _buildColorPalette(context),

            SizedBox(height: 24.h),
            MPText.head('Theme Switching Demo'),
            SizedBox(height: 16.h),

            // Theme Switching Demo
            _buildThemeSwitchingDemo(context),

            SizedBox(height: 24.h),
            MPText.head('Component Examples'),
            SizedBox(height: 16.h),

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
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.mp.adaptiveBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.mp.adaptiveBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Primary Colors',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: context.mp.textColor,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _buildColorSwatch(context, 'Primary', context.mp.primary),
              _buildColorSwatch(context, 'Surface', context.mp.primarySurface),
              _buildColorSwatch(context, 'Focus', context.mp.primaryFocus),
              _buildColorSwatch(context, 'Border', context.mp.primaryBorder),
              _buildColorSwatch(context, 'Hover', context.mp.primaryHover),
              _buildColorSwatch(context, 'Pressed', context.mp.primaryPressed),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Neutral Colors',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: context.mp.textColor,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
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
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.mp.adaptiveBorderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: _getContrastColor(color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSwitchingDemo(BuildContext context) {
    final currentThemeMode = _getCurrentThemeMode();

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.mp.adaptiveBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.mp.adaptiveBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme Switching Controls',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: context.mp.textColor,
            ),
          ),
          SizedBox(height: 16.h),

          // Theme Mode Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

          SizedBox(height: 16.h),

          // Theme Preview
          Container(
            height: 120.h,
            decoration: BoxDecoration(
              color: context.mp.adaptiveBackgroundColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: context.mp.adaptiveBorderColor),
            ),
            child: Row(
              children: [
                // Light Theme Preview
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8.r),
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: MPColorTheme.light.neutral100 ??
                          const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(6.r),
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
                        SizedBox(height: 4.h),
                        Text(
                          'Light',
                          style: TextStyle(
                            color: MPColorTheme.light.neutral20 ??
                                const Color(0xFF303F9F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        MPButton(
                          text: 'Sample',
                          onPressed: () {},
                          size: MPButtonSize.small,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 8.w),

                // Dark Theme Preview
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8.r),
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: MPColorTheme.dark.neutral20 ??
                          const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(6.r),
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
                        SizedBox(height: 4.h),
                        Text(
                          'Dark',
                          style: TextStyle(
                            color: MPColorTheme.dark.neutral80 ??
                                const Color(0xFFB8B8B8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        MPButton(
                          text: 'Sample',
                          onPressed: () {},
                          size: MPButtonSize.small,
                          variant: MPButtonVariant.outlined,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
        borderRadius: BorderRadius.circular(8.r),
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
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color:
                      isSelected ? context.mp.neutral100 : context.mp.textColor,
                  size: 18,
                ),
                SizedBox(width: 8.w),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? context.mp.neutral100
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
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.mp.adaptiveBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.mp.adaptiveBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Component Examples',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: context.mp.textColor,
            ),
          ),
          SizedBox(height: 16.h),

          // Button Examples
          Row(
            children: [
              Expanded(
                child: MPButton(
                  text: 'Primary',
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: MPButton(
                  text: 'Outlined',
                  onPressed: () {},
                  variant: MPButtonVariant.outlined,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: MPButton(
                  text: 'Ghost',
                  onPressed: () {},
                  variant: MPButtonVariant.ghost,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Text Field Examples
          MPTextField(
            TextEditingController(),
            label: 'Sample Text Field',
            hint: 'Enter text here...',
          ),

          SizedBox(height: 16.h),

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
              SizedBox(width: 8.w),
              Expanded(
                child: MPTabRounded(
                  title: 'Tab 2',
                  isActiveTab: false,
                  onTab: () {},
                ),
              ),
              SizedBox(width: 8.w),
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
