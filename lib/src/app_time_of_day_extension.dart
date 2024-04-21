import 'package:flutter/material.dart';



extension TimeOfDayExtension on TimeOfDay {
  // int compareTo(TimeOfDay meetingDate) {
  //   print('tapBookTime => $hour:$minute');
  //   print('appBook => ${meetingDate.hour}:${meetingDate.minute}');
  //   if (hour < meetingDate.hour) return -1;
  //   if (hour > meetingDate.hour) return 1;
  //   if (minute < meetingDate.minute) return -1;
  //   if (minute > meetingDate.minute) return 1;
  //   return 0;
  // }

  bool isBetween(TimeOfDay startTime, TimeOfDay endTime) {
    int shopOpenTimeInSeconds = startTime.hour * 60 + startTime.minute;
    int shopCloseTimeInSeconds = endTime.hour * 60 + endTime.minute;
    int timeNowInSeconds = hour * 60 + minute;

    if (shopOpenTimeInSeconds <= timeNowInSeconds &&
        timeNowInSeconds <= shopCloseTimeInSeconds) {
      // OPEN; IS BETWEEN startTime(opening time) and endTime(closingTime)
      return true;
    } else {
      // CLOSED; IS NOT BETWEEN startTime(opening time) and endTime(closingTime)
      return false;
    }
  }

  String get to24hours {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}
