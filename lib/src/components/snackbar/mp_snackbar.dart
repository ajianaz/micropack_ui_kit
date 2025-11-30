import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// MPSnackbar - Theme-aware snackbar component
///
/// This component provides consistent theming for snackbars across light and dark modes.
/// It automatically adapts colors based on the current theme.
class MPSnackbar {
  /// Show a themed snackbar
  ///
  /// [context] - BuildContext for showing the snackbar
  /// [message] - Message text to display
  /// [backgroundColor] - Optional custom background color
  /// [textColor] - Optional custom text color
  /// [duration] - How long to show the snackbar
  /// [action] - Optional action button
  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Color? textColor,
    Duration? duration,
    SnackBarAction? action,
  }) {
    final themeColors = context.mp;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: textColor ?? themeColors.textColor,
          ),
        ),
        backgroundColor: backgroundColor ?? themeColors.adaptiveBackgroundColor,
        duration: duration ?? const Duration(seconds: 3),
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        elevation: 4,
      ),
    );
  }

  /// Show success snackbar
  static void success(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    final themeColors = context.mp;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: themeColors.neutral100,
              size: 20.r,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: themeColors.neutral100,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: themeColors.successColor,
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        elevation: 4,
      ),
    );
  }

  /// Show error snackbar
  static void error(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    final themeColors = context.mp;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error,
              color: themeColors.neutral100,
              size: 20.r,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: themeColors.neutral100,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: themeColors.errorColor,
        duration: duration ?? const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        elevation: 4,
      ),
    );
  }

  /// Show warning snackbar
  static void warning(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    final themeColors = context.mp;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.warning,
              color: themeColors.neutral100,
              size: 20.r,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: themeColors.neutral100,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: themeColors.warningColor,
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        elevation: 4,
      ),
    );
  }

  /// Show info snackbar
  static void info(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    final themeColors = context.mp;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.info,
              color: themeColors.neutral100,
              size: 20.r,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: themeColors.neutral100,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: themeColors.infoColor,
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        elevation: 4,
      ),
    );
  }
}
