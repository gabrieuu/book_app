import 'package:book_app/model/user_model.dart';

abstract class CustomAuthRepository {
  Future<UserModel?> get user;
  Future<bool> register({required String email, required String password});
  Future<bool> signIn(String email, String password);
  Future<bool> isAutenticated();
  Future<void> updateNameAndUsername(
      {required String nome, required String username});
  Future<void> signOut();
}
