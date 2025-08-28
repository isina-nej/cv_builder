import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../features/cv_builder/models/cv_model.dart';

class ModernPDFExporter {
  static Future<Uint8List> generateModernPDF(CVModel cv) async {
    final pdf = pw.Document();

    // Modern color palette with solid colors (no withOpacity)
    const primaryColor = PdfColor.fromInt(0xFF2563eb); // Blue-600
    const lightBlue = PdfColor.fromInt(0xFFe0f2fe); // Light blue
    const veryLightBlue = PdfColor.fromInt(0xFFf0f9ff); // Very light blue
    const accentColor = PdfColor.fromInt(0xFF0ea5e9); // Sky-500
    const textColor = PdfColor.fromInt(0xFF1f2937); // Gray-800
    const lightGray = PdfColor.fromInt(0xFFf8fafc); // Gray-50

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(0),
        build: (context) => pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Left sidebar - 35% width
            pw.Expanded(
              flex: 35,
              child: _buildSidebar(cv, primaryColor, lightBlue, veryLightBlue),
            ),
            // Right content - 65% width
            pw.Expanded(
              flex: 65,
              child: _buildMainContent(cv, primaryColor, accentColor, textColor, lightGray),
            ),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildSidebar(CVModel cv, PdfColor primaryColor, PdfColor lightBlue, PdfColor veryLightBlue) {
    return pw.Container(
      color: primaryColor,
      height: double.infinity,
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(25),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Profile Photo Placeholder
            pw.Container(
              width: 120,
              height: 120,
              decoration: pw.BoxDecoration(
                color: PdfColors.white,
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(60)),
                border: pw.Border.all(color: PdfColors.white, width: 3),
              ),
              child: pw.Center(
                child: pw.Text(
                  cv.personalInfo.name.isNotEmpty 
                    ? cv.personalInfo.name.substring(0, 1).toUpperCase()
                    : 'P',
                  style: pw.TextStyle(
                    fontSize: 48,
                    fontWeight: pw.FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            pw.SizedBox(height: 25),

            // Name
            pw.Text(
              cv.personalInfo.name.toUpperCase(),
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
                letterSpacing: 1.2,
              ),
            ),
            pw.SizedBox(height: 8),

            // Job Title
            if (cv.personalInfo.jobTitle?.isNotEmpty == true) ...[
              pw.Text(
                cv.personalInfo.jobTitle!,
                style: pw.TextStyle(
                  fontSize: 12,
                  color: lightBlue,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ],
            
            pw.SizedBox(height: 25),

            // Contact Information
            _buildSidebarSection(
              'CONTACT',
              lightBlue,
              [
                if (cv.personalInfo.email.isNotEmpty)
                  _buildContactItem('📧', cv.personalInfo.email, veryLightBlue),
                if (cv.personalInfo.phone.isNotEmpty)
                  _buildContactItem('📱', cv.personalInfo.phone, veryLightBlue),
                if (cv.personalInfo.address.isNotEmpty)
                  _buildContactItem('📍', cv.personalInfo.address, veryLightBlue),
                if (cv.personalInfo.website?.isNotEmpty == true)
                  _buildContactItem('🌐', cv.personalInfo.website!, veryLightBlue),
                if (cv.personalInfo.linkedIn?.isNotEmpty == true)
                  _buildContactItem('💼', cv.personalInfo.linkedIn!, veryLightBlue),
              ],
            ),

            pw.SizedBox(height: 25),

            // Skills Section
            if (cv.skills.isNotEmpty) ...[
              _buildSidebarSection(
                'SKILLS',
                lightBlue,
                cv.skills.take(8).map((skill) => 
                  _buildSkillItem(skill.name, skill.level / 5.0, veryLightBlue)
                ).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static pw.Widget _buildMainContent(CVModel cv, PdfColor primaryColor, PdfColor accentColor, PdfColor textColor, PdfColor lightGray) {
    return pw.Container(
      color: PdfColors.white,
      height: double.infinity,
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(30),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Professional Summary
            if (cv.personalInfo.summary.isNotEmpty) ...[
              _buildMainSection('PROFESSIONAL SUMMARY', primaryColor),
              pw.SizedBox(height: 15),
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: lightGray,
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
                  border: pw.Border(
                    left: pw.BorderSide(color: accentColor, width: 4),
                  ),
                ),
                child: pw.Text(
                  cv.personalInfo.summary,
                  style: pw.TextStyle(
                    fontSize: 11,
                    color: textColor,
                    lineSpacing: 1.5,
                  ),
                  textAlign: pw.TextAlign.justify,
                ),
              ),
              pw.SizedBox(height: 30),
            ],

            // Work Experience
            if (cv.experiences.isNotEmpty) ...[
              _buildMainSection('WORK EXPERIENCE', primaryColor),
              pw.SizedBox(height: 20),
              ...cv.experiences.map((exp) => _buildExperienceCard(exp, accentColor, textColor, lightGray)),
            ],

            // Education
            if (cv.educations.isNotEmpty) ...[
              pw.SizedBox(height: 30),
              _buildMainSection('EDUCATION', primaryColor),
              pw.SizedBox(height: 20),
              ...cv.educations.map((edu) => _buildEducationCard(edu, accentColor, textColor)),
            ],
          ],
        ),
      ),
    );
  }

  static pw.Widget _buildSidebarSection(String title, PdfColor sectionColor, List<pw.Widget> children) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.white,
            letterSpacing: 1.5,
          ),
        ),
        pw.Container(
          margin: const pw.EdgeInsets.only(top: 8, bottom: 15),
          height: 2,
          width: 40,
          color: sectionColor,
        ),
        ...children,
      ],
    );
  }

  static pw.Widget _buildContactItem(String emoji, String text, PdfColor textColor) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            emoji,
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            child: pw.Text(
              text,
              style: pw.TextStyle(
                fontSize: 9.5,
                color: textColor,
                lineSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSkillItem(String skillName, double level, PdfColor textColor) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 15),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            skillName,
            style: pw.TextStyle(
              fontSize: 10,
              color: textColor,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Container(
            height: 8,
            width: double.infinity,
            decoration: pw.BoxDecoration(
              color: const PdfColor.fromInt(0xFF1e3a8a), // Darker blue
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
            ),
            child: pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Container(
                height: 8,
                width: (level * 140).clamp(0, 140), // Fixed width for sidebar
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildMainSection(String title, PdfColor primaryColor) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: primaryColor,
            letterSpacing: 1.2,
          ),
        ),
        pw.Container(
          margin: const pw.EdgeInsets.only(top: 8),
          height: 3,
          width: 60,
          decoration: pw.BoxDecoration(
            color: primaryColor,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildExperienceCard(experience, PdfColor accentColor, PdfColor textColor, PdfColor lightGray) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 25),
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: const PdfColor.fromInt(0xFFe5e7eb), width: 1),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Header with job title and dates
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      experience.title,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      experience.company,
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: accentColor,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: pw.BoxDecoration(
                  color: const PdfColor.fromInt(0xFFe0f2fe),
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(16)),
                ),
                child: pw.Text(
                  '${experience.startDate} - ${experience.endDate}',
                  style: pw.TextStyle(
                    fontSize: 9,
                    color: accentColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          pw.SizedBox(height: 12),
          
          // Description
          if (experience.description.isNotEmpty) ...[
            pw.Text(
              experience.description,
              style: pw.TextStyle(
                fontSize: 10,
                color: textColor,
                lineSpacing: 1.4,
              ),
              textAlign: pw.TextAlign.justify,
            ),
          ],
          
          // Achievements
          if (experience.achievements.isNotEmpty) ...[
            pw.SizedBox(height: 12),
            pw.Text(
              'Key Achievements:',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: textColor,
              ),
            ),
            pw.SizedBox(height: 6),
            ...experience.achievements.take(4).map((achievement) =>
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 6),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      margin: const pw.EdgeInsets.only(top: 6, right: 10),
                      width: 4,
                      height: 4,
                      decoration: pw.BoxDecoration(
                        color: accentColor,
                        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        achievement,
                        style: pw.TextStyle(
                          fontSize: 9,
                          color: textColor,
                          lineSpacing: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static pw.Widget _buildEducationCard(education, PdfColor accentColor, PdfColor textColor) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 18),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            margin: const pw.EdgeInsets.only(top: 8, right: 20),
            width: 10,
            height: 10,
            decoration: pw.BoxDecoration(
              color: accentColor,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  education.degree,
                  style: pw.TextStyle(
                    fontSize: 13,
                    fontWeight: pw.FontWeight.bold,
                    color: textColor,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  education.institution,
                  style: pw.TextStyle(
                    fontSize: 11,
                    color: accentColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                if (education.fieldOfStudy?.isNotEmpty == true) ...[
                  pw.SizedBox(height: 2),
                  pw.Text(
                    education.fieldOfStudy!,
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: const PdfColor.fromInt(0xFF6b7280),
                    ),
                  ),
                ],
                pw.SizedBox(height: 4),
                pw.Row(
                  children: [
                    pw.Text(
                      '${education.startDate} - ${education.endDate}',
                      style: pw.TextStyle(
                        fontSize: 9,
                        color: const PdfColor.fromInt(0xFF6b7280),
                      ),
                    ),
                    if (education.grade?.isNotEmpty == true) ...[
                      pw.SizedBox(width: 15),
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: pw.BoxDecoration(
                          color: const PdfColor.fromInt(0xFFf3f4f6),
                          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                        ),
                        child: pw.Text(
                          'Grade: ${education.grade}',
                          style: pw.TextStyle(
                            fontSize: 8,
                            color: const PdfColor.fromInt(0xFF374151),
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
