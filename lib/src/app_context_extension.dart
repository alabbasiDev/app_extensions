import 'package:flutter/material.dart';

extension AppContextExtension on BuildContext {
  get removeFocusFromInputField {
    FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
