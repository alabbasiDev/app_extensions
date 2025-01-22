import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_extensions/src/app_strings_extensions.dart';
import 'package:path/path.dart' as path;

extension FilePathExtensions on String {
  bool get isBase64 {
    if (isNullOrEmpty) {
      return false;
    }
    try {
      base64.decode(this);
      return true;
    } on FormatException {
      return false;
    }
  }

  String get getFileName => path.basename(this);

  // String get getFileDirectoryName => path.dirname(this);

  String getFileExtension([int level = 1]) => path.extension(this);

  Future<String> get encodeFileToBase64 async {
    final Uint8List bytes = await File(this).readAsBytes();
    return base64Encode(bytes);
  }

  Future<File?> get decodeFileFromBase64 async {
    if (!isBase64) {
      return null;
    }
    Uint8List bytes = base64.decode(this);
    return File.fromRawPath(bytes);
  }
}
