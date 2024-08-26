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
            child: const Text(
            'MONTSERRAT',
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
    SelectableText('Title',
    style: MPTextStyle.title(),),
    SelectableText('Heading1',
    style: MPTextStyle.heading1(),),
    SelectableText('Heading2',
    style: MPTextStyle.heading2(),),
    SelectableText('Heading3',
    style: MPTextStyle.heading3(),),
    SelectableText('Body1',
    style: MPTextStyle.body1(),),
    SelectableText('Body2',
    style: MPTextStyle.body2(),),
    SelectableText('Caption',
    style: MPTextStyle.caption(),),
    SelectableText('Overline',
    style: MPTextStyle.overline(),),
    
  ];
}
