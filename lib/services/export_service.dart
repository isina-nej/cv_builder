// lib/services/export_service.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import '../core/providers/cv_provider.dart';
import 'advanced_pdf_exporter.dart';
import 'html_exporter.dart';

class ExportService {
  static Future<void> exportToPDF(BuildContext context) async {
    try {
      final cv = Provider.of<CVProvider>(context, listen: false).cv;
      final bytes = await AdvancedPDFExporter.generateProfessionalPDF(cv);
      final dir = await getTemporaryDirectory();
      final file = File(
        '${dir.path}/cv_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await file.writeAsBytes(bytes);

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF exported successfully to ${file.path}'),
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

  static Future<void> exportToHTML(BuildContext context) async {
    try {
      final cv = Provider.of<CVProvider>(context, listen: false).cv;
      final html = HtmlExporter.generateHTML(cv);
      final dir = await getTemporaryDirectory();
      final file = File(
        '${dir.path}/cv_${DateTime.now().millisecondsSinceEpoch}.html',
      );
      await file.writeAsString(html);

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('HTML exported successfully to ${file.path}'),
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
}
