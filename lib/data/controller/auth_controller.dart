import 'package:book_app/data/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();


  var isLogin = true.obs;
  var title = "Bem vindo ao BookApp!".obs;
  var botaoCadastrar = "Criar Conta".obs;
  var titleButton = "Entrar";
  void toggleRegistrar () => isLogin.value = !isLogin.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //ever(isLogin, (callback) => null)
  }

  String? validarEmail(String mail){
    if(mail.isNotEmpty && mail != null){
      return null;
    }else{
      return "error email!";
    }
  }

  String? validarSenha(String pass){
    if(pass != null && pass.length > 5){
      return null;
    }else{
      return "senha precisa ser maior que 5!";
    }
  }

  String? validarNome(String nome){
    if(nome.isNotEmpty && nome != null){
      return null;
    }else{
      return "Informe um nome";
    }
  }

  login(){
    AuthService.to.signIn(email.text, password.text);
  }
   createuser(){
    AuthService.to.createUser(name.text, email.text, password.text);
   }
}