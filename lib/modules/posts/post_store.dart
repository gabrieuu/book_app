import 'package:book_app/core/status.dart';
import 'package:book_app/model/postModel/post_model.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/service/auth_service.dart';
import 'package:book_app/modules/posts/post_repository/custom_posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'post_store.g.dart';

class PostStore = _PostStoreBase with _$PostStore;

abstract class _PostStoreBase with Store {
  CustomPostsRepository repository;
  //AuthRepository authRepository;

  @observable
  ObservableList<PostModel> posts = ObservableList.of([]);

  @observable
  Status situacaoPost = Status.NAO_CARREGADO;
  @observable
  Status situacaoPostUpload = Status.NAO_CARREGADO;

  final AuthService _authService;

  @observable
  bool searchIsSelect = false;

  @observable
  TextEditingController searchController = TextEditingController();

  final content = TextEditingController();

  _PostStoreBase(this.repository, this._authService) {
    init();
  }

  init() async {
    await getPosts();
  }

  @action
  Future<void> getPosts() async {
    situacaoPost = Status.CARREGANDO;
    var listPosts = await repository.getPosts();
    posts = ObservableList.of(listPosts);

    List<Future<void>> futures = posts.map((e) async {
      e.isCurtido = await isCurtido(e.id!);
    }).toList();

    await Future.wait(futures);
    posts.sort((a, b) => b.id!.compareTo(a.id!));
    situacaoPost = Status.SUCESSO;
  }

  Future<List<PostModel>> getPostsByUser(String userId) async {
    var list = await repository.getPostByUser(userId);
    return list;
  }

  @action
  Future<void> addPost(PostModel postModel) async {
    situacaoPostUpload = Status.CARREGANDO;
    // final postModel = PostModel(
    //     content: content.text, autorId: userController.user.id!, bookId: null);
    posts.add(postModel);
    print(posts.toString());
    await repository.addPost(postModel);
    situacaoPostUpload = Status.SUCESSO;
  }

  @action
  Future<void> curtirPost(PostModel post) async {
    int index = posts.indexWhere((element) => element.id == post.id);

    if (index != -1) {
      posts[index] = PostModel(
          content: post.content,
          autorId: post.autorId,
          id: post.id,
          autorName: post.autorName,
          bookId: post.bookId,
          quantidadeCurtidas: (post.isCurtido)
              ? post.quantidadeCurtidas! - 1
              : post.quantidadeCurtidas! + 1,
          quantidadeComentarios: post.quantidadeComentarios,
          isCurtido: !post.isCurtido);
    }
    UserModel? user = _authService.currentUser;
    if(user == null) throw Exception("Usuário não autenticado");
    await repository.curtirPost(post.id!, user.id!);
  }

  @action
  Future<bool> isCurtido(int idPost) async {
    UserModel? user = _authService.currentUser;
    if(user == null) throw Exception("Usuário não autenticado");
    return await repository.isCurtido(idPost, user.id!);
  }

  @action
  Future<int> getQuantidadeCurtidas(int idPost) async {
    return await repository.getQuantidadeCurtidas(idPost);
  }
}
