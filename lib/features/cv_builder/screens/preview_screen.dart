// lib/features/cv_builder/screens/preview_screen.dart
import 'package:flutter/material.dart';
import '../widgets/cv_preview.dart';
import '../../../services/export_service.dart';
import '../../../config/routes/app_router.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.pushNamed(context, AppRouter.edit),
          ),
        ],
      ),
      body: const CVPreview(),
      floatingActionButton: SizedBox(
        height: 280,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "pdf",
              onPressed: () => ExportService.exportToPDF(context),
              child: const Icon(Icons.picture_as_pdf),
              tooltip: 'Export as Modern PDF',
            ),
            const SizedBox(height: 12),
            FloatingActionButton(
              heroTag: "advanced_pdf",
              onPressed: () => ExportService.exportToAdvancedPDF(context),
              child: const Icon(Icons.picture_as_pdf_outlined),
              tooltip: 'Export as Advanced PDF',
              backgroundColor: Colors.deepPurple,
            ),
            const SizedBox(height: 12),
            FloatingActionButton(
              heroTag: "docx",
              onPressed: () => ExportService.exportToDOCX(context),
              child: const Icon(Icons.description),
              tooltip: 'Export as DOCX',
            ),
            const SizedBox(height: 12),
            FloatingActionButton(
              heroTag: "html",
              onPressed: () => ExportService.exportToHTML(context),
              child: const Icon(Icons.web),
              tooltip: 'Export as HTML',
            ),
          ],
        ),
      ),
    );
  }
}
