import 'package:book_app/core/model/book_model.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritaRepository {

  final supabase = Supabase.instance.client;
  AuthRepository authRepository = AuthRepository();
  addFavorite(String idLivro) async{
   try {
      await supabase.from("favoritos").insert({
        "id_favoritos": "${authRepository.user!.id}$idLivro",
      "id_user" : authRepository.user!.id,
      "book_id" : idLivro
    });
   } on PostgrestException catch (e) {
     await supabase.from("favoritos").delete().eq("id_favoritos", "${authRepository.user!.id}$idLivro");
   }
  }

   Future<List<String>> booksFavorites() async{
    List<String> listBook = [];
    try {
      final response = await supabase.from("favoritos").select("book_id").eq("id_user", authRepository.user!.id);
      response.forEach((element) => listBook.add(element["book_id"]));
      print(listBook);
    } catch (e) {
      print(e);
    }
    
    return listBook;
  }
}