import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:book_app/modules/primeiro_acesso/exception/username_ja_existe_exception.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository{

  // AuthRepository authRepository;

  final client = Supabase.instance.client;

  UserRepository();
  
  Future<UserModel> getUserById(String userId) async{
    final user = await client.from("usuarios").select("*").eq("id_user", userId);
    return UserModel.fromMap(user[0]);
  }

  Future<List<UserModel>> getUsersByName(String name) async{
    try {
      final users = await client.from('usuarios').select('*').ilike('username', '$name%');
      return (users as List).map((e) => UserModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> alteraNomeAndUsername({required String nome, required String username, required String userId}) async{
    try {
      await client.from('usuarios').update({'name': nome, 'username': username}).eq('id_user', userId);
    } catch (e) {
      throw UsernameJaExisteException();
    }
  }

  Future<void> alteraPrimeiroAcesso(String userId) async{
      await client.from('usuarios').update({'passou_introducao': true}).eq('id_user', userId);
  }
  
}