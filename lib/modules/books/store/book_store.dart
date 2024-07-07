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
  int indexActionChipSelect = 0;
  @observable
  bool searchIsSelect = false;
  @observable
  Status livrosCarregados = Status.NAO_CARREGADO;

  BookRepository service;

  // FavoritaRepository favoritaRepository;
  TextEditingController searchBook = TextEditingController();

  _BookStoreBase(this.service){
    _initBookStore();
  }

  _initBookStore() async{
    await fetchAllBooks('Ação');
  }

  @action
  tornaLivroFavorito(Book book){
    listBooks.where((element ) => element.id == book.id).first.isFavorite = !listBooks.where((element ) => element.id == book.id).first.isFavorite;
  }

  @action
  Future<void> fetchAllBooks(String book) async{
    try {
      livrosCarregados = Status.CARREGANDO;
      listBooks = await service.fetchAll(book);
      livrosCarregados = Status.SUCESSO;
    } catch (e) {
      print(e);
      livrosCarregados = Status.ERRO;
    }
  }
}