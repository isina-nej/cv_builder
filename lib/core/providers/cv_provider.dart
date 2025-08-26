// lib/core/providers/cv_provider.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../../features/cv_builder/models/cv_model.dart';
import '../../features/cv_builder/models/personal_info.dart';
import '../../features/cv_builder/models/education.dart';
import '../../features/cv_builder/models/experience.dart';
import '../../features/cv_builder/models/skill.dart';

class CVProvider extends ChangeNotifier {
  CVModel _cv = CVModel(
    personalInfo: PersonalInfo(),
    educations: [],
    experiences: [],
    skills: [],
    template: CVTemplates.modern,
  );

  CVModel get cv => _cv;

  void updatePersonalInfo(PersonalInfo info) {
    _cv = _cv.copyWith(personalInfo: info);
    notifyListeners();
  }

  void addEducation(Education edu) {
    _cv.educations.add(edu);
    notifyListeners();
  }

  void removeEducation(int index) {
    _cv.educations.removeAt(index);
    notifyListeners();
  }

  void addExperience(Experience exp) {
    _cv.experiences.add(exp);
    notifyListeners();
  }

  void removeExperience(int index) {
    _cv.experiences.removeAt(index);
    notifyListeners();
  }

  void addSkill(Skill skill) {
    _cv.skills.add(skill);
    notifyListeners();
  }

  void removeSkill(int index) {
    _cv.skills.removeAt(index);
    notifyListeners();
  }

  void changeTemplate(String template) {
    _cv = _cv.copyWith(template: template);
    notifyListeners();
  }

  void loadCV(CVModel newCV) {
    _cv = newCV;
    notifyListeners();
  }

  // Add reordering functions
  void reorderEducations(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final Education item = _cv.educations.removeAt(oldIndex);
    _cv.educations.insert(newIndex, item);
    notifyListeners();
  }

  // Similar for others
}
