import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.r),
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
            padding: EdgeInsets.all(20.r),
            child: MPButton(
              text: 'Dialog Message',
              onPressed: () async {
                return showMPDialog(
                  context,
                  child: Column(
                    children: [
                      const Icon(FontAwesomeIcons.accessibleIcon),
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
