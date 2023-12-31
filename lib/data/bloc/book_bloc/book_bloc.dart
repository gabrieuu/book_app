import 'dart:async';

import 'package:book_app/data/bloc/book_bloc/book_event.dart';
import 'package:book_app/data/bloc/book_bloc/book_state.dart';
import 'package:book_app/data/model/book_model.dart';
import 'package:book_app/data/repository/book_repository.dart';


class BookBloc {
  final _repository = BookRepository();
  final StreamController<BookEvent> _inputStreamController = StreamController();
  final StreamController<BookState> _outputStreamController = StreamController();

  Sink<BookEvent> get input => _inputStreamController.sink;
  Stream<BookState> get stream => _outputStreamController.stream;

  BookBloc(){
    _inputStreamController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(BookEvent event) async{
    List<Book> books = [];
    _outputStreamController.add(LoadingStateBook());
    if(event is GetBooks){
      try {
        books = await _repository.fetchAllBooks(event.book);
      } catch (e) {
        _outputStreamController.add(ErrorStateBook(mensagem: "Nome de Livro inválido!"));
      }
    }
    if(books.isNotEmpty) _outputStreamController.add(SucessStateBook(books));
  }


  void dispose(){
    _inputStreamController.close();
  }
}