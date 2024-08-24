import 'package:flutter/material.dart';


/// add Padding Property to widget
extension WidgetPaddingX on Widget {
  Widget paddingDirection({
    double? start,
    double? end,
    double? bottom,
    double? top,
  }) =>
      Padding(
        padding: EdgeInsetsDirectional.only(
          start: start ?? 0.0,
          end: end ?? 0.0,
          bottom: bottom ?? 0.0,
          top: top ?? 0.0,
        ),
        child: this,
      );
}



extension ListSpaceBetweenExtension on List<Widget> {
  List<Widget> withSpaceBetween({
    double? width,
    double? height,
    bool includeAfterLast = false,
    bool includeBeforFirst = false,
  }) =>
      [
        for (int i = 0; i < length; i++) ...[
          if (i == 0 && includeBeforFirst)
            SizedBox(
              // color: Colors.red,
              width: width,
              height: height,
            ),
          if (i > 0)
            SizedBox(
              // color: Colors.red,
              width: width,
              height: height,
            ),
          this[i],
          if (includeAfterLast && i == length - 1)
            SizedBox(
              // color: Colors.red,
              width: width,
              height: height,
            ),
        ],
      ];
}
