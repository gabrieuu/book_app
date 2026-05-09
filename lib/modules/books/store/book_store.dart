import 'package:book_app/core/status.dart';
import 'package:book_app/model/author_model.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/books/repository/custom_book_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'book_store.g.dart';

class BookStore = _BookStoreBase with _$BookStore;

abstract class _BookStoreBase with Store {
  @observable
  ObservableList<BookModel> listBooks = ObservableList.of([]);

  @observable
  ObservableList<BookModel> listBooksSearches = ObservableList.of([]);

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
  ObservableList<BookModel> recomendados = ObservableList.of([]);

  @action
  void setIndexCategoriaSelecionada(int value) =>
      indexCategoriaSelecionada = value;

  @observable
  List<String> listCategorias = [
    "Romance",
    "Ficção",
    "Ação",
    "Terror",
    "Misterio",
    "Comédia"
  ];
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
  BookRepository repository;

  @observable
  TextEditingController searchBook = TextEditingController();

  _BookStoreBase(this.repository) {
    _initBookStore();
    reaction((p0) => indexCategoriaSelecionada, (p0) async {
      await fetchBookByCategory();
    });
  }

  _initBookStore() async {
    await Future.wait<void>([getRecomendados(), fetchBookByCategory()]);
  }

  Future<BookModel?> getBookById(String id) async{
    final data = await repository.getBookById(id);
    if(data == null) return null;
    return BookModel(
     apiId: id,
      title: data.title,
      imagemUrl: data.coversUrls[0],
      author: ''
    );
  }

  @action
  tornaLivroFavorito(BookModel book) {
    
  }

  @action
  Future<void> searchBooks(String book) async {
    try {
      livrosCarregados = Status.CARREGANDO;
      listBooksSearches = ObservableList.of(await repository.fetchAll(book));
      livrosCarregados = Status.SUCESSO;
    } catch (e) {
      print(e);
      livrosCarregados = Status.ERRO;
    }
  }

  Future<void> getRecomendados() async {
    try {
      livrosRecomendadosStatus = Status.CARREGANDO;
      recomendados = ObservableList.of(await repository.getBooksRecomendados());
      livrosRecomendadosStatus = Status.SUCESSO;
    } catch (e) {
      print(e);
      livrosRecomendadosStatus = Status.ERRO;
    }
  }

  Future<void> fetchBookByCategory() async {
    try {
      livrosCarregados = Status.CARREGANDO;
      listBooks = ObservableList.of(await repository
          .getBooksByCategory(listCategorias[indexCategoriaSelecionada]));
      livrosCarregados = Status.SUCESSO;
    } catch (e) {
      print(e);
      livrosCarregados = Status.ERRO;
    }
  }
}
