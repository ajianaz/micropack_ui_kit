import 'package:flutter/material.dart';

/// Step definition for MPStepper
class MPStep {
  /// Step title
  final Widget title;

  /// Step subtitle (optional)
  final Widget? subtitle;

  /// Step content
  final Widget content;

  /// Optional leading widget (replaces step number)
  final Widget? leading;

  /// Whether step is in error state
  final bool isError;

  const MPStep({
    required this.title,
    this.subtitle,
    required this.content,
    this.leading,
    this.isError = false,
  });
}
