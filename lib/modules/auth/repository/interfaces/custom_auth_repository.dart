import 'package:book_app/model/user_model.dart';

abstract class CustomAuthRepository {
  UserModel? get user;
  Future<void> createUser({required String email, required String password});
  Future<void> signIn(String email, String password);
  Future<void> signOut();
}
