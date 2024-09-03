import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:html_unescape/html_unescape.dart';
import 'package:convert/convert.dart';
// import 'package:collection/collection.dart';

extension AppStringsExtention on String? {

  String get locale =>
      intl.Intl
          .getCurrentLocale()
          .split('_')
          .first;

  bool get isNullOrEmpty => this == null || this?.trim().isEmpty == true;

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

  // DateTime? get parseTimeFromStringToDateTime {
  //   if (isNullOrEmpty) {
  //     return null;
  //   } else {
  //     DateTime dateTime =
  //     intl.DateFormat(apiTimeOfDayFormat, 'en').parse(this!);
  //     return dateTime;
  //   }
  // }

  // //TODO remove and palce it with 
  // TimeOfDay? get toTimeOfDay {
  //   if (isNotNullOrEmpty) {
  //     return TimeOfDay.fromDateTime(
  //       parseTimeFromStringToDateTime!,
  //     );
  //   }
  //   return null;
  // }

  TimeOfDay? get from12hTo24hTimeOfDay {
    if (isNotNullOrEmpty) {
      assert(this!.contains('AM') ||this!.contains('am') ||this!.contains('PM') ||this!.contains('pm'), 'must contain AM or PM');
      bool withSeconds = this!.split(':').length == 3;

      DateTime date2 = intl.DateFormat(withSeconds ? "hh:mm:ssa" : "hh:mma")
          .parse(this!.replaceAll(' ', '')
          .replaceAll('am', 'AM').replaceAll('pm', 'PM')
      );
      // return TimeOfDay.fromDateTime(intl.DateFormat("HH:mm").format(date2));
      return TimeOfDay.fromDateTime(date2);
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


  bool get isJsonString {
    try {
      if (isNullOrEmpty) {
        return false;
      }
      var data = json.decode(this ?? '');
      if (data is Map) {
        return true;
      }
      return false;
    } on FormatException catch (_) {
      // logger.e(error.message);
      return false;
    }
  }

  String? get plain {
    if (isNullOrEmpty) {
      return null;
    }
    var unescape = HtmlUnescape();
    return unescape.convert(this!);
    //return date;
  }

  DateTime? get fixToDateTime {
    if (isNullOrEmpty) {
      return null;
    }
    return FixedDateTimeFormatter('YYYYMMDD').decode(this!);
  }

}
