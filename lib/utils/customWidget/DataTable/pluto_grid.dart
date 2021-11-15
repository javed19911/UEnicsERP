// import 'dart:convert';
// // import 'dart:html' as webFile;
// import 'dart:typed_data';
//
// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:pluto_grid/pluto_grid.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'package:http/http.dart' as http;
//
// import 'custom_data_table.dart';
//
// class PlutoGridExample extends StatefulWidget {
//   @override
//   _PlutoGridExampleState createState() => _PlutoGridExampleState();
// }
//
// class _PlutoGridExampleState extends State<PlutoGridExample> {
//   List<ColumnsData> columnData = [
//     ColumnsData(columnName: 'Commodity', isSearchRequired: false),
//     ColumnsData(columnName: 'Variety'),
//     ColumnsData(columnName: 'Last Updated'),
//     ColumnsData(columnName: 'Market'),
//     ColumnsData(columnName: 'State'),
//     ColumnsData(columnName: 'Model Price quintal', isSortingRequired: false),
//     ColumnsData(columnName: 'Price Range quintal', isSortingRequired: false),
//   ];
//
//   Dio dio = Dio();
//   CancelToken cancelToken;
//   var BASE_URL_WEB = "https://staging.praman.ai/api/web/";
//   List<MandiCommodity> mandiCommodity;
//   MandiRatesListingModel mandiRatesListingModel;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _getMandiCommodities({"commodity_id": "1"});
//     super.initState();
//   }
//
//   List<PlutoColumn> columns = [
//     /// Text Column definition
//     PlutoColumn(
//         title: 'text column',
//         field: 'text_field',
//         type: PlutoColumnType.text(),
//         frozen: PlutoColumnFrozen.left,
//         enableColumnDrag: false,
//         enableContextMenu: false,
//         enableEditingMode: false,
//         textAlign: PlutoColumnTextAlign.left,
//         enableFilterMenuItem: true,
//         hide: false),
//
//     /// Number Column definition
//     PlutoColumn(
//       title: 'number column',
//       field: 'number_field',
//       enableEditingMode: false,
//       enableColumnDrag: false,
//       enableContextMenu: false,
//       type: PlutoColumnType.number(),
//     ),
//
//     /// Select Column definition
//     PlutoColumn(
//       title: 'select column',
//       field: 'select_field',
//       type: PlutoColumnType.select(['item1', 'item2', 'item3']),
//     ),
//
//     /// Datetime Column definition
//     PlutoColumn(
//       title: 'date column',
//       field: 'date_field',
//       type: PlutoColumnType.date(),
//     ),
//
//     /// Time Column definition
//     PlutoColumn(
//       title: 'time column',
//       field: 'time_field',
//       type: PlutoColumnType.time(),
//     ),
//   ];
//
//   List<PlutoRow> rows = [
//     PlutoRow(
//       cells: {
//         'text_field': PlutoCell(value: 'Text cell value1'),
//         'number_field': PlutoCell(value: 2020),
//         'select_field': PlutoCell(value: 'item1'),
//         'date_field': PlutoCell(value: '2020-08-06'),
//         'time_field': PlutoCell(value: '12:30'),
//       },
//     ),
//     PlutoRow(
//       cells: {
//         'text_field': PlutoCell(value: 'Text cell value2'),
//         'number_field': PlutoCell(value: 2021),
//         'select_field': PlutoCell(value: 'item2'),
//         'date_field': PlutoCell(value: '2020-08-07'),
//         'time_field': PlutoCell(value: '18:45'),
//       },
//     ),
//     PlutoRow(
//       cells: {
//         'text_field': PlutoCell(value: 'Text cell value3'),
//         'number_field': PlutoCell(value: 2022),
//         'select_field': PlutoCell(value: 'item3'),
//         'date_field': PlutoCell(value: '2020-08-08'),
//         'time_field': PlutoCell(value: '23:59'),
//       },
//     ),
//   ];
//
//   PlutoGridStateManager stateManager;
//
//   getCsv() async {
//     //create an element rows of type list of list. All the above data set are stored in associate list
// //Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.
//
//     List<List<dynamic>> rows1 = [];
//     for (int i = 0; i < rows.length; i++) {
// //row refer to each column of a row in csv file and rows refer to each row in a file
//       List<dynamic> row = [];
//       rows[i].cells.keys.forEach((key) {
//         row.add(rows[i].cells[key]?.value);
//       });
//       rows1.add(row);
//     }
//
// //     await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
// //     bool checkPermission = await SimplePermissions.checkPermission(
// //         Permission.WriteExternalStorage);
// //     if (checkPermission) {
// // //store file in documents folder
// //
// //       String dir =
// //           (await getExternalStorageDirectory()).absolute.path + "/documents";
// //       file = "$dir";
// //       print(LOGTAG + " FILE " + file);
// //       File f = new File(file + "filename.csv");
//
// // convert rows to String and write as csv file
//
//     String csv = const ListToCsvConverter().convert(rows1);
//     //f.writeAsString(csv);
//     downloadCSV(csv);
//   }
//
//   void downloadCSV(String csv) async {
//     final content = base64Encode(csv.codeUnits);
//     final url = 'data:text/csv;base64,$content';
//     await launch(url);
//
//     // List<int> list = csv.codeUnits;
//     // Uint8List bytes = Uint8List.fromList(csv.codeUnits);
//     // FileSaver.instance.saveAs("myFile", bytes, "csv", MimeType.CSV);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PlutoGrid Demo'),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 10),
//           ElevatedButton(
//             child: const Text('Toggle filtering'),
//             onPressed: () {
//               stateManager.setShowColumnFilter(!stateManager.showColumnFilter);
//             },
//           ),
//           mandiRatesListingModel != null
//               ? dataTable()
//               : const Center(child: CircularProgressIndicator()),
//         ],
//       ),
//     );
//   }
//
//   Widget dataTable() {
//     return Expanded(
//       child: Container(
//           padding: const EdgeInsets.all(10),
//           child: CustomDataTable(
//             columns: buildColumns(),
//             getRows: getRows,
//           )
//           // PlutoGrid(
//           //     columns: columns, //buildColumns(),
//           //     rows: rows, //buildRows(),
//           //     createFooter: (stateManager) {
//           //       stateManager.setPageSize(10, notify: false); // default 40
//           //       return footer();
//           //     },
//           //     onSelected: (onSelect) {}, //buildRows(),
//           //     onChanged: (PlutoGridOnChangedEvent event) {
//           //       event.column;
//           //     },
//           //     onLoaded: (PlutoGridOnLoadedEvent event) {
//           //       onLoad(event);
//           //     }),
//           ),
//     );
//   }
//
//   Future<List<PlutoRow>> getRows(Map<String, String> queryMap) async {
//     queryMap.addAll({"commodity_id": "1"});
//     // _getMandiCommodities(
//     //     {"commodity_id": "1", "market": text.capitalize()});
//     await _getMandiCommodities(queryMap);
//     //     .then((value) {
//     //   return buildRows();
//     // });
//     return buildRows();
//   }
//
//   Widget footer() {
//     return Row(
//       children: [
//         buildDownloadCSVBtn(),
//         //Flexible(child: PlutoPagination(stateManager)),
//       ],
//     );
//   }
//
//   Widget buildDownloadCSVBtn() {
//     return ElevatedButton(
//       child: const Text('Get pdf'),
//       onPressed: () {
//         getCsv();
//
//         // var blob = webFile.Blob(["data"], 'text/plain', 'native');
//         //
//         // var anchorElement = webFile.AnchorElement(
//         //   href: webFile.Url.createObjectUrlFromBlob(blob).toString(),
//         // )..setAttribute("download", "data.txt")..click();
//         // List<List<dynamic>> rows = [];
//         //
//         // for (int i = 0; i < stateManager.refRows.filteredList.length; i++) {
//         //   List<dynamic> row = [];
//         //   row.add(
//         //       stateManager.refRows.filteredList[i].cells["Market"]?.value);
//         //   rows.add(row);
//         // }
//         // String csv = const ListToCsvConverter().convert(rows);
//         // webFile.AnchorElement(href: "data:text/plain;charset=utf-8,$csv")
//         //   ..setAttribute("download", "data.csv")
//         //   ..click();
//       },
//     );
//   }
//
//   List<PlutoColumn> buildColumns() {
//     return List<PlutoColumn>.generate(columnData.length, (index) {
//       ColumnsData data = columnData[index];
//       return PlutoColumn(
//         title: data.columnName,
//         field: data.columnName,
//         type: PlutoColumnType.text(),
//       );
//     });
//   }
//
//   List<PlutoRow> buildRows() {
//     return List<PlutoRow>.generate(mandiCommodity.length, (index) {
//       return PlutoRow(
//         cells:
//             // buildPlutoCell(mandiCommodity[index])
//             {
//           'Commodity': PlutoCell(value: mandiCommodity[index].commodityName),
//           'Variety': PlutoCell(value: mandiCommodity[index].variety),
//           'Last Updated': PlutoCell(value: mandiCommodity[index].date),
//           'Market': PlutoCell(value: mandiCommodity[index].marketName),
//           'State': PlutoCell(value: mandiCommodity[index].state),
//           'Model Price quintal':
//               PlutoCell(value: mandiCommodity[index].modalPrice),
//           'Price Range quintal':
//               PlutoCell(value: mandiCommodity[index].maxPrice),
//         },
//       );
//     });
//   }
//
//   Map<String, PlutoCell> buildPlutoCell(MandiCommodity mandiCommodity) {
//     Map<String, PlutoCell> cell = <String, PlutoCell>{};
//     for (var e in columnData) {
//       cell.putIfAbsent(
//           e.columnName, () => PlutoCell(value: mandiCommodity.commodityName));
//     }
//     return cell;
//   }
//
//   Future<MandiRatesListingModel> getMandiCommodityData(
//       Map<String, dynamic> data) async {
//     final response = await http.post(
//       Uri.parse(BASE_URL_WEB + "market_prices/commodity_market_prices"),
//       headers: {
//         "Accept": "application/json",
//         "Content-Type": "application/json",
//         // "lang": "${langCode.languageCode}"
//       },
//       body: json.encode(data),
//     );
//     var responseMap = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       if (responseMap["success"] == true) {
//         return MandiRatesListingModel.fromJson(jsonDecode(response.body));
//       } else {
//         throw Exception('Server returned  - ${response.body}');
//       }
//     } else {
//       throw Exception("Unable to fetch recent lots");
//     }
//   }
//
//   Future<MandiSearchResponse> getMandis(
//       String input, String commodityId) async {
//     if (cancelToken != null) {
//       if (!cancelToken.isCancelled) {
//         cancelToken.cancel("Cancelled previous request");
//       }
//     }
//     cancelToken = CancelToken();
//     try {
//       var response =
//           await dio.post("${BASE_URL_WEB}market_prices/search_mandi_name",
//               cancelToken: cancelToken,
//               data: {"search_text": input, "commodity_id": commodityId},
//               options: Options(headers: {
//                 "Accept": "application/json",
//                 "Content-Type": "application/json",
//                 // "lang": "${langCode.languageCode}"
//               }));
//       if (response.statusCode == 200) {
//         return MandiSearchResponse.fromJson(response.data);
//       } else {
//         throw Exception("Unable to fetch recent lots");
//       }
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
//
//   Future<List<String>> getMandiForSearch(String input) async {
//     MandiSearchResponse response = await getMandis(input, "1");
//     print(response.searchResult.length.toString());
//     return Future.value(response.searchResult);
//   }
//
//   Future _getMandiCommodities(Map<String, dynamic> _inputMap) async {
//     try {
//       mandiRatesListingModel = await getMandiCommodityData(_inputMap);
//       setState(() {
//         print(_inputMap);
//         mandiCommodity = mandiRatesListingModel.commodities;
//         print(mandiCommodity);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
// }
