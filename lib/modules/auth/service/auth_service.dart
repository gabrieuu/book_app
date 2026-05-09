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
      final user = await _repository.signIn(email, password);
      _currentUser = user;
      Modular.to.navigate('/initial/home');
      return Result.success(true);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<bool>> createUser(
      {required String email, required String password}) async {
    try {
      final user = await _repository.createUser(email: email, password: password);
      _currentUser = user;
      return Result.success(true);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<void> signOut() async {
    if(_repository.user == null) return;
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

      if (_currentUser!.passouIntroducao) {
        Modular.to.navigate('/initial/home');
        return;
      }

      Modular.to.navigate('/primeiro-acesso/apresentacao');
      return;
    } catch (e) {
      await _repository.signOut();
      Modular.to.navigate('/auth');
    }
  }

  Future<bool> isAuthenticated() async {
    return _repository.user != null;
  }
}