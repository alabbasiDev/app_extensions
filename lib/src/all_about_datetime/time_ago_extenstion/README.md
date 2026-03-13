# Time Ago Extension

Human-readable “time ago” strings for `DateTime` (e.g. “2 h ago”, “just now”).

## Import

```dart
import 'package:app_extensions/app_extensions.dart';
```

## Basic usage

Call the extension on any `DateTime`:

```dart
final DateTime postedAt = DateTime.now().subtract(const Duration(hours: 2));
print(postedAt.timeAgo);  // e.g. "2 h ago"

final DateTime justNow = DateTime.now();
print(justNow.timeAgo);    // "just now"
```

The default formatter is chosen by **locale** (via `Intl.getCurrentLocale()`) or falls back to English.

## With a specific formatter

Use `timeAgoWith()` when you want a fixed language or custom formatter:

```dart
// English
print(postedAt.timeAgoWith(const EnglishTimeAgoFormatter()));  // "2 h ago"

// Arabic
print(postedAt.timeAgoWith(const ArabicTimeAgoFormatter()));   // e.g. "منذ ساعتين"
```

## App-provided formatters map

Pass your app’s supported languages as a **map** of language code → formatter. When set, this map is used for [effective]; when null, the built-in `defaultFormattersByLang` (en, ar) is used.

```dart
// At app startup (e.g. main or after locale is known)
TimeAgoConfig.formatters = <String, TimeAgoFormatter>{
  'en': const EnglishTimeAgoFormatter(),
  'ar': const ArabicTimeAgoFormatter(),
  // Add any other locales your app supports:
  // 'fr': const FrenchTimeAgoFormatter(),
};

// Use localeGetter so .timeAgo follows the app language
TimeAgoConfig.localeGetter = () => 'ar';
print(postedAt.timeAgo);  // "منذ ساعتين"

TimeAgoConfig.localeGetter = () => 'en';
print(postedAt.timeAgo);  // "2 h ago"
```

- `**TimeAgoConfig.formatters**` — Set to your map of language code → `TimeAgoFormatter`. Use your app’s supported locales only.
- `**TimeAgoConfig.supportedLanguageCodes**` — List of codes from the active map (your map if set, else default). Use for a language picker.
- **`TimeAgoConfig.localeGetter`** — When set, returns the current language code so [effective] picks the right formatter. Set it when the user changes language.

Example: when the user changes language, update the getter:’s getter:

```dart
void onLanguageChanged(String languageCode) {
  TimeAgoConfig.localeGetter = () => languageCode;
}
```

## Global default (single formatter)

Set a global formatter so all `.timeAgo` calls use it:

```dart
TimeAgoConfig.formatter = const ArabicTimeAgoFormatter();
```

Or provide a locale getter (e.g. from your app’s locale):

```dart
TimeAgoConfig.localeGetter = () => 'ar';
```

When [formatters] is null, `TimeAgoConfig.defaultFormattersByLang` is used (`en`, `ar`). Set [formatters] to your own map to use only your app’s supported locales.

## Custom formatter

Implement `TimeAgoFormatter` and pass it to `timeAgoWith()` or set `TimeAgoConfig.formatter`:

```dart
class MyTimeAgoFormatter implements TimeAgoFormatter {
  const MyTimeAgoFormatter();
  @override String yearsAgo(int count) => '$count year(s) ago';
  @override String monthsAgo(int count) => '$count month(s) ago';
  @override String weeksAgo(int count) => '$count week(s) ago';
  @override String daysAgo(int count) => '$count day(s) ago';
  @override String hoursAgo(int count) => '$count hour(s) ago';
  @override String minutesAgo(int count) => '$count min(s) ago';
  @override String secondsAgo(int count) => '$count sec ago';
  @override String get justNow => 'now';
}

// Usage
print(someDate.timeAgoWith(const MyTimeAgoFormatter()));
```

## Ranges and thresholds

Unit thresholds are in `TimeAgoThresholds` (e.g. `daysPerYear`, `secondsForJustNow`) for tests or custom logic.


| Difference  | Example (English) |
| ----------- | ----------------- |
| < 3 seconds | just now          |
| 3+ seconds  | 5 s ago           |
| 1+ minutes  | 2 m ago           |
| 1+ hours    | 2 h ago           |
| 1+ days     | 3 d ago           |
| 7+ days     | 2 weeks ago       |
| 30+ days    | 2 mo ago          |
| 365+ days   | 1 year ago        |


Future dates (difference is negative) are shown as "just now".

## Testing

Use `timeAgoFrom(referenceNow, formatter)` so results are deterministic:

```dart
final ref = DateTime(2025, 1, 15, 12, 0);
final post = DateTime(2025, 1, 15, 10, 0);
post.timeAgoFrom(ref, const EnglishTimeAgoFormatter()); // "2 h ago"
```

