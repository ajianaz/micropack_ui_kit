// ignore_for_file: must_be_immutable, public_member_api_docs

import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MPDialog extends StatefulWidget {
  MPDialog({
    required this.child,
    super.key,
    this.maxHeight,
    this.background,
    this.elevation,
    this.padding,
    this.cornerRadius,
  });
  final Widget child;

  double? maxHeight;
  Color? background;
  double? elevation;
  double? padding;
  double? cornerRadius;

  @override
  State<StatefulWidget> createState() => MPDialogState();
}

class MPDialogState extends State<MPDialog> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceWidth = MediaQuery.of(context).size.width;
        var width = MediaQuery.of(context).size.width;
        if (deviceWidth > MpUiKit.limitMediumLargeScreen) {
          width = 600;
        } else if (deviceWidth > MpUiKit.limitSmallMediumScreen) {
          width = 600;
        } else {
          width = width - 40;
        }

        final deviceHeight = MediaQuery.of(context).size.height;

        return Center(
          child: Container(
            margin: MediaQuery.of(context).viewInsets,
            constraints: BoxConstraints(
              maxWidth: width,
              minHeight: 10,
              maxHeight: widget.maxHeight ?? deviceHeight - 100,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.cornerRadius ?? 16),
              ),
              elevation: widget.elevation,
              color: widget.background ?? context.mp.adaptiveBackgroundColor,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(widget.padding ?? 16.0),
                        child: widget.child,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
