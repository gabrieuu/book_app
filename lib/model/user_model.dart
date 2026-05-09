class UserModel {
  String? id;
  String name;
  String email;
  String username;
  bool passouIntroducao;
  String? photoUrl;

  UserModel(
      {this.id,
      required this.name,
      required this.email,
      this.username = '',
      this.photoUrl,
      required this.passouIntroducao});

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id_user'],
      name: map["name"] ?? '',
      email: map["email"] ?? '',
      username: map["username"] ?? '',
      passouIntroducao: map["passou_introducao"] ?? false,
      photoUrl: map["photo_url"],
    );
  }

  static UserModel buildUser({
    String? id,
    String? name,
    String? email,
    String? username,
    bool? passouIntroducao,
  }) {
    if (id == null) throw Exception('id não pode ser nulo');
    return UserModel(
      id: id,
      name: name ?? '',
      email: email ?? '',
      username: username ?? '',
      passouIntroducao: passouIntroducao ?? false,
    );
  }

  static UserModel empty() {
    return UserModel(
        name: 'teste',
        email: 'teste',
        username: 'testee',
        passouIntroducao: true);
  }
}
