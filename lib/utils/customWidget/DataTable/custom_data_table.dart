import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'data_table_csv.dart';
import 'data_table_pdf.dart';

class CustomDataTable extends StatefulWidget {
  final List<PlutoColumn> columns;
  List<PlutoRow>? rows;
  final Future<List<PlutoRow>> Function(Map<String, String>)? getRows;
  CustomDataTable({Key? key, required this.columns, this.rows, this.getRows})
      : super(key: key);

  @override
  _CustomDataTableState createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  PlutoGridStateManager? stateManager;

  Timer? _debounce;
  Map<String, String> queryMap = {};

  @override
  void dispose() {
    // myController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // @override
  // void initState() {
  //   getRows();
  //   super.initState();
  // }

  void getRows(PlutoGridStateManager stateManager) async {
    if (widget.rows == null && widget.getRows != null) {
      stateManager.setShowLoading(true);
      var rows = await widget.getRows!({});
      if (rows != null) {
        stateManager.appendRows(rows);
        widget.rows = rows;
      }
      setState(() {});
      stateManager.setShowLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
        columns: widget.columns, //buildColumns(),
        rows: widget.rows, //buildRows(),
        configuration: PlutoGridConfiguration(
            enableGridBorderShadow: false,
            rowHeight: 30,
            // enableColumnBorder: true,
            gridBorderColor: Colors.transparent),
        createFooter: (stateManager) {
          stateManager.setPageSize(10, notify: false); // default 40
          return footer(stateManager);
        },
        onSelected: (onSelect) {}, //buildRows(),
        onChanged: (PlutoGridOnChangedEvent event) {},
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager!;
          stateManager!.setShowColumnFilter(true);
          getRows(stateManager!);
          stateManager!.eventManager?.listener((event1) {
            if (event1 is PlutoGridChangeColumnFilterEvent) {
              queryMap[event1.column!.field] = event1.filterValue!;
              if (widget.getRows != null) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () async {
                  stateManager!.appendRows(await widget.getRows!(queryMap));
                  // .then((dataList) => widget.dataList?.addAll(dataList));
                });
              }
            }
          });
        });
  }

  Widget footer(PlutoGridStateManager stateManager) {
    return ScreenTypeLayout(
      mobile: mobileFooter(stateManager),
      tablet: webFooter(stateManager),
      desktop: webFooter(stateManager),
      // ),
    );
  }

  Widget mobileFooter(PlutoGridStateManager stateManager) {
    return Column(
      children: [
        Divider(),
        // widget.rows != null ? PlutoPagination(stateManager) : Container(),
        Flexible(
          child: Row(
            children: [
              buildDownloadCSVBtn(),
              filePickerBtn(),
              getPdfBtn(),
            ],
          ),
        ),
      ],
    );
  }

  Widget webFooter(PlutoGridStateManager stateManager) {
    return Column(
      children: [
        Divider(),
        Expanded(
          child: Row(
            children: [
              buildDownloadCSVBtn(),
              filePickerBtn(),
              getPdfBtn(),
              widget.rows != null
                  ? Flexible(child: PlutoPagination(stateManager))
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDownloadCSVBtn() {
    return ElevatedButton(
      child: const Text('Get CSV'),
      onPressed: () {
        DataTableCsv().export(
            "downloadCsvFile",
            widget.columns,
            stateManager?.refRows?.filteredList != null &&
                    stateManager!.refRows!.filteredList.isNotEmpty
                ? stateManager!.refRows!.filteredList
                : stateManager!.refRows!.originalList);
      },
    );
  }

  Widget filePickerBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        child: const Text('Pick Files'),
        onPressed: () async {
          var files = await DataTableCsv().pickFile(withData: true);
          print(files);
        },
      ),
    );
  }

  Widget getPdfBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        child: const Text('Get Pdf'),
        onPressed: () async {
          DataTablePdf().export(
              "downloadPdfFile",
              widget.columns,
              stateManager?.refRows?.filteredList != null &&
                      stateManager!.refRows!.filteredList.isNotEmpty
                  ? stateManager!.refRows!.filteredList
                  : stateManager!.refRows!.originalList);
        },
      ),
    );
  }
}
