import 'package:book_app/model/comment_model.dart';
import 'package:book_app/modules/comment_post/repository/custom_coment_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const table = 'comment_post';

class CommentRepositorySupabase implements CustomComentRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<List<CommentModel>> getCommentFromPost(int idPost) async {
    var response = await supabase
        .from(table)
        .select("*, usuarios(name)")
        .eq('id_post', idPost) as List;
    List<CommentModel> listComments =
        response.map((element) => CommentModel.fromJson(element)).toList();
    return listComments;
  }

  @override
  Future<bool> addComment(CommentModel comment) async {
    try {
      await supabase.from(table).insert(comment.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
