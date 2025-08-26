// lib/services/pdf_exporter.dart
import 'package:pdf/widgets.dart' as pw;
import '../features/cv_builder/models/cv_model.dart';
import 'dart:io';

class PDFExporter {
  static Future<List<int>> generatePDF(CVModel cv) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (cv.personalInfo.photoPath != null)
              pw.Image(
                pw.MemoryImage(
                  File(cv.personalInfo.photoPath!).readAsBytesSync(),
                ),
              ),
            pw.Text(
              cv.personalInfo.name,
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(cv.personalInfo.email),
            pw.Text(cv.personalInfo.phone),
            pw.Text(cv.personalInfo.address),
            pw.Text(cv.personalInfo.summary),
            pw.SizedBox(height: 20),
            pw.Text(
              'Education',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            ...cv.educations.map(
              (edu) => pw.Text(
                '${edu.degree} at ${edu.institution} (${edu.startDate} - ${edu.endDate})',
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Experience',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            ...cv.experiences.map(
              (exp) => pw.Text(
                '${exp.title} at ${exp.company} (${exp.startDate} - ${exp.endDate})',
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Skills',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            ...cv.skills.map(
              (skill) => pw.Text('${skill.name} - Level ${skill.level}'),
            ),
          ],
        ),
      ),
    );

    return pdf.save();
  }
}
