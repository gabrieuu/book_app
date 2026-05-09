class AuthorModel {
  final String? apiId;
  final String name;
  final String? fullName;
  final List<String>? photoUrls;
  final String about;
  final String? dateOfBirth;
  final String? dateOfDeath;

  AuthorModel({
    this.apiId,
    required this.name,
    this.fullName,
    this.photoUrls,
    required this.about,
    this.dateOfBirth,
    this.dateOfDeath,
  });

  factory AuthorModel.fromOpenLibrary(Map<String, dynamic> json) {
    return AuthorModel(
      apiId: json['key']?.toString().replaceFirst('/authors/', ''),
      name: json['name'] ?? 'Autor desconhecido',
      fullName: json['full_name'],
      photoUrls: (json['photos'] as List<dynamic>?)
          ?.map((photoId) =>
              'https://covers.openlibrary.org/a/id/$photoId-L.jpg')
          .toList(),
      about: json['bio'] is String
          ? json['bio']
          : (json['bio']?['value'] ?? 'Sem descrição disponível'),
      dateOfBirth: json['birth_date'],
      dateOfDeath: json['death_date'],
    );
  }
}