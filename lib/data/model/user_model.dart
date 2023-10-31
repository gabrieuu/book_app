class UserModel {
  String name;
  String id;
  String email;

  UserModel({
    required this.name,
    required this.email,
    required this.id,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map["name"],
      email: map["email"],
      id: map["id_user"],
    );
  }
}
