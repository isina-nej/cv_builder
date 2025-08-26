// lib/features/cv_builder/models/cv_model.dart
import 'personal_info.dart';
import 'education.dart';
import 'experience.dart';
import 'skill.dart';
import '../../../core/utils/constants.dart';

class CVModel {
  final PersonalInfo personalInfo;
  final List<Education> educations;
  final List<Experience> experiences;
  final List<Skill> skills;
  final String template;

  CVModel({
    required this.personalInfo,
    this.educations = const [],
    this.experiences = const [],
    this.skills = const [],
    this.template = CVTemplates.modern,
  });

  CVModel copyWith({
    PersonalInfo? personalInfo,
    List<Education>? educations,
    List<Experience>? experiences,
    List<Skill>? skills,
    String? template,
  }) {
    return CVModel(
      personalInfo: personalInfo ?? this.personalInfo,
      educations: educations ?? this.educations,
      experiences: experiences ?? this.experiences,
      skills: skills ?? this.skills,
      template: template ?? this.template,
    );
  }
}