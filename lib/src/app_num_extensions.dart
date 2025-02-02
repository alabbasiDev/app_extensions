import 'package:intl/intl.dart';

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
    if (this == null) {
      return null;
    }
    var formatter = NumberFormat('###,###,###');
    return formatter.format(this);
  }

  String amountWithCurrency(double amount, String currency,
          {int? decimalDigits}) =>
      NumberFormat.currency(
        name: currency,
        decimalDigits: decimalDigits,
      ).format(amount);

  static String formatDoubleNumberDecimal(double? v) {
    if (v == null) return '';
    NumberFormat formatter = NumberFormat();
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 2;
    return formatter.format(v);
  }
}
