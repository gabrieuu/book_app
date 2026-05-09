import 'dart:developer';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/core/status.dart';
import 'package:book_app/modules/auth/service/auth_service.dart';
import 'package:book_app/modules/books/repository/custom_book_repository.dart';
import 'package:book_app/modules/favoritas/repository/custom_favorita_repository.dart';
import 'package:mobx/mobx.dart';
part 'favoritas_store.g.dart';

class FavoritasStore = _FavoritasStoreBase with _$FavoritasStore;

abstract class _FavoritasStoreBase with Store {
  final CustomFavoritaRepository favoritesRepository;
  final AuthService _authService;
  final BookRepository bookRepository;

  @observable
  Status favoritasLoading = Status.NAO_CARREGADO;

  @observable
  ObservableList<BookModel> listBooksFavorites = ObservableList.of([]);

  _FavoritasStoreBase(
      this.bookRepository, this.favoritesRepository, this._authService) {
    _init();
  }

  _init() async {
    log('favoritas');
    await getBooksFavorites(null);
  }

  @action
  Future<void> addFavorite({required BookModel book, String? idUser}) async {
    log('addFavorite não implementado');
  }

  Future<List<BookModel>> getBooksFavorites(String? userId) async {
    log('getBooksFavorites não implementado');
    return [];
  }

  @action
  bool isFavorita(BookModel book) {
    log('isFavorita não implementado');
    return false;
  }

  @action
  removeFavorita(BookModel book) async {
    log('removeFavorita não implementado');
  }
}
