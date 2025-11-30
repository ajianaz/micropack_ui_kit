import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Typography',
          style: TextStyle(color: context.mp.textColor),
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Text(
              MPTextStyle.defaultFontFamily,
              style: TextStyle(color: context.mp.textColor),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _textStyles(context).length,
              padding: EdgeInsets.all(20.r),
              itemBuilder: (context, index) => _textStyles(context)[index],
              separatorBuilder: (context, index) => Container(
                height: 1,
                margin: EdgeInsets.symmetric(vertical: 16.h),
                color: context.mp.adaptiveBorderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithTheme(String text, TextStyle style) {
    return Builder(
      builder: (context) => MPText(
        text,
        style: style.copyWith(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.95)
              : Colors.black.withOpacity(0.87),
        ),
      ),
    );
  }

  List<Widget> _textStyles(BuildContext context) => [
        _buildTextWithTheme('Title', MPTextStyle.title()),
        _buildTextWithTheme('Heading1', MPTextStyle.heading1()),
        _buildTextWithTheme('Heading2', MPTextStyle.heading2()),
        _buildTextWithTheme('Heading3', MPTextStyle.heading3()),
        _buildTextWithTheme('Body1', MPTextStyle.body1()),
        _buildTextWithTheme('Body2', MPTextStyle.body2()),
        _buildTextWithTheme('Caption', MPTextStyle.caption()),
        _buildTextWithTheme('Overline', MPTextStyle.overline()),
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
