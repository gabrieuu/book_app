import 'package:book_app/core/model/user_model.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// class UserService{

//   AuthRepository authRepository = AuthRepository();
//   final client = Supabase.instance.client;

//   Future<UserModel?> getUserById() async{
//     final user = await client.from("usuarios").select("*").eq("id_user", authRepository.user!.id);
//     return UserModel.fromMap(user[0]);
//   }
// }