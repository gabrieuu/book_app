import 'package:book_app/model/comment_model.dart';

abstract class CustomComentRepository {
  Future<List<CommentModel>> getCommentFromPost(int idPost);
  Future<bool> addComment(CommentModel comment);
}
