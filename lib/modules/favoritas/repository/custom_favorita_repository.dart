import 'package:book_app/model/book_model.dart';

abstract class CustomFavoritaRepository {
  Future<void> addFavorite({required String idLivro, required String idUser});
  Future<void> removeFavorita(
      {required String idLivro, required String idUser});
  Future<bool> isFavorita({required Book book, required String userId});
  Future<List<String>> booksFavorites(String userId);
}
