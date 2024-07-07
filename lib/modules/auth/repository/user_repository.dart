import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository{

  AuthRepository authRepository;

  final client = Supabase.instance.client;

  UserRepository(this.authRepository);
  
  Future<UserModel?> getUserById() async{
    final user = await client.from("usuarios").select("*").eq("id_user", authRepository.user?.id);
    return UserModel.fromMap(user[0]);
  }
}