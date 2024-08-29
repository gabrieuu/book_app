class UserModel {
  String? id;
  String name;
  String email;
  String username;
  bool passouIntroducao;

  UserModel(
    {
    this.id,
    required this.name,
    required this.email,
    this.username = '',
    required this.passouIntroducao
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id_user'],
      name: map["name"] ?? '',
      email: map["email"],
      username: map["username"] ?? '',
      passouIntroducao: map["passou_introducao"],
    );
  }
}
