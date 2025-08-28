import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../features/cv_builder/models/cv_model.dart';

class AdvancedPDFExporter {
  static Future<Uint8List> generateAdvancedPDF(CVModel cv) async {
    final pdf = pw.Document();

    // Professional color palette with solid colors (no withOpacity)
    const primaryColor = PdfColor.fromInt(0xFF1a365d); // Dark blue
    const accentColor = PdfColor.fromInt(0xFF3182ce); // Bright blue
    const textColor = PdfColor.fromInt(0xFF2d3748); // Dark gray
    const lightGray = PdfColor.fromInt(0xFFf7fafc); // Very light gray
    const mediumGray = PdfColor.fromInt(0xFFe2e8f0); // Medium gray
    const darkGray = PdfColor.fromInt(0xFF4a5568); // Dark gray

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(0),
        build: (context) => pw.Row(
          children: [
            // Left sidebar - 35% width
            pw.Expanded(
              flex: 35,
              child: _buildSidebar(cv, primaryColor, lightGray, mediumGray),
            ),
            // Right content - 65% width
            pw.Expanded(
              flex: 65,
              child: _buildMainContent(cv, textColor, accentColor, darkGray),
            ),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildSidebar(CVModel cv, PdfColor primaryColor, PdfColor lightGray, PdfColor mediumGray) {
    return pw.Container(
      color: primaryColor,
      height: double.infinity,
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(30),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Profile section
            pw.Container(
              width: 100,
              height: 100,
              decoration: pw.BoxDecoration(
                color: PdfColor.fromInt(0xFF9CA3AF),
                borderRadius: pw.BorderRadius.circular(50),
                border: pw.Border.all(
                  color: PdfColors.white,
                  width: 3,
                ),
              ),
              child: pw.Center(
                child: pw.Icon(
                  pw.IconData(0xe7fd), // person icon
                  size: 50,
                  color: PdfColors.white,
                ),
              ),
            ),

            pw.SizedBox(height: 20),

            // Name
            pw.Text(
              cv.personalInfo.name,
              style: pw.TextStyle(
                color: PdfColors.white,
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 5),

            // Title
            if (cv.personalInfo.jobTitle?.isNotEmpty == true) ...[
              pw.Text(
                cv.personalInfo.jobTitle!,
                style: pw.TextStyle(
                  color: PdfColor.fromInt(0xFFE2E8F0),
                  fontSize: 14,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
              pw.SizedBox(height: 25),
            ],

            // Contact Information
            _buildSectionHeader('CONTACT', PdfColors.white),
            pw.SizedBox(height: 15),
            
            if (cv.personalInfo.email.isNotEmpty) ...[
              _buildContactItem('Email', cv.personalInfo.email, PdfColors.white),
              pw.SizedBox(height: 10),
            ],
            
            if (cv.personalInfo.phone.isNotEmpty) ...[
              _buildContactItem('Phone', cv.personalInfo.phone, PdfColors.white),
              pw.SizedBox(height: 10),
            ],
            
            if (cv.personalInfo.address.isNotEmpty) ...[
              _buildContactItem('Address', cv.personalInfo.address, PdfColors.white),
              pw.SizedBox(height: 10),
            ],
            
            if (cv.personalInfo.website?.isNotEmpty == true) ...[
              _buildContactItem('Website', cv.personalInfo.website!, PdfColors.white),
              pw.SizedBox(height: 25),
            ],

            // Skills Section
            if (cv.skills.isNotEmpty) ...[
              _buildSectionHeader('SKILLS', PdfColors.white),
              pw.SizedBox(height: 15),
              ...cv.skills.map((skill) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 15),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      skill.name,
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Container(
                      width: double.infinity,
                      height: 8,
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromInt(0xFF4A5568),
                        borderRadius: pw.BorderRadius.circular(4),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Container(
                          width: (skill.level / 5) * 100,
                          height: 8,
                          decoration: pw.BoxDecoration(
                            color: PdfColor.fromInt(0xFF3182CE),
                            borderRadius: pw.BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }

  static pw.Widget _buildMainContent(CVModel cv, PdfColor textColor, PdfColor accentColor, PdfColor darkGray) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(40),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Summary/About section
          if (cv.personalInfo.summary.isNotEmpty) ...[
            _buildSectionHeader('PROFESSIONAL SUMMARY', accentColor),
            pw.SizedBox(height: 15),
            pw.Text(
              cv.personalInfo.summary,
              style: pw.TextStyle(
                color: textColor,
                fontSize: 11,
                lineSpacing: 1.4,
              ),
            ),
            pw.SizedBox(height: 30),
          ],

          // Experience section
          if (cv.experiences.isNotEmpty) ...[
            _buildSectionHeader('PROFESSIONAL EXPERIENCE', accentColor),
            pw.SizedBox(height: 15),
            ...cv.experiences.map((exp) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 25),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              exp.title,
                              style: pw.TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 3),
                            pw.Text(
                              exp.company,
                              style: pw.TextStyle(
                                color: accentColor,
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromInt(0xFFE6FFFA),
                          borderRadius: pw.BorderRadius.circular(12),
                          border: pw.Border.all(
                            color: accentColor,
                            width: 1,
                          ),
                        ),
                        child: pw.Text(
                          '${exp.startDate} - ${exp.endDate}',
                          style: pw.TextStyle(
                            color: accentColor,
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  if (exp.description.isNotEmpty)
                    pw.Text(
                      exp.description,
                      style: pw.TextStyle(
                        color: darkGray,
                        fontSize: 10,
                        lineSpacing: 1.3,
                      ),
                    ),
                ],
              ),
            )),
            pw.SizedBox(height: 20),
          ],

          // Education section
          if (cv.educations.isNotEmpty) ...[
            _buildSectionHeader('EDUCATION', accentColor),
            pw.SizedBox(height: 15),
            ...cv.educations.map((edu) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 20),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 8,
                    height: 8,
                    margin: const pw.EdgeInsets.only(top: 6, right: 15),
                    decoration: pw.BoxDecoration(
                      color: accentColor,
                      shape: pw.BoxShape.circle,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          edu.degree,
                          style: pw.TextStyle(
                            color: textColor,
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 3),
                        pw.Text(
                          edu.institution,
                          style: pw.TextStyle(
                            color: accentColor,
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 3),
                        pw.Text(
                          '${edu.startDate} - ${edu.endDate}',
                          style: pw.TextStyle(
                            color: darkGray,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],

          // Languages section
          if (cv.personalInfo.languages.isNotEmpty) ...[
            pw.SizedBox(height: 20),
            _buildSectionHeader('LANGUAGES', accentColor),
            pw.SizedBox(height: 15),
            pw.Wrap(
              spacing: 10,
              runSpacing: 10,
              children: cv.personalInfo.languages.take(6).map((language) => pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromInt(0xFFEDF2F7),
                  borderRadius: pw.BorderRadius.circular(15),
                  border: pw.Border.all(
                    color: PdfColor.fromInt(0xFFCBD5E0),
                  ),
                ),
                child: pw.Row(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Text(
                      language,
                      style: pw.TextStyle(
                        color: textColor,
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Container(
                      width: 4,
                      height: 4,
                      decoration: pw.BoxDecoration(
                        color: accentColor,
                        shape: pw.BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }

  static pw.Widget _buildSectionHeader(String title, PdfColor color) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          width: 50,
          height: 3,
          color: color,
        ),
      ],
    );
  }

  static pw.Widget _buildContactItem(String label, String value, PdfColor color) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label.toUpperCase(),
          style: pw.TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        pw.SizedBox(height: 3),
        pw.Text(
          value,
          style: pw.TextStyle(
            color: color,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}