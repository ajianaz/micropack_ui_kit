import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MPButton extends StatelessWidget {
  const MPButton({
    required this.label,
    required this.onpressed,
    super.key,
    this.size = MPButtonSize.small,
    this.variant = MPButtonVariant.primary,
    this.enabled = true,
  });

  final String label;

  final Future Function() onpressed;

  final MPButtonSize size;

  final MPButtonVariant variant;

  final bool enabled;

  @override
  Widget build(BuildContext context) => Text(label);
}
