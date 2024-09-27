import 'dart:developer';

import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_auth_repository.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:book_app/modules/auth/status_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @observable
  StatusLogin isLogadoStatus = StatusLogin.NAO_CARREGADO;

  UserController userController;
  GlobalKey<ScaffoldMessengerState> scaffoldKeyLoginPage =
      GlobalKey<ScaffoldMessengerState>();

  @observable
  bool loginIsLoading = false;

  @observable
  String erroNome = '';
  @observable
  String erroEmail = '';
  @observable
  String erroSenha = '';

  @observable
  bool passwordVisibility = false;

  final CustomAuthRepository _repository;

  _AuthControllerBase(this._repository, this.userController) {
    isAuthenticated();
  }

  UserModel? get user => _repository.user;

  @observable
  var isLogin = true;
  @observable
  var title = "Bem vindo ao BookApp!";
  @observable
  var botaoCadastrar = "Criar Conta";

  @observable
  var titleButton = "Entrar";

  @action
  void clear() {
    name.clear();
    email.clear();
    password.clear();
    erroEmail = '';
    erroSenha = '';
    erroNome = '';
  }

  @action
  togglePasswordVisibility() => passwordVisibility = !passwordVisibility;

  @action
  void toggleRegistrar() {
    isLogin = !isLogin;
    clear();
  }

  String? validarEmail(String email) {
    if (email.isEmpty) {
      erroEmail = "Campo não pode ser vazio!";
      return null;
    } else if (!RegExp(
            r'^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})$')
        .hasMatch(email)) {
      erroEmail = "Formato de email inválido!";
      return null;
    }
    erroEmail = '';
    return null;
  }

  @action
  String? validarSenha(String pass) {
    if (pass.length < 6) {
      erroSenha = "Senha precisa ser maior que 5!";
      return null;
    }
    erroSenha = '';
    return null;
  }

  @action
  String? validarNome(String nome) {
    if (nome.isEmpty) {
      erroNome = '';
      return null;
    }
    erroNome = '';
    return null;
  }

  isAuthenticated() async {
    try {
      if (_repository.user != null) {
        await userController.getUser();

        if (userController.user.passouIntroducao) {
          Modular.to.navigate('/initial/home');
          return;
        }

        Modular.to.navigate('/primeiro-acesso/apresentacao');
      } else {
        Modular.to.navigate('/auth/');
      }
    } catch (e) {
      await signOut();
    }
  }

  @action
  login() async {
    try {
      loginIsLoading = true;
      await _repository.signIn(email.text, password.text);
      await isAuthenticated();
      loginIsLoading = false;
    } on AuthException catch (e) {
      loginIsLoading = false;
    } catch (e) {
      log('$e');
      loginIsLoading = false;
    }
  }

  @action
  createuser() async {
    try {
      loginIsLoading = true;
      await _repository.createUser(email: email.text, password: password.text);
      await isAuthenticated();
      loginIsLoading = false;
    } catch (e) {
      print(e);
      loginIsLoading = false;
    }
  }

  @action
  signOut() async {
    try {
      await _repository.signOut();
      Modular.to.navigate('/auth/');
    } catch (e) {
      print('erro ao deslogar');
    }
  }
}
