import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Field'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.r),
            child: MPTextField(
              TextEditingController(),
              label: 'Text Field Sample 1',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: MPTextField.border(
              TextEditingController(),
              label: 'Text Field Sample Border',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: MPTextField.password(
              TextEditingController(),
              label: 'Text Field Password',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: MPTextField.borderPassword(
              TextEditingController(),
              label: 'Text Field Password Border',
            ),
          ),
        ],
      ),
    );
  }
}
