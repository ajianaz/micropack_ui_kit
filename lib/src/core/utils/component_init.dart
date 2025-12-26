import 'package:flutter/material.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MPComponentInit extends StatelessWidget {
  const MPComponentInit({
    required this.builder,
    super.key,
    this.designSize,
  });

  final Widget Function(BuildContext context) builder;
  final Size? designSize;

  @override
  Widget build(BuildContext context) => MediaQuery(
        data: MediaQueryData.fromView(View.of(context)),
        child: LayoutBuilder(
          builder: (_, constraints) {
            if (constraints.maxWidth != 0) {
              return builder(context);
            }

            return nil;
          },
        ),
      );
}
