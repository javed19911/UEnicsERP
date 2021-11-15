// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintPreview extends StatelessWidget {
  void saveFile() async {
    await FileSaver.instance.saveFile(
        "File", await _generatePdf(PdfPageFormat.a4, "Print"), "pdf",
        mimeType: MimeType.PDF);
  }

  @override
  Widget build(BuildContext context) {
    saveFile();
    return Scaffold(
      appBar: AppBar(title: const Text("Print Preview")),
      body: PdfPreview(
        build: (format) => _generatePdf(format, "Print Preview"),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(
                  child: pw.Text(title, style: pw.TextStyle(font: font)),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Flexible(child: pw.FlutterLogo())
            ],
          );
        },
      ),
    );

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World'),
          ); // Center
        }));

    return pdf.save();
  }
}
