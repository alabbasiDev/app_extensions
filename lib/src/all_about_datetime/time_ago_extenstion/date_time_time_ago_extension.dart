import 'time_ago_formatter.dart';

/// Thresholds used to choose the "time ago" unit. Values are in days or seconds.
abstract class TimeAgoThresholds {
  TimeAgoThresholds._();

  /// Minimum days to show years (e.g. 365).
  static const int daysPerYear = 365;

  /// Minimum days to show months (e.g. 30).
  static const int daysPerMonth = 30;

  /// Minimum days to show weeks (e.g. 7).
  static const int daysPerWeek = 7;

  /// Minimum days to show days (1).
  static const int oneDay = 1;

  /// Minimum seconds to show "X s ago" instead of "just now" (e.g. 3).
  static const int secondsForJustNow = 3;
}

extension DateTimeTimeAgoExtension on DateTime {
  /// Returns a human-readable "time ago" string using [TimeAgoConfig.effective]
  /// (from [TimeAgoConfig.formatters], [TimeAgoConfig.formatter], or locale).
  String get timeAgo => timeAgoWith(TimeAgoConfig.effective);

  /// Returns a "time ago" string using the given [formatter].
  /// Use this for a specific language or custom formatter.
  String timeAgoWith(TimeAgoFormatter formatter) =>
      timeAgoFrom(DateTime.now(), formatter);

  /// Same as [timeAgoWith] but uses [referenceNow] as "now". Useful for tests
  /// or when you have a fixed reference time.
  String timeAgoFrom(DateTime referenceNow, TimeAgoFormatter formatter) {
    final Duration difference = referenceNow.difference(this);
    if (difference.isNegative) return formatter.justNow;
    final int inDays = difference.inDays;
    if (inDays > TimeAgoThresholds.daysPerYear) {
      final int years = (inDays / TimeAgoThresholds.daysPerYear).floor();
      return formatter.yearsAgo(years);
    }
    if (inDays >= TimeAgoThresholds.daysPerMonth) {
      final int months = (inDays / TimeAgoThresholds.daysPerMonth).floor();
      return formatter.monthsAgo(months);
    }
    if (inDays >= TimeAgoThresholds.daysPerWeek) {
      final int weeks = (inDays / TimeAgoThresholds.daysPerWeek).floor();
      return formatter.weeksAgo(weeks);
    }
    if (inDays >= TimeAgoThresholds.oneDay) {
      return formatter.daysAgo(inDays);
    }
    if (difference.inHours >= 1) {
      return formatter.hoursAgo(difference.inHours);
    }
    if (difference.inMinutes >= 1) {
      return formatter.minutesAgo(difference.inMinutes);
    }
    if (difference.inSeconds >= TimeAgoThresholds.secondsForJustNow) {
      return formatter.secondsAgo(difference.inSeconds);
    }
    return formatter.justNow;
  }
}
