// lib/services/docx_exporter.dart
import 'package:docx_template/docx_template.dart';
import 'dart:io';
import '../features/cv_builder/models/cv_model.dart';

class DocxExporter {
  static Future<List<int>> generateDocx(CVModel cv) async {
    // Assume a template.docx in assets, load it
    // For simplicity, assume DocxTemplate.fromBytes(templateBytes)
    // But need to implement properly
    final docx = await DocxTemplate.fromBytes(await File('assets/template.docx').readAsBytes());
    Content c = Content();
    c.add(TextContent("name", cv.personalInfo.name));
    // Add more
    final bytes = await docx.generate(c);
    return bytes!;
  }
}