import 'package:book_app/core/snackbar.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_user_repository.dart';
import 'package:book_app/modules/auth/repository/user_repository.dart';
import 'package:book_app/modules/primeiro_acesso/telas_de_apresentacao/primeira_tela.dart';
import 'package:book_app/modules/primeiro_acesso/telas_de_apresentacao/segunda_tela.dart';
import 'package:book_app/modules/primeiro_acesso/telas_de_apresentacao/terceira_tela.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:one_context/one_context.dart';
part 'primeiro_acesso_controller.g.dart';

class PrimeiroAcessoController = _PrimeiroAcessoControllerBase
    with _$PrimeiroAcessoController;

abstract class _PrimeiroAcessoControllerBase with Store {
  @observable
  int indexSelecionado = 0;

  CustomUserRepository userRepository;
  UserController userController;

  final TextEditingController nome = TextEditingController();

  final TextEditingController username = TextEditingController();

  _PrimeiroAcessoControllerBase(this.userRepository, this.userController);

  navegaEntreAsTelas() {
    if (indexSelecionado == 0) {
      Modular.to.pushNamed('/primeiro-acesso/apresentacao');
    }
    if (indexSelecionado == 1) {
      Modular.to.pushNamed('/primeiro-acesso/criar-usuario');
    }
    if (indexSelecionado == 2) {
      Modular.to.pushNamed('/primeiro-acesso/finalizacao');
    }
  }

  String erroNome = '';

  String erroUsername = '';

  String? validaName(String? value) {
    if (value == null || value.isEmpty || value == '') {
      erroNome = "Campo não pode ser vazio!";
      return null;
    }
    erroNome = '';
    return null;
  }

  String? validaUsername(String? value) {
    if (value == null || value.isEmpty || value == '') {
      erroUsername = "Campo não pode ser vazio!";
      return null;
    }
    erroUsername = '';
    return null;
  }

  @action
  void proximoIndex() {
    if (indexSelecionado == 3) {
      return;
    }
    indexSelecionado++;
  }

  @action
  Future<void> alteraNomeAndUsername() async {
    try {
      await userRepository.alteraNomeAndUsername(
          nome: nome.text,
          username: username.text,
          userId: userController.user.id!);
      await userController.getUser();
      OneContext().showSnackBar(builder: (_) {
        return const SnackBar(
          content: Text('Nome e Username alterados com sucesso!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        );
      });
      proximoIndex();
    } catch (e) {
      OneContext().showSnackBar(builder: (_) {
        return const SnackBar(
          content: Text('Esse username já existe!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        );
      });
    }
  }

  Future<void> completaIntroducao() async {
    try {
      await userRepository.alteraPrimeiroAcesso(userController.user.id!);
      Modular.to.navigate('/initial');
    } catch (e) {
      OneContext().showSnackBar(builder: (_) {
        return const SnackBar(
          content: Text('Erro ao completar introdução!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        );
      });
    }
  }
}
