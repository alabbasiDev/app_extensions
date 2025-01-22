import 'package:path/path.dart' as path;

extension FilePathExtensions on String {
  String get getFileName => path.basename(this);

  // String get getFileDirectoryName => path.dirname(this);

  String getFileExtension([int level = 1]) => path.extension(this);
}
