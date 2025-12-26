import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Typography',
          style: TextStyle(color: context.mp.textColor),
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MPResponsivePadding.card(context),
            child: MPText(
              MPTextStyle.defaultFontFamily,
              style: TextStyle(color: context.mp.textColor),
              fontSize: 16,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _textStyles(context).length,
              padding: MPResponsivePadding.card(context),
              itemBuilder: (context, index) => _textStyles(context)[index],
              separatorBuilder: (context, index) => Container(
                height: 1,
                margin: EdgeInsets.symmetric(vertical: MPResponsivePadding.getSm(context)),
                color: context.mp.adaptiveBorderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithTheme(String text, TextStyle style, double fontSize) {
    return Builder(
      builder: (context) => MPText(
        text,
        style: style.copyWith(
          color: context.mp.textColor,
        ),
        fontSize: fontSize,
      ),
    );
  }

  List<Widget> _textStyles(BuildContext context) => [
        _buildTextWithTheme('Title', MPTextStyle.title(), 24),
        _buildTextWithTheme('Heading1', MPTextStyle.heading1(), 34),
        _buildTextWithTheme('Heading2', MPTextStyle.heading2(), 27),
        _buildTextWithTheme('Heading3', MPTextStyle.heading3(), 21),
        _buildTextWithTheme('Body1', MPTextStyle.body1(), 17),
        _buildTextWithTheme('Body2', MPTextStyle.body2(), 14),
        _buildTextWithTheme('Caption', MPTextStyle.caption(), 11),
        _buildTextWithTheme('Overline', MPTextStyle.overline(), 8),
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
