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

enum SkillLevel {
  beginner(1, 'Beginner'),
  intermediate(2, 'Intermediate'),
  advanced(3, 'Advanced'),
  expert(4, 'Expert'),
  master(5, 'Master');

  const SkillLevel(this.value, this.displayName);
  final int value;
  final String displayName;
}

class Skill {
  final String name;
  final int level; // 1-5
  final SkillCategory category;
  final String? description;
  final int? yearsOfExperience;
  final List<String> relatedProjects;

  Skill({
    this.name = '',
    this.level = 1,
    this.category = SkillCategory.other,
    this.description,
    this.yearsOfExperience,
    this.relatedProjects = const [],
  });

  Skill copyWith({
    String? name,
    int? level,
    SkillCategory? category,
    String? description,
    int? yearsOfExperience,
    List<String>? relatedProjects,
  }) {
    return Skill(
      name: name ?? this.name,
      level: level ?? this.level,
      category: category ?? this.category,
      description: description ?? this.description,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      relatedProjects: relatedProjects ?? this.relatedProjects,
    );
  }

  SkillLevel get skillLevel {
    switch (level) {
      case 1:
        return SkillLevel.beginner;
      case 2:
        return SkillLevel.intermediate;
      case 3:
        return SkillLevel.advanced;
      case 4:
        return SkillLevel.expert;
      case 5:
        return SkillLevel.master;
      default:
        return SkillLevel.beginner;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'level': level,
      'category': category.name,
      'description': description,
      'yearsOfExperience': yearsOfExperience,
      'relatedProjects': relatedProjects,
    };
  }

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      name: map['name'] ?? '',
      level: map['level'] ?? 1,
      category: SkillCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => SkillCategory.other,
      ),
      description: map['description'],
      yearsOfExperience: map['yearsOfExperience'],
      relatedProjects: List<String>.from(map['relatedProjects'] ?? []),
    );
  }
}
