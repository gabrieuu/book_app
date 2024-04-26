import 'package:book_app/core/model/book_model.dart';
import 'package:book_app/core/client_http/dio_client.dart';
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
  final _service = BookRepository(DioClient());

  TextEditingController searchBook = TextEditingController();

  _BookStoreBase(){
    _initBookStore();
  }

  _initBookStore() async{
    await fetchAllBooks('Ação');
  }

  @action
  Future<void> fetchAllBooks(String book) async{
    try {
      livrosCarregados = Status.CARREGANDO;
      listBooks = await _service.fetchAll(book);
      livrosCarregados = Status.SUCESSO;
    } catch (e) {
      print(e);
      livrosCarregados = Status.ERRO;
    }
  }
}