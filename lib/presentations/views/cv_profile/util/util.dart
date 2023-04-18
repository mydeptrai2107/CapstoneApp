// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:app/configs/image_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> saveAsFile(final BuildContext context, final LayoutCallback build,
    final PdfPageFormat pageFormat) async {
  final bytes = await build(pageFormat);
  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/document.pdf');
  print('save as file ${file.path}...');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

void showPrintedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document printed successfully')));
}

void showSharedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document shared successfully')));
}

Future<Uint8List> generatePDF(final PdfPageFormat format) async {
  final doc = pw.Document(title: 'Flutter School');
  final logoImage = pw.MemoryImage(
      (await rootBundle.load(ImageFactory.logo)).buffer.asUint8List());

  final pageTheme = await _myPageTheme(format);
  doc.addPage(pw.MultiPage(
      pageTheme: pageTheme,
      header: (context) => pw.Image(
          alignment: pw.Alignment.center,
          logoImage,
          fit: pw.BoxFit.cover,
          width: 180),
      build: (final context) => [
            pw.Container(
                padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                      pw.Column(children: [
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                      ]),
                      pw.Column(children: [
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                        pw.Text('Phone'),
                      ])
                    ]))
          ]));

  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final logoImage = pw.MemoryImage(
      (await rootBundle.load(ImageFactory.editCV)).buffer.asUint8List());

  return pw.PageTheme(
    margin: const pw.EdgeInsets.symmetric(
        horizontal: 1 * PdfPageFormat.cm, vertical: 0.5 * PdfPageFormat.cm),
    textDirection: pw.TextDirection.ltr,
    orientation: pw.PageOrientation.portrait,
    buildBackground: (context) {
      return pw.FullPage(
          ignoreMargins: true,
          child: pw.Watermark(
              angle: 20,
              child: pw.Opacity(
                  opacity: 0.5,
                  child: pw.Image(
                      alignment: pw.Alignment.center,
                      logoImage,
                      fit: pw.BoxFit.cover))));
    },
  );
}
