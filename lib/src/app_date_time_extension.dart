import 'dart:io';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;

const String apiTimeOfDayFormat = intl.DateFormat.HOUR24_MINUTE_SECOND;

extension AppDateTimeExtension on DateTime? {
  String get locale => intl.Intl.getCurrentLocale().split('_').first;

  String? showFormattedDate({
    bool withTime = false,
    bool onlyTime = false,
    bool onlyDay = false,
    bool onlyYearAndMonth = false,
    bool onlyTimeWithAMPM = false,
    bool dateWithDayName = false,
    String? localeCod,
    String? separator = '/',
  }) {
    if (this == null) {
      return null;
    }
    if (onlyTime) {
      return intl.DateFormat('hh:mm', localeCod ?? locale).format(this!);
    }

    if (onlyTimeWithAMPM) {
      return intl.DateFormat('hh:mm a', localeCod ?? locale).format(this!);
    }

    if (withTime) {
      return intl.DateFormat(
              'hh:mm a  dd $separator MM $separator yyyy', localeCod ?? locale)
          .format(this!);
    }

    if (dateWithDayName) {
      return intl.DateFormat(
              'EE $separator dd MMM $separator yyyy', localeCod ?? locale)
          .format(this!);
    }

    if (onlyDay) {
      return intl.DateFormat('dd', localeCod ?? locale).format(this!);
    }

    if (onlyYearAndMonth) {
      return intl.DateFormat('MMMM $separator yyyy', localeCod ?? locale)
          .format(this!);
    }

    return intl.DateFormat(
      'dd $separator MMM $separator yyyy',
      localeCod ?? locale,
    ).format(this!);
  }

  String? get formattedDateTimeToApi {
    if (this == null) {
      return null;
    }
    return intl.DateFormat(apiTimeOfDayFormat).format(this!);
  }

  String? get formattedTimeToApi {
    if (this == null) {
      return null;
    }
    return intl.DateFormat(apiTimeOfDayFormat).format(this!);
  }

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
    return intl.DateFormat.EEEE(locale).format(this!);
  }

  static List<String> get allWeekDays =>
      intl.DateFormat.EEEE(Platform.localeName).dateSymbols.STANDALONEWEEKDAYS;

  bool isCurrentDateInRange(DateTimeRange dateTimeRange) {
    final currentDate = DateTime.now();
    return currentDate.isAfter(dateTimeRange.start) &&
        currentDate.isBefore(dateTimeRange.end);
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

  String get toDateYMDHMA {
    var date = intl.DateFormat("yyyy-MM-dd h:mm a", "en").format(this);
    return date;
  }

  String get toDateYMD {
    var date = intl.DateFormat("yyyy-MM-dd", "en").format(this);
    return date;
  }

  String get toDateMMyy {
    var date = intl.DateFormat("yy/MM", "en").format(this);
    return date;
  }

  String get toTimeHMS {
    var date = intl.DateFormat("HH:mm:ss", "en").format(this);
    return date;
  }

  String get toTimeHMA {
    var date = intl.DateFormat("h:mm a", "en").format(this);
    return date;
  }

  String toTimeHMALocal(String local) =>
      intl.DateFormat("h:mm a", local).format(this);

  String toDateyMMMMEEEEd(String local) =>
      intl.DateFormat("yMMMMEEEEd", local).format(this);

  String toDateMMMMEEEEd(String local) =>
      intl.DateFormat("MMMMEEEEd", local).format(this);

  String toDatedMMMMy(String local) =>
      intl.DateFormat("d MMMM y", local).format(this);

  String toDateddMMyyyy(String local) =>
      intl.DateFormat("ddMMyyyy", local).format(this);

  String toDateMMddyyyy(String local) =>
      intl.DateFormat("MMddyyyy", local).format(this);

  String toDateyMMMMd(String local) =>
      intl.DateFormat("MMMMd", local).format(this);
}
