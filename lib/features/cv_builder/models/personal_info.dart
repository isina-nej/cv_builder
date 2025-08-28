// lib/features/cv_builder/models/personal_info.dart
class PersonalInfo {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String summary;
  final String? photoPath;
  final String? website;
  final String? linkedIn;
  final String? github;
  final String? jobTitle;
  final String? dateOfBirth;
  final String? nationality;
  final List<String> languages;
  final Map<String, String> socialLinks;

  PersonalInfo({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.summary = '',
    this.photoPath,
    this.website,
    this.linkedIn,
    this.github,
    this.jobTitle,
    this.dateOfBirth,
    this.nationality,
    this.languages = const [],
    this.socialLinks = const {},
  });

  PersonalInfo copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? summary,
    String? photoPath,
    String? website,
    String? linkedIn,
    String? github,
    String? jobTitle,
    String? dateOfBirth,
    String? nationality,
    List<String>? languages,
    Map<String, String>? socialLinks,
  }) {
    return PersonalInfo(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      summary: summary ?? this.summary,
      photoPath: photoPath ?? this.photoPath,
      website: website ?? this.website,
      linkedIn: linkedIn ?? this.linkedIn,
      github: github ?? this.github,
      jobTitle: jobTitle ?? this.jobTitle,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      nationality: nationality ?? this.nationality,
      languages: languages ?? this.languages,
      socialLinks: socialLinks ?? this.socialLinks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'summary': summary,
      'photoPath': photoPath,
      'website': website,
      'linkedIn': linkedIn,
      'github': github,
      'jobTitle': jobTitle,
      'dateOfBirth': dateOfBirth,
      'nationality': nationality,
      'languages': languages,
      'socialLinks': socialLinks,
    };
  }

  factory PersonalInfo.fromMap(Map<String, dynamic> map) {
    return PersonalInfo(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      summary: map['summary'] ?? '',
      photoPath: map['photoPath'],
      website: map['website'],
      linkedIn: map['linkedIn'],
      github: map['github'],
      jobTitle: map['jobTitle'],
      dateOfBirth: map['dateOfBirth'],
      nationality: map['nationality'],
      languages: List<String>.from(map['languages'] ?? []),
      socialLinks: Map<String, String>.from(map['socialLinks'] ?? {}),
    );
  }
}
