import 'dart:convert';

import 'package:UEnicsERP/ui/base/BaseActivity.dart';
import 'package:UEnicsERP/ui/inventory/item/item_master_vm.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ItemMasterActivity extends StatefulWidget {
  const ItemMasterActivity({Key? key}) : super(key: key);

  @override
  _ItemMasterActivityState createState() => _ItemMasterActivityState();
}

class _ItemMasterActivityState
    extends BaseActivity<ItemMasterActivity, ItemMasterVM> {
  List<PlutoColumn> columns = [
    /// Text Column definition
    PlutoColumn(
      title: 'text column',
      field: 'text_field',
      type: PlutoColumnType.text(),
      enableEditingMode: false,
    ),

    /// Number Column definition
    PlutoColumn(
      title: 'number column',
      field: 'number_field',
      type: PlutoColumnType.number(),
    ),

    /// Select Column definition
    PlutoColumn(
      title: 'select column',
      field: 'select_field',
      type: PlutoColumnType.select(['item1', 'item2', 'item3']),
    ),

    /// Datetime Column definition
    PlutoColumn(
      title: 'date column',
      field: 'date_field',
      type: PlutoColumnType.date(
        format: 'MM/dd/yyyy',
      ),
    ),

    /// Time Column definition
    PlutoColumn(
      title: 'time column',
      field: 'time_field',
      type: PlutoColumnType.time(),
    ),

    // PlutoColumn(
    //     title: 'Action',
    //     field: '',
    //     type: PlutoColumnType.text(),
    //     enableRowDrag: false,
    //     enableSorting: false,
    //     enableEditingMode: false,
    //     renderer: (rendererContext) {
    //       return Row(
    //         children: [
    //           IconButton(
    //             icon: const Icon(
    //               Icons.add_circle,
    //             ),
    //             onPressed: () {
    //               rendererContext.stateManager!.insertRows(
    //                 rendererContext.rowIdx!,
    //                 [rendererContext.stateManager!.getNewRow()],
    //               );
    //             },
    //             iconSize: 18,
    //             color: Colors.green,
    //             padding: const EdgeInsets.all(0),
    //           ),
    //           IconButton(
    //             icon: const Icon(
    //               Icons.remove_circle_outlined,
    //             ),
    //             onPressed: () {
    //               rendererContext.stateManager!
    //                   .removeRows([rendererContext.row]);
    //             },
    //             iconSize: 18,
    //             color: Colors.red,
    //             padding: const EdgeInsets.all(0),
    //           ),
    //         ],
    //       );
    //     }),
  ];

  List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'text_field': PlutoCell(value: 'Text cell value1'),
        'number_field': PlutoCell(value: 2020),
        'select_field': PlutoCell(value: 'item1'),
        'date_field': PlutoCell(value: '2020-08-06'),
        'time_field': PlutoCell(value: '12:30'),
      },
    ),
    PlutoRow(
      cells: {
        'text_field': PlutoCell(value: 'Text cell value2'),
        'number_field': PlutoCell(value: 2021),
        'select_field': PlutoCell(value: 'item2'),
        'date_field': PlutoCell(value: '2020-08-07'),
        'time_field': PlutoCell(value: '18:45'),
      },
    ),
    PlutoRow(
      cells: {
        'text_field': PlutoCell(value: 'Text cell value3'),
        'number_field': PlutoCell(value: 2022),
        'select_field': PlutoCell(value: 'item3'),
        'date_field': PlutoCell(value: '2020-08-08'),
        'time_field': PlutoCell(value: '23:59'),
      },
    ),
  ];

  @override
  Widget getWidget(BuildContext context, viewModel) {
    // return getWebWidget();
    return ScreenTypeLayout(
      mobile: getMobileWidget(),
      tablet: getWebWidget(padding: 0),
      desktop: getWebWidget(),
    );
  }

  Widget getMobileWidget() {
    return Container(
        padding: const EdgeInsets.all(10),
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: rows.length,
          itemBuilder: (context, i) {
            var row = rows[i];
            return ListTile(
              title: Text(row.cells["text_field"]?.value),
            );
          },
        ));
  }

  Widget getWebWidget({double padding = 10}) {
    return Container(
      padding: EdgeInsets.all(padding),
      child: padding > 0
          ? Card(
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              child: getGrid(),
            )
          : getGrid(),
    );
  }

  Widget getGrid() {
    return PlutoGrid(
      columns: columns,
      rows: rows,
      configuration: PlutoGridConfiguration(
          enableGridBorderShadow: false,
          rowHeight: 30,
          // enableColumnBorder: true,
          gridBorderColor: Colors.transparent),
      onChanged: (PlutoGridOnChangedEvent event) {
        print(event);
      },
      // onLoaded: (PlutoGridOnLoadedEvent event) {
      //   event.stateManager?.setShowColumnFilter(true);
      //   // event.stateManager?.setShowLoading(true);
      //   print(event);
      // },
      onLoaded: (PlutoGridOnLoadedEvent event) {
        // stateManager = event.stateManager;
        event.stateManager?.setShowColumnFilter(true);
        getCsv();
        // event.stateManager?.refRows.filteredList.

        // stateManager.eventManager.listener((event1) {
        //   print("listener event...${event1.runtimeType}");
        //   if (event1 is PlutoGridChangeColumnFilterEvent) {
        //     var eventFilter = event1;
        //     if (eventFilter.filterValue.length > 3) {
        //       _getMandiCommodities({
        //         "commodity_id": "1",
        //         "market": eventFilter.filterValue.capitalize()
        //       });
        //       stateManager.appendRows(buildRows());
        //     }
        //     print(
        //         'Fliter Value....${eventFilter.filterValue}');
        //   }
        // });
      },

      // createHeader: (stateManager) {
      //   stateManager.setPageSize(1, notify: false); // default 40
      //   return BoldText("Test DataGrid");
      // },
      createFooter: (stateManager) {
        stateManager.setPageSize(10, notify: false); // default 40
        return Column(
          children: [
            Divider(),
            Expanded(child: PlutoPagination(stateManager)),
          ],
        );
      },
    );
  }

  getCsv() async {
    //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.

    List<List<dynamic>> rows1 = [];
    for (int i = 0; i < rows.length; i++) {
//row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> row = [];
      rows[i].cells.keys.forEach((key) {
        row.add(rows[i].cells[key]?.value);
      });
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
    downloadCSV(csv);
  }

  void downloadCSV(String csv) async {
    final content = base64Encode(csv.codeUnits);
    final url = 'data:text/csv;base64,$content';
    await launch(url);
  }
}
