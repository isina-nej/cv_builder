// lib/features/cv_builder/models/skill.dart
enum SkillCategory {
  technical,
  language,
  soft,
  creative,
  analytical,
  management,
  communication,
  other,
}

class Skill {
  final String name;
  final int level; // 1-5
  final SkillCategory category;

  Skill({this.name = '', this.level = 1, this.category = SkillCategory.other});

  Skill copyWith({String? name, int? level, SkillCategory? category}) {
    return Skill(
      name: name ?? this.name,
      level: level ?? this.level,
      category: category ?? this.category,
    );
  }
}
