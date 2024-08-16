import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  GlobalKey<ScaffoldMessengerState> scaffoldKeyLoginPage = GlobalKey<ScaffoldMessengerState>();

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
  
  final AuthRepository _repository;

  _AuthControllerBase(this._repository){
    _isAuthenticated();
  }

  User? get user => _repository.user;

  @observable
  var isLogin = true;
  @observable
  var title = "Bem vindo ao BookApp!";
  @observable
  var botaoCadastrar = "Criar Conta";
  
  @observable
  var userIsAuthenticate = false;
  
  @observable
  var titleButton = "Entrar";

  @action
  void clear(){
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
  void toggleRegistrar (){
    isLogin = !isLogin;
    clear();
  }

  String? validarEmail(String email){
    if(email.isEmpty){
      erroEmail = "Campo não pode ser vazio!";
       return null;
    }else if(!RegExp(r'^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})$')
      .hasMatch(email)){
        erroEmail = "Formato de email inválido!";
         return null;
    }
    erroEmail = '';
      return null;

  }

  @action
  String? validarSenha(String pass){
    if(pass.length < 6){
      erroSenha = "Senha precisa ser maior que 5!";
      return null;
    }
    erroSenha = '';
      return null;
    
  }

  @action
  String? validarNome(String nome){
    if(nome.isEmpty){
      erroNome = '';
      return null;
    }
    erroNome = '';
    return null;
    
  }

  _isAuthenticated(){
    if(_repository.user != null){
      userIsAuthenticate = true;
    }else{
      userIsAuthenticate = false;
    }

  }

  @action
  login() async{
    try {
      loginIsLoading = true;
      await _repository.signIn(email.text, password.text);
      userIsAuthenticate = true;
      Modular.to.navigate('/initial');
      loginIsLoading = false;
    } on AuthException catch (e) {
      loginIsLoading = false;
    }
  }
  
  @action
   createuser() async{
    loginIsLoading = true;
   await _repository.createUser(name.text, email.text, password.text);
   Modular.to.navigate('/initial');
   userIsAuthenticate = true;
   loginIsLoading = false;
  }

  @action
  signOut() async{
    await _repository.signOut();
    userIsAuthenticate = false;
  }

}