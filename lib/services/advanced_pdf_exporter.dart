// lib/services/advanced_pdf_exporter.dart
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../features/cv_builder/models/cv_model.dart';
import '../features/cv_builder/models/skill.dart';

class AdvancedPDFExporter {
  static Future<Uint8List> generateProfessionalPDF(CVModel cv) async {
    final pdf = pw.Document();

    // Define colors
    const primaryColor = PdfColor.fromInt(0xFF1e3a8a);
    const secondaryColor = PdfColor.fromInt(0xFF3b82f6);
    const accentColor = PdfColor.fromInt(0xFF6366f1);
    const textColor = PdfColor.fromInt(0xFF1f2937);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => _buildHeader(cv, primaryColor),
        footer: (context) => _buildFooter(context, primaryColor),
        build: (context) => [
          // Professional Summary
          if (cv.personalInfo.summary.isNotEmpty) ...[
            _buildSection(
              'Professional Summary',
              primaryColor,
              pw.Paragraph(
                text: cv.personalInfo.summary,
                style: pw.TextStyle(
                  fontSize: 12,
                  color: textColor,
                  lineSpacing: 1.5,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
          ],

          // Work Experience
          if (cv.experiences.isNotEmpty) ...[
            _buildSection(
              'Work Experience',
              primaryColor,
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: cv.experiences
                    .map(
                      (exp) =>
                          _buildExperienceItem(exp, secondaryColor, textColor),
                    )
                    .toList(),
              ),
            ),
            pw.SizedBox(height: 20),
          ],

          // Education
          if (cv.educations.isNotEmpty) ...[
            _buildSection(
              'Education',
              primaryColor,
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: cv.educations
                    .map(
                      (edu) => _buildEducationItem(edu, accentColor, textColor),
                    )
                    .toList(),
              ),
            ),
            pw.SizedBox(height: 20),
          ],

          // Skills
          if (cv.skills.isNotEmpty) ...[
            _buildSection(
              'Skills & Expertise',
              primaryColor,
              _buildSkillsSection(cv.skills, primaryColor, textColor),
            ),
          ],
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(CVModel cv, PdfColor primaryColor) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [primaryColor, const PdfColor.fromInt(0xFF3b82f6)],
          begin: pw.Alignment.topLeft,
          end: pw.Alignment.bottomRight,
        ),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            cv.personalInfo.name.isNotEmpty
                ? cv.personalInfo.name
                : 'Your Name',
            style: pw.TextStyle(
              fontSize: 28,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            'Professional',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.normal,
              color: PdfColors.white,
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              if (cv.personalInfo.email.isNotEmpty)
                _buildContactInfo('Email:', cv.personalInfo.email),
              if (cv.personalInfo.phone.isNotEmpty)
                _buildContactInfo('Phone:', cv.personalInfo.phone),
              if (cv.personalInfo.address.isNotEmpty)
                _buildContactInfo('Address:', cv.personalInfo.address),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildContactInfo(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 10,
            color: const PdfColor.fromInt(0xFFb3b3b3),
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 11, color: PdfColors.white),
        ),
      ],
    );
  }

  static pw.Widget _buildFooter(pw.Context context, PdfColor primaryColor) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 10),
      decoration: pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: primaryColor, width: 1)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Generated with CV Builder',
            style: pw.TextStyle(
              fontSize: 9,
              color: const PdfColor.fromInt(0xFF6b7280),
            ),
          ),
          pw.Text(
            'Page ${context.pageNumber}',
            style: pw.TextStyle(
              fontSize: 9,
              color: const PdfColor.fromInt(0xFF6b7280),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSection(
    String title,
    PdfColor primaryColor,
    pw.Widget content,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: pw.BoxDecoration(
            color: primaryColor.shade(0.1),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ),
        pw.SizedBox(height: 12),
        content,
      ],
    );
  }

  static pw.Widget _buildExperienceItem(
    dynamic exp,
    PdfColor color,
    PdfColor textColor,
  ) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 16),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          pw.Container(
            margin: const pw.EdgeInsets.only(top: 8, right: 16),
            width: 8,
            height: 8,
            decoration: pw.BoxDecoration(
              color: color,
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  exp.position ?? 'Position',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: textColor,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  exp.company ?? 'Company',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: color,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  '${exp.startDate ?? 'Start'} - ${exp.endDate ?? 'Present'}',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: const PdfColor.fromInt(0xFF6b7280),
                  ),
                ),
                if (exp.description?.isNotEmpty == true) ...[
                  pw.SizedBox(height: 6),
                  pw.Text(
                    exp.description!,
                    style: pw.TextStyle(
                      fontSize: 11,
                      color: textColor,
                      lineSpacing: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildEducationItem(
    dynamic edu,
    PdfColor color,
    PdfColor textColor,
  ) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 16),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          pw.Container(
            margin: const pw.EdgeInsets.only(top: 8, right: 16),
            width: 8,
            height: 8,
            decoration: pw.BoxDecoration(
              color: color,
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  edu.degree ?? 'Degree',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: textColor,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  edu.institution ?? 'Institution',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: color,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  '${edu.startDate ?? 'Start'} - ${edu.endDate ?? 'Present'}',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: const PdfColor.fromInt(0xFF6b7280),
                  ),
                ),
                if (edu.grade?.isNotEmpty == true) ...[
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Grade: ${edu.grade}',
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: const PdfColor.fromInt(0xFF6b7280),
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSkillsSection(
    List<dynamic> skills,
    PdfColor primaryColor,
    PdfColor textColor,
  ) {
    // Group skills by category
    final Map<SkillCategory, List<dynamic>> groupedSkills = {};
    for (final skill in skills) {
      if (!groupedSkills.containsKey(skill.category)) {
        groupedSkills[skill.category] = [];
      }
      groupedSkills[skill.category]!.add(skill);
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: groupedSkills.entries.map((entry) {
        return pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 16),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                _getCategoryDisplayName(entry.key),
                style: pw.TextStyle(
                  fontSize: 13,
                  fontWeight: pw.FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Wrap(
                spacing: 8,
                runSpacing: 6,
                children: entry.value.map((skill) {
                  return pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: pw.BoxDecoration(
                      color: _getCategoryColor(skill.category).shade(0.1),
                      borderRadius: const pw.BorderRadius.all(
                        pw.Radius.circular(12),
                      ),
                      border: pw.Border.all(
                        color: _getCategoryColor(skill.category),
                        width: 0.5,
                      ),
                    ),
                    child: pw.Row(
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Text(
                          skill.name,
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: _getCategoryColor(skill.category),
                          ),
                        ),
                        pw.SizedBox(width: 4),
                        ...List.generate(skill.level, (index) {
                          return pw.Container(
                            width: 4,
                            height: 4,
                            margin: const pw.EdgeInsets.only(left: 1),
                            decoration: pw.BoxDecoration(
                              color: _getCategoryColor(skill.category),
                              shape: pw.BoxShape.circle,
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  static String _getCategoryDisplayName(SkillCategory category) {
    switch (category) {
      case SkillCategory.technical:
        return 'Technical Skills';
      case SkillCategory.language:
        return 'Languages';
      case SkillCategory.soft:
        return 'Soft Skills';
      case SkillCategory.creative:
        return 'Creative Skills';
      case SkillCategory.analytical:
        return 'Analytical Skills';
      case SkillCategory.management:
        return 'Management Skills';
      case SkillCategory.communication:
        return 'Communication Skills';
      case SkillCategory.other:
        return 'Other Skills';
    }
  }

  static PdfColor _getCategoryColor(SkillCategory category) {
    switch (category) {
      case SkillCategory.technical:
        return const PdfColor.fromInt(0xFF2563eb);
      case SkillCategory.language:
        return const PdfColor.fromInt(0xFF059669);
      case SkillCategory.soft:
        return const PdfColor.fromInt(0xFF7c3aed);
      case SkillCategory.creative:
        return const PdfColor.fromInt(0xFFea580c);
      case SkillCategory.analytical:
        return const PdfColor.fromInt(0xFF0891b2);
      case SkillCategory.management:
        return const PdfColor.fromInt(0xFF4338ca);
      case SkillCategory.communication:
        return const PdfColor.fromInt(0xFFdb2777);
      case SkillCategory.other:
        return const PdfColor.fromInt(0xFF6b7280);
    }
  }
}
