// ignore_for_file: public_member_api_docs, parameter_assignments
// ignore_for_file: unnecessary_breaks, no_default_cases

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

Future<void> showMPDialog(
  BuildContext context, {
  /// [REQUIRED] Widget content or body of dialog
  required Widget child,

  /// Close dialog when tapping outside dialog area. Default is true
  bool barrierDismissible = true,

  /// Background color of dialog
  Color? background,

  /// Maximum height of dialog. Defaults to device height - 100
  double? maxHeight,

  /// Corner radius of dialog
  double? cornerRadius,

  /// Dialog elevation
  double? elevation,

  /// Dialog padding
  double? padding,
}) async {
  await showDialog<void>(
    context: context,
    builder: (context) {
      return MPDialogAnimated(
        background: background,
        maxHeight: maxHeight,
        elevation: elevation ?? 8.0,
        padding: padding,
        cornerRadius: cornerRadius ?? 16.0,
        child: child,
      );
    },
    barrierDismissible: barrierDismissible,
  );
}

Future<void> showMPAlertDialog(
  BuildContext context, {
  /// Content text
  required String? content,

  /// Text style for content
  MPTextStyle? contentStyle,

  /// Icon type: none, success, failed, warning, custom.
  /// Default is DialogIconType.none
  DialogIconType? iconType = DialogIconType.none,

  /// Custom icon used if iconType is DialogIconType.custom
  Widget? icon,

  /// Title text
  String? title,

  /// Text style for title
  MPTextStyle? titleStyle,

  /// Close dialog when tapping outside dialog area. Default is true
  bool barrierDismissible = true,

  /// Primary button text
  String? textPrimary,

  /// Action for primary button
  void Function()? onPrimary,

  /// Primary button background color
  Color? colorPrimary,

  /// Primary button text color
  Color? textColorPrimary,

  /// Primary button text size
  double? textSizePrimary,

  /// Secondary button text
  String? textSecondary,

  /// Action for secondary button
  void Function()? onSecondary,

  /// Secondary button background color
  Color? colorSecondary,

  /// Secondary button text color
  Color? textColorSecondary,

  /// Secondary button text size
  double? textSizeSecondary,

  /// Dialog background color
  Color? background,

  /// Dialog border color
  Color? borderColor,

  /// Dialog border width. Default is 2
  double borderWidth = 2,
}) async {
  icon = _getDialogIcon(icon, iconType);

  await showDialog<void>(
    context: context,
    builder: (context) {
      const double width = 420;

      return Builder(
        builder: (context) {
          final themeColors = context.mp;

          return MPDialogAnimated(
            // background: Colors.transparent,
            elevation: 0.0,
            child: SizedBox(
              width: width,
              child: Stack(
                children: [
                  Container(
                    width: width,
                    height: (width * 186) / 286,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor ?? themeColors.primary,
                        width: borderWidth,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  RotationTransition(
                    turns: const AlwaysStoppedAnimation(352 / 360),
                    child: Container(
                      width: width,
                      height: (width * 186) / 286,
                      decoration: ShapeDecoration(
                        color:
                            background ?? themeColors.adaptiveBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(24),
                    width: width,
                    height: (width * 186) / 286,
                    child: Material(
                      color: background ?? themeColors.adaptiveBackgroundColor,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: iconType != DialogIconType.none,
                              child: icon ?? const SizedBox(),
                            ),
                            const SizedBox(height: 16),
                            Visibility(
                              visible: title != null,
                              child: MPText.head(
                                title ?? '',
                                style: titleStyle?.toTextStyle(context) ??
                                    TextStyle(color: themeColors.textColor),
                              ),
                            ),
                            const SizedBox(height: 16),
                            MPText(
                              content ?? '',
                              style: contentStyle?.toTextStyle(context) ??
                                  TextStyle(color: themeColors.textColor),
                              maxLines: 4,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Visibility(
                                  visible: textSecondary != null &&
                                      onSecondary != null,
                                  child: Expanded(
                                    child: MPButton(
                                      text: '$textSecondary',
                                      textColor: textColorSecondary,
                                      strokeColor:
                                          colorSecondary ?? themeColors.primary,
                                      strokeWidth: 2,
                                      textSize: textSizeSecondary,
                                      background: themeColors.primarySurface,
                                      onPressed: onSecondary,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: (textPrimary != null &&
                                          onPrimary != null) &&
                                      (textSecondary != null &&
                                          onSecondary != null),
                                  child: const SizedBox(width: 16),
                                ),
                                Visibility(
                                  visible:
                                      textPrimary != null && onPrimary != null,
                                  child: Expanded(
                                    child: MPButton(
                                      text: '$textPrimary',
                                      textColor: textColorPrimary,
                                      textSize: textSizePrimary,
                                      background:
                                          colorPrimary ?? themeColors.primary,
                                      onPressed: onPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
              .animate(
                onPlay: (controller) => controller.repeat(reverse: true),
              )
              .shake(delay: 5000.ms);
        },
      );
    },
    barrierDismissible: barrierDismissible,
  );
}

enum DialogIconType { none, success, failed, warning, custom }

Widget? _getDialogIcon(Widget? icon, DialogIconType? iconType) {
  switch (iconType) {
    case DialogIconType.none:
      icon = null;
      break;
    case DialogIconType.success:
      icon = MpUiKit.iconSuccess;
      break;
    case DialogIconType.failed:
      icon = MpUiKit.iconFailed;
      break;
    case DialogIconType.warning:
      icon = MpUiKit.iconWarning;
      break;
    default:
      // For DialogIconType.custom or unknown, use the provided icon
      break;
  }
  return icon;
}
