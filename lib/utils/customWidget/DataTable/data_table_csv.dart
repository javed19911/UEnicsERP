import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_file_picker.dart';
import 'i_export.dart';

class DataTableCsv extends IExport {
  DataTableCsv() : super(FileExt.csv);

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

    String csv = const ListToCsvConverter().convert(rows1);
    Uint8List bytes = Uint8List.fromList(csv.codeUnits);
    List
    bytes.
    await save("MyCSV", bytes, mimeType: MimeType.CSV);
  }

  @override
  void preview(List<PlutoColumn?> columns, List<PlutoRow?> rows) {
    // TODO: implement preview
  }

  @override
  void printDocument(List<PlutoColumn?> columns, List<PlutoRow?> rows) {
    // TODO: implement printDocument
  }

  void localDownLoad(String csv) async {
    print('CSV....$csv');
    var content = base64Encode(csv.codeUnits);
    var url = 'data:text/csv;base64,$content';
    await launch(url);
  }
}
