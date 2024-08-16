import 'package:book_app/core/status.dart';
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
  
  @observable
  PostStore postStore;

  @observable
  ObservableList<PostModel> myPosts = ObservableList.of([]);

  GlobalKey<ScaffoldState> globalkey = GlobalKey<ScaffoldState>();

  @observable
  Status situacaoPost = Status.NAO_CARREGADO;

  @observable
  FavoritasStore favoritasStore;

  _ProfileControllerBase({
    required this.userController,
    required this.favoritasStore,
    required this.postStore,
  }){
    getPostsByUserId();
  }

  @action
  void setUser(UserModel user){
    getPostsByUserId();
  }

  @action
  getPostsByUserId() async {
    situacaoPost = Status.CARREGANDO;
    myPosts = ObservableList.of(await postStore.getPostsByUser(userController.user.id!));
    situacaoPost = Status.SUCESSO;
  }



}