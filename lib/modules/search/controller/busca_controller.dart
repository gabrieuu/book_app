import 'package:book_app/core/status.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_user_repository.dart';
import 'package:book_app/modules/auth/repository/user_repository.dart';
import 'package:book_app/modules/books/repository/book_repository.dart';
import 'package:book_app/modules/books/repository/custom_book_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'busca_controller.g.dart';

class BuscaController = _BuscaControllerBase with _$BuscaController;

abstract class _BuscaControllerBase with Store {
  TextEditingController searchTextFieldController = TextEditingController();

  @observable
  UserController userController;

  @observable
  int tabBarSelecionada = 0;

  @observable
  ObservableList<UserModel> leitoresEncrontrados = ObservableList.of([]);
  @observable
  ObservableList<Book> livrosEncontrados = ObservableList.of([]);

  CustomUserRepository userRepository;
  CustomBookRepository bookRepository;

  @observable
  Status statusLeitoresCarregando = Status.NAO_CARREGADO;
  @observable
  Status statusLivrosCarregando = Status.NAO_CARREGADO;

  _BuscaControllerBase(
      this.userController, this.userRepository, this.bookRepository);

  @action
  Future<void> buscarPorTabBar(int value) async {
    if (tabBarSelecionada == value) return;
    tabBarSelecionada = value;
    if (searchTextFieldController.text.isEmpty) {
      return;
    }
    await buscar();
  }

  @action
  Future<void> buscar({String? value}) async {
    if (value != null) {
      leitoresEncrontrados.clear();
      livrosEncontrados.clear();
    }
    if (tabBarSelecionada == 0) {
      if (livrosEncontrados.isEmpty) {
        await buscaLivros(value ?? searchTextFieldController.text);
      }
      return;
    }
    if (tabBarSelecionada == 1) {
      if (leitoresEncrontrados.isEmpty) {
        await buscaLeitores(value ?? searchTextFieldController.text);
      }
      return;
    }
  }

  @action
  Future<void> buscaLeitores(String name) async {
    try {
      statusLeitoresCarregando = Status.CARREGANDO;
      leitoresEncrontrados =
          ObservableList.of(await userRepository.getUsersByName(name));
      statusLeitoresCarregando = Status.SUCESSO;
    } catch (e) {
      statusLeitoresCarregando = Status.ERRO;
    }
  }

  @action
  Future<void> buscaLivros(String nome) async {
    try {
      statusLivrosCarregando = Status.CARREGANDO;
      livrosEncontrados = ObservableList.of(
          await bookRepository.fetchAll(searchTextFieldController.text));
      statusLivrosCarregando = Status.SUCESSO;
    } catch (e) {
      statusLivrosCarregando = Status.ERRO;
    }
  }
}
