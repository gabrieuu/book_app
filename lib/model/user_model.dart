class UserModel {
  String? id;
  String name;
  String email;

  UserModel(
    {
    this.id,
    required this.name,
    required this.email,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id_user'],
      name: map["name"],
      email: map["email"]
    );
  }
}
