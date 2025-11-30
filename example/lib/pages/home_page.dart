import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit_example/pages/article_card_page.dart';
import 'package:micropack_ui_kit_example/pages/button_page.dart';

import 'package:micropack_ui_kit_example/pages/color_page.dart';
import 'package:micropack_ui_kit_example/pages/dialog_page.dart';
import 'package:micropack_ui_kit_example/pages/textfield_page.dart';
import 'package:micropack_ui_kit_example/pages/theme_showcase_page.dart';
import 'package:micropack_ui_kit_example/pages/typography_page.dart';
import 'package:micropack_ui_kit_example/pages/tab_page.dart';
import 'package:micropack_ui_kit_example/providers/theme_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Micropack UI Kit',
              style: TextStyle(color: context.mp.textColor),
            ),
            backgroundColor: context.mp.adaptiveBackgroundColor,
            elevation: 0,
            actions: [
              // Theme toggle button
              PopupMenuButton<ThemeMode>(
                icon: Icon(
                  themeProvider.getThemeIcon(),
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
                        Text('Dark',
                            style: TextStyle(color: context.mp.textColor)),
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
                onSelected: (ThemeMode mode) {
                  themeProvider.setTheme(mode);
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
                _ThemeInfoCard(themeProvider: themeProvider),

                const _SectionTitle(
                  title: 'Assets',
                ),
                const _SectionTitle(
                  title: 'Core',
                ),
                const _Button(name: 'Colors', page: ColorPage()),
                const _Button(name: 'Typography', page: TypographyPage()),
                const _SectionTitle(
                  title: 'Theme',
                ),
                const _Button(
                    name: 'Theme Showcase', page: ThemeShowcasePage()),
                const _SectionTitle(
                  title: 'Components',
                ),
                const _Button(name: 'Button', page: ButtonPage()),
                const _Button(name: 'Dialog', page: DialogPage()),
                const _Button(name: 'Text Field', page: TextFieldPage()),
                const _Button(name: 'Article Card', page: ArticleCardPage()),
                const _Button(name: 'Tabs', page: TabPage()),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ThemeInfoCard extends StatelessWidget {
  const _ThemeInfoCard({required this.themeProvider});

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
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
                themeProvider.getThemeIcon(),
                color: context.mp.textColor,
                size: 24,
              ),
              SizedBox(width: 12.w),
              Text(
                'Theme Information',
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
            'Current Theme: ${themeProvider.getThemeName()}',
            style: TextStyle(
              fontSize: 14.sp,
              color: context.mp.subtitleColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Brightness: ${themeProvider.getCurrentBrightnessName(context)}',
            style: TextStyle(
              fontSize: 14.sp,
              color: context.mp.subtitleColor,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Tap the theme icon in the app bar to switch between Light, Dark, and System themes.',
            style: TextStyle(
              fontSize: 12.sp,
              color: context.mp.captionColor,
            ),
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
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: context.mp.textColor,
          ),
          textAlign: TextAlign.start,
        ),
      );
}

class _Button extends StatelessWidget {
  const _Button({required this.name, required this.page});

  final String name;
  final Widget page;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: 16.h,
        ),
        child: MPButton(
          text: name,
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => page),
            );
          },
        ),
      );
}
