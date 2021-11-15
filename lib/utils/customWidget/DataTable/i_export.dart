import 'package:pluto_grid/pluto_grid.dart';

abstract class IExport {
  void export(
      String fileName, List<PlutoColumn?> columns, List<PlutoRow?> rows);
  void printDocument(List<PlutoColumn?> columns, List<PlutoRow?> rows);
  void preview(List<PlutoColumn?> columns, List<PlutoRow?> rows);
  void localDownLoad(String content);
  Future selectLocalFile({bool multiSelect = false, bool withData = false});
}
