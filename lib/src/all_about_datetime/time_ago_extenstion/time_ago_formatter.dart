import 'package:intl/intl.dart';

/// Formatter interface for "time ago" strings. Implement this to support
/// any language or custom format. Use [TimeAgoConfig.formatter] for a global
/// default, or pass explicitly via [DateTimeTimeAgoExtension.timeAgoWith].
abstract class TimeAgoFormatter {
  /// [count] is the number of years/months/weeks/days/hours/minutes/seconds.
  String yearsAgo(int count);
  String monthsAgo(int count);
  String weeksAgo(int count);
  String daysAgo(int count);
  String hoursAgo(int count);
  String minutesAgo(int count);
  String secondsAgo(int count);
  /// Shown for "now" or for differences below the seconds threshold.
  String get justNow;
}

/// English formatter. Uses short units: "2 h ago", "3 d ago", "just now".
class EnglishTimeAgoFormatter implements TimeAgoFormatter {
  const EnglishTimeAgoFormatter();

  @override
  String yearsAgo(int count) => '$count year${count == 1 ? '' : 's'} ago';

  @override
  String monthsAgo(int count) => '$count mo${count == 1 ? '' : 's'} ago';

  @override
  String weeksAgo(int count) => '$count week${count == 1 ? '' : 's'} ago';

  @override
  String daysAgo(int count) => '$count d${count == 1 ? '' : 's'} ago';

  @override
  String hoursAgo(int count) => '$count h${count == 1 ? '' : 's'} ago';

  @override
  String minutesAgo(int count) => '$count m${count == 1 ? '' : 's'} ago';

  @override
  String secondsAgo(int count) => '$count s ago';

  @override
  String get justNow => 'just now';
}

/// Arabic formatter (e.g. "منذ ساعتين", "الآن").
/// Uses Arabic plural rules: 0, 1, 2, 3–10, 11–99.
class ArabicTimeAgoFormatter implements TimeAgoFormatter {
  const ArabicTimeAgoFormatter();

  static String _pluralAr(
    int count,
    String one,
    String two,
    String few,
    String many,
  ) {
    if (count == 0) return one;
    if (count == 1) return one;
    if (count == 2) return two;
    if (count >= 3 && count <= 10) return few;
    return many;
  }

  @override
  String yearsAgo(int count) =>
      'منذ $count ${_pluralAr(count, 'سنة', 'سنتين', 'سنوات', 'سنة')}';

  @override
  String monthsAgo(int count) =>
      'منذ $count ${_pluralAr(count, 'شهر', 'شهرين', 'أشهر', 'شهر')}';

  @override
  String weeksAgo(int count) =>
      'منذ $count ${_pluralAr(count, 'أسبوع', 'أسبوعين', 'أسابيع', 'أسبوع')}';

  @override
  String daysAgo(int count) =>
      'منذ $count ${_pluralAr(count, 'يوم', 'يومين', 'أيام', 'يوم')}';

  @override
  String hoursAgo(int count) =>
      'منذ $count ${_pluralAr(count, 'ساعة', 'ساعتين', 'ساعات', 'ساعة')}';

  @override
  String minutesAgo(int count) =>
      'منذ $count ${_pluralAr(count, 'دقيقة', 'دقيقتين', 'دقائق', 'دقيقة')}';

  @override
  String secondsAgo(int count) =>
      'منذ $count ${_pluralAr(count, 'ثانية', 'ثانيتين', 'ثوانٍ', 'ثانية')}';

  @override
  String get justNow => 'الآن';
}

/// Global config for the default [TimeAgoFormatter].
/// The app can pass its own map of language code → formatter via [formatters];
/// otherwise the built-in [defaultFormattersByLang] is used.
class TimeAgoConfig {
  TimeAgoConfig._();

  static TimeAgoFormatter? _formatter;

  static Map<String, TimeAgoFormatter>? _formattersMap;

  /// Map of language code → formatter for the app’s supported locales.
  /// When set, this is used for [effective]; when null, [defaultFormattersByLang]
  /// is used. Include all locales your app supports
  /// (e.g. 'en', 'ar', 'fr').
  static Map<String, TimeAgoFormatter>? get formatters => _formattersMap;

  static set formatters(Map<String, TimeAgoFormatter>? value) {
    _formattersMap = value != null ? Map<String, TimeAgoFormatter>.from(value) : null;
  }

  /// Returns the current locale language code. When set, used by [effective] to
  /// pick the formatter from the formatters map. When null, uses
  /// `Intl.getCurrentLocale().split('_').first`. Set when the user changes
  /// language, e.g. `TimeAgoConfig.localeGetter = () => languageCode;`
  static String? Function()? localeGetter;

  /// Language codes from the active formatters map (app-provided or default).
  /// Use for a language picker or validation.
  static List<String> get supportedLanguageCodes =>
      _effectiveFormattersMap.keys.toList();

  /// Built-in formatters (en, ar). Used when [formatters] is null. Unmodifiable.
  static const Map<String, TimeAgoFormatter> defaultFormattersByLang = <String, TimeAgoFormatter>{
    'en': EnglishTimeAgoFormatter(),
    'ar': ArabicTimeAgoFormatter(),
  };

  static Map<String, TimeAgoFormatter> get _effectiveFormattersMap =>
      _formattersMap ?? defaultFormattersByLang;

  static TimeAgoFormatter? get formatter => _formatter;

  static set formatter(TimeAgoFormatter? value) {
    _formatter = value;
  }

  static String get _localeCode {
    final String? fromGetter = localeGetter?.call();
    if (fromGetter != null && fromGetter.isNotEmpty) return fromGetter;
    try {
      final String locale = Intl.getCurrentLocale();
      if (locale.isNotEmpty) return locale.split('_').first;
    } catch (_) { /* Intl not initialized or failed */ }
    return 'en';
  }

  static TimeAgoFormatter get effective {
    if (_formatter != null) return _formatter!;
    final Map<String, TimeAgoFormatter> map = _effectiveFormattersMap;
    if (map.isEmpty) return defaultFormattersByLang['en']!;
    final String code = _localeCode;
    return map[code] ?? map['en'] ?? map.values.first;
  }
}
