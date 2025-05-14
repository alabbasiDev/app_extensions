import 'package:intl/intl.dart';
import 'dart:math';

extension NumExtension on num? {
  //converts number to short form like 1K, 1M, 1B, etc.
  String? get toShortForm {
    if (this == null) {
      return null;
    }

    var f = NumberFormat.compact(locale: "en_US");
    return f.format(this);
  }

  String? get formatNumbersWithSeparators {
    if (this == null) return null;

    var formatter = NumberFormat('###,###,###');
    return formatter.format(this);
  }

  String? amountWithCurrency({required String currency, int? decimalDigits}) {
    if (this == null) return null;
    return NumberFormat.currency(
      name: currency,
      decimalDigits: decimalDigits,
    ).format(this);
  }

  String? get formatDoubleNumberDecimal {
    if (this == null) return null;
    double? value = this?.toDouble();
    NumberFormat formatter = NumberFormat();
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 2;
    return formatter.format(value);
  }

  // Usage:
  // print(formatBytesWithFractions(768)); //=> 768 B
  // print(formatBytesWithFractions(768, precision: 1)); //=> 768.0 B
  String formatBytesWithFractions({int precision = 2}) {
    int bytes = this?.toInt() ?? 0;

    if (bytes <= 0) return "0 B";
    const units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    double value = bytes.toDouble();
    int unitIndex = 0;

    while (value >= 1024 && unitIndex < units.length - 1) {
      value /= 1024;
      unitIndex++;
    }

    // Handle B with decimal places
    if (unitIndex == 0 && precision > 0) {
      return '${bytes.toStringAsFixed(precision)} B';
    }

    String formattedNumber = value
        .toStringAsFixed(precision)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');

    return '$formattedNumber ${units[unitIndex]}';
  }

}
