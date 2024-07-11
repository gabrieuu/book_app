import 'package:book_app/model/book_model.dart';
import 'package:book_app/database/bd_book.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritaRepository {
  final database = BDBook();
  final supabase = Supabase.instance.client;
  AuthRepository authRepository = Modular.get();

  addFavorite(String idLivro) async {
    //database.addFavorito();
    await supabase.from("favoritos").insert({
      "id_favoritos": "${authRepository.user!.id}$idLivro",
      "id_user": authRepository.user!.id,
      "book_id": idLivro
    });
  }

  removeFavorita(String idLivro) async {
    await supabase
        .from("favoritos")
        .delete()
        .eq("id_favoritos", "${authRepository.user!.id}$idLivro");
  }

  Future<bool> isFavorita(Book book) async{
    List response = await supabase.from("favoritos").select("book_id").eq('id_user', authRepository.user!.id).eq('id_favoritos', '${authRepository.user!.id}${book.id}');
    if(response.isNotEmpty) return true;
    return false;
  }

  Future<List<String>> booksFavorites() async {
    List<String> listBook = [];
    try {
      final response = await supabase
          .from("favoritos")
          .select("book_id")
          .eq("id_user", authRepository.user!.id);
      response.forEach((element) => listBook.add(element["book_id"]));
      print(listBook);
    } catch (e) {
      print(e);
    }

    return listBook;
  }
}
