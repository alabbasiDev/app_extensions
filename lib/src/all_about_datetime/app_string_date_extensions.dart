import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../app_extensions.dart';

extension AppStringDateExtensions on String? {
  DateTime? toDateTime({intl.DateFormat? format}) {
    if (isNullOrEmpty) {
      return null;
    }
    if (format != null) {
      return format.parse(this!);
    }
    return DateTime.tryParse(this!);
  }

  TimeOfDay? get toTimeOfDay {
    if (isNullOrEmpty) {
      return null;
    }

    List<String> parts = this!.split(':');
    if (parts.length < 2) {
      return null;
    }

    int? hour = int.tryParse(parts[0]);
    int? minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) {
      return null;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  DateTime? get fixToDateTime {
    if (isNullOrEmpty) {
      return null;
    }
    return FixedDateTimeFormatter('YYYYMMDD').decode(this!);
  }

  TimeOfDay? from12hTo24hTimeOfDay({String locale = 'en'}) {
    if (isNullOrEmpty) return null;
    final normalized = this!.replaceAll(' ', '').toUpperCase();
    assert(
      normalized.contains('AM') || normalized.contains('PM'),
      'must contain AM or PM',
    );
    final pattern = normalized.split(':').length == 3 ? "hh:mm:ssa" : "hh:mma";
    final dateTime = intl.DateFormat(pattern, locale).parse(normalized);
    return TimeOfDay.fromDateTime(dateTime);
  }
}
