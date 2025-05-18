import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Typography'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Text(
              MPTextStyle.defaultFontFamily,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _textStyles.length,
              padding: EdgeInsets.all(20.r),
              itemBuilder: (context, index) => _textStyles[index],
              separatorBuilder: (context, index) => Container(
                height: 1,
                margin: EdgeInsets.symmetric(vertical: 16.h),
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static final _textStyles = [
    MPText(
      'Title',
      style: MPTextStyle.title(),
    ),
    MPText(
      'Heading1',
      style: MPTextStyle.heading1(),
    ),
    MPText(
      'Heading2',
      style: MPTextStyle.heading2(),
    ),
    MPText(
      'Heading3',
      style: MPTextStyle.heading3(),
    ),
    MPText(
      'Body1',
      style: MPTextStyle.body1(),
    ),
    MPText(
      'Body2',
      style: MPTextStyle.body2(),
    ),
    MPText(
      'Caption',
      style: MPTextStyle.caption(),
    ),
    MPText(
      'Overline',
      style: MPTextStyle.overline(),
    ),
    MPText.head(
      'Head',
    ),
    MPText.subhead(
      'Subhead',
    ),
    const MPText('Default'),
    MPText.label(
      'Label',
    ),
    MPText.body(
      'Body',
    ),
    MPText.small(
      'Small',
    ),
  ];
}
