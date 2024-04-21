import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'app_date_time_extension.dart';

extension AppStringsExtention on String? {

  String get locale => intl.Intl.getCurrentLocale().split('_').first;

  bool get isNullOrEmpty => this == null || this?.isEmpty == true;

  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  bool get isBase64 {
    if (isNullOrEmpty) {
      return false;
    }
    try {
      base64.decode(this!);
      return true;
    } on FormatException {
      return false;
    }
  }

// bool isNullEmptyOrFalse() => this == null || this == '' || !this;

// bool isNullEmptyZeroOrFalse() =>
//     this == null || this == '' || !this || this == 0;

  DateTime? get parseTimeFromStringToDateTime {
    if (isNullOrEmpty) {
      return null;
    } else {
      DateTime dateTime =
          intl.DateFormat(apiTimeOfDayFormat, 'en').parse(this!);
      return dateTime;
    }
  }

  TimeOfDay? get toTimeOfDay {
    if (isNotNullOrEmpty) {
      return TimeOfDay.fromDateTime(
        parseTimeFromStringToDateTime!,
      );
    }
    return null;
  }

  String? get timeOfDayToApi => isNullOrEmpty ? null : '$this:00';

  Color? get toColor {
    if (isNullOrEmpty) {
      return null;
    }

    var hexColor = this!.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }

    return Color(int.parse("0x$hexColor"));
  }

  TextDirection get getTextDirection {
    bool isRtl;
    if (this != null) {
      isRtl = intl.Bidi.detectRtlDirectionality(this!);
    } else {
      isRtl = intl.Bidi.isRtlLanguage(
        locale
        /*Localizations.localeOf(Get.context!).languageCode*/,
      );
    }
    // if (opposite) {
    //   return !isRtl ? TextDirection.rtl : TextDirection.ltr;
    // }
    return isRtl ? TextDirection.rtl : TextDirection.ltr;
  }

  TextDirection get getOppositeTextDirection {
    bool isRtl;
    if (this != null) {
      isRtl = intl.Bidi.detectRtlDirectionality(this!);
    } else {
      isRtl = intl.Bidi.isRtlLanguage(
          locale
        // Localizations.localeOf(Get.context!).languageCode,
      );
    }
    return !isRtl ? TextDirection.rtl : TextDirection.ltr;
  }

  bool get isHex {
    if (isNullOrEmpty) {
      return false;
    }
    // check if this regex = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$";
    // /^#?([a-f0-9]{6}|[a-f0-9]{3})$/
    return RegExp(r'^[0-9a-fA-F]+$').hasMatch(this!);
  }

  String? get flagEmoji {
    if (isNullOrEmpty) {
      return null;
    }
    const base = 127397;

    String? str = this;
    if (str!.length > 2) {
      str = str.substring(0, str.length - 1);
    }

    return str
        .toUpperCase()
        .codeUnits
        .map((e) => String.fromCharCode(base + e))
        .toList()
        .reduce((value, element) => value + element)
        .toString()
        .trim()
        .replaceAll('D', '');
  }
}
