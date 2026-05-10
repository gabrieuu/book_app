import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_auth_repository.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_user_repository.dart';
import 'package:book_app/shared/result.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthService {
  final CustomAuthRepository _repository;
  final CustomUserRepository _userRepository;
  UserModel? _currentUser;
  
  AuthService(this._repository, this._userRepository);

  Future<void> _initializeCurrentUser() async {
    _currentUser = await _repository.user;
  }

  UserModel? get currentUser => _currentUser;

  Future<Result<bool>> signIn(String email, String password) async {
    try {
      await _repository.signIn(email, password);
      _currentUser = await _repository.user;
      Modular.to.navigate('/initial/home');
      return Result.success(true);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<bool>> createUser(
      {required String email, required String password}) async {
    try {
      await _repository.register(email: email, password: password);
      _currentUser = await _repository.user;
      return Result.success(true);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    Modular.to.navigate('/auth');
  }

  Future<void> redirectAutentication() async {
    try {
      final isAutenticated = await isAuthenticated();

      if(!isAutenticated) {
        Modular.to.navigate('/auth');
        return;
      }

      if(_currentUser == null) {
        await _initializeCurrentUser();
      }

      UserModel user = _currentUser!;

      if(user.username.isEmpty){
        Modular.to.navigate('/primeiro-acesso/apresentacao');
      }

      Modular.to.navigate('/initial/home');
    } catch (e) {
      await _repository.signOut();
      Modular.to.navigate('/auth');
    }
  }

  Future<bool> isAuthenticated() async {
    return _repository.isAutenticated();
  }
}