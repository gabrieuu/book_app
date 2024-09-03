import 'package:book_app/model/post_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const table = 'post';

class PostRepository {
  final supabase = Supabase.instance.client;

  addPost(PostModel post) async {
    try {
      await supabase.from(table).insert(post.toJson);
    } catch (e) {
      print(e);
    }
  }

  Future<List<PostModel>> getPosts() async {
    try {
      PostgrestList response =
          await supabase.from('postagens').select('*, usuarios(name)');
      return response.map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<PostModel>> getPostByUser(String idUser) async {
    try {
      var response = await supabase
          .from('postagens')
          .select('*, usuarios(name)')
          .eq('autor_id', idUser);
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(response);
      return data.map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> curtirPost(int idPost, String idUser) async {
    var response = await supabase
        .from('curtidas')
        .select()
        .eq('id_post', idPost)
        .eq('id_user', idUser) as List;
    if (response.isNotEmpty) {
      await supabase
          .from('curtidas')
          .delete()
          .eq('id_post', idPost)
          .eq('id_user', idUser);
      return;
    }
    try {
      await supabase
          .from('curtidas')
          .insert({'id_post': idPost, 'id_user': idUser});
    } catch (e) {
      print(e);
    }
  }

  Future<int> getQuantidadeCurtidas(int idPost) async {
    try {
      var response = await supabase
          .from('curtidas')
          .select('*')
          .eq('id_post', idPost)
          .count(CountOption.exact);
      return response.count;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<bool> isCurtido(int idPost, String idUser) async {
    try {
      var response = await supabase
          .from('curtidas')
          .select('id_post')
          .eq('id_post', idPost)
          .eq('id_user', idUser);
      return response.length > 0;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
