import 'dart:io';

class FileUtils {
  static const double fileSizeLimited = 10;

  static double getFileSize(File file) {
    final sizeInBytes = file.lengthSync();
    final sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }
}
