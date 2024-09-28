import 'package:collection/collection.dart';

/// A map from case-insensitive strings to values.
/// Much of HTTP is case-insensitive, so this is useful to have pre-defined.

class CaseInsensitiveMap<V> extends CanonicalizedMap<String, String, V> {
  /// Creates an empty case-insensitive map.
  CaseInsensitiveMap() : super(_canonicalize);

  /// Creates a case-insensitive map that is initialized with the key/value
  /// pairs of [other].

  /// CaseInsensitiveMap
  /// example
  ///  Map data = { 'SNO': '123'};
  ///  Map newMap = CaseInsensitiveMap.from(data);
  ///  print(newMap['SNO']) => it will print the value of SNO=> 123 ;
  ///  print(newMap['Sno']) => it will print the value of SNO=> 123;
  ///  print(newMap['sno']) => it will print the value of SNO=> 123;
  CaseInsensitiveMap.from(Map<String, V> other)
      : super.from(other, _canonicalize);

  static String _canonicalize(String key) => key.toLowerCase();

  /// snake_case
  /// example
  ///  Map data = { 'hello_world': '123'};
  ///  Map newMap = CaseInsensitiveMap.from(data);
  ///  print(newMap['hello_World']) => it will print the value of SNO=> 123 ;
  ///  print(newMap['HELLO_WORLD']) => it will print the value of SNO=> 123;
  ///  print(newMap['helloWorld']) => it will print the value of SNO=> 123;
  ///  print(newMap['HelloWorld']) => it will print the value of SNO=> 123;

  CaseInsensitiveMap.fromSnakeCase(Map<String, V> other)
      : super.from(other, _canonicalizeSnakeCase);

  static String _canonicalizeSnakeCase(String key) =>
      key.replaceAll('_', '').toLowerCase();

  /// param-case
  /// example
  ///  Map data = { 'hello-world': '123'};
  ///  Map newMap = CaseInsensitiveMap.from(data);
  ///  print(newMap['hello-World']) => it will print the value of SNO=> 123 ;
  ///  print(newMap['HELLO-WORLD']) => it will print the value of SNO=> 123;
  ///  print(newMap['helloWorld']) => it will print the value of SNO=> 123;
  ///  print(newMap['HelloWorld']) => it will print the value of SNO=> 123;
  CaseInsensitiveMap.fromParamCase(Map<String, V> other)
      : super.from(other, _canonicalizeParamCase);

  static String _canonicalizeParamCase(String key) =>
      key.replaceAll('-', '').toLowerCase();
}

extension ConvertMapToStringCookie on Map<String, dynamic> {
  String get convertToStringCookies =>
      entries.map((e) => '${e.key}=${e.value}').toList().join(';');

  Map<String, dynamic> get toCaseInsensitiveMap =>
      CaseInsensitiveMap.from(this);

  Map<String, dynamic> get toSnakeCaseInsensitiveMap =>
      CaseInsensitiveMap.fromSnakeCase(this);

  Map<String, dynamic> get toParamCaseInsensitiveMap =>
      CaseInsensitiveMap.fromParamCase(this);
}
