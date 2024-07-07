import 'package:book_app/core/status.dart';
import 'package:book_app/model/post_model.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:book_app/modules/posts/post_repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'post_store.g.dart';

class PostStore = _PostStoreBase with _$PostStore;

abstract class _PostStoreBase with Store {
  PostRepository repository;
  AuthRepository authRepository;

  @observable
  List<PostModel> posts = [];

  @observable
  Status situacaoPost = Status.NAO_CARREGADO;
  @observable
  Status situacaoPostUpload = Status.NAO_CARREGADO;
  
  final content = TextEditingController();

  _PostStoreBase(this.repository, this.authRepository){
    init();
    reaction((_) => situacaoPostUpload, (_) {
      if(situacaoPostUpload == Status.SUCESSO) getPosts();
     });
  }

  init() async{
   await getPosts();
  }

  Future<void> getPosts() async{
    situacaoPost = Status.CARREGANDO;
    posts = await repository.getPosts();
    posts.sort((a, b) => b.id!.compareTo(a.id!));
    situacaoPost = Status.SUCESSO;
  }
  
  void addPost() async{
    situacaoPostUpload = Status.CARREGANDO;
    final postModel = PostModel(content: content.text, autorId: authRepository.user!.id, bookId: null);
    await repository.addPost(postModel);
    situacaoPostUpload = Status.SUCESSO;
  }

}