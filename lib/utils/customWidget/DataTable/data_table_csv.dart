import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_file_picker.dart';
import 'i_export.dart';

class DataTableCsv implements IExport {
  @override
  void export(
      String fileName, List<PlutoColumn?> columns, List<PlutoRow?> rows) async {
    //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.

    List<List<dynamic>> rows1 = [];
    List<dynamic> row = [];
    for (var column in columns) {
      row.add(column!.title);
    }
    rows1.add(row);
    for (int i = 0; i < rows.length; i++) {
//row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> row = [];
      for (var key in rows[i]!.cells.keys) {
        row.add(rows[i]?.cells[key]?.value);
      }
      rows1.add(row);
    }

//     await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
//     bool checkPermission = await SimplePermissions.checkPermission(
//         Permission.WriteExternalStorage);
//     if (checkPermission) {
// //store file in documents folder
//
//       String dir =
//           (await getExternalStorageDirectory()).absolute.path + "/documents";
//       file = "$dir";
//       print(LOGTAG + " FILE " + file);
//       File f = new File(file + "filename.csv");

// convert rows to String and write as csv file

    String csv = const ListToCsvConverter().convert(rows1);
    //f.writeAsString(csv);
    print('CSV....$csv');
    var content = base64Encode(csv.codeUnits);
    var url = 'data:text/csv;base64,$content';
    await launch(url);
    //localDownLoad(csv);
  }

  @override
  void preview(List<PlutoColumn?> columns, List<PlutoRow?> rows) {
    // TODO: implement preview
  }

  @override
  void printDocument(List<PlutoColumn?> columns, List<PlutoRow?> rows) {
    // TODO: implement printDocument
  }

  @override
  void localDownLoad(String csv) async {
    print('CSV....$csv');
    var content = base64Encode(csv.codeUnits);
    var url = 'data:text/csv;base64,$content';
    await launch(url);
  }

  @override
  Future selectLocalFile(
      {bool multiSelect = false, bool withData = false}) async {
    var file = await CustomFilePicker.selectFile(
        fileExt: FileExt.csv, allowMultiple: multiSelect, withData: withData);
    if (multiSelect) {
      var files = [];
      file.forEach((v) {
        files.add(withData ? v.bytes : v.path);
      });
      return files;
    } else {
      return [withData ? file.bytes : file.path];
    }
  }
}
