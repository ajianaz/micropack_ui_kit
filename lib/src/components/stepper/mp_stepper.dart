import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_helper.dart';
import 'package:micropack_ui_kit/src/components/button/mp_button.dart';

import 'mp_step.dart';

/// A stepper with adaptive theming
///
/// Follows theme rules:
/// - Active step uses primary color
/// - Completed step uses success color
/// - Error step uses error color
/// - Inactive step uses subtitle color
/// - Labels use semantic text colors
class MPStepper extends StatelessWidget {
  /// List of steps
  final List<MPStep> steps;

  /// Current step index
  final int currentStep;

  /// Stepper type
  final StepperType type;

  /// Callback when continue button pressed
  final VoidCallback? onContinue;

  /// Callback when cancel button pressed
  final VoidCallback? onCancel;

  /// Enable/disable controls
  final bool controlsEnabled;

  const MPStepper({
    super.key,
    required this.steps,
    required this.currentStep,
    this.type = StepperType.vertical,
    this.onContinue,
    this.onCancel,
    this.controlsEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.mp;

    return Stepper(
      type: type,
      currentStep: currentStep,
      onStepContinue: onContinue,
      onStepCancel: onCancel,
      controlsBuilder: (context, details) {
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: [
              if (currentStep < steps.length - 1)
                MPButton.primary(
                  text: 'Continue',
                  onPressed: details.onStepContinue,
                ),
              const SizedBox(width: 12),
              if (currentStep > 0)
                MPButton.outlined(
                  text: 'Back',
                  onPressed: details.onStepCancel,
                ),
            ],
          ),
        );
      },
      steps: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;

        return Step(
          title: DefaultTextStyle(
            style: TextStyle(
              color: theme.textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            child: step.title,
          ),
          subtitle: step.subtitle != null
              ? DefaultTextStyle(
                  style: TextStyle(
                    color: theme.subtitleColor,
                    fontSize: 14,
                  ),
                  child: step.subtitle!,
                )
              : null,
          content: step.content,
          state: _getStepState(index),
          isActive: index == currentStep,
        );
      }).toList(),
    );
  }

  StepState _getStepState(int index) {
    if (steps[index].isError) {
      return StepState.error;
    }
    if (index < currentStep) {
      return StepState.complete;
    }
    if (index == currentStep) {
      return StepState.editing;
    }
    return StepState.indexed;
  }
}
