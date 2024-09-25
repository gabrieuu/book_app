import 'dart:developer';

import 'package:book_app/core/status.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/model/post_model.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/auth/repository/user_repository.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:book_app/modules/posts/post_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  @observable
  UserController userController;

  FavoritasStore favoritasStore;

  UserRepository userRepository;

  @observable
  int quantidadeSeguidores = 0;
  @observable
  int quantidadeSeguindo = 0;

  @observable
  int tabBarSelecionada = 0;
  @observable
  PostStore postStore;

  @observable
  bool isSeguindo = false;

  @observable
  ObservableList<PostModel> myPosts = ObservableList.of([]);

  @observable
  ObservableList<Book> myFavoritas = ObservableList.of([]);

  GlobalKey<ScaffoldState> globalkey = GlobalKey<ScaffoldState>();

  @observable
  List<UserModel> listSeguidores = [];

  @observable
  List<UserModel> listSeguindo = [];

  @observable
  Status situacaoPost = Status.NAO_CARREGADO;

  @observable
  Status situacaoFavoritos = Status.NAO_CARREGADO;

  _ProfileControllerBase(
      {required this.userController,
      required this.postStore,
      required this.favoritasStore,
      required this.userRepository});

  @action
  Future<void> init(String? userId) async {
    await Future.wait<void>([
      getPostsByUserId(userId: userId),
      getFavoritosByUserId(userId: userId),
      getQuantidadeSeguidores(userId),
      getQuantidadeSeguindo(userId),
      getIsSeguindo(userId),
      getSeguidores(userId),
      getSeguindo(userId)
    ]);
  }

  @action
  Future<void> getSeguidores(String? userId) async {
    listSeguidores =
        await userRepository.getSeguidores(userId ?? userController.user.id!);
  }

  @action
  Future<void> getSeguindo(String? userId) async {
    listSeguindo =
        await userRepository.getSeguindo(userId ?? userController.user.id!);
  }

  @action
  Future<void> getIsSeguindo(String? userId) async {
    if (userId == null) return;
    isSeguindo =
        await userRepository.getIsSeguindo(userController.user.id!, userId);
  }

  @action
  Future<void> getPostsByUserId({String? userId}) async {
    try {
      situacaoPost = Status.CARREGANDO;
      myPosts = ObservableList.of(
          await postStore.getPostsByUser(userId ?? userController.user.id!));
      situacaoPost = Status.SUCESSO;
    } catch (e) {
      situacaoPost = Status.ERRO;
      log('$e');
    }
  }

  @action
  Future<void> getFavoritosByUserId({String? userId}) async {
    try {
      situacaoFavoritos = Status.CARREGANDO;
      myFavoritas =
          ObservableList.of(await favoritasStore.getBooksFavorites(userId));
      situacaoFavoritos = Status.SUCESSO;
    } catch (e) {
      log('$e');
    }
  }

  @action
  seguirPessoa(String pessoaIdSeguida) async {
    try {
      isSeguindo = !isSeguindo;
      await userRepository.seguirPessoa(
          userIdSeguidor: userController.user.id!,
          userIdSeguida: pessoaIdSeguida);
    } catch (e) {
      quantidadeSeguidores--;
    }
    await getQuantidadeSeguidores(pessoaIdSeguida);
  }

  @action
  Future<void> getQuantidadeSeguidores(String? userId) async {
    quantidadeSeguidores = await userRepository
        .getQuantidadeSeguidores(userId ?? userController.user.id!);
  }

  @action
  Future<void> getQuantidadeSeguindo(String? userId) async {
    quantidadeSeguindo = await userRepository
        .getQuantidadeSeguindo(userId ?? userController.user.id!);
  }

  @computed
  double get getAlturaTabbar {
    if (tabBarSelecionada == 0) {
      return myPosts.length * 160 + 80;
    }
    return myFavoritas.length * 160 + 50;
  }
}
