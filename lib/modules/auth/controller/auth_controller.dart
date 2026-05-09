import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/service/auth_service.dart';
import 'package:book_app/modules/auth/status_login.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @observable
  StatusLogin isLogadoStatus = StatusLogin.NAO_CARREGADO;

  GlobalKey<ScaffoldMessengerState> scaffoldKeyLoginPage =
      GlobalKey<ScaffoldMessengerState>();

  @observable
  bool loginIsLoading = false;
  
  @observable
  String? loginErrorMessage;

  @observable
  String erroNome = '';
  @observable
  String erroEmail = '';
  @observable
  String erroSenha = '';

  @observable
  bool passwordVisibility = false;


  _AuthControllerBase(this._authService);

  final AuthService _authService;

  UserModel? get user => _authService.currentUser;

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

  @action
  Future<void> redirectAutentication() => _authService.redirectAutentication();

  @action
  login() async {
    loginIsLoading = true;
    final result = await _authService.signIn(email.text, password.text);
    if(result.isFailure){
      loginErrorMessage = result.messageOrNull;
      loginIsLoading = false;
      return;
    }
    loginIsLoading = false;
    loginErrorMessage = null;
   
  }

  @action
  createuser() async {
    loginIsLoading = true;
    final result = await _authService.createUser(email: email.text, password: password.text);
    if(result.isFailure){
      loginErrorMessage = result.messageOrNull;
      loginIsLoading = false;
      return;
    }
    loginErrorMessage = null;
    loginIsLoading = false;
  }

  @action
  signOut() async => await _authService.signOut();
}
