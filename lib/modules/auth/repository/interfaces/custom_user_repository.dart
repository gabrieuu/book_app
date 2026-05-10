import 'dart:io';

import 'package:book_app/model/user_model.dart';

abstract class CustomUserRepository {
  Future<UserModel> getUserById(String userId);

  Future<List<UserModel>> getUsersByName(String name);

  Future<void> atualizaFotoPerfil(
      {required File photo});

  Future<void> seguirPessoa(
      {required int idUser});

  Future<List<UserModel>> getSeguidores(String userId);

  Future<List<UserModel>> getSeguindo(String userId);

  Future<int> getQuantidadeSeguidores(String userId);

  Future<int> getQuantidadeSeguindo(String userId);
}
