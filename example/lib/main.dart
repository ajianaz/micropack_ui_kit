import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import 'package:micropack_ui_kit_example/app.dart';
import 'package:micropack_ui_kit_example/contanta.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MPTextStyle.defaultFontFamily = defaultFontFamily;
  runApp(const App());
}
