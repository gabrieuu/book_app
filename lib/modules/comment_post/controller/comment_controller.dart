import 'package:book_app/core/status.dart';
import 'package:book_app/model/comment_model.dart';
import 'package:book_app/model/post_model.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_auth_repository.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:book_app/modules/comment_post/repository/comment_repository.dart';
import 'package:book_app/modules/comment_post/repository/custom_coment_repository.dart';
import 'package:book_app/modules/posts/post_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'comment_controller.g.dart';

class CommentController = _CommentControllerBase with _$CommentController;

abstract class _CommentControllerBase with Store {
  CustomComentRepository repository;
  CustomAuthRepository authRepository;

  @observable
  PostStore postStore;

  @observable
  ObservableList<CommentModel> comments = ObservableList();

  @observable
  PostModel? postSelecionado;

  @observable
  Status commentsLoading = Status.NAO_CARREGADO;

  final commentInsert = TextEditingController();

  _CommentControllerBase(
      {required this.repository,
      required this.authRepository,
      required this.postStore});

  @action
  getComments(int idPost) async {
    commentsLoading = Status.CARREGANDO;
    var commentsResponse = await repository.getCommentFromPost(idPost);
    comments.clear();
    comments.addAll(commentsResponse);
    commentsLoading = Status.SUCESSO;
  }

  @action
  addComments(String userId) async {
    final comment = CommentModel(
        content: commentInsert.text,
        idPost: postSelecionado!.id!,
        autorId: userId);
    commentInsert.clear();
    await repository.addComment(comment);
    int index = postStore.posts
        .indexWhere((element) => element.id == postSelecionado!.id);
    if (index != -1) {
      postSelecionado!.quantidadeComentarios++;
      postStore.posts[index] = postSelecionado!;
    }
    getComments(postSelecionado!.id!);
  }

  Future<int> quantidadeDeComentarios(int idPost) async {
    var listComment = await repository.getCommentFromPost(idPost);
    return listComment.length;
  }
}
