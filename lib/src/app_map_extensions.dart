import 'package:collection/collection.dart';


/// A map from case-insensitive strings to values.
/// Much of HTTP is case-insensitive, so this is useful to have pre-defined.
/// example
///  Map data = { 'SNO': '123'};
///  Map newMap = CaseInsensitiveMap.from(data);
///  print(newMap['SNO']) => it will print the value of SNO=> 123 ;
///  print(newMap['Sno']) => it will print the value of SNO=> 123;
///  print(newMap['sno']) => it will print the value of SNO=> 123;
class CaseInsensitiveMap<V> extends CanonicalizedMap<String, String, V> {
  CaseInsensitiveMap() : super((key) => key.toLowerCase());

  CaseInsensitiveMap.from(Map<String, V> other)
      : super.from(other, (key) => key.toLowerCase());
}

extension ConvertMapToStringCookie on Map<String, dynamic> {
  String get convertToStringCookies =>
      entries.map((e) => '${e.key}=${e.value}').toList().join(';');

  Map<String, dynamic> get toCaseInsensitiveMap =>
      CaseInsensitiveMap.from(this);
}
