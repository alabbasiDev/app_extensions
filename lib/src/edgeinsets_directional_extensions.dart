import 'package:flutter/material.dart';

extension EdgeInsetsDirectionalExtension on EdgeInsetsDirectional {
  EdgeInsets resolveToEdgeInsets(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);
    return EdgeInsets.only(
      left: textDirection == TextDirection.ltr ? start : end,
      top: top,
      right: textDirection == TextDirection.ltr ? end : start,
      bottom: bottom,
    );
  }
}