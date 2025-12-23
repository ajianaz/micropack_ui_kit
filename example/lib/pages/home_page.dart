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
import 'package:micropack_ui_kit_example/pages/mp_error_handling_page.dart';
import 'package:micropack_ui_kit_example/pages/mp_accessibility_page.dart';
import 'package:micropack_ui_kit_example/pages/form_components_page.dart';
import 'package:micropack_ui_kit_example/pages/toast_page.dart';
import 'package:micropack_ui_kit_example/pages/avatar_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/divider_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/empty_state_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/list_tile_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/bottom_sheet_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/navigation_rail_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/app_bar_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/platform_adaptive_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/badge_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/switch_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/chip_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/progress_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/dropdown_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/tooltip_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/checkbox_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/snackbar_demo_page.dart';
import 'package:micropack_ui_kit_example/pages/skeleton_demo_page.dart';
import 'package:micropack_ui_kit_example/test_performance.dart';

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
            surfaceTintColor: Colors.transparent,
            color: context.mp.cardColor,
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
          padding: MPResponsivePadding.page(context),
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
            const _Button(
                name: 'Form Components',
                page: FormComponentsPage()),
            const _Button(name: 'Toast', page: ToastPage()),
            const _SectionTitle(
              title: 'Feedback & Display',
            ),
            _Button(
              name: 'Avatar Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const AvatarDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Avatar Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'List Tile Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ListTileDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open List Tile Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'Divider Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const DividerDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Divider Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'Empty State Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const EmptyStateDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Empty State Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            const _SectionTitle(
              title: 'Form Components',
            ),
            _Button(
              name: 'Badge Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const BadgeDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Badge Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'Switch Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SwitchDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Switch Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'Chip Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ChipDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Chip Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'Progress Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ProgressDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Progress Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'Dropdown Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const DropdownDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Dropdown Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'Tooltip Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const TooltipDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Tooltip Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'Checkbox Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const CheckboxDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Checkbox Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'Snackbar Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SnackbarDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Snackbar Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'Skeleton Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SkeletonDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Skeleton Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            const _SectionTitle(
              title: 'Navigation',
            ),
            _Button(
              name: 'Bottom Sheet Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const BottomSheetDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Bottom Sheet Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            const _SectionTitle(
              title: 'Navigation',
            ),
            _Button(
              name: 'Navigation Rail Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const NavigationRailDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Navigation Rail Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'App Bar Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const AppBarDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open App Bar Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            _Button(
              name: 'Platform Adaptive Demo',
              onPressed: () async {
                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const PlatformAdaptiveDemoPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open Platform Adaptive Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              },
            ),
            const _SectionTitle(
              title: 'Testing',
            ),
            const _Button(
                name: 'Error Handling Demo', page: MPErrorHandlingPage()),
            const _Button(
                name: 'Accessibility Demo', page: MPAccessibilityPage()),
            const _Button(
                name: 'Performance Testing', page: TestPerformancePage()),
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
      margin: EdgeInsets.only(
        bottom: MPResponsivePadding.getLg(context),
        left: MPResponsivePadding.getXs(context),
        right: MPResponsivePadding.getXs(context),
      ),
      padding: MPResponsivePadding.card(context),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(
          MPResponsive.isMobile(context) ? 12 : 16,
        ),
        border: Border.all(
          color: context.mp.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: context.mp.adaptiveShadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(MPResponsivePadding.getSm(context)),
                decoration: BoxDecoration(
                  color: context.mp.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  themeIcon,
                  color: context.mp.primary,
                  size: MPResponsive.isMobile(context) ? 20 : 24,
                ),
              ),
              SizedBox(width: MPResponsivePadding.getMd(context)),
              Expanded(
                child: MPText(
                  'Theme Information',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.mp.textColor,
                  ),
                  fontSize: MPResponsive.isMobile(context) ? 16 : 18,
                ),
              ),
            ],
          ),
          SizedBox(height: MPResponsivePadding.getMd(context)),
          _buildInfoRow(
            context,
            'Current Theme',
            themeName,
            Icons.palette_outlined,
          ),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          _buildInfoRow(
            context,
            'Brightness',
            brightnessName,
            Icons.brightness_6_outlined,
          ),
          SizedBox(height: MPResponsivePadding.getMd(context)),
          Container(
            padding: EdgeInsets.all(MPResponsivePadding.getSm(context)),
            decoration: BoxDecoration(
              color: context.mp.adaptiveBackgroundColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: context.mp.captionColor,
                ),
                SizedBox(width: MPResponsivePadding.getSm(context)),
                Expanded(
                  child: MPText(
                    'Tap the theme icon in the app bar to switch between Light, Dark, and System themes.',
                    style: TextStyle(
                      color: context.mp.captionColor,
                    ),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: context.mp.subtitleColor,
        ),
        SizedBox(width: MPResponsivePadding.getSm(context)),
        MPText(
          '$label: ',
          style: TextStyle(
            color: context.mp.subtitleColor,
            fontWeight: FontWeight.w500,
          ),
          fontSize: 14,
        ),
        MPText(
          value,
          style: TextStyle(
            color: context.mp.textColor,
            fontWeight: FontWeight.w600,
          ),
          fontSize: 14,
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: MPResponsivePadding.getLg(context),
          bottom: MPResponsivePadding.getSm(context),
          left: MPResponsivePadding.getXs(context),
          right: MPResponsivePadding.getXs(context),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: MPResponsive.isMobile(context) ? 20 : 24,
              decoration: BoxDecoration(
                color: context.mp.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: MPResponsivePadding.getSm(context)),
            MPText.head(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: context.mp.textColor,
              ),
              textAlign: TextAlign.start,
              fontSize: MPResponsive.isMobile(context) ? 20 : 24,
            ),
          ],
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
          top: MPResponsivePadding.getSm(context),
          left: MPResponsivePadding.getXs(context),
          right: MPResponsivePadding.getXs(context),
        ),
        child: MPButton(
          text: name,
          variant: MPButtonVariant.outlined,
          onPressed: onPressed ?? () async {
            if (page != null) {
              try {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => page!),
                );
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open $name Page: $e'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                }
              }
            }
          },
        ),
      );
}
