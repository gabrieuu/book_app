import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
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
  
  var titleButton = "Entrar";

  @action
  void toggleRegistrar () => isLogin = !isLogin;

  String? validarEmail(String mail){
    if(mail.isNotEmpty){
      return null;
    }else{
      return "error email!";
    }
  }

  String? validarSenha(String pass){
    if(pass.length > 5){
      return null;
    }else{
      return "senha precisa ser maior que 5!";
    }
  }

  String? validarNome(String nome){
    if(nome.isNotEmpty){
      return null;
    }else{
      return "Informe um nome";
    }
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
    await _repository.signIn(email.text, password.text);

    userIsAuthenticate = true;
  }
  
  @action
   createuser() async{
   await _repository.createUser(name.text, email.text, password.text);
   userIsAuthenticate = true;
  }

  @action
  signOut() async{
    await _repository.signOut();
    userIsAuthenticate = false;
  }

}