// lib/services/export_service.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import '../core/providers/cv_provider.dart';
import '../features/cv_builder/models/cv_model.dart';
import 'pdf_exporter.dart';

class ExportService {
  static Future<void> exportToPDF(BuildContext context) async {
    try {
      final cv = Provider.of<CVProvider>(context, listen: false).cv;
      final bytes = await PDFExporter.generatePDF(cv);
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
      final html = _generateHTML(cv);
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

  static String _generateHTML(CVModel cv) {
    return '''
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${cv.personalInfo.name} - CV</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                line-height: 1.6;
                color: #333;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 40px 20px;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                background: white;
                border-radius: 16px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.1);
                overflow: hidden;
            }
            .header {
                background: linear-gradient(135deg, #6366f1 0%, #10b981 100%);
                color: white;
                padding: 40px;
                text-align: center;
            }
            .header h1 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 10px;
            }
            .header p {
                font-size: 1.1rem;
                opacity: 0.9;
            }
            .content {
                padding: 40px;
            }
            .section {
                margin-bottom: 40px;
            }
            .section h2 {
                font-size: 1.5rem;
                color: #6366f1;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #e5e7eb;
            }
            .item {
                background: #f8fafc;
                padding: 20px;
                margin-bottom: 15px;
                border-radius: 8px;
                border-left: 4px solid #6366f1;
            }
            .item h3 {
                color: #1f2937;
                margin-bottom: 5px;
            }
            .item p {
                color: #6b7280;
                margin-bottom: 5px;
            }
            .skills {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }
            .skill {
                background: linear-gradient(135deg, #6366f1, #10b981);
                color: white;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 500;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>${cv.personalInfo.name}</h1>
                <p>${cv.personalInfo.email} • ${cv.personalInfo.phone}</p>
            </div>
            
            <div class="content">
                <div class="section">
                    <h2>Education</h2>
                    ${cv.educations.map((edu) => '''
                        <div class="item">
                            <h3>${edu.degree}</h3>
                            <p><strong>${edu.institution}</strong></p>
                            <p>${edu.startDate} - ${edu.endDate}</p>
                        </div>
                    ''').join()}
                </div>
                
                <div class="section">
                    <h2>Experience</h2>
                    ${cv.experiences.map((exp) => '''
                        <div class="item">
                            <h3>${exp.title}</h3>
                            <p><strong>${exp.company}</strong></p>
                            <p>${exp.startDate} - ${exp.endDate}</p>
                        </div>
                    ''').join()}
                </div>
                
                <div class="section">
                    <h2>Skills</h2>
                    <div class="skills">
                        ${cv.skills.map((skill) => '<div class="skill">${skill.name} (${skill.level}/5)</div>').join()}
                    </div>
                </div>
            </div>
        </div>
    </body>
    </html>
    ''';
  }
}
