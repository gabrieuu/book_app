import 'package:book_app/data/model/book_model.dart';
import 'package:book_app/data/service/auth_service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteService {

  final supabase = Supabase.instance.client;
  
  addFavorite(String idLivro) async{
   try {
      await supabase.from("favoritos").insert({
        "id_favoritos": "${AuthService.to.user!.id}$idLivro",
      "id_user" : AuthService.to.user!.id,
      "book_id" : idLivro
    });
   } on PostgrestException catch (e) {
     await supabase.from("favoritos").delete().eq("id_favoritos", "${AuthService.to.user!.id}$idLivro");
   }
  }

   Future<List<String>> booksFavorites() async{
    List<String> listBook = [];
    try {
      final response = await supabase.from("favoritos").select("book_id").eq("id_user", AuthService.to.user!.id);
      response.forEach((element) => listBook.add(element["book_id"]));
      print(listBook);
    } catch (e) {
      print(e);
    }
    
    return listBook;
  }
}