import 'dart:io';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'custom_file_picker.dart';

abstract class IExport {
  late String fileExt;

  IExport(this.fileExt);

  void export(
      String fileName, List<PlutoColumn?> columns, List<PlutoRow?> rows);
  void printDocument(List<PlutoColumn?> columns, List<PlutoRow?> rows);
  void preview(List<PlutoColumn?> columns, List<PlutoRow?> rows);

  Future save(String name, Uint8List bytes,
      {MimeType mimeType = MimeType.OTHER}) async {
    if (!kIsWeb) {
      if (Platform.isIOS || Platform.isAndroid) {
        return FileSaver.instance.saveAs(name, bytes, fileExt, mimeType);
      }
    }
    return FileSaver.instance
        .saveFile(name, bytes, fileExt, mimeType: mimeType);
  }

  Future pickFile({bool multiSelect = false, bool withData = false}) async {
    var file = await CustomFilePicker.selectFile(
        fileExt: fileExt, allowMultiple: multiSelect, withData: withData);
    if (file != null) {
      if (multiSelect) {
        var files = [];
        file.forEach((v) {
          files.add(withData ? v.bytes : v.path);
        });
        return files;
      } else {
        return [withData ? file.first.bytes : file.first.path];
      }
    }
    return null;
  }
}
