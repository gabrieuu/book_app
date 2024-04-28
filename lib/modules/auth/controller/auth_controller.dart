import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mobx/mobx.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AuthRepository repository;

  _AuthControllerBase(this.repository){
    _isAuthenticated();
  }

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
    if(repository.user != null){
      userIsAuthenticate = true;
    }else{
      userIsAuthenticate = false;
    }

  }

  @action
  login() async{
    await repository.signIn(email.text, password.text);
    userIsAuthenticate = true;
  }
  
  @action
   createuser() async{
   await repository.createUser(name.text, email.text, password.text);
   userIsAuthenticate = true;
  }

  @action
  signOut() async{
    await repository.signOut();
    userIsAuthenticate = false;
  }

}