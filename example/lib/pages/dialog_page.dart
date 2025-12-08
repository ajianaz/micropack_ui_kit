import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Dialog',
          style: TextStyle(color: context.mp.textColor),
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: MPResponsivePadding.card(context),
            child: MPButton(
              text: 'Alert Dialog',
              onPressed: () async {
                return showMPAlertDialog(
                  context,
                  content: 'Alert Message',
                  iconType: DialogIconType.success,
                );
              },
            ),
          ),
          Padding(
            padding: MPResponsivePadding.card(context),
            child: MPButton(
              text: 'Dialog Message',
              onPressed: () async {
                return showMPDialog(
                  context,
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.accessibleIcon,
                        color: context.mp.textColor,
                      ),
                      MPText.subhead(
                        'Custom Dialog',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
