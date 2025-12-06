import 'package:flutter/material.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit_example/pages/article_card_page.dart';
import 'package:micropack_ui_kit_example/pages/button_page.dart';

import 'package:micropack_ui_kit_example/pages/color_page.dart';
import 'package:micropack_ui_kit_example/pages/dialog_page.dart';
import 'package:micropack_ui_kit_example/pages/mp_card_page.dart';
import 'package:micropack_ui_kit_example/pages/responsive_page.dart';
import 'package:micropack_ui_kit_example/pages/tab_page.dart';
import 'package:micropack_ui_kit_example/pages/textfield_page.dart';
import 'package:micropack_ui_kit_example/pages/theme_showcase_page.dart';
import 'package:micropack_ui_kit_example/pages/theme_toggle_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/typography_page.dart';
import 'package:micropack_ui_kit_example/test_error_handling.dart';
import 'package:micropack_ui_kit_example/test_accessibility.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      appBar: AppBar(
        title: MPText.head(
          'Micropack UI Kit',
          style: TextStyle(color: context.mp.textColor),
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
        actions: [
          // Theme toggle button
          PopupMenuButton<ThemeMode>(
            icon: Icon(
              _getThemeIcon(),
              color: context.mp.textColor,
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<ThemeMode>(
                value: ThemeMode.light,
                child: Row(
                  children: [
                    Icon(Icons.light_mode,
                        size: 20, color: context.mp.textColor),
                    SizedBox(width: 8),
                    Text('Light',
                        style: TextStyle(color: context.mp.textColor)),
                  ],
                ),
              ),
              PopupMenuItem<ThemeMode>(
                value: ThemeMode.dark,
                child: Row(
                  children: [
                    Icon(Icons.dark_mode,
                        size: 20, color: context.mp.textColor),
                    SizedBox(width: 8),
                    Text('Dark', style: TextStyle(color: context.mp.textColor)),
                  ],
                ),
              ),
              PopupMenuItem<ThemeMode>(
                value: ThemeMode.system,
                child: Row(
                  children: [
                    Icon(Icons.settings_brightness,
                        size: 20, color: context.mp.textColor),
                    SizedBox(width: 8),
                    Text('System',
                        style: TextStyle(color: context.mp.textColor)),
                  ],
                ),
              ),
            ],
            onSelected: (ThemeMode mode) async {
              try {
                await MPThemeManager.instance.setThemeMode(mode);
              } catch (e) {
                debugPrint('Failed to set theme mode: $e');
              }
            },
          ),
        ],
      ),
      body: Container(
        color: context.mp.adaptiveBackgroundColor,
        child: ListView(
          padding: EdgeInsets.only(
            top: 16.h,
            left: 20.w,
            right: 20.w,
            bottom: 32.h,
          ),
          shrinkWrap: true,
          children: [
            // Theme info card
            _ThemeInfoCard(),

            const _SectionTitle(
              title: 'Assets',
            ),
            const _SectionTitle(
              title: 'Core',
            ),
            _Button(
              name: 'Colors',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ColorPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Color Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            const _Button(name: 'Typography', page: TypographyPage()),
            _Button(
              name: 'Responsive Design',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ResponsivePage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Responsive Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            const _SectionTitle(
              title: 'Theme',
            ),
            const _Button(name: 'Theme Showcase', page: ThemeShowcasePage()),
            const _Button(
                name: 'Theme Toggle Demo', page: ThemeToggleDemoPage()),
            const _SectionTitle(
              title: 'Components',
            ),
            const _Button(name: 'Button', page: ButtonPage()),
            const _Button(name: 'Dialog', page: DialogPage()),
            const _Button(name: 'Text Field', page: TextFieldPage()),
            const _Button(name: 'Article Card', page: ArticleCardPage()),
            const _Button(name: 'Card', page: MPCardPage()),
            const _Button(name: 'Tabs', page: TabPage()),
            const _SectionTitle(
              title: 'Testing',
            ),
            const _Button(
                name: 'Error Handling Demo', page: ErrorHandlingDemoPage()),
            const _Button(
                name: 'Accessibility Demo', page: AccessibilityTestPage()),
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
}

class _ThemeInfoCard extends StatelessWidget {
  const _ThemeInfoCard();

  @override
  Widget build(BuildContext context) {
    String themeName = 'System';
    String brightnessName = 'Light';
    IconData themeIcon = Icons.settings_brightness;

    try {
      final themeManager = MPThemeManager.instance;
      themeName = themeManager.getThemeName();
      themeIcon = themeManager.getThemeIcon();
      brightnessName = themeManager.getCurrentBrightnessName(context);
    } catch (e) {
      debugPrint('Failed to get theme info: $e');
    }

    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.mp.adaptiveBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.mp.adaptiveBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                themeIcon,
                color: context.mp.textColor,
                size: 24,
              ),
              SizedBox(width: 12.w),
              MPText(
                'Theme Information',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: context.mp.textColor,
                ),
                fontSize: 18,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          MPText(
            'Current Theme: $themeName',
            style: TextStyle(
              color: context.mp.subtitleColor,
            ),
            fontSize: 14,
          ),
          SizedBox(height: 4.h),
          MPText(
            'Brightness: $brightnessName',
            style: TextStyle(
              color: context.mp.subtitleColor,
            ),
            fontSize: 14,
          ),
          SizedBox(height: 12.h),
          MPText(
            'Tap theme icon in the app bar to switch between Light, Dark, and System themes.',
            style: TextStyle(
              color: context.mp.captionColor,
            ),
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: 30.h,
        ),
        child: MPText.head(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: context.mp.textColor,
          ),
          textAlign: TextAlign.start,
          fontSize: 24,
        ),
      );
}

class _Button extends StatelessWidget {
  const _Button({required this.name, this.page, this.onPressed});

  final String name;
  final Widget? page;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: 16.h,
        ),
        child: MPButton(
          text: name,
          onPressed: onPressed ??
              () async {
                if (page != null) {
                  try {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => page!),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to open $name Page: $e'),
                        backgroundColor: context.mp.errorColor,
                      ),
                    );
                  }
                }
              },
        ),
      );
}
