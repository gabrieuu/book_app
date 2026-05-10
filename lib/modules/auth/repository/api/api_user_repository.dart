import 'dart:io';

import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_user_repository.dart';

class ApiUserRepository implements CustomUserRepository{
  @override
  Future<void> atualizaFotoPerfil({required File photo}) {
    // TODO: implement atualizaFotoPerfil
    throw UnimplementedError();
  }

  @override
  Future<void> completaPrimeiroAcesso({required String nome, required String username}) {
    // TODO: implement completaPrimeiroAcesso
    throw UnimplementedError();
  }

  @override
  Future<int> getQuantidadeSeguidores(String userId) {
    // TODO: implement getQuantidadeSeguidores
    throw UnimplementedError();
  }

  @override
  Future<int> getQuantidadeSeguindo(String userId) {
    // TODO: implement getQuantidadeSeguindo
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getSeguidores(String userId) {
    // TODO: implement getSeguidores
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getSeguindo(String userId) {
    // TODO: implement getSeguindo
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getUserById(String userId) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUsersByName(String name) {
    // TODO: implement getUsersByName
    throw UnimplementedError();
  }

  @override
  Future<void> seguirPessoa({required int idUser}) {
    // TODO: implement seguirPessoa
    throw UnimplementedError();
  }

}