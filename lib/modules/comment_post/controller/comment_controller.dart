import 'package:book_app/core/status.dart';
import 'package:book_app/model/comment_model.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:book_app/modules/comment_post/repository/comment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'comment_controller.g.dart';

class CommentController = _CommentControllerBase with _$CommentController;

abstract class _CommentControllerBase with Store {
  
  CommentRepository repository;
  AuthRepository authRepository = Modular.get();
  
  @observable
  ObservableList<CommentModel> comments = ObservableList();

  @observable
  Status commentsLoading = Status.NAO_CARREGADO;

  final commentInsert = TextEditingController();

  _CommentControllerBase({required this.repository});

  @action
  getComments(int idPost) async{
    commentsLoading = Status.CARREGANDO;
    var commentsResponse = await repository.getCommentFromPost(idPost);
    comments.clear();
    comments.addAll(commentsResponse);
    commentsLoading = Status.SUCESSO;
  }
  @action
  addComments(int idPost, String userId) async{
    final comment = CommentModel(content: commentInsert.text, idPost: idPost, autorId: userId);
    commentInsert.clear();
    await repository.addComment(comment);
    getComments(idPost);
  }

  Future<int> quantidadeDeComentarios(int idPost) async{
    var listComment = await repository.getCommentFromPost(idPost);
    return listComment.length;
  }
}