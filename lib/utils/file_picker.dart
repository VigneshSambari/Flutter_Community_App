import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:sessions/constants.dart';

Future<List<File>> pickFilesBlog() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowedExtensions: allowedFileTypesBlog,
    type: FileType.custom,
    allowMultiple: true,
  );
  if (result != null) {
    List<File> files = result.paths.map((path) => File(path!)).toList();
    print(files);
    return files;
  } else {
    return [];
  }
}
