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
  ObservableList<PostModel> posts = ObservableList.of([]);

  @observable
  Status situacaoPost = Status.NAO_CARREGADO;
  @observable
  Status situacaoPostUpload = Status.NAO_CARREGADO;

  @observable
  bool searchIsSelect = false;

  @observable
  TextEditingController searchController = TextEditingController();

  final content = TextEditingController();

  _PostStoreBase(this.repository, this.authRepository) {
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

  Future<List<PostModel>>  getPostsByUser(String userId) async{
    var list = await repository.getPostByUser(userId);
    return list;
  }

  @action
  Future<void> addPost() async {
    situacaoPostUpload = Status.CARREGANDO;
    final postModel = PostModel(
        content: content.text, autorId: authRepository.user!.id, bookId: null);
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
          quantidadeCurtidas: (post.isCurtido) ? post.quantidadeCurtidas! - 1 : post.quantidadeCurtidas! + 1,
          quantidadeComentarios: post.quantidadeComentarios,
          isCurtido: !post.isCurtido);
    }
    await repository.curtirPost(post.id!, authRepository.user!.id);
  }

  @action
  Future<bool> isCurtido(int idPost) async {
    return await repository.isCurtido(idPost, authRepository.user!.id);
  }

  @action
  Future<int> getQuantidadeCurtidas(int idPost) async {
    return await repository.getQuantidadeCurtidas(idPost);
  }
}
