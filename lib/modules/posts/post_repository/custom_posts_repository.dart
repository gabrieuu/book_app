import 'package:book_app/model/post_model.dart';

abstract class CustomPostsRepository {
  Future<void> addPost(PostModel post);
  Future<List<PostModel>> getPosts();
  Future<List<PostModel>> getPostByUser(String idUser);
  Future<void> curtirPost(int idPost, String idUser);
  Future<int> getQuantidadeCurtidas(int idPost);
  Future<bool> isCurtido(int idPost, String idUser);
}
