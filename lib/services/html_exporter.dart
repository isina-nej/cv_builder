// lib/services/html_exporter.dart
import '../features/cv_builder/models/cv_model.dart';

class HtmlExporter {
  static String generateHTML(CVModel cv) {
    String html = '''
<!DOCTYPE html>
<html>
<head>
  <title>${cv.personalInfo.name}'s CV</title>
  <style>
    body { font-family: Arial, sans-serif; }
    .editable { contenteditable: true; border: 1px dotted gray; }
  </style>
</head>
<body>
  <h1 class="editable">${cv.personalInfo.name}</h1>
  <p class="editable">Email: ${cv.personalInfo.email}</p>
  <p class="editable">Phone: ${cv.personalInfo.phone}</p>
  <p class="editable">Address: ${cv.personalInfo.address}</p>
  <p class="editable">Summary: ${cv.personalInfo.summary}</p>
  <h2>Education</h2>
  ${cv.educations.map((edu) => '<div class="editable"><h3>${edu.degree}</h3><p>${edu.institution} (${edu.startDate} - ${edu.endDate})</p><p>${edu.description}</p></div>').join('')}
  <h2>Experience</h2>
  ${cv.experiences.map((exp) => '<div class="editable"><h3>${exp.title}</h3><p>${exp.company} (${exp.startDate} - ${exp.endDate})</p><p>${exp.description}</p></div>').join('')}
  <h2>Skills</h2>
  ${cv.skills.map((skill) => '<p class="editable">${skill.name} - Level ${skill.level}</p>').join('')}
</body>
</html>
    ''';
    return html;
  }
}