import 'package:book_app/model/user_model.dart';

class UserResponseDto {
  final String email;
	final String? name;
	final String? username;
	final bool passouIntroducao;
	final String? photoUrl;

  UserResponseDto({
    required this.email,
    this.passouIntroducao = false,
    this.name,
    this.photoUrl,
    this.username
  });

  factory UserResponseDto.fromMap(Map<String, dynamic> map) {
    return UserResponseDto(
      email: map['email'],
      name: map['name'],
      username: map['username'],
      passouIntroducao: map['passouIntroducao'] ?? false,
      photoUrl: map['photoUrl']
    );
  }

  UserModel toUserModel() {
    return UserModel(
      name: name ?? '',
      email: email,
      username: username ?? '',
      passouIntroducao: passouIntroducao,
      photoUrl: photoUrl
    );
  }

}