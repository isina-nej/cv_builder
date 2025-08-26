// lib/features/cv_builder/models/personal_info.dart
class PersonalInfo {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String summary;
  final String? photoPath;

  PersonalInfo({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.summary = '',
    this.photoPath,
  });

  PersonalInfo copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? summary,
    String? photoPath,
  }) {
    return PersonalInfo(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      summary: summary ?? this.summary,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}