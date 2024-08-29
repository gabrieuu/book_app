import 'package:book_app/model/book_model.dart';
import 'package:book_app/database/bd_book.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritaRepository {
  final database = BDBook();
  final supabase = Supabase.instance.client;

  addFavorite({required String idLivro, required String idUser}) async {
    //database.addFavorito();
    var response = await supabase.from("favoritos").insert({
      "id_favoritos": "$idUser$idLivro",
      "id_user": idUser,
      "book_id": idLivro
    });

    print(response);
  }

  Future<void> removeFavorita({required String idLivro, required String idUser}) async {
    await supabase
        .from("favoritos")
        .delete()
        .eq("id_favoritos", "$idUser$idLivro");
  }

  Future<bool> isFavorita({required Book book, required String userId}) async{
    List response = await supabase.from("favoritos").select("book_id").eq('id_user', userId).eq('id_favoritos', '$userId${book.id}');
    if(response.isNotEmpty) return true;
    return false;
  }

  Future<List<String>> booksFavorites(String userId) async {
    List<String> listBook = [];
    try {
      final response = await supabase
          .from("favoritos")
          .select("book_id")
          .eq("id_user", userId);
      response.forEach((element) => listBook.add(element["book_id"]));
    } catch (e) {
      print(e);
    }

    return listBook;
  }
}
