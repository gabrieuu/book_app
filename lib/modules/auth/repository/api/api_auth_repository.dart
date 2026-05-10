import 'dart:developer';

import 'package:book_app/database/secure_storage/custom_secure_storage.dart';
import 'package:book_app/infra/client_http/client_http.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/repository/api/dto/login_response_dto.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_auth_repository.dart';

class ApiAuthRepository implements CustomAuthRepository{

  final ClientHttp client;
  final CustomSecureStorage customSecureStorage = CustomSecureStorage();
  UserModel? _user;

  ApiAuthRepository(this.client);

  @override
  Future<bool> register({required String email, required String password}) async{
    final response = await client.post('/auth/register', data: {
      'email' : email,
      'password': password
    });

    customSecureStorage.saveJWTToken(response['token']);

    return isAutenticated();
  }

  @override
  Future<bool> signIn(String email, String password) async {
    final response = await client.post('/auth/login', data: {
      'email' : email,
      'password': password
    });

    customSecureStorage.saveJWTToken(response['token']);

    return isAutenticated();
  }

  @override
  Future<void> signOut() async{
    log('deslogado');
  }

  @override
  Future<UserModel?> get user async {
    if(_user != null) {
      return _user;
    }

    final token = await customSecureStorage.getJWTToken();
    if(token == null) {
      return null;
    }

    final response = await client.get('/auth/me');
    _user = UserResponseDto.fromMap(response).toUserModel();
    return _user;
  }

  @override
  Future<bool> isAutenticated() async{
    return await customSecureStorage.getJWTToken() != null;
  }
  
  @override
  Future<void> updateNameAndUsername({required String nome, required String username}) async{
    final response = await client.post('/auth/update-user', data: {
      'name': nome,
      'username': username
    });
  }

}