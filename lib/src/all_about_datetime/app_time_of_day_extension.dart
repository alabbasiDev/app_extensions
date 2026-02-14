import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  bool isBetween(TimeOfDay startTime, TimeOfDay endTime) {
    final timeInMinutes = hour * 60 + minute;
    final startInMinutes = startTime.hour * 60 + startTime.minute;
    final endInMinutes = endTime.hour * 60 + endTime.minute;
    return startInMinutes <= timeInMinutes && timeInMinutes <= endInMinutes;
  }

  String get to24hours {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}
