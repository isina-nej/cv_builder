// lib/features/cv_builder/screens/builder_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/cv_provider.dart';
import '../widgets/personal_form.dart';
import '../widgets/education_form.dart';
import '../widgets/experience_form.dart';
import '../widgets/template_selector.dart';
import '../../../config/routes/app_router.dart';
import '../models/education.dart';
import '../models/experience.dart';
import '../models/skill.dart';

class BuilderScreen extends StatelessWidget {
  const BuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cvProvider = Provider.of<CVProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Your CV'),
        actions: [
          IconButton(
            icon: const Icon(Icons.preview),
            onPressed: () => Navigator.pushNamed(context, AppRouter.preview),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TemplateSelector(),
              const PersonalForm(),
              const EducationForm(),
              ReorderableListView(
                shrinkWrap: true,
                onReorder: cvProvider.reorderEducations,
                children: cvProvider.cv.educations.asMap().entries.map((entry) {
                  int index = entry.key;
                  Education edu = entry.value;
                  return ListTile(
                    key: ValueKey(index),
                    title: Text(edu.degree),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => cvProvider.removeEducation(index),
                    ),
                  );
                }).toList(),
              ),
              const ExperienceForm(),
              ReorderableListView(
                shrinkWrap: true,
                children: cvProvider.cv.experiences.asMap().entries.map((
                  entry,
                ) {
                  int index = entry.key;
                  Experience exp = entry.value;
                  return ListTile(
                    key: ValueKey(index),
                    title: Text(exp.title),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => cvProvider.removeExperience(index),
                    ),
                  );
                }).toList(),
                onReorder: (old, new_) {}, // Add reorder
              ),
              // Skills Section - Add manual skill entry instead of SkillForm
              ElevatedButton(
                onPressed: () {
                  // Add a basic skill entry dialog or form
                  _showSkillDialog(context, cvProvider);
                },
                child: const Text('Add Skill'),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cvProvider.cv.skills.length,
                itemBuilder: (_, i) {
                  final skill = cvProvider.cv.skills[i];
                  return ListTile(
                    title: Text(skill.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => cvProvider.removeSkill(i),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSkillDialog(BuildContext context, CVProvider cvProvider) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController levelController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Skill'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Skill Name'),
            ),
            TextField(
              controller: levelController,
              decoration: const InputDecoration(labelText: 'Level'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  levelController.text.isNotEmpty) {
                final skill = Skill(
                  name: nameController.text,
                  level: int.tryParse(levelController.text) ?? 1,
                );
                cvProvider.addSkill(skill);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
