import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:math';

extension AppStringsExtention on String? {
  String get locale => intl.Intl.getCurrentLocale().split('_').first;

  bool get isNullOrEmpty => this == null || this?.trim().isEmpty == true;

  bool get isNotNullOrEmpty => this != null && this!.trim().isNotEmpty;

  Future<void> copyToClipBoard(String message) async {
    if (isNullOrEmpty) return;
    await Clipboard.setData(ClipboardData(text: this!));
    message.toastMessage();
  }

  toastMessage({
    Color? backgroundColor,
    Color? textColor,
    ToastGravity? gravity,
    double? fontSize,
    Toast? toastLength,
  }) {
    if (isNullOrEmpty) return;
    Fluttertoast.showToast(
      msg: this!,
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: backgroundColor ?? Colors.black,
      textColor: textColor ?? Colors.white,
      fontSize: fontSize ?? 16.0,
    );
  }

  DateTime? get toDateTime {
    if (isNullOrEmpty) {
      return null;
    }

    return DateTime.tryParse(this!);
  }

  //region Date and Time
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

  DateTime? get fixToDateTime {
    if (isNullOrEmpty) {
      return null;
    }
    return FixedDateTimeFormatter('YYYYMMDD').decode(this!);
  }

  TimeOfDay? get from12hTo24hTimeOfDay {
    if (isNotNullOrEmpty) {
      assert(
          this!.contains('AM') ||
              this!.contains('am') ||
              this!.contains('PM') ||
              this!.contains('pm'),
          'must contain AM or PM');
      bool withSeconds = this!.split(':').length == 3;

      DateTime date2 = intl.DateFormat(withSeconds ? "hh:mm:ssa" : "hh:mma")
          .parse(this!
              .replaceAll(' ', '')
              .replaceAll('am', 'AM')
              .replaceAll('pm', 'PM'));
      // return TimeOfDay.fromDateTime(intl.DateFormat("HH:mm").format(date2));
      return TimeOfDay.fromDateTime(date2);
    }
    return null;
  }

  // String? get timeOfDayToApi => isNullOrEmpty ? null : '$this:00';

  //endregion

  //region text direction
  TextDirection get getTextDirection {
    bool isRtl;
    if (this != null) {
      isRtl = intl.Bidi.detectRtlDirectionality(this!);
    } else {
      isRtl = intl.Bidi.isRtlLanguage(
        locale /*Localizations.localeOf(Get.context!).languageCode*/,
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
      isRtl = intl.Bidi.isRtlLanguage(locale
          // Localizations.localeOf(Get.context!).languageCode,
          );
    }
    return !isRtl ? TextDirection.rtl : TextDirection.ltr;
  }

  //endregion

  //region Color
  Color? get toColor {
    try {
      if (isNullOrEmpty || !isHexColor) {
        return null;
      }

      // Remove all '#' characters
      String hex = this!.replaceAll('#', '');

      // Handle shorthand formats (3 or 4 characters)
      if (hex.length == 3 || hex.length == 4) {
        hex = hex.split('').map((char) => char + char).join();
      }

      // Add alpha channel if missing (6 characters → 8 with FF alpha)
      if (hex.length == 6) {
        hex = 'FF$hex';
      }

      // Parse hex to integer and create Color
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      if (kDebugMode) {
        print('====> Error in converting string toColor $e <===');
      }
      return null;
    }
  }

  bool get isHexColor {
    if (isNullOrEmpty) {
      return false;
    }

    final trimmedInput = this!.trim();

    // Regular expression to validate hex color formats:
    // - Optional # followed by 3, 4, 6, or 8 hex digits
    final hexColorRegex = RegExp(
      r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$',
    );

    return hexColorRegex.hasMatch(trimmedInput);
  }

  //endregion

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
      return true;
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

  String? addImageBaseUrl(String baseUrl) {
    // logger.d(this);
    if (isNullOrEmpty) {
      return null;
    }

    if (this!.startsWith('http') || this!.startsWith('https')) {
      return this;
    }

    String imageBaseUrl = baseUrl.trim().endsWith('/')
        ? baseUrl.trim().substring(0, baseUrl.length - 1).trim()
        : baseUrl.trim();

    String imagePath = this!.trim();

    if (imagePath.startsWith('/')) {
      imagePath = imagePath.substring(1);
    }

    final String encodedUrl = Uri.encodeFull('$imageBaseUrl/$imagePath');
    // logger.d(encodedUrl);

    return encodedUrl;
  }

  // Usage:
  // print(parseFormattedBytes('2.5 GB')); //=>  2684354560
  int get parseFormattedBytes {

    if (isNullOrEmpty) return 0;

    String formattedString = this!.trim();
    final regExp = RegExp(r'^([\d.]+)\s?([A-Za-z]+)$');
    final match = regExp.firstMatch(formattedString);

    if (match == null) return 0;

    final value = double.parse(match.group(1)!);
    final unit = match.group(2)!.toUpperCase();

    const units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    final exponent = units.indexOf(unit);

    if (exponent == -1) return 0;

    return (value * pow(1024, exponent)).round();
  }
}
