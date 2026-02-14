import 'dart:convert';
import 'dart:typed_data';

import 'package:app_extensions/src/app_strings_extensions.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

/// Web implementation of [FilePathExtensions].
/// Base64 operations work fully. File system operations (encodeFileToBase64 for
/// paths, toBytes for paths, isValidFilePath) return null/false since web has
/// no file system access. decodeFileFromBase64 returns Uint8List instead of File.
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

  /// On web, file system access is not available. Returns null.
  Future<String?> get encodeFileToBase64 async {
    if (isBase64) {
      return this;
    }
    return null;
  }

  /// On web, File from dart:io is not available. Returns decoded bytes (Uint8List)
  /// instead so the content can be used with Blob, download, or display.
  Future<Object?> get decodeFileFromBase64 async {
    if (!isBase64) {
      return null;
    }
    return base64.decode(this);
  }

  Future<Uint8List?> get toBytes async {
    if (isNullOrEmpty) return null;
    if (isBase64) {
      return base64.decode(this);
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

  /// On web, file system access is not available. Returns false.
  Future<bool> get isValidFilePath async => false;
}
