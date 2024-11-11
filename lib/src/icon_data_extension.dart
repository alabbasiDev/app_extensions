
import 'dart:convert';

import 'package:flutter/material.dart';

extension IconDataExtension on IconData {
  String get toJSONString {
    Map<String, dynamic> map = <String, dynamic>{
      'codePoint': codePoint,
      'fontFamily': fontFamily,
      'fontPackage': fontPackage,
      'matchTextDirection': matchTextDirection,
    };

    return jsonEncode(map);
  }

  static IconData fromJsonString(String jsonString) {
    Map<String, dynamic> map = jsonDecode(jsonString);
    return IconData(
      map['codePoint'],
      fontFamily: map['fontFamily'],
      fontPackage: map['fontPackage'],
      matchTextDirection: map['matchTextDirection'],
    );
  }

  Map<String, dynamic> get toJson {
    return <String, dynamic>{
      'codePoint': codePoint,
      'fontFamily': fontFamily,
      'fontPackage': fontPackage,
      'matchTextDirection': matchTextDirection,
    };
  }

  static IconData fromJson(Map<String, dynamic> json) {
    return IconData(
      json['codePoint'],
      fontFamily: json['fontFamily'],
      fontPackage: json['fontPackage'],
      matchTextDirection: json['matchTextDirection'],
    );
  }
}