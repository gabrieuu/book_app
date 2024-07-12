import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/books/repository/book_repository.dart';
import 'package:book_app/core/status.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'book_store.g.dart';

class BookStore = _BookStoreBase with _$BookStore;

abstract class _BookStoreBase with Store {

  @observable
  List<Book> listBooks = [];

  @observable
  List<Book> listBooksSearches = [];

  @observable
  int indexActionChipSelect = 0;
  @observable
  bool searchIsSelect = false;
  @observable
  Status livrosCarregados = Status.NAO_CARREGADO;

  @observable
  List<String> listCategorias = ["Romance", "Fiction", "Action", "Horror", "Mistery", "Comedy"];

  BookRepository service;

  // FavoritaRepository favoritaRepository;
  TextEditingController searchBook = TextEditingController();

  _BookStoreBase(this.service){
    _initBookStore();
  }

  _initBookStore() async{
    await fetchBookByCategory();
  }

  @action
  tornaLivroFavorito(Book book){
    listBooks.where((element ) => element.id == book.id).first.isFavorite = !listBooks.where((element ) => element.id == book.id).first.isFavorite;
  }

  @action
  Future<void> searchBooks(String book) async{
    try {
      livrosCarregados = Status.CARREGANDO;
      listBooksSearches = await service.fetchAll(book);
      livrosCarregados = Status.SUCESSO;
    } catch (e) {
      print(e);
      livrosCarregados = Status.ERRO;
    }
  }

  Future<void> fetchBookByCategory() async{
     try {
      livrosCarregados = Status.CARREGANDO;
      listBooks = await service.fetchCategory(listCategorias[indexActionChipSelect]);
      livrosCarregados = Status.SUCESSO;
    } catch (e) {
      print(e);
      livrosCarregados = Status.ERRO;
    }
  }
}