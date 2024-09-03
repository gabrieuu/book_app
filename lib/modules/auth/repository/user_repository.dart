import 'dart:developer';

import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:book_app/modules/primeiro_acesso/exception/username_ja_existe_exception.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  // AuthRepository authRepository;

  final client = Supabase.instance.client;

  UserRepository();

  Future<UserModel> getUserById(String userId) async {
    final user =
        await client.from("usuarios").select("*").eq("id_user", userId);
    return UserModel.fromMap(user[0]);
  }

  Future<List<UserModel>> getUsersByName(String name) async {
    try {
      final users =
          await client.from('usuarios').select('*').ilike('username', '$name%');
      return (users as List).map((e) => UserModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> alteraNomeAndUsername(
      {required String nome,
      required String username,
      required String userId}) async {
    try {
      await client
          .from('usuarios')
          .update({'name': nome, 'username': username}).eq('id_user', userId);
    } catch (e) {
      throw UsernameJaExisteException();
    }
  }

  Future<void> alteraPrimeiroAcesso(String userId) async {
    await client
        .from('usuarios')
        .update({'passou_introducao': true}).eq('id_user', userId);
  }

  Future<void> seguirPessoa(
      {required String userIdSeguidor, required String userIdSeguida}) async {
    try {
      var response = await client.from('seguidores').insert({
        'pessoa_seguidora_id': userIdSeguidor,
        'pessoa_seguida_id': userIdSeguida
      });
    } catch (e) {
      await client
          .from('seguidores')
          .delete()
          .eq('pessoa_seguidora_id', userIdSeguidor)
          .eq('pessoa_seguida_id', userIdSeguida);
    }
  }

  Future<bool> getIsSeguindo(String userIdLogado, String idUsuario) async {
    var response = await client
        .from('seguidores')
        .select('*')
        .eq('pessoa_seguidora_id', userIdLogado)
        .eq('pessoa_seguida_id', idUsuario)
        .count(CountOption.exact);
    if (response.count > 0) return true;
    return false;
  }

  Future<List<UserModel>> getSeguidores(String userId) async {
    try {
      var response =
          await client.rpc('get_seguidores', params: {'user_id': userId});
      var list = (response as List).map((e) => UserModel.fromMap(e)).toList();
      return list;
    } catch (e) {
      return [];
    }
  }

  Future<List<UserModel>> getSeguindo(String userId) async {
    try {
      var response =
          await client.rpc('get_seguindo', params: {'user_id': userId});
      var list = (response as List).map((e) => UserModel.fromMap(e)).toList();
      return list;
    } catch (e) {
      return [];
    }
  }

  Future<int> getQuantidadeSeguidores(String userId) async {
    try {
      var response = await client
          .from('seguidores')
          .select('*')
          .eq('pessoa_seguida_id', userId)
          .count(CountOption.exact);
      return response.count;
    } catch (e) {
      log('$e');
      return 0;
    }
  }

  Future<int> getQuantidadeSeguindo(String userId) async {
    try {
      var response = await client
          .from('seguidores')
          .select('*')
          .eq('pessoa_seguidora_id', userId)
          .count(CountOption.exact);
      return response.count;
    } catch (e) {
      log('$e');
      return 0;
    }
  }

  // Future<UserModel> getSeguidores(String userId) async{
  //   await client.from('seguidores').select(', data').eq('pessoa_seguida_id', userId);
  // }
}
