import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/books/repository/book_repository.dart';
import 'package:book_app/core/status.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'book_store.g.dart';

class BookStore = _BookStoreBase with _$BookStore;

abstract class _BookStoreBase with Store {

  @observable
  ObservableList<Book> listBooks = ObservableList.of([]);

  @observable
  ObservableList<Book> listBooksSearches = ObservableList.of([]);

  @observable
  int indexActionChipSelect = 0;
  @observable
  bool searchIsSelect = false;
  @observable
  Status livrosCarregados = Status.NAO_CARREGADO;

  @observable
  Status livrosRecomendadosStatus = Status.NAO_CARREGADO;

  @observable
  int indexCategoriaSelecionada = 0;

  @observable
  ObservableList<Book> recomendados = ObservableList.of([]);

  @action
  void setIndexCategoriaSelecionada(int value) => indexCategoriaSelecionada = value;



  @observable
  List<String> listCategorias = ["Romance", "Fiction", "Action", "Horror", "Mistery", "Comedy"];
  List<String> autores = [
    'Cassandra Clare',
    'Colleen Hoover',
    'George R.R. Martin',
    'Stephen King',
    'J.K. Rowling',
    'Holly Black',
    'Raphael Montes',
    'Sarah J. Mass',
    'Emily Henry',
    'Julia Quinn',
    'John Green'
  ];
  BookRepository service;

  // FavoritaRepository favoritaRepository;
  @observable
  TextEditingController searchBook = TextEditingController();

  _BookStoreBase(this.service){
    _initBookStore();
    reaction((p0) => indexCategoriaSelecionada, (p0) async{ 
      await fetchBookByCategory();
    });
  }

  _initBookStore() async{
    await Future.wait<void>([
      getRecomendados(),
      fetchBookByCategory()
    ]);
  }

  @action
  tornaLivroFavorito(Book book){
    listBooks.where((element ) => element.id == book.id).first.isFavorite = !listBooks.where((element ) => element.id == book.id).first.isFavorite;
  }

  @action
  Future<void> searchBooks(String book) async{
    try {
      livrosCarregados = Status.CARREGANDO;
      listBooksSearches = ObservableList.of(await service.fetchAll(book));
      livrosCarregados = Status.SUCESSO;
    } catch (e) {
      print(e);
      livrosCarregados = Status.ERRO;
    }
  }

 Future<void>getRecomendados() async{
    try {
      livrosRecomendadosStatus = Status.CARREGANDO;
      recomendados = ObservableList.of(await service.getBooksRecomendados());
      livrosRecomendadosStatus = Status.SUCESSO;
    } catch (e) {
      print(e);
      livrosRecomendadosStatus = Status.ERRO;
    }
  }

  Future<void> fetchBookByCategory() async{
     try {
      livrosCarregados = Status.CARREGANDO;
      listBooks = ObservableList.of(await service.fetchCategory(listCategorias[indexCategoriaSelecionada]));
      livrosCarregados = Status.SUCESSO;
    } catch (e) {
      print(e);
      livrosCarregados = Status.ERRO;
    }
  }
}