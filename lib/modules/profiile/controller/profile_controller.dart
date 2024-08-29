import 'package:book_app/core/status.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/model/post_model.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
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

  @observable
  PostStore postStore;

  @observable
  ObservableList<PostModel> myPosts = ObservableList.of([]);

  @observable
  ObservableList<Book> myFavoritas = ObservableList.of([]);

  GlobalKey<ScaffoldState> globalkey = GlobalKey<ScaffoldState>();

  @observable
  Status situacaoPost = Status.NAO_CARREGADO;

  @observable
  Status situacaoFavoritos = Status.NAO_CARREGADO;

  _ProfileControllerBase({
    required this.userController,
    required this.postStore,
    required this.favoritasStore
  });

  @action
  getPostsByUserId({String? userId}) async {
    situacaoPost = Status.CARREGANDO;
    myPosts = ObservableList.of(await postStore.getPostsByUser(userId ?? userController.user.id!));
    situacaoPost = Status.SUCESSO;
  }
  @action
  getFavoritosByUserId({String? userId}) async {
    situacaoFavoritos = Status.CARREGANDO;
    myFavoritas = ObservableList.of(await favoritasStore.getBooksFavorites(userId));
    situacaoFavoritos = Status.SUCESSO;
  }


}