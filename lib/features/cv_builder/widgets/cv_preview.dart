// lib/features/cv_builder/widgets/cv_preview.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/cv_provider.dart';
import '../../../core/widgets/cross_platform_image.dart';

class CVPreview extends StatelessWidget {
  const CVPreview({super.key});

  Widget _buildSection(BuildContext context, String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        content,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cv = Provider.of<CVProvider>(context).cv;

    // Depending on template, change layout
    // For simplicity, basic layout
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CrossPlatformImage(imagePath: cv.personalInfo.photoPath, height: 150),
          Text(
            cv.personalInfo.name,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(cv.personalInfo.email),
          Text(cv.personalInfo.phone),
          Text(cv.personalInfo.address),
          Text(cv.personalInfo.summary),
          _buildSection(
            context,
            'Education',
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cv.educations.length,
              itemBuilder: (_, i) {
                final edu = cv.educations[i];
                return ListTile(
                  title: Text(edu.degree),
                  subtitle: Text(
                    '${edu.institution} (${edu.startDate} - ${edu.endDate})',
                  ),
                );
              },
            ),
          ),
          _buildSection(
            context,
            'Experience',
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cv.experiences.length,
              itemBuilder: (_, i) {
                final exp = cv.experiences[i];
                return ListTile(
                  title: Text(exp.title),
                  subtitle: Text(
                    '${exp.company} (${exp.startDate} - ${exp.endDate})',
                  ),
                );
              },
            ),
          ),
          _buildSection(
            context,
            'Skills',
            Wrap(
              children: cv.skills
                  .map(
                    (skill) =>
                        Chip(label: Text('${skill.name} (${skill.level})')),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
