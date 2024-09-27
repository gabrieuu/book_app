import 'dart:developer';

import 'package:book_app/model/book_model.dart';
import 'package:book_app/core/status.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_auth_repository.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:book_app/modules/books/repository/book_repository.dart';
import 'package:book_app/modules/books/repository/custom_book_repository.dart';
import 'package:book_app/modules/books/store/book_store.dart';
import 'package:book_app/modules/favoritas/repository/custom_favorita_repository.dart';
import 'package:book_app/modules/favoritas/repository/favorite_repository.dart';
import 'package:mobx/mobx.dart';
part 'favoritas_store.g.dart';

class FavoritasStore = _FavoritasStoreBase with _$FavoritasStore;

abstract class _FavoritasStoreBase with Store {
  //final bookRepository = Modular.get<BookRepository>();
  final CustomFavoritaRepository favoritesRepository;
  //CustomAuthRepository authRepository;
  UserController userController;
  final CustomBookRepository bookRepository;

  @observable
  Status favoritasLoading = Status.NAO_CARREGADO;

  @observable
  ObservableList<Book> listBooksFavorites = ObservableList.of([]);

  _FavoritasStoreBase(
      this.bookRepository, this.favoritesRepository, this.userController) {
    _init();
  }

  _init() async {
    log('favoritas');
    await getBooksFavorites(null);
  }

  @action
  Future<void> addFavorite({required Book book, String? idUser}) async {
    listBooksFavorites.add(book);
    await favoritesRepository.addFavorite(
        idLivro: book.id, idUser: idUser ?? userController.user.id!);
  }

  Future<List<Book>> getBooksFavorites(String? userId) async {
    List<String> lists = await favoritesRepository
        .booksFavorites(userId ?? userController.user.id!);
    List<Book> listBooks = await bookRepository.getBooksByListId(lists);
    if (userId == null) {
      listBooksFavorites = ObservableList.of(listBooks);
    }
    return listBooks;
  }

  @action
  bool isFavorita(Book book) {
    for (int i = 0; i < listBooksFavorites.length; i++) {
      if (listBooksFavorites[i].id == book.id) return true;
    }
    return false;
  }

  @action
  removeFavorita(Book book) async {
    listBooksFavorites.removeWhere((element) => element.id == book.id);
    await favoritesRepository.removeFavorita(
        idLivro: book.id, idUser: userController.user.id!);
  }
}
