// lib/services/export_service.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;
import '../core/providers/cv_provider.dart';
import 'modern_pdf_exporter.dart';
import 'advanced_pdf_exporter.dart';
import 'html_exporter.dart';
import 'docx_exporter.dart';

class ExportService {
  static Future<void> exportToPDF(BuildContext context) async {
    try {
      final cv = Provider.of<CVProvider>(context, listen: false).cv;
      final bytes = await ModernPDFExporter.generateModernPDF(cv);

      if (kIsWeb) {
        _downloadFileWeb(
          bytes,
          'cv_${DateTime.now().millisecondsSinceEpoch}.pdf',
          'application/pdf',
        );
      } else {
        final dir = await getTemporaryDirectory();
        final file = File(
          '${dir.path}/cv_${DateTime.now().millisecondsSinceEpoch}.pdf',
        );
        await file.writeAsBytes(bytes);
      }

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              kIsWeb
                  ? 'PDF downloaded successfully!'
                  : 'PDF exported successfully!',
            ),
            action: SnackBarAction(label: 'OK', onPressed: () {}),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static Future<void> exportToAdvancedPDF(BuildContext context) async {
    try {
      final cv = Provider.of<CVProvider>(context, listen: false).cv;
      final bytes = await AdvancedPDFExporter.generateAdvancedPDF(cv);

      if (kIsWeb) {
        _downloadFileWeb(
          bytes,
          'cv_advanced_${DateTime.now().millisecondsSinceEpoch}.pdf',
          'application/pdf',
        );
      } else {
        final dir = await getTemporaryDirectory();
        final file = File(
          '${dir.path}/cv_advanced_${DateTime.now().millisecondsSinceEpoch}.pdf',
        );
        await file.writeAsBytes(bytes);
      }

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              kIsWeb
                  ? 'Advanced PDF downloaded successfully!'
                  : 'Advanced PDF exported successfully!',
            ),
            action: SnackBarAction(label: 'OK', onPressed: () {}),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting Advanced PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static Future<void> exportToDOCX(BuildContext context) async {
    try {
      final cv = Provider.of<CVProvider>(context, listen: false).cv;
      final bytes = await DocxExporter.generateDocx(cv);

      if (kIsWeb) {
        _downloadFileWeb(
          bytes,
          'cv_${DateTime.now().millisecondsSinceEpoch}.docx',
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        );
      } else {
        final dir = await getTemporaryDirectory();
        final file = File(
          '${dir.path}/cv_${DateTime.now().millisecondsSinceEpoch}.docx',
        );
        await file.writeAsBytes(bytes);
      }

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              kIsWeb
                  ? 'DOCX downloaded successfully!'
                  : 'DOCX exported successfully!',
            ),
            action: SnackBarAction(label: 'OK', onPressed: () {}),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting DOCX: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static Future<void> exportToHTML(BuildContext context) async {
    try {
      final cv = Provider.of<CVProvider>(context, listen: false).cv;
      final htmlContent = HtmlExporter.generateHTML(cv);

      if (kIsWeb) {
        _downloadFileWeb(
          htmlContent.codeUnits,
          'cv_${DateTime.now().millisecondsSinceEpoch}.html',
          'text/html',
        );
      } else {
        final dir = await getTemporaryDirectory();
        final file = File(
          '${dir.path}/cv_${DateTime.now().millisecondsSinceEpoch}.html',
        );
        await file.writeAsString(htmlContent);
      }

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              kIsWeb
                  ? 'HTML downloaded successfully!'
                  : 'HTML exported successfully!',
            ),
            action: SnackBarAction(label: 'OK', onPressed: () {}),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting HTML: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static void _downloadFileWeb(
    List<int> bytes,
    String fileName,
    String mimeType,
  ) {
    final blob = html.Blob([bytes], mimeType);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
