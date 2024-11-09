import 'package:book_app/model/user_model.dart';

abstract class CustomUserRepository {
  Future<UserModel> getUserById(String userId);

  Future<void> createUser(
      {String? idUser, required String email, required String password});

  Future<List<UserModel>> getUsersByName(String name);

  Future<void> alteraNomeAndUsername(
      {required String nome, required String username, required String userId});

  Future<void> alteraPrimeiroAcesso(String userId);

  Future<void> seguirPessoa(
      {required String userIdSeguidor, required String userIdSeguida});

  Future<bool> getIsSeguindo(String userIdLogado, String idUsuario);

  Future<List<UserModel>> getSeguidores(String userId);

  Future<List<UserModel>> getSeguindo(String userId);

  Future<int> getQuantidadeSeguidores(String userId);

  Future<int> getQuantidadeSeguindo(String userId);
}
