import 'package:flutter/material.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit_example/pages/button_page.dart';

import 'package:micropack_ui_kit_example/pages/color_page.dart';
import 'package:micropack_ui_kit_example/pages/dialog_page.dart';
import 'package:micropack_ui_kit_example/pages/textfield_page.dart';
import 'package:micropack_ui_kit_example/pages/typography_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Micropack UI Kit'),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: 16.h,
          left: 20.w,
          right: 20.w,
          bottom: 32.h,
        ),
        shrinkWrap: true,
        children: const [
          _SectionTitle(
            title: 'Assets',
          ),
          _SectionTitle(
            title: 'Core',
          ),
          _Button(name: 'Colors', page: ColorPage()),
          _Button(name: 'Typography', page: TypographyPage()),
          _SectionTitle(
            title: 'Components',
          ),
          _Button(name: 'Button', page: ButtonPage()),
          _Button(name: 'Dialog', page: DialogPage()),
          _Button(name: 'Text Field', page: TextFieldPage()),
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
        child: FilledButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Text(name),
          // disabled: true,
        ),
      );
}
