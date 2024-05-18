import 'dart:io';

import 'package:path/path.dart' as path;

String findProjectRoot(String directory) {
  if (File(path.join(directory, 'pubspec.yaml')).existsSync()) {
    return directory;
  } else {
    final parentDirectory = path.dirname(directory);
    return findProjectRoot(parentDirectory);
  }
}
