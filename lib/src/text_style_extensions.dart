import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle? {
  TextStyle? get withBoldFont => this?.copyWith(fontWeight: FontWeight.bold);
}
