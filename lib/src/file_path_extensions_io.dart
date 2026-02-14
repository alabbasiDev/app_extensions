import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_extensions/src/app_strings_extensions.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

extension FilePathExtensions on String {
  bool get isBase64 {
    if (isNullOrEmpty) return false;
    try {
      base64.decode(this);
      return true;
    } on FormatException {
      return false;
    }
  }

  String? getFileName({bool addUniqueTimeStampIfNull = false}) {
    if (isBase64) {
      return addUniqueTimeStampIfNull
          ? DateTime.now().millisecondsSinceEpoch.toString()
          : null;
    }
    return path.basename(this);
  }

  String? getFileExtension([int level = 1]) {
    if (isBase64) {
      return extensionFromMime(getFileMimeType ?? '');
    }
    return path.extension(this, level);
  }

  Future<String?> get encodeFileToBase64 async {
    if (isBase64) {
      return this;
    }
    if (await isValidFilePath == false) {
      return null;
    }
    final Uint8List bytes = await File(this).readAsBytes();
    return base64Encode(bytes);
  }

  Future<File?> get decodeFileFromBase64 async {
    if (!isBase64) {
      return null;
    }
    final Uint8List bytes = base64.decode(this);
    return File.fromRawPath(bytes);
  }

  Future<Uint8List?> get toBytes async {
    if (isNullOrEmpty) return null;
    if (isBase64) {
      return base64.decode(this);
    }
    if (await isValidFilePath) {
      return File(this).readAsBytesSync();
    }
    return null;
  }

  String? get getFileMimeType {
    if (isBase64) {
      final Uint8List bytes = base64.decode(this);
      return lookupMimeType('', headerBytes: bytes);
    }
    return lookupMimeType(this);
  }

  Future<bool> get isValidFilePath async {
    try {
      final file = File(this);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }
}
