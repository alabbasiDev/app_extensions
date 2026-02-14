import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

extension AppDateTimeExtension on DateTime? {

  TimeOfDay? get toTimeOfDay {
    if (this == null) {
      return null;
    }
    return TimeOfDay.fromDateTime(this!);
  }

  String? get getDayName {
    if (this == null) {
      return null;
    }
    return intl.DateFormat.EEEE('en').format(this!);
  }
  String? getDayNameWithLocale({required String locale}) {
    if (this == null) {
      return null;
    }
    return intl.DateFormat.EEEE(locale).format(this!);
  }

  static List<String> get allWeekDays =>
      intl.DateFormat.EEEE(_localeName).dateSymbols.STANDALONEWEEKDAYS;

  static String get _localeName {
    final locale = PlatformDispatcher.instance.locale;
    final countryCode = locale.countryCode;
    return countryCode != null && countryCode.isNotEmpty
        ? '${locale.languageCode}_$countryCode'
        : locale.languageCode;
  }

  bool isDateInRange(DateTimeRange dateTimeRange, {DateTime? dateTime}) {
    final dateWantToCheck = dateTime ?? DateTime.now();
    return dateWantToCheck.isAfter(dateTimeRange.start) &&
        dateWantToCheck.isBefore(dateTimeRange.end);
  }

  int? compareTimeOnlyHoursAndMinutes(DateTime time2) {
    if (this == null) {
      return null;
    }

    // Extract the hours and minutes from the two DateTime objects.
    DateTime time1 = this!;
    int hour1 = time1.hour;
    int minute1 = time1.minute;
    int hour2 = time2.hour;
    int minute2 = time2.minute;

    // Get the difference between the two hours and minutes.
    int differenceInHoursAndMinutes =
        (hour1 * 60) + minute1 - (hour2 * 60) - minute2;

    // If the difference is positive, then time1 is after time2.
    if (differenceInHoursAndMinutes > 0) {
      return 1;
    }

    // If the difference is negative, then time1 is before time2.
    if (differenceInHoursAndMinutes < 0) {
      return -1;
    }

    // If the two DateTime objects are equal, then return 0.
    return 0;
  }

// String? get showTimeAgo {
//   // final jiffy =;
//   // String timeAgo = Jiffy(dateTime).fromNow();
//   if (this == null) {
//     return null;
//   }
//   String locale;
//   if (Get.locale?.languageCode == 'ar') {
//     locale = 'ar_short';
//     time_ago.setLocaleMessages(
//       'ar_short',
//       AppArShortMessages(),
//     );
//   } else {
//     locale = 'en_short';
//     time_ago.setLocaleMessages(
//       'en_short',
//       AppEnShortMessages(),
//     );
//   }
//   String timeAgo = time_ago.format(
//     this!,
//     locale: locale,
//   );
//   return timeAgo;
// }
}

extension DateExtension on DateTime {
  String get toDateYMDHMS {
    var date = intl.DateFormat("yyyy-MM-dd HH:mm:ss", "en").format(this);
    return date;
  }

  String toDateYMDHMSWithLocale({required String locale}) =>
      intl.DateFormat("yyyy-MM-dd HH:mm:ss", locale).format(this);

  String get toDateYMDHMA {
    var date = intl.DateFormat("yyyy-MM-dd h:mm a", "en").format(this);
    return date;
  }

  String toDateYMDHMAWithLocale({required String locale}) =>
      intl.DateFormat("yyyy-MM-dd h:mm a", locale).format(this);

  String get toDateYMD {
    var date = intl.DateFormat("yyyy-MM-dd", "en").format(this);
    return date;
  }

  String toDateYMDWithLocale({required String locale}) =>
      intl.DateFormat("yyyy-MM-dd", locale).format(this);

  String get toDateMMyy {
    var date = intl.DateFormat("yy/MM", "en").format(this);
    return date;
  }

  String toDateMMyyWithLocale({required String locale}) =>
      intl.DateFormat("yy/MM", locale).format(this);

  String get toTimeHMS {
    var date = intl.DateFormat("HH:mm:ss", "en").format(this);
    return date;
  }

  String toTimeHMSWithLocale({required String locale}) =>
      intl.DateFormat("HH:mm:ss", locale).format(this);

  String get toTimeHMA {
    var date = intl.DateFormat("h:mm a", "en").format(this);
    return date;
  }

  String toTimeHMAWithLocale({required String locale}) =>
      intl.DateFormat("h:mm a", locale).format(this);

  String toDateyMMMMEEEEdWithLocale({required String locale}) =>
      intl.DateFormat("yMMMMEEEEd", locale).format(this);

  String toDateMMMMEEEEdWithLocale({required String locale}) =>
      intl.DateFormat("MMMMEEEEd", locale).format(this);

  String toDatedMMMMyWithLocale({required String locale}) =>
      intl.DateFormat("d MMMM y", locale).format(this);

  String toDateddMMyyyyWithLocale({required String locale}) =>
      intl.DateFormat("ddMMyyyy", locale).format(this);

  String toDateMMddyyyyWithLocale({required String locale}) =>
      intl.DateFormat("MMddyyyy", locale).format(this);

  String toDateyMMMMdWithLocale({required String locale}) =>
      intl.DateFormat("MMMMd", locale).format(this);
}
