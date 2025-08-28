// lib/services/docx_exporter.dart
import 'dart:convert';
import '../features/cv_builder/models/cv_model.dart';
import '../features/cv_builder/models/experience.dart';
import '../features/cv_builder/models/education.dart';
import '../features/cv_builder/models/skill.dart';

class DocxExporter {
  static Future<List<int>> generateDocx(CVModel cv) async {
    // Create a basic DOCX-compatible XML content
    final content =
        '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:body>
    <w:p>
      <w:r>
        <w:t>${cv.personalInfo.name}</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:t>${cv.personalInfo.email} | ${cv.personalInfo.phone}</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:t>${cv.personalInfo.address}</w:t>
      </w:r>
    </w:p>
    <w:p/>
    <w:p>
      <w:r>
        <w:t>Professional Summary</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:t>${cv.personalInfo.summary}</w:t>
      </w:r>
    </w:p>
    <w:p/>
    <w:p>
      <w:r>
        <w:t>Work Experience</w:t>
      </w:r>
    </w:p>
    ${_generateExperienceXml(cv.experiences)}
    <w:p/>
    <w:p>
      <w:r>
        <w:t>Education</w:t>
      </w:r>
    </w:p>
    ${_generateEducationXml(cv.educations)}
    <w:p/>
    <w:p>
      <w:r>
        <w:t>Skills</w:t>
      </w:r>
    </w:p>
    ${_generateSkillsXml(cv.skills)}
  </w:body>
</w:document>
''';

    return utf8.encode(content);
  }

  static String _generateExperienceXml(List<Experience> experiences) {
    return experiences
        .map(
          (exp) =>
              '''
    <w:p>
      <w:r>
        <w:t>${exp.title} at ${exp.company}</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:t>${exp.startDate} - ${exp.endDate}</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:t>${exp.description}</w:t>
      </w:r>
    </w:p>
    <w:p/>
''',
        )
        .join();
  }

  static String _generateEducationXml(List<Education> educations) {
    return educations
        .map(
          (edu) =>
              '''
    <w:p>
      <w:r>
        <w:t>${edu.degree} in ${edu.fieldOfStudy ?? 'General Studies'}</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:t>${edu.institution}, ${edu.endDate}</w:t>
      </w:r>
    </w:p>
    <w:p/>
''',
        )
        .join();
  }

  static String _generateSkillsXml(List<Skill> skills) {
    return skills
        .map(
          (skill) =>
              '''
    <w:p>
      <w:r>
        <w:t>${skill.name}: ${skill.level}/5</w:t>
      </w:r>
    </w:p>
''',
        )
        .join();
  }
}
