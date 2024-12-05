import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: MPButton(text: 'Save', onPressed: () async {}),
      ),
    );
  }
}
