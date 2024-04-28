import 'package:book_app/core/model/book_model.dart';
import 'package:book_app/core/client_http/dio_client.dart';
import 'package:book_app/modules/favoritas/repository/favorite_repository.dart';
import 'package:book_app/modules/home/repository/book_repository.dart';
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

  FavoritaRepository favoritaRepository;
  TextEditingController searchBook = TextEditingController();

  _BookStoreBase(this.service, this.favoritaRepository){
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
      var idFavoritos = await favoritaRepository.booksFavorites();
      listBooks = await service.fetchAll(book);
      
      for(int i = 0; i< listBooks.length; i++){
        if(idFavoritos.isEmpty) break;
        if(idFavoritos.contains(listBooks[i].id)){
          listBooks[i].isFavorite = true;
          idFavoritos.remove(listBooks[i].id);
        }
      }

      livrosCarregados = Status.SUCESSO;
    } catch (e) {
      print(e);
      livrosCarregados = Status.ERRO;
    }
  }
}