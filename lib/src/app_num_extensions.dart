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
}
