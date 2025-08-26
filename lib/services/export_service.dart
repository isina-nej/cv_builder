// lib/services/export_service.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/providers/cv_provider.dart';
import 'pdf_exporter.dart';
import 'docx_exporter.dart';
import 'html_exporter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

class ExportService {
  static Future<void> exportToPDF(BuildContext context) async {
    final cv = Provider.of<CVProvider>(context, listen: false).cv;
    final bytes = await PDFExporter.generatePDF(cv);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/cv.pdf');
    await file.writeAsBytes(bytes);
    OpenFile.open(file.path);
  }

  static Future<void> exportToWord(BuildContext context) async {
    final cv = Provider.of<CVProvider>(context, listen: false).cv;
    final bytes = await DocxExporter.generateDocx(cv);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/cv.docx');
    await file.writeAsBytes(bytes);
    OpenFile.open(file.path);
  }

  static Future<void> exportToHTML(BuildContext context) async {
    final cv = Provider.of<CVProvider>(context, listen: false).cv;
    final html = HtmlExporter.generateHTML(cv);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/cv.html');
    await file.writeAsString(html);
    OpenFile.open(file.path);
  }
}