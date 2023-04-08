import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> pickFile({required bool allowMultipleFiles}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: allowMultipleFiles,
    type: FileType.image,
  );
  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  }
  return null;
}

Future<String> saveFile(
    {required File file, required String folderName}) async {
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  Directory newDirectory =
      Directory('${appDocumentsDirectory.path}/$folderName');
  if (!await newDirectory.exists()) {
    await newDirectory.create(recursive: true);
  }
  String filePath = '${newDirectory.path}/${file.path.split('/').last}';
  await file.copy(filePath);
  return filePath;
}
