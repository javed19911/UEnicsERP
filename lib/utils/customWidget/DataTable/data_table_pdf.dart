import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart' as material;
import 'package:pdf/widgets.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import 'custom_file_picker.dart';
import 'i_export.dart';
// import 'package:universal_html/html.dart' as html;

class DataTablePdf implements IExport {
  static const PdfColor green =
      PdfColor.fromInt(0xffe06c6c); //darker background color
  static const PdfColor lightGreen =
      PdfColor.fromInt(0xffedabab); //light background color

  static const _darkColor = PdfColor.fromInt(0xff242424);
  static const _lightColor = PdfColor.fromInt(0xff9D9D9D);
  static const PdfColor baseColor = PdfColor.fromInt(0xffD32D2D);
  static const PdfColor _baseTextColor = PdfColor.fromInt(0xffffffff);
  static const PdfColor accentColor = PdfColor.fromInt(0xfff1c0c0);

  Widget pdfHeader() {
    return Container(
        decoration: BoxDecoration(
            color: const PdfColor.fromInt(0xffffffff),
            borderRadius: BorderRadius.circular(4)),
        // margin: const EdgeInsets.only(bottom: 8, top: 8),
        // padding: const EdgeInsets.fromLTRB(10, 7, 10, 4),
        child: Column(children: [
          Text(
            "Javed Hussain",
            style: TextStyle(
                fontSize: 16, color: _darkColor, fontWeight: FontWeight.bold),
          ),
          Text("+91-8287733567",
              style: const TextStyle(fontSize: 14, color: _darkColor)),
          Text("Guwahati, Assam",
              style: const TextStyle(fontSize: 14, color: _darkColor)),
          // Divider(color: _darkColor),
        ]));
  }

//create pdf file
  @override
  void export(
      String fileName, List<PlutoColumn?> columns, List<PlutoRow?> rows) async {
    // final PageTheme pageTheme = await _myPageTheme(PdfPageFormat.a3);

    Widget headerWidget = pdfHeader();
    // final Uint8List fontData = File('open-sans.ttf').readAsBytesSync();
    // final ttf = pw.Font.ttf(fontData.buffer.asByteData());

    //final pw.Document pdf = pw.Document();
    // final pdf = pw.Document();
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    // pdf.addPage(pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       return pw.Center(
    //         child: pw.Text('Hello World', style: pw.TextStyle(font: font)),
    //       ); // Center
    //     })); // Page

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        // pageTheme: pageTheme,
        crossAxisAlignment: CrossAxisAlignment.start,
        // header: (Context context) {
        //   // if (context.pageNumber == 1) {
        //   //   return Container();
        //   // }
        //   return Container(
        //       alignment: Alignment.centerRight,
        //       child: pw.Text(
        //           'Page ${context.pageNumber} of ${context.pagesCount}',
        //           style: Theme.of(context)
        //               .defaultTextStyle
        //               .copyWith(color: PdfColors.grey)));
        // },
        footer: (Context context) {
          return pw.Container(
              alignment: Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: pw.Text(
                  'Page ${context.pageNumber} of ${context.pagesCount}',
                  style: Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        build: (Context context) => <Widget>[
              pw.Header(
                level: 0,
                child: headerWidget,
              ),
              pw.Table.fromTextArray(
                context: context,
                border: null,
                headerAlignment: Alignment.centerLeft,
                cellAlignment: Alignment.centerLeft,
                headerDecoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.zero,
                  color: baseColor,
                ),
                headerHeight: 25,
                cellHeight: 30,
                headerStyle: pw.TextStyle(
                  color: _baseTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                cellStyle: const pw.TextStyle(
                  color: _darkColor,
                  fontSize: 10,
                ),
                // rowDecoration:  BoxDecoration(
                //   border:  BoxBorder(
                //     bottom: true,
                //     color: accentColor,
                //     width: .5,
                //   ),
                // ),

                headers: List<String>.generate(
                  // 3,
                  columns.length,
                  (col) {
                    print('${columns[col]!.title}');
                    // return ('Header $col');
                    return columns[col]!.title;
                  },
                ),
                data: List<List<String>>.generate(
                  rows.length,
                  (row) => List<String>.generate(
                    // 3,
                    rows[row]!.cells.length,
                    (col) {
                      print("Cell....$row, $col");
                      return rows[row]!
                          .cells[columns[col]!.field]!
                          .value!
                          .toString();
                      // return "Cell $row, $col";
                    },
                  ),
                ),
              ),
            ]));

    await FileSaver.instance
        .saveFile("MyPdf", await pdf.save(), "pdf", mimeType: MimeType.PDF);
  }

  Future<PageTheme> _myPageTheme(PdfPageFormat format) async {
    return PageTheme(
      pageFormat: format.applyMargin(
          left: 2.0 * PdfPageFormat.cm,
          top: 4.0 * PdfPageFormat.cm,
          right: 2.0 * PdfPageFormat.cm,
          bottom: 2.0 * PdfPageFormat.cm),
      theme: ThemeData.withFont(
//      base: pw.Font.ttf(await rootBundle.load('assets/fonts/nexa_bold.otf')),
//      bold:
//          pw.Font.ttf(await rootBundle.load('assets/fonts/raleway_medium.ttf')),
          ),
      buildBackground: (Context context) {
        return FullPage(
          ignoreMargins: true,
          child: CustomPaint(
            size: PdfPoint(format.width, format.height),
            painter: (PdfGraphics canvas, PdfPoint size) {
              context.canvas
                ..setColor(lightGreen)
                ..moveTo(0, size.y)
                ..lineTo(0, size.y - 230)
                ..lineTo(60, size.y)
                ..fillPath()
                ..setColor(green)
                ..moveTo(0, size.y)
                ..lineTo(0, size.y - 100)
                ..lineTo(100, size.y)
                ..fillPath()
                ..setColor(lightGreen)
                ..moveTo(30, size.y)
                ..lineTo(110, size.y - 50)
                ..lineTo(150, size.y)
                ..fillPath()
                ..moveTo(size.x, 0)
                ..lineTo(size.x, 230)
                ..lineTo(size.x - 60, 0)
                ..fillPath()
                ..setColor(green)
                ..moveTo(size.x, 0)
                ..lineTo(size.x, 100)
                ..lineTo(size.x - 100, 0)
                ..fillPath()
                ..setColor(lightGreen)
                ..moveTo(size.x - 30, 0)
                ..lineTo(size.x - 110, 50)
                ..lineTo(size.x - 150, 0)
                ..fillPath();
            },
          ),
        );
      },
    );
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
        fileExt: FileExt.pdf, allowMultiple: multiSelect, withData: withData);
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
