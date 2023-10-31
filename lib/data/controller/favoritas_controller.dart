import 'package:book_app/data/bloc/favoritas_bloc/favoritas_event.dart';
import 'package:book_app/data/model/book_model.dart';
import 'package:book_app/data/service/book_service.dart';
import 'package:book_app/data/service/client_http/dio_client.dart';
import 'package:book_app/data/service/favorite_service/favorite_service.dart';

class FavoritasController{
  final service = BookService(DioClient());
  final favoritesService = FavoriteService();

  AddBookFavorite(String idBook) async{
    await favoritesService.addFavorite(idBook);
  }

  Future<List<Book>> getBooksFavorites() async{
    List<String> lists = await favoritesService.booksFavorites();
    return await service.fetchFavoritesBooks(lists);
  }
}