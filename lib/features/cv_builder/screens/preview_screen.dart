// lib/features/cv_builder/screens/preview_screen.dart
import 'package:flutter/material.dart';
import '../widgets/cv_preview.dart';
import '../../../services/export_service.dart';
import '../../../../../config/routes/app_router.dart';

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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => ExportService.exportToPDF(context),
            child: const Icon(Icons.picture_as_pdf),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => ExportService.exportToWord(context),
            child: const Icon(Icons.description),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => ExportService.exportToHTML(context),
            child: const Icon(Icons.web),
          ),
        ],
      ),
    );
  }
}