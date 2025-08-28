// lib/features/cv_builder/models/education.dart
class Education {
  final String degree;
  final String institution;
  final String startDate;
  final String endDate;
  final String description;
  final String? grade;
  final String? gpa;
  final String? fieldOfStudy;
  final bool isCurrentlyStudying;

  Education({
    this.degree = '',
    this.institution = '',
    this.startDate = '',
    this.endDate = '',
    this.description = '',
    this.grade,
    this.gpa,
    this.fieldOfStudy,
    this.isCurrentlyStudying = false,
  });

  Education copyWith({
    String? degree,
    String? institution,
    String? startDate,
    String? endDate,
    String? description,
    String? grade,
    String? gpa,
    String? fieldOfStudy,
    bool? isCurrentlyStudying,
  }) {
    return Education(
      degree: degree ?? this.degree,
      institution: institution ?? this.institution,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      grade: grade ?? this.grade,
      gpa: gpa ?? this.gpa,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      isCurrentlyStudying: isCurrentlyStudying ?? this.isCurrentlyStudying,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'degree': degree,
      'institution': institution,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
      'grade': grade,
      'gpa': gpa,
      'fieldOfStudy': fieldOfStudy,
      'isCurrentlyStudying': isCurrentlyStudying,
    };
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      degree: map['degree'] ?? '',
      institution: map['institution'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      description: map['description'] ?? '',
      grade: map['grade'],
      gpa: map['gpa'],
      fieldOfStudy: map['fieldOfStudy'],
      isCurrentlyStudying: map['isCurrentlyStudying'] ?? false,
    );
  }
}
