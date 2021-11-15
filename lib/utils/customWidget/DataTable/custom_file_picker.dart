import 'package:file_picker/file_picker.dart';

class FileExt {
  static String csv = 'csv', pdf = 'pdf', xlsx = 'xlsx';
}

class CustomFilePicker {
  // static PlatformFile selectedFile;
  static Future selectFile(
      {required String fileExt,
      bool allowMultiple = false,
      bool withData = false}) async {
    print(fileExt.toString());
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple,
        withData: withData,
        type: FileType.custom,
        allowedExtensions: [fileExt]);

    if (result != null) {
      return result.files.first;
    } else {
      return null;
    }
  }
}
