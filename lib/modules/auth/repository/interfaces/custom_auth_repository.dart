import 'package:book_app/model/user_model.dart';

abstract class CustomAuthRepository {
  Future<UserModel?> get user;
  Future<UserModel> createUser({required String email, required String password});
  Future<UserModel> signIn(String email, String password);
  Future<void> signOut();
}
