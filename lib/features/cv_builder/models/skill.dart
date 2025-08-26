// lib/features/cv_builder/models/skill.dart
class Skill {
  final String name;
  final int level; // 1-5
  final String category;

  Skill({this.name = '', this.level = 1, this.category = 'Other'});

  Skill copyWith({String? name, int? level, String? category}) {
    return Skill(
      name: name ?? this.name,
      level: level ?? this.level,
      category: category ?? this.category,
    );
  }
}
