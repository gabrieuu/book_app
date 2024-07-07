import 'package:book_app/model/comment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const table = 'comment_post';
class CommentRepository{

  final supabase = Supabase.instance.client;

  Future<List<CommentModel>> getCommentFromPost(int idPost) async{
    var response = await supabase.from(table).select("*").eq('id_post', idPost) as List;
    List<CommentModel> listComments = response.map((element) => CommentModel.fromJson(element)).toList();
    return listComments;
  }

  Future<bool> addComment(CommentModel comment) async{
    try {
      await supabase.from(table).insert(comment.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}