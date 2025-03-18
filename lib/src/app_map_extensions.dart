import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:app_extensions/app_extensions.dart';
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

extension MapExtension on Map<String, dynamic> {
  void get removeNullValues {
    removeWhere((key, value) {
      if (value is String) {
        return value.isNullOrEmpty;
      }
      if (value is List) {
        return value.isNullOrEmpty;
      }
      return value == null;
    });
  }
}

extension DeepSearchMap on Map<String, dynamic>? {
  // Helper function for key existence check
  bool deepContainsKey(String targetKey) {
    if (this == null || this!.isEmpty) return false;

    Map data = this!;
    if (data.containsKey(targetKey)) {
      return true;
    }
    for (final value in data.values) {
      // If the value is a map, check it recursively
      if (value.deepContainsKey(targetKey)) {
        return true;
      }
    }
    return false;
  }

  // Helper function for value retrieval
  dynamic deepSearchValue(String targetKey) {
    if (this == null) return null;
    Map data = this!;
    if (data.containsKey(targetKey)) {
      return data[targetKey];
    }
    for (final value in data.values) {
      // check it recursively
      if (value is Map<String, dynamic>) {
        final result = value.deepSearchValue(targetKey);
        if (result != null) return result;
      } else if (value is List<Map<String, dynamic>>) {
        final result = value.deepSearchValue(targetKey);
        if (result != null) return result;
      }
    }
    return null;
  }

  /// Returns the value of the first key found in [keysToSearch]
  dynamic firstKeyValueOrNull(List<String> keysToSearch) {
    for (final key in keysToSearch) {
      final value = deepSearchValue(key);
      if (value != null) return value;
    }
    return null;
  }
}

extension DeepSearchOnList on List<Map<String, dynamic>>? {
  // Helper function for key existence check
  bool deepContainsKey(String targetKey) {
    if (isNullOrEmpty) return false;

    List<Map<String, dynamic>> data = this!;
    for (final item in data) {
      if (item.deepContainsKey(targetKey)) {
        return true;
      }
    }

    return false;
  }

  // Helper function for value retrieval
  dynamic deepSearchValue(String targetKey) {
    if (this == null) return null;
    List<Map<String, dynamic>> data = this!;

    for (final Map<String, dynamic> item in data) {
      final result = item.deepSearchValue(targetKey);
      if (result != null) return result;
    }
    return null;
  }
}

typedef Condition = bool Function();

extension MapExtension2<K, V> on Map<K, V> {
  void addIf(Condition condition, K key, V value) {
    if (condition is bool && condition.call()) {
      this[key] = value;
    }
  }

  void addAllIf(Condition condition, Map<K, V> values) {
    if (condition is bool && condition.call()) addAll(values);
  }

  void assign(K key, V val) {
    clear();
    this[key] = val;
  }

  void assignAll(Map<K, V> val) {
    clear();
    addAll(val);
  }
}
