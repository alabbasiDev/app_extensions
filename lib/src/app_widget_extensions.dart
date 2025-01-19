import 'package:flutter/widgets.dart';

/// add Padding Property to widget
extension WidgetPaddingX on Widget {
  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: this);

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
          padding: EdgeInsets.only(
              top: top, left: left, right: right, bottom: bottom),
          child: this);


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
  Widget get paddingZero => Padding(padding: EdgeInsets.zero, child: this);
}

/// Add margin property to widget
extension WidgetMarginX on Widget {
  Widget marginAll(double margin) =>
      Container(margin: EdgeInsets.all(margin), child: this);

  Widget marginSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Container(
          margin:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: this);

  Widget marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Container(
          margin: EdgeInsets.only(
              top: top, left: left, right: right, bottom: bottom),
          child: this);

  Widget get marginZero => Container(margin: EdgeInsets.zero, child: this);
}

/// Allows you to insert widgets inside a CustomScrollView
extension WidgetSliverBoxX on Widget {
  Widget get sliverBox => SliverToBoxAdapter(child: this);
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