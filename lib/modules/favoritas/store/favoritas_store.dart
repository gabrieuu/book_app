import 'package:book_app/core/model/book_model.dart';
import 'package:book_app/core/client_http/dio_client.dart';
import 'package:book_app/modules/favoritas/repository/favorite_repository.dart';
import 'package:book_app/modules/home/repository/book_repository.dart';
import 'package:mobx/mobx.dart';
part 'favoritas_store.g.dart';

class FavoritasStore = _FavoritasStoreBase with _$FavoritasStore;

abstract class _FavoritasStoreBase with Store {
  final bookRepository = BookRepository(DioClient());
  final FavoritaRepository favoritesRepository;

  @observable
  List<Book> listBooksFavorites = [];

  _FavoritasStoreBase(this.favoritesRepository){
    _initFavoritaStore();
  }

  _initFavoritaStore() async{
    await getBooksFavorites();
  }

  @action
  Future<void> getBooksFavorites() async{
    List<String> lists = await favoritesRepository.booksFavorites();
    listBooksFavorites = await bookRepository.fetchFavoritesBooks(lists);
  }
}