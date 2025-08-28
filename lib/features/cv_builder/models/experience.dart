// lib/features/cv_builder/models/experience.dart
class Experience {
  final String title;
  final String company;
  final String location;
  final String startDate;
  final String endDate;
  final String description;
  final List<String> achievements;
  final bool isCurrentJob;

  Experience({
    this.title = '',
    this.company = '',
    this.location = '',
    this.startDate = '',
    this.endDate = '',
    this.description = '',
    this.achievements = const [],
    this.isCurrentJob = false,
  });

  Experience copyWith({
    String? title,
    String? company,
    String? location,
    String? startDate,
    String? endDate,
    String? description,
    List<String>? achievements,
    bool? isCurrentJob,
  }) {
    return Experience(
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      achievements: achievements ?? this.achievements,
      isCurrentJob: isCurrentJob ?? this.isCurrentJob,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'company': company,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
      'achievements': achievements,
      'isCurrentJob': isCurrentJob,
    };
  }

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      location: map['location'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      description: map['description'] ?? '',
      achievements: List<String>.from(map['achievements'] ?? []),
      isCurrentJob: map['isCurrentJob'] ?? false,
    );
  }
}
