import 'package:book_app/model/post_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const table = 'post';
class PostRepository{
  final supabase = Supabase.instance.client;
  
  addPost(PostModel post) async{
    try {
      await supabase.from(table).insert(post.toJson);
    } catch (e) {
      print(e);
    }
  }

  Future<List<PostModel>> getPosts() async{
    try {
      PostgrestList response = await supabase
                            .from('post')
                            .select('*, usuarios(name)');
      return response.map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}