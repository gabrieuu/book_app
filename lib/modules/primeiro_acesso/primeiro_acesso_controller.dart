import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_auth_repository.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_user_repository.dart';
import 'package:book_app/modules/auth/service/auth_service.dart';
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

  final CustomAuthRepository userRepository;
  final AuthService _authService;
  final TextEditingController nome = TextEditingController();

  final TextEditingController username = TextEditingController();

  _PrimeiroAcessoControllerBase(this.userRepository, this._authService);

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
      if(_authService.currentUser == null) throw Exception("Usuário não autenticado");

      await userRepository.updateNameAndUsername(
          nome: nome.text,
          username: username.text);

      _authService.currentUser!.name = nome.text;
      _authService.currentUser!.username = username.text;
      
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
    Modular.to.navigate('/initial/home');
  }
}
